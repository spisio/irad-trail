# The Irad Trail

A trail game for the Commodore 64, in the spirit of the 1971 MECC classic.

Spring 1877. Kokand has fallen and settlers hold your clan's pastures on the Chu. Lead the family 690 versts by horse caravan, over the Kök-Bel, Otmek and Ala-Bel passes, to the Church of St. Janyl at Iyık Janyl. Arrive by the Feast of St. Janyl on 24 August, and cross the Ala-Bel before the September snow.

**Play in the browser:** https://spisio.github.io/irad-trail/

## Play on an emulator

The same BASIC program runs on a real or emulated Commodore 64.

1. Download [`irad-trail.d64`](irad-trail.d64) (disk image) or [`irad-trail.prg`](irad-trail.prg) (program file).
2. In [VICE](https://vice-emu.sourceforge.io/) (x64sc), choose File → Smart attach and pick the file.
3. If it does not start by itself, type `LOAD"*",8`, press Return, then type `RUN`.

You can also paste [`irad-trail.bas`](irad-trail.bas) into VICE (Edit → Paste) at the READY prompt.

## How to play

- Spend 400 rubles on horses, food, powder and shot, felts and furs, and supplies. Keep some back for the healer.
- Each turn is one week. Trade, fly your hunting eagle, or ride on.
- When told to, type the word shown (ALGA, URAN, CHU or KEL) and press Return. The faster you type, the better.
- Ford rivers or pay the rivermen, deal with raiders and wolves, and keep your felts thick for the passes.

## Files

| File | What it is |
|---|---|
| `irad-trail.bas` | The program listing, Commodore 64 BASIC V2 |
| `irad-trail.prg` | Tokenized program file |
| `irad-trail.d64` | 1541 disk image holding the program as `IRAD TRAIL` |
| `index.html` | Browser version: runs the listing in a small BASIC interpreter |
| `game.template.html` | Source for `index.html` |
| `build.ps1` | Rebuilds the `.prg`, `.d64` and `index.html` from the listing |
| `serve.ps1` | Minimal local web server for testing |

To rebuild after editing the listing:

```powershell
powershell -ExecutionPolicy Bypass -File build.ps1
```
