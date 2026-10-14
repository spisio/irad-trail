# Builds the Apple II edition of the Irad Trail from apple2/irad.bas:
#   ../irad-trail.dsk   self-booting 140K disk image (no DOS needed)
#   ../index.html       browser version (page.template.html + embedded listing)
#
# The disk: track 0 sector 0 holds a small loader. The Disk II boot ROM loads it to $0800.
# The loader reads tracks 1..N (16 sectors each, physical order) to $4000 using the ROM's own
# sector reader, cold-starts Applesoft, and types "POKE103,1:POKE104,64:POKE105,lo:POKE106,hi:RUN"
# through a temporary keyboard hook, so the program runs from $4001, above hi-res page 1.
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Split-Path -Parent $here

$kw = @('END','FOR','NEXT','DATA','INPUT','DEL','DIM','READ','GR','TEXT','PR#','IN#','CALL','PLOT','HLIN','VLIN','HGR2','HGR',
  'HCOLOR=','HPLOT','DRAW','XDRAW','HTAB','HOME','ROT=','SCALE=','SHLOAD','TRACE','NOTRACE','NORMAL','INVERSE','FLASH','COLOR=','POP',
  'VTAB','HIMEM:','LOMEM:','ONERR','RESUME','RECALL','STORE','SPEED=','LET','GOTO','RUN','IF','RESTORE','&','GOSUB','RETURN','REM',
  'STOP','ON','WAIT','LOAD','SAVE','DEF','POKE','PRINT','CONT','LIST','CLEAR','GET','NEW','TAB(','TO','FN','SPC(','THEN','AT','NOT',
  'STEP','+','-','*','/','^','AND','OR','>','=','<','SGN','INT','ABS','USR','FRE','SCRN(','PDL','POS','SQR','RND','LOG','EXP','COS',
  'SIN','TAN','ATN','PEEK','LEN','STR$','VAL','ASC','CHR$','LEFT$','RIGHT$','MID$')
$tokPRINT = 0x80 + [array]::IndexOf($kw, 'PRINT')
$tokATN = 0x80 + [array]::IndexOf($kw, 'ATN')

function MatchKw([string]$s, [int]$i, [string]$k) {
  $j = $i
  foreach ($ch in $k.ToCharArray()) {
    while ($j -lt $s.Length -and $s[$j] -eq ' ') { $j++ }
    if ($j -ge $s.Length -or $s[$j] -cne $ch) { return 0 }
    $j++
  }
  return $j
}

# Same rules as Applesoft's PARSE (and the crunch() in the page).
function Crunch([string]$s) {
  $out = New-Object System.Collections.Generic.List[byte]
  $q = $false; $rem = $false; $data = $false; $i = 0
  while ($i -lt $s.Length) {
    $c = $s[$i]; $cc = [int][char]$c
    if ($rem) { $out.Add($cc); $i++; continue }
    if ($q) { $out.Add($cc); if ($c -eq '"') { $q = $false }; $i++; continue }
    if ($c -eq '"') { $q = $true; $out.Add(34); $i++; continue }
    if ($data) { if ($c -eq ':') { $data = $false }; $out.Add($cc); $i++; continue }
    if ($c -eq ' ') { $i++; continue }
    if ($c -eq '?') { $out.Add($tokPRINT); $i++; continue }
    if ($cc -ge 0x30 -and $cc -le 0x3B) { $out.Add($cc); $i++; continue }
    $m = -1; $end = 0
    for ($k = 0; $k -lt $kw.Count; $k++) { $e = MatchKw $s $i $kw[$k]; if ($e -gt 0) { $m = $k; $end = $e; break } }
    if ($m -ge 0) {
      $tok = 0x80 + $m
      if ($kw[$m] -eq 'AT') {
        $j = $end; while ($j -lt $s.Length -and $s[$j] -eq ' ') { $j++ }
        if ($j -lt $s.Length -and $s[$j] -eq 'N') { $tok = $tokATN; $end = $j + 1 }
        elseif ($j -lt $s.Length -and $s[$j] -eq 'O') { $out.Add(65); $i++; continue }
      }
      $out.Add($tok); $i = $end
      if ($kw[$m] -eq 'REM') { $rem = $true }
      if ($kw[$m] -eq 'DATA') { $data = $true }
      continue
    }
    $out.Add($cc); $i++
  }
  return ,$out.ToArray()
}

$src = Get-Content -Raw -Path (Join-Path $here 'irad.bas')
$lines = $src -split "`r?`n" | Where-Object { $_.Trim() -ne '' }

# --- Program image at $4000 ($4000 must be 0; the program starts at $4001) ---
$img = New-Object System.Collections.Generic.List[byte]
$img.Add(0)
$addr = 0x4001
foreach ($ln in $lines) {
  if ($ln -notmatch '^\s*(\d+)\s*(.*)$') { throw "Bad line: $ln" }
  $num = [int]$Matches[1]; $body = Crunch $Matches[2]
  if ($body.Length -gt 250) { throw "Line $num too long ($($body.Length) bytes)" }
  $next = $addr + 4 + $body.Length + 1
  $img.Add([byte]($next -band 0xFF)); $img.Add([byte]($next -shr 8))
  $img.Add([byte]($num -band 0xFF)); $img.Add([byte]($num -shr 8))
  $img.AddRange([byte[]]$body); $img.Add(0)
  $addr = $next
}
$img.Add(0); $img.Add(0)
$vartab = 0x4000 + $img.Count            # first byte after the program's final $00 $00
$prog = $img.ToArray()
$pages = [math]::Ceiling($prog.Length / 256)
$ntracks = [math]::Ceiling($pages / 16)
if (0x4000 + $pages * 256 -gt 0xB800) { throw "Program too large: $($prog.Length) bytes" }
$lastCount = $pages - 16 * ($ntracks - 1)

