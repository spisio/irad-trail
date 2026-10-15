# Builds the MS-DOS edition of Köch from dos/KOCH.BAS (the readable source):
#   ../KOCH.BAS     compact GW-BASIC program with DOS line endings, for PC-BASIC or GW-BASIC.
#                   Spaces next to punctuation are dropped and REM text is cut, so it fits in
#                   GW-BASIC's 60K of free memory together with its sprites and data.
#   ../index.html   browser version (page.template.html + the same compact program)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Split-Path -Parent $here
$src = (Get-Content -Raw -Path (Join-Path $here 'KOCH.BAS')) -replace "`r`n", "`n"
$punct = ':,;=+-*/()<>^\'
function Compact([string]$body) {
  if ($body -match '^REM\b') { if ($body -match '^REM (KOCH|IRADI|KUBLE)') { return $body } else { return 'REM' } }
  $sb = New-Object System.Text.StringBuilder; $q = $false; $data = $false
  for ($i = 0; $i -lt $body.Length; $i++) {
    $c = $body[$i]
    if ($c -eq '"') { $q = -not $q; [void]$sb.Append($c); continue }
    if ($q -or $data) { if ($data -and $c -eq ':') { $data = $false }; [void]$sb.Append($c); continue }
    if (-not $q -and $body.Substring($i) -match '^DATA\b' -and ($i -eq 0 -or $body[$i - 1] -match '[ :]')) { $data = $true }
    if ($c -eq ' ') {
      $prev = if ($sb.Length) { $sb[$sb.Length - 1] } else { ' ' }
      $j = $i; while ($j -lt $body.Length -and $body[$j] -eq ' ') { $j++ }
      $next = if ($j -lt $body.Length) { $body[$j] } else { ' ' }
      if ($punct.IndexOf($prev) -ge 0 -or $punct.IndexOf($next) -ge 0 -or $prev -eq ' ') { continue }
    }
    [void]$sb.Append($c)
  }
  return $sb.ToString().TrimEnd()
}
$out = @()
foreach ($l in ($src.TrimEnd() -split "`n")) {
  if ($l -notmatch '^(\d+) (.*)$') { throw "Bad line: $l" }
  $line = "$($Matches[1]) " + (Compact $Matches[2])
  if ($line.Length -gt 250) { throw "Line too long for GW-BASIC: $($line.Substring(0, 12))..." }
  $out += $line
}
[IO.File]::WriteAllText((Join-Path $root 'KOCH.BAS'), (($out -join "`r`n") + "`r`n" + [char]26), [Text.Encoding]::ASCII)
$tpl = Get-Content -Raw -Encoding UTF8 -Path (Join-Path $here 'page.template.html')
$head = "<!doctype html>`n<html lang=`"en`">`n<meta charset=`"utf-8`">`n<meta name=`"viewport`" content=`"width=device-width, initial-scale=1, viewport-fit=cover`">`n"
[IO.File]::WriteAllText((Join-Path $root 'index.html'), $head + $tpl.Replace('%%BASIC_SOURCE%%', ($out -join "`n")), (New-Object Text.UTF8Encoding $false))
"KOCH.BAS: $($out.Count) lines, $((Get-Item (Join-Path $root 'KOCH.BAS')).Length) bytes (source $($src.Length))"
