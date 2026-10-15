# Builds the Commodore 64 edition of Köch from koch.bas:
#   koch.prg   Commodore 64 tokenized BASIC program
#   koch.d64   1541 disk image holding the program as "KOCH"
#   index.html       browser version (template + embedded listing)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

$kw = @('END','FOR','NEXT','DATA','INPUT#','INPUT','DIM','READ','LET','GOTO','RUN','IF','RESTORE','GOSUB','RETURN','REM',
  'STOP','ON','WAIT','LOAD','SAVE','VERIFY','DEF','POKE','PRINT#','PRINT','CONT','LIST','CLR','CMD','SYS','OPEN','CLOSE',
  'GET','NEW','TAB(','TO','FN','SPC(','THEN','NOT','STEP','+','-','*','/','^','AND','OR','>','=','<','SGN','INT','ABS',
  'USR','FRE','POS','SQR','RND','LOG','EXP','COS','SIN','TAN','ATN','PEEK','LEN','STR$','VAL','ASC','CHR$','LEFT$',
  'RIGHT$','MID$','GO')

function Crunch([string]$s) {
  $out = New-Object System.Collections.Generic.List[byte]
  $q = $false; $rem = $false; $data = $false; $i = 0
  while ($i -lt $s.Length) {
    $c = $s[$i]
    if ($rem) { $out.Add([byte][char]$c); $i++; continue }
    if ($c -eq '"') { $q = -not $q; $out.Add(34); $i++; continue }
    if ($q) { $out.Add([byte][char]$c); $i++; continue }
    if ($data) { if ($c -eq ':') { $data = $false }; $out.Add([byte][char]$c); $i++; continue }
    if ($c -eq ' ') { $out.Add(32); $i++; continue }
    $m = -1
    for ($k = 0; $k -lt $kw.Count; $k++) {
      if ($s.Length - $i -ge $kw[$k].Length -and $s.Substring($i, $kw[$k].Length) -ceq $kw[$k]) { $m = $k; break }
    }
    if ($m -ge 0) {
      $out.Add([byte](0x80 + $m)); $i += $kw[$m].Length
      if ($kw[$m] -eq 'REM') { $rem = $true }
      if ($kw[$m] -eq 'DATA') { $data = $true }
      continue
    }
    $out.Add([byte][char]$c); $i++
  }
  return ,$out.ToArray()
}

$src = Get-Content -Raw -Path (Join-Path $here 'koch.bas')
$lines = $src -split "`r?`n" | Where-Object { $_.Trim() -ne '' }

# --- PRG ---
$prg = New-Object System.Collections.Generic.List[byte]
$prg.Add(0x01); $prg.Add(0x08)
$addr = 0x0801
foreach ($ln in $lines) {
  if ($ln -notmatch '^\s*(\d+)\s*(.*)$') { throw "Bad line: $ln" }
  $num = [int]$Matches[1]; $body = Crunch $Matches[2]
  if ($body.Length -gt 250) { throw "Line $num too long" }
  $next = $addr + 4 + $body.Length + 1
  $prg.Add([byte]($next -band 0xFF)); $prg.Add([byte]($next -shr 8))
  $prg.Add([byte]($num -band 0xFF)); $prg.Add([byte]($num -shr 8))
  $prg.AddRange([byte[]]$body); $prg.Add(0)
  $addr = $next
}
$prg.Add(0); $prg.Add(0)
$prgBytes = $prg.ToArray()
[IO.File]::WriteAllBytes((Join-Path $here 'koch.prg'), $prgBytes)

