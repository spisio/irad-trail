# The Irad Trail

Spring 1877. Kokand has fallen and settlers hold your clan's pastures on the Chu. Lead your family 690 versts by horse caravan, over the Kök-Bel, Otmek and Ala-Bel passes, to the Church of St. Janyl at Iyık Janyl.

**Play in the browser:** https://spisio.github.io/irad-trail/

There are two editions:

| Edition | Style | Browser | Emulator file |
|---|---|---|---|
| **Apple II** (main) | 1985-style hi-res pictures, named family, eagle hunting, river crossings, map | [play](https://spisio.github.io/irad-trail/) | [`irad-trail.dsk`](irad-trail.dsk) |
| **Commodore 64 classic** | 1978-style text game | [play](https://spisio.github.io/irad-trail/c64/) | [`c64/irad-trail.d64`](c64/irad-trail.d64), [`c64/irad-trail.prg`](c64/irad-trail.prg) |

## Apple II edition

Choose who you are (a biy's son, a felt merchant or a herder), name your family of five, pick a month to leave, and buy horses, food, felt coats, powder and spare tack at Osmon's shop. On the road you set the pace and rations, rest, trade, talk to people at landmarks, ford rivers or pay the rivermen, and hunt with your golden eagle (J and L to turn, space to loose the eagle). Arrive by the Feast of St. Janyl on 24 August for a bonus.

### On an emulator

[`irad-trail.dsk`](irad-trail.dsk) boots by itself on an Apple II+, IIe or IIc with 48K. It needs no DOS.

1. In [AppleWin](https://github.com/AppleWin/AppleWin) (or any Apple II emulator), put `irad-trail.dsk` in drive 1.
2. Reboot. The loader reads the program and runs it. At normal disk speed this takes about 20 seconds.

To paste the listing instead: at the `]` prompt type `POKE 103,1:POKE 104,64:POKE 16384,0:NEW`, paste [`apple2/irad.bas`](apple2/irad.bas), then type `RUN`. The program is too large to sit below the hi-res screen, so it has to start at $4001.

## Commodore 64 classic

In [VICE](https://vice-emu.sourceforge.io/), choose File → Smart attach and pick `c64/irad-trail.d64`, or type `LOAD"*",8` and `RUN`.

## Files

| Path | What it is |
|---|---|
| `apple2/irad.bas` | Apple II edition listing, Applesoft BASIC |
| `apple2/page.template.html` | Source for `index.html`: Applesoft interpreter and Apple II hi-res display |
| `apple2/build.ps1` | Builds `index.html` and the bootable `irad-trail.dsk` |
| `c64/` | Commodore 64 classic edition: listing, `.prg`, `.d64`, page and build script |
| `serve.ps1` | Minimal local web server for testing |

To rebuild after editing a listing:

```powershell
powershell -ExecutionPolicy Bypass -File apple2/build.ps1
powershell -ExecutionPolicy Bypass -File c64/build.ps1
```

### How the Apple II disk boots

Track 0, sector 0 holds a 167-byte 6502 loader. The Disk II boot ROM loads it to $0800. It steps the drive head and calls the ROM's own sector reader to load tracks 1 to 8 into $4000 and up. Then it cold-starts Applesoft and types `POKE103,1:POKE104,64:POKE105,…:POKE106,…:RUN` through a temporary keyboard hook. The program runs from $4001, above hi-res page 1.
