# Frontier QL — flight HUD and Mode 8 dithering experiment 03

A separate branch of experimental-02 implementing the requested flight display:
original speed/altitude/reference text at the top, the original scanner over the
scene, and the flight icon strips hidden. The actual scene raster grows from
320×168 to 320×200. Its vertical projection centre stays at the original y=84,
so the added rows reveal more below the old view rather than stretching it.
Horizontal 320→256 sampling is retained for QL Mode 8.

![Flight HUD](evidence/game.png)

## Run

```sh
/path/to/qlbox --no-config --rom minerva --ram 1m --no-qsound --speed 8 --run build/frontier
```

Use the windowed/SDL QLBox executable. Press **1** in the intro to enter the game.
Original function-key actions remain: **F2** opens the galactic map; **F1** returns
to flight. **Shift+F1–F5** supplies F6–F10. **Ctrl+Esc** exits cleanly.
During slow menu redraws, hold the key until the game responds; input remains
cooperatively polled. The automated round-trip test uses longer key holds to
avoid a down/up event occurring entirely during a redraw.

Tested with QLBox R24, Minerva, 1 MB RAM, CPU speed 8, default fast timing.
No sound or runtime floating point. Physical QL hardware and accurate stock
68008 timing are untested. The host-path `--run` loader handles XTcc dataspace
metadata. This remains an experimental port, not a fully play-tested release.

## HUD behaviour

- The original formatted flight values are moved from y=158 to y=1. They are
  not replacement numbers or an invented HUD simulation.
- Existing warning/target text and aiming marks are drawn on the overlay too.
  White text retains opaque black shadow pixels for contrast.
- The scanner uses the game's original grid, contact projection and filtering.
  Contact rendering runs only when the player's original scanner equipment bit
  is set. The original panel-selection flag is saved and restored around the
  drawing call; the overlay does not grant scanner equipment.
- Flight icon strips and surrounding panel gauges are not composited. Use the
  original function keys and information screens. The reduced flight HUD does
  not reproduce every panel gauge. Mouse controls are retained, but hidden-panel
  click targets have not been redesigned; use function keys for navigation.
- Maps and other non-flight screens keep their original layout and panel.

The radar is a software overlay, with empty pixels revealing the scene beneath.
The scene is not cut off behind a black radar box. A separate indexed HUD plane
allows the original scanner's black-background readback to continue working.
Index zero is transparent; the native text renderer marks black shadow pixels
with a reserved HUD-only sentinel. Main and panel palette namespaces remain
separate while compositing.

Presentation combines the scene and HUD row by row, avoiding a second full-screen
pass that would temporarily erase the HUD. Text, bitmap and line drawing mark
HUD rows; rows with no drawing are skipped. The game still uses software screen
publication, so this is not a claim of tear-free hardware page flipping.

## Dithering

Mode 8 now uses a build-time **4×4 ordered-dither table** mapping RGB444 colours
onto the eight RGB cube colours. The 64 KB table feeds two 8 KB pre-shifted palette
caches. Flash bits remain clear. There are no runtime colour-distance searches,
floating-point calculations or error-diffusion passes.

A 2×2 pattern was tried first but looked coarse. The final 4×4 pattern recovers
more intermediate shading. HUD foreground uses a solid sample for clear text
and scanner lines, while the scene uses the full dither pattern. Dithering still
cannot reproduce the original continuous palette exactly, and the retained
320→256 reduction can lose thin lines and small font strokes.

At QLBox speed 8, fast timing, the checked 200-publication microbenchmark measured:

| Presentation path | Mean time |
|---|---:|
| Experimental-02 solid Mode 8, previous measurement | 31.6 ms |
| Experimental-03 4×4 Mode 8, no HUD | 31.9 ms |
| Experimental-03 synthetic HUD active on every row | 60.3 ms |

