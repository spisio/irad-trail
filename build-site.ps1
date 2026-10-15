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
# Page titles, descriptions, share images and structured data live in site/meta.json (UTF-8),
# so this script needs no non-ASCII text of its own.
$meta = (Read-Text 'site/meta.json') | ConvertFrom-Json
function Enc($s) { $s.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;").Replace([string][char]34, "&quot;") }
function Head($m, $rootp) {
  $url = $meta.site + $m.path; $img = $meta.site + $m.image
  $ld = ($m.ld | ConvertTo-Json -Depth 10 -Compress).Replace('</', '<\/')
  @(
    "<title>$(Enc $m.title)</title>",
    "<meta name=`"description`" content=`"$(Enc $m.description)`">",
    "<link rel=`"canonical`" href=`"$url`">",
    "<meta name=`"theme-color`" content=`"#13235e`">",
    "<link rel=`"icon`" href=`"$($rootp)site/img/favicon.svg`" type=`"image/svg+xml`">",
    "<link rel=`"icon`" href=`"$($rootp)site/img/favicon-32.png`" sizes=`"32x32`" type=`"image/png`">",
    "<link rel=`"apple-touch-icon`" href=`"$($rootp)site/img/apple-touch-icon.png`">",
    "<meta property=`"og:type`" content=`"website`">",
    "<meta property=`"og:site_name`" content=`"Kuble Soft`">",
    "<meta property=`"og:locale`" content=`"en_US`">",
    "<meta property=`"og:title`" content=`"$(Enc $m.ogTitle)`">",
    "<meta property=`"og:description`" content=`"$(Enc $m.description)`">",
    "<meta property=`"og:url`" content=`"$url`">",
    "<meta property=`"og:image`" content=`"$img`">",
    "<meta property=`"og:image:width`" content=`"1200`">",
    "<meta property=`"og:image:height`" content=`"630`">",
    "<meta property=`"og:image:alt`" content=`"$(Enc $m.imageAlt)`">",
    "<meta name=`"twitter:card`" content=`"summary_large_image`">",
    "<meta name=`"twitter:title`" content=`"$(Enc $m.ogTitle)`">",
    "<meta name=`"twitter:description`" content=`"$(Enc $m.description)`">",
    "<meta name=`"twitter:image`" content=`"$img`">",
    "<meta name=`"twitter:image:alt`" content=`"$(Enc $m.imageAlt)`">",
    "<script type=`"application/ld+json`">$ld</script>"
  ) -join "`n"
}
foreach ($p in $pages) {
  $m = $meta.pages | Where-Object { $_.file -eq $p.file }
  if (-not $m) { throw "No metadata for $($p.file)" }
  $h = $header
  foreach ($n in 'HOME', 'GAMES', 'HISTORY') { $h = $h.Replace("%%NAV_$n%%", $(if ($n -eq $p.nav) { ' aria-current="page"' } else { '' })) }
  $s = (Read-Text $p.file).Replace('<!--#meta-->', (Head $m $p.rootp)).Replace('<!--#header-->', $h).Replace('<!--#footer-->', $footer).Replace('<!--#sidebar-->', $sidebar).Replace('%%ROOT%%', $p.rootp)
  if ($s -match '<!--#|%%') { throw "Unfilled placeholder in $($p.file)" }
  Write-Text $p.file $s
}

# robots.txt and sitemap.xml
$today = (Get-Date).ToString('yyyy-MM-dd')
Write-Text 'robots.txt' ("User-agent: *`nAllow: /`n`nSitemap: $($meta.site)sitemap.xml`n")
$urls = ($meta.pages | ForEach-Object { "  <url><loc>$($meta.site)$($_.path)</loc><lastmod>$today</lastmod></url>" }) -join "`n"
Write-Text 'sitemap.xml' ("<?xml version=`"1.0`" encoding=`"UTF-8`"?>`n<urlset xmlns=`"http://www.sitemaps.org/schemas/sitemap/0.9`">`n$urls`n</urlset>`n")
"Site built: $($pages.file -join ', '), robots.txt, sitemap.xml"
