# The Irad Trail

Spring 1877. Kokand has fallen and settlers hold your clan's pastures on the Chu. Lead your family 690 versts by horse caravan, over the Kök-Bel, Otmek and Ala-Bel passes, to the Church of St. Janyl at Iyık Janyl.

**Play in the browser:** https://spisio.github.io/irad-trail/

There are three editions, each in the style of a different era:

| Edition | Style | Browser | File for an emulator |
|---|---|---|---|
| **MS-DOS** (main) | 1990 style: 16-color EGA scenes, hunting on foot, rafting the Naryn, Top Ten and graves | [play](https://spisio.github.io/irad-trail/) | [`IRAD.BAS`](IRAD.BAS) (GW-BASIC) |
| **Apple II** | 1985 style: hi-res pictures, named family, eagle hunting | [play](https://spisio.github.io/irad-trail/apple2/) | [`apple2/irad-trail.dsk`](apple2/irad-trail.dsk) |
| **Commodore 64** | 1978 style: text game | [play](https://spisio.github.io/irad-trail/c64/) | [`c64/irad-trail.d64`](c64/irad-trail.d64) |

## MS-DOS edition

Choose who you are (a biy's son, a felt merchant or a herder), name your family of five, pick a month to leave, and shop at Osmon's shop by the Chu ford. On the road, press Enter to size up the situation: change the pace and rations, rest, trade, talk to people, look at the map, or hunt.

- **Hunting:** walk the field with the arrow keys (Home, PgUp, End and PgDn for diagonals) and shoot with the space bar. Hares, marmots, roe deer and arkhar. You can carry only 100 funt back.
- **Rivers:** ford, float the packs on a goatskin raft, pay the rivermen, or wait a day.
- **The Naryn gorge:** raft the last 70 versts to Iyık Janyl and steer around the rocks, or pay the herders for the mountain road.
- **Top Ten and graves:** the best scores are saved in `IRADTOP.DAT`. When a caravan leader dies, the grave and its epitaph are saved in `IRADGRV.DAT` and appear beside the road for the next player.

### Running it in DOS

`IRAD.BAS` is a plain GW-BASIC program for an EGA or VGA PC (SCREEN 7).

- **PC-BASIC** (free GW-BASIC emulator, [robhagemans.github.io/pcbasic](https://robhagemans.github.io/pcbasic/)): `pcbasic IRAD.BAS`
- **DOSBox** with your own `GWBASIC.EXE`: `GWBASIC IRAD.BAS`

The readable source is [`dos/IRAD.BAS`](dos/IRAD.BAS). The build makes the compact `IRAD.BAS` from it by dropping spaces next to punctuation and REM text, so the program fits in GW-BASIC's 60K together with its sprites.

## Apple II edition

[`apple2/irad-trail.dsk`](apple2/irad-trail.dsk) boots by itself on an Apple II+, IIe or IIc with 48K and needs no DOS. Put it in drive 1 of [AppleWin](https://github.com/AppleWin/AppleWin) or another emulator and reboot.

To paste the listing instead: at the `]` prompt type `POKE 103,1:POKE 104,64:POKE 16384,0:NEW`, paste [`apple2/irad.bas`](apple2/irad.bas), then type `RUN`.

## Commodore 64 edition

In [VICE](https://vice-emu.sourceforge.io/), choose File → Smart attach and pick `c64/irad-trail.d64`, or type `LOAD"*",8` and `RUN`.

## Building

Each edition has a PowerShell build script that writes its page and emulator files:

```powershell
powershell -ExecutionPolicy Bypass -File dos/build.ps1
powershell -ExecutionPolicy Bypass -File apple2/build.ps1
powershell -ExecutionPolicy Bypass -File c64/build.ps1
```

| Path | What it is |
|---|---|
| `dos/IRAD.BAS` | MS-DOS edition source, GW-BASIC |
| `dos/page.template.html` | Source for `index.html`: GW-BASIC interpreter and EGA display |
| `dos/test-bot.js` | Simulated player used to test the MS-DOS edition |
| `apple2/` | Apple II edition: Applesoft listing, page, bootable disk builder |
| `c64/` | Commodore 64 edition: BASIC listing, page, `.prg` and `.d64` builder |
| `serve.ps1` | Minimal local web server for testing |

### How the Apple II disk boots

Track 0, sector 0 holds a 167-byte 6502 loader. The Disk II boot ROM loads it to $0800. It steps the drive head and calls the ROM's own sector reader to load tracks 1 to 8 into $4000 and up. Then it cold-starts Applesoft and types `POKE103,1:POKE104,64:POKE105,…:POKE106,…:RUN` through a temporary keyboard hook. The program runs from $4001, above hi-res page 1.