# --- D64 (35 tracks, 683 sectors) ---
function SecPerTrack($t) { if ($t -le 17) { 21 } elseif ($t -le 24) { 19 } elseif ($t -le 30) { 18 } else { 17 } }
function Offset($t, $s) { $o = 0; for ($i = 1; $i -lt $t; $i++) { $o += (SecPerTrack $i) }; return ($o + $s) * 256 }
$d64 = New-Object byte[] 174848
$used = @{}
# File data on track 17, then 19 onward if needed
$chain = @()
$t = 17; $s = 0
$nSec = [math]::Ceiling($prgBytes.Length / 254)
for ($n = 0; $n -lt $nSec; $n++) {
  $chain += ,@($t, $s); $s++
  if ($s -ge (SecPerTrack $t)) { $t = if ($t -eq 17) { 19 } else { $t + 1 }; $s = 0 }
}
for ($n = 0; $n -lt $nSec; $n++) {
  $ts = $chain[$n]; $o = Offset $ts[0] $ts[1]
  $chunkLen = [math]::Min(254, $prgBytes.Length - $n * 254)
  [Array]::Copy($prgBytes, $n * 254, $d64, $o + 2, $chunkLen)
  if ($n -lt $nSec - 1) { $d64[$o] = $chain[$n + 1][0]; $d64[$o + 1] = $chain[$n + 1][1] }
  else { $d64[$o] = 0; $d64[$o + 1] = $chunkLen + 1 }
  $used["$($ts[0]),$($ts[1])"] = $true
}
$used['18,0'] = $true; $used['18,1'] = $true
# BAM
$b = Offset 18 0
$d64[$b] = 18; $d64[$b + 1] = 1; $d64[$b + 2] = 0x41; $d64[$b + 3] = 0
for ($tr = 1; $tr -le 35; $tr++) {
  $free = 0; $bits = 0
  for ($sec = 0; $sec -lt (SecPerTrack $tr); $sec++) {
    if (-not $used["$tr,$sec"]) { $free++; $bits = $bits -bor (1 -shl $sec) }
  }
  $e = $b + 4 * $tr
  $d64[$e] = $free; $d64[$e + 1] = $bits -band 0xFF; $d64[$e + 2] = ($bits -shr 8) -band 0xFF; $d64[$e + 3] = ($bits -shr 16) -band 0xFF
}
function PutName($offset, [string]$name, $len) {
  for ($i = 0; $i -lt $len; $i++) { $d64[$offset + $i] = if ($i -lt $name.Length) { [byte][char]$name[$i] } else { 0xA0 } }
}
PutName ($b + 0x90) 'KOCH 1877' 16
$d64[$b + 0xA0] = 0xA0; $d64[$b + 0xA1] = 0xA0
$d64[$b + 0xA2] = [byte][char]'I'; $d64[$b + 0xA3] = [byte][char]'R'; $d64[$b + 0xA4] = 0xA0
$d64[$b + 0xA5] = [byte][char]'2'; $d64[$b + 0xA6] = [byte][char]'A'
for ($i = 0xA7; $i -le 0xAA; $i++) { $d64[$b + $i] = 0xA0 }
# Directory
$dir = Offset 18 1
$d64[$dir] = 0; $d64[$dir + 1] = 0xFF
$d64[$dir + 2] = 0x82; $d64[$dir + 3] = $chain[0][0]; $d64[$dir + 4] = $chain[0][1]
PutName ($dir + 5) 'IRAD TRAIL' 16
$d64[$dir + 30] = $nSec -band 0xFF; $d64[$dir + 31] = $nSec -shr 8
[IO.File]::WriteAllBytes((Join-Path $here 'koch.d64'), $d64)

# --- HTML ---
$tpl = Get-Content -Raw -Encoding UTF8 -Path (Join-Path $here 'game.template.html')
$head = "<!doctype html>`n<html lang=`"en`">`n<meta charset=`"utf-8`">`n<meta name=`"viewport`" content=`"width=device-width, initial-scale=1, viewport-fit=cover`">`n"
$html = $head + $tpl.Replace('%%BASIC_SOURCE%%', $src.TrimEnd())
[IO.File]::WriteAllText((Join-Path $here 'index.html'), $html, (New-Object Text.UTF8Encoding $false))

"PRG: $($prgBytes.Length) bytes, $($lines.Count) lines; D64 sectors used: $nSec"
