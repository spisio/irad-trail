# Builds the whole Kuble Soft site:
#   1. puts each edition's page top (site/tops/*.html) in front of its game script template
#   2. runs the three edition builds (index.html, apple2/index.html, c64/index.html and emulator files)
#   3. builds about.html from site/about.template.html
#   4. fills in the shared header, sidebar and footer (site/*.html) on every page
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$utf8 = New-Object Text.UTF8Encoding $false
function Read-Text($p) { [IO.File]::ReadAllText((Join-Path $root $p), $utf8) }
function Write-Text($p, $s) { [IO.File]::WriteAllText((Join-Path $root $p), $s, $utf8) }

foreach ($pair in @(@('dos/page.template.html', 'site/tops/dos.html'), @('apple2/page.template.html', 'site/tops/apple2.html'), @('c64/game.template.html', 'site/tops/c64.html'))) {
  $t = Read-Text $pair[0]; $i = $t.IndexOf('<script type="text/plain" id="bas">')
  if ($i -lt 0) { throw "Script marker missing in $($pair[0])" }
  Write-Text $pair[0] ((Read-Text $pair[1]) + "`n" + $t.Substring($i))
}

& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $root 'dos/build.ps1')
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $root 'apple2/build.ps1')
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $root 'c64/build.ps1')
Write-Text 'about.html' (Read-Text 'site/about.template.html')

$header = Read-Text 'site/header.html'; $footer = Read-Text 'site/footer.html'; $sidebar = Read-Text 'site/sidebar.html'
$pages = @(
  @{ file = 'index.html'; rootp = ''; nav = 'HOME' },
  @{ file = 'apple2/index.html'; rootp = '../'; nav = 'HOME' },
  @{ file = 'c64/index.html'; rootp = '../'; nav = 'HOME' },
  @{ file = 'about.html'; rootp = ''; nav = 'HISTORY' }
)
foreach ($p in $pages) {
  $h = $header
  foreach ($n in 'HOME', 'GAMES', 'HISTORY') { $h = $h.Replace("%%NAV_$n%%", $(if ($n -eq $p.nav) { ' aria-current="page"' } else { '' })) }
  $s = (Read-Text $p.file).Replace('<!--#header-->', $h).Replace('<!--#footer-->', $footer).Replace('<!--#sidebar-->', $sidebar).Replace('%%ROOT%%', $p.rootp)
  if ($s -match '<!--#|%%') { throw "Unfilled placeholder in $($p.file)" }
  Write-Text $p.file $s
}
"Site built: $($pages.file -join ', ')"