The dense HUD case deliberately exercises transparency and black shadows on
all rows. Actual flight overlay cost depends on the marked rows and pixels;
it is not represented by a fixed FPS claim. The timing excludes game simulation,
geometry, rasterisation, HUD generation and palette setup. The row-skipping
optimization helps sparse real HUDs; it cannot reduce this all-rows synthetic
case. The dithered background conversion itself costs almost the same as solid
Mode 8 in this test.

## Renderer changes and memory safety

Simply changing the bottom clip from 168 to 200 would overrun two original
scanline workspaces. This branch also changes:

- Small polygon workspace: 336-byte row-bank stride → 400; 3,702 bytes → 4,406.
- Large polygon workspace: 21,912 bytes → 26,072, including the expanded row
  headers and edge-mask array. Its initialization covers all 200 rows.
- 51 immediate raster extents/fill counts switch between the original menu
  values and the expanded flight values. The scanner's own coordinates are
  intentionally excluded. The exact list is in `evidence/hud-extents.txt`.

Extent switching patches immediate operands in the job's own relocated code.
This targets the 68000/68008 execution model; cached later CPUs would need an
instruction-cache strategy and are not validated by these tests.

Five guard words surround the HUD/screen buffers and stack boundary. The runtime
checker verifies them, the active extent operands and the status-line position.
Flight, map and flight-return captures all pass. The pre-existing 64 KB stack
reservation is retained. Code/data/BSS/stack total **884,462 bytes** before QDOS
job overhead; the executable is **612,690 bytes** including relocation and loader
metadata. **1 MB remains the tested RAM configuration.**

## Build and repeat the checks

Host requirements: POSIX make, a C compiler and Python 3. Modern-host JAS and
QDOS linker source are bundled; no cross C compiler is required.

```sh
make
make check
make build/presentbench build/hudbench
```

`make check` compares the unmodified-source JAS conversion against all 537,120
reference bytes, checks 6,639 explicit relative branches in the modified game,
and rejects active VM hostcall/RTE instructions. This equivalence proof applies
to the source conversion, not to the deliberately changed native port.

```sh
/path/to/qlbox-headless --no-config --rom minerva --ram 1m --no-qsound --speed 8 --run build/presentbench --frames 1800 --ram-dump build/bench.ram
python3 tests/check_present.py build 8
/path/to/qlbox-headless --no-config --rom minerva --ram 1m --no-qsound --speed 8 --run build/hudbench --frames 2400 --ram-dump build/hudbench.ram
python3 tests/check_present.py build 8 hud
```

The benchmark waits after recording results, so frame-limit exit 124 is expected.
Each oracle checks all 32,768 physical screen bytes. The main and panel test
palettes differ, exercising their boundary, the flight palette selection, all
four dither rows/columns, transparent pixels, opaque black shadows, scanner
cropping and blank margins.

The supplied R24 harness patch enables timed physical-key events, as in earlier
packages. Apply it to a separate QLBox R24 tree and rebuild its headless runner.
Set `FRONTIER_EVENTS=tests/game.events`, `tests/menu.events`, or
`tests/roundtrip.events`; capture RAM at frames 1600, 2300 or 6000 respectively.
Then run:

```sh
python3 tests/check_runtime.py build/game.ram 1
python3 tests/check_runtime.py build/menu.ram 0
python3 tests/check_runtime.py build/roundtrip.ram 1
```

`tests/quit.events` must terminate with status zero before frame 3500. The game
binary itself does not depend on emulator instrumentation.

## Limits and provenance

Broader gameplay, docking, combat, missions, complete save/load UI, long sessions
and physical hardware remain unverified. File-service implementation is unchanged
from experimental-01; its standalone create/read/write/enumerate/delete test
passed there. Root WIN1_ `.CMD` directory selection and silent audio limitations
remain. This HUD changes presentation, not the original simulation or mechanics.

Game/renderer source is the supplied Atari ST-derived FrontVM 2004 assembly,
not the Amiga binary. See `reference/FrontVM-README.txt` and vendor notices for
attribution. No relicensing of original game code/data is implied. The old
`README-MODE4-BASELINE.md` is preserved for historical architecture context;
its display and memory figures do not describe this branch.
