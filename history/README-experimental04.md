# Frontier QL — readable flight HUD experiment 04

This version draws flight HUD text directly at **256-pixel Mode 8 resolution**.
It bypasses both scene dithering and the 320→256 horizontal reduction. Every
original font stroke is retained, with solid white letters on opaque black.
The scene retains the previous 4×4 ordered dithering and extended flight view.

![Actual emulator capture](evidence/game.png)

## Changes

- Actual speed, set speed and altitude occupy the first line. The reference
  object is on the second line; warnings start below them.
- Bottom-left clock, original time-control artwork and date have an opaque
  64×32 native-pixel panel. The date has its own line. Function-key icons are
  hidden. Text values still come from Frontier's original formatters.
- Time-control artwork is selected from the original bitmaps using the current
  game time-rate state. Transport click coordinates are adjusted to match the
  native-width strip; hidden clock/date/icon regions have no click action.
- The original scanner remains over the scene alongside the clock panel.
- Maps and other non-flight screens retain the previous renderer and layout.
  This change fixes **flight HUD text**, not every menu font in the game.

The separate native text plane costs 51,200 bytes plus 204 bytes of state.
Characters advance at their original font width; only field origins are moved.
Text foreground/background use fixed Mode 8 white/black, independent of palette
changes. Long strings are clipped safely at the physical right edge.

## Run

```sh
/path/to/qlbox --no-config --rom minerva --ram 1m --no-qsound --speed 8 --run build/frontier
```

Use windowed QLBox. Press **1** to enter the game. **F2** opens the galactic map;
**F1** returns to flight. **Shift+F1–F5** supplies F6–F10. **Ctrl+Esc** exits.
Hold function keys through slow redraws if needed.

Tested with QLBox R24, Minerva, 1 MB, speed 8 and default fast timing. No sound
or runtime floating point. Physical hardware and stock 68008 performance remain
untested. Mouse transport clicking has a coordinate correction, but has not had
an end-to-end physical mouse test; cursor visibility over the opaque panel
remains a limitation. This is an experimental port, not a fully tested release.

The executable is 613,476 bytes. Linker code/data/BSS allocation is
936,836 bytes before QDOS job overhead. The 64 KB stack is retained.
No new whole-game speed claim is made; prototype03 timings in the historical
notes do not measure this additional native text compositor.

## Build and validation

```sh
make
make check
```

JAS and linker sources are bundled. Requirements: POSIX make, C compiler,
Python 3. Conversion checks compare all 537,120 original loaded bytes and
validate 6,639 explicit original-game branch displacements.

The included QLBox R24 harness patch supports the supplied timed key events.
Run with `FRONTIER_EVENTS=tests/game.events`, `tests/menu.events`, or
`tests/roundtrip.events`, saving RAM after 1800, 2300, or 6000 frames respectively:

```sh
python3 tests/check_runtime.py build/game.ram 1
python3 tests/check_readable.py build/game.ram
python3 tests/check_runtime.py build/menu.ram 0
python3 tests/check_runtime.py build/roundtrip.ram 1
```

Runtime checks verify five boundary guards, 51 switched raster extents, and
HUD state. The readability check compares actual font bits against the native
text plane and physical Mode 8 pixels, including field placement and the
opaque clock panel. `tests/quit.events` exercises clean Ctrl+Esc exit.

Historical renderer/background information is in README-experimental03.md.
The older synthetic HUD benchmark predates the new opaque clock panel; its
old full-screen oracle is not a validation of the new HUD compositor.

Original source, build scripts, native assembly, tests and executable are
included. Original source credits/licensing remain in reference/ and vendor/.
