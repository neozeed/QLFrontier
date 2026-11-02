# Frontier QL — shared source, two executables (experiment 06)

One source tree now builds **frontier0** and **frontier8**.

| Executable | Behaviour |
|---|---|
| `build/frontier0` | Original experiment01 four-colour Mode 4 display, with readable text only. |
| `build/frontier8` | Exact experiment05 binary: Mode 8 flight HUD, Mode 4 information screens. |

The requested “0” is the executable variant name. The original version uses
QL Mode 4: four colours, 512×256 physical resolution. Its original 320×200
picture stays centred, with the original 168-row flight view and lower panel.

## frontier0: text only

The common text routines now print solid white on opaque black, bypassing the
scene dither. Font pixels, positions and character advances are unchanged.
There is no horizontal resampling of its original 320-wide picture.

**No HUD redesign, viewport expansion, background flattening, palette change,
dither change, icon removal, clock relocation or FPS relocation is applied.**
The original scanner, panel, transport artwork and original strings remain.
Bitmap-embedded lettering remains bitmap artwork, as in experiment05.

![Original display with readable text](evidence/frontier0-game.png)

![Original options with readable text](evidence/frontier0-options.png)

Only tagged text pixels bypass the existing palette conversion. Tag masks
follow screen clears, raster writes, bitmaps and buffer copies. Boundary guards
are included for validation. The original Mode 4 palette upload code, extended
palette layout and all 65,536 dither-table bytes are frozen regressions.

## frontier8: unchanged

`frontier8` is byte-for-byte identical to the released experiment05 executable.
It retains its right-hand flight readout, readable FPS, opaque clock/date,
overlaid scanner, hidden transport artwork and automatic Mode 4 menus/maps.
Its detailed notes are in README-experimental05.md (historical file paths in
that document refer to the former single-executable package).

## Build

Host requirements: POSIX make, C compiler and Python 3. JAS and the QDOS linker
sources are included. No cross C compiler is needed.

```sh
make                  # builds build/frontier0 and build/frontier8
make check
```

Or build either executable with `make frontier0` or `make frontier8`.
`make clean && make -j2 check` was tested; a subsequent make is a no-op.

Both targets share one original game/reference tree, native keyboard/file/
raster services, text renderer, palette-generation algorithm and toolchain.
Small display/startup/data fragments select the original Mode 4 or experiment05
backend. Generated translations are `build/frontier0.s` and `build/frontier8.s`.

## Run

```sh
/path/to/qlbox --no-config --rom minerva --ram 1m --no-qsound --speed 8 --run build/frontier0
/path/to/qlbox --no-config --rom minerva --ram 1m --no-qsound --speed 8 --run build/frontier8
```

Use a windowed QLBox for interactive play. Press **1** to enter the game;
**F2** opens the galactic map and **F1** returns to flight. **Esc**, then another
**Esc**, opens options. **Shift+F1–F5** supplies F6–F10. **Ctrl+Esc** exits.
Hold keys through slow redraws if necessary.

Tested with QLBox R24, Minerva, 1 MB and speed 8. No sound or runtime floating
point was added. Stock 68008 performance and physical hardware are untested.
The packaged binaries are 611,048 bytes (`frontier0`) and 631,872 bytes
(`frontier8`), including relocation and loader metadata. No new FPS claim is made.

## Verification

`make check` checks the full 537,120-byte unmodified-source conversion, relative
branch ranges, native helper branch distances, absence of VM hostcalls/RTE,
exact experiment01 normalized game source for frontier0, its original dither/
palette services, and exact experiment05 executable bytes for frontier8.

`frontier0` emulator runs cover flight, options, map-to-flight return and clean
exit. The options oracle compares 63,744 active pixels outside the parked mouse
cursor rectangle: tagged text is solid; every other pixel follows the original
dither cache. It also checks black margins, the original HUD position and four
memory-boundary guards. No wholesale layout or dithering adjustment is hidden
inside the readability change.

```sh
python3 tests/check_mode0.py build/game0.ram
python3 tests/check_mode0.py build/options0.ram pixels
```

Use the supplied event files with the test harness patch: `game.events` at
1900 frames, `options.events` at 4500, `roundtrip.events` at 6500, and
`quit.events` with a 4500-frame maximum. Frame-limit status 124 is expected for
captures; the quit test returns 0. The experiment05 checks now reference
`build/frontier8` and its map file. Existing frontier8 evidence is retained
because the binary is identical. This is representative regression testing,
not exhaustive gameplay or save/load validation.

Original source and vendor credits/licensing remain in reference/ and vendor/.