# --- Boot loader (assembled by hand; see comments in the header) ---
$loader = [byte[]]@(
  0x01,                         # $0800 sectors for the boot ROM to read
  0x4C,0x04,0x08,               # $0801 JMP INIT (patched to JMP NEXT)
  0xA9,0x25, 0x8D,0x02,0x08,    # $0804 INIT: LDA #<NEXT : STA $0802
  0xA9,0x00, 0x85,0xF1, 0x85,0xF0, 0x85,0xF4,   # half-track, track, key index = 0
  0xA9,0x40, 0x85,0xF2,         # destination page $40
  0xA9,0x10, 0x8D,0x00,0x08,    # ROM reads 16 sectors per call
  0xA5,0x2B, 0x4A,0x4A,0x4A,0x4A, 0x09,0xC0, 0x8D,0x55,0x08,   # patch JMP $Cn5C for the boot slot
  0xE6,0xF0,                    # $0825 NEXT: INC track
  0xA5,0xF0, 0xC9,($ntracks + 1), 0xB0,0x29,    # done after the last track
  0x20,0x6C,0x08, 0x20,0x6C,0x08,               # two half-steps
  0xA5,0xF0, 0x85,0x41,         # expected track
  0xA9,0x00, 0x85,0x3D, 0x85,0x26,              # sector 0, buffer low byte 0
  0xA5,0xF2, 0x85,0x27, 0x18, 0x69,0x10, 0x85,0xF2,
  0xA5,0xF0, 0xC9,$ntracks, 0xD0,0x05, 0xA9,$lastCount, 0x8D,0x00,0x08,   # last track: read only the pages needed
  0xA6,0x2B, 0x4C,0x5C,0xC6,    # $0851 LDX slot : JMP $Cn5C (ROM returns to $0801)
  0xA6,0x2B, 0xBD,0x88,0xC0,    # $0856 DONE: motor off
  0xA9,0x8D, 0x85,0x38, 0xA9,0x08, 0x85,0x39,   # KSW -> FAKE
  0x20,0x2F,0xFB, 0x20,0x58,0xFC, 0x4C,0x00,0xE0, # INIT, HOME, Applesoft cold start
  0xA5,0xF1, 0x18, 0x69,0x01, 0x29,0x03, 0x0A, 0x05,0x2B, 0xAA, 0xBD,0x81,0xC0,   # $086C STEP: next phase on
  0xA9,0x56, 0x20,0xA8,0xFC,                    # wait about 20 ms
  0xA5,0xF1, 0x29,0x03, 0x0A, 0x05,0x2B, 0xAA, 0xBD,0x80,0xC0,   # previous phase off
  0xE6,0xF1, 0x60,
  0x91,0x28, 0x86,0xF3, 0xA6,0xF4, 0xBD,0xA7,0x08, 0xE6,0xF4,   # $088D FAKE keyboard
  0xC9,0x8D, 0xD0,0x08, 0xA2,0x1B, 0x86,0x38, 0xA2,0xFD, 0x86,0x39, 0xA6,0xF3, 0x60
)
if ($loader.Length -ne 0xA7) { throw "Loader length is $($loader.Length), expected 167" }
$cmd = "POKE103,1:POKE104,64:POKE105,$($vartab -band 0xFF):POKE106,$($vartab -shr 8):RUN"
$boot = New-Object byte[] 256
[Array]::Copy($loader, $boot, $loader.Length)
$o = $loader.Length
foreach ($ch in $cmd.ToCharArray()) { $boot[$o++] = [byte]([int][char]$ch -bor 0x80) }
$boot[$o++] = 0x8D

# --- DSK image (DOS 3.3 sector order) ---
$phys2log = @(0, 7, 14, 6, 13, 5, 12, 4, 11, 3, 10, 2, 9, 1, 8, 15)
$dsk = New-Object byte[] 143360
[Array]::Copy($boot, 0, $dsk, 0, 256)
for ($pg = 0; $pg -lt $pages; $pg++) {
  $t = 1 + [math]::Floor($pg / 16); $ps = $pg % 16
  $off = ($t * 16 + $phys2log[$ps]) * 256
  $n = [math]::Min(256, $prog.Length - $pg * 256)
  [Array]::Copy($prog, $pg * 256, $dsk, $off, $n)
}
[IO.File]::WriteAllBytes((Join-Path $root 'irad-trail.dsk'), $dsk)
[IO.File]::WriteAllBytes((Join-Path $here 'irad.bin'), $prog)

# --- HTML ---
$tpl = Get-Content -Raw -Encoding UTF8 -Path (Join-Path $here 'page.template.html')
$head = "<!doctype html>`n<html lang=`"en`">`n<meta charset=`"utf-8`">`n<meta name=`"viewport`" content=`"width=device-width, initial-scale=1, viewport-fit=cover`">`n"
$html = $head + $tpl.Replace('%%BASIC_SOURCE%%', $src.TrimEnd())
[IO.File]::WriteAllText((Join-Path $root 'index.html'), $html, (New-Object Text.UTF8Encoding $false))

"Program: $($prog.Length) bytes ($pages pages, $ntracks tracks), VARTAB=`$$('{0:X4}' -f $vartab), $($lines.Count) lines"
