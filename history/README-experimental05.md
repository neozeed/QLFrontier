# Frontier QL — readable interface experiment 05

Flight retains **Mode 8**, the dithered scene and transparent scanner. The speed,
reference and altitude readout is at the upper right; real FPS is at the upper
left. Clock and date have an opaque bottom-left panel. The VCR/time-control
artwork is removed. HUD letters retain every original font stroke.

![Flight](evidence/game.png)

Menus and maps automatically switch to **Mode 4**. Its 512 horizontal pixels
allow the original 320-wide layouts to be expanded without dropping any source
pixels. This resolves the otherwise unavoidable collisions in dense Mode 8
panels. The game returns to Mode 8 when returning to flight.

![Options](evidence/options.png)

## Text and display

- Both common string-printing calls now use solid white text on opaque black.
  Text does not pass through palette dithering. Original formatted values and
  strings are retained, including planet/system names and the FPS counter.
- Menu glyphs always use their original 320-wide layout, even on the first draw
  while entering a menu. Mode 4 maps five source pixels to eight output pixels
  with repetitions `[0,0,1,2,2,3,4,4]`; it never discards a stroke.
- Text-heavy panels use a solid black fill instead of the patterned index-14
  background. Maps and graphical content retain ordered colour dithering.
- Two 8,000-byte tag masks follow the indexed screen buffers. Clear/fill, span,
  pixel, bitmap and screen-copy services update the masks so text does not stay
  behind after the game overwrites it. Cursor save/restore retains its original
  behaviour; the parked pointer can cover a little of the top-left text.
- The equipment heading is shortened to “Equipment:” to fit beside the model.
  Padding preserves the original string-table offsets.
- Clock/date are composited separately in both modes. Transport artwork is
  hidden; original time simulation and keyboard handlers are unchanged.
- Flight keeps the original projection centre and expanded 200-row viewport
  from experiment03. Altitude is retained on a third line below the reference
  object. Warning text starts below those lines.

This covers the common text renderer throughout the game. Text baked into an
original bitmap, such as some small icon-strip artwork, remains bitmap artwork.
Representative screens are tested; this is not an exhaustive gameplay test of
all missions, text-entry forms, save files or unusually long generated names.

## Run

```sh
/path/to/qlbox --no-config --rom minerva --ram 1m --no-qsound --speed 8 --run build/frontier
```

Use windowed QLBox. Press **1** to enter the game. **F2** opens the galactic map;
**F3** opens ship equipment; **F1** returns to flight. **Esc** pauses, then another
**Esc** opens options. **Shift+F1–F5** supplies F6–F10. **Ctrl+Esc** exits cleanly.
Hold keys through slow redraws if needed. The supplied event files use extended
key holds for repeatable emulator tests.

Tested with QLBox R24, Minerva, **1 MB**, speed 8, default fast timing. The
executable is **631,872 bytes**; linker code/data/BSS/stack allocation is
**972,962 bytes**, before QDOS overhead. The 64 KB stack is retained. No sound
or runtime floating point is added. Physical hardware, stock 68008 timing and
all QLBox R25 configurations are untested. No new frame-rate claim is made.

Mode switches clear the physical screen before presentation, including the
margins, so old Mode 4 pixels cannot appear as coloured bars in Mode 8.

## Build and checks

```sh
make
make check
```

JAS and the QDOS linker sources are bundled. Host requirements are POSIX make,
a C compiler and Python 3. The build generates the colour tables; there is no
runtime colour-distance search or floating-point calculation.

`make check` verifies all 537,120 original loaded bytes of the unmodified-source
JAS conversion, 6,638 explicit branches in the modified game, and absence of
active VM hostcall/RTE instructions. It does not claim the modified game is
byte-identical to the reference.

With the included QLBox R24 harness patch and timed event files, capture RAM for:

| Event file | Frames | Expected mode |
|---|---:|---|
| `tests/game.events` | 1900 | Flight / Mode 8 |
| `tests/menu.events` | 3000 | Galactic map / Mode 4 |
| `tests/equipment.events` | 3500 | Equipment / Mode 4 |
| `tests/options.events` | 4500 | Options / Mode 4 |
| `tests/roundtrip.events` | 6500 | Back in flight / Mode 8 |
| `tests/quit.events` | 4500 maximum | Clean exit 0 |

```sh
python3 tests/check_runtime.py build/game.ram 1
python3 tests/check_readable.py build/game.ram
python3 tests/check_runtime.py build/options.ram 0
python3 tests/check_ui.py build/options.ram options
python3 tests/check_runtime.py build/roundtrip.ram 1
```

Runtime checks inspect six boundary guards, 51 raster extents, HUD position and
actual display mode. Flight checks compare font strokes and physical pixels,
including the original FPS output. The independent Mode 4 oracle compares
101,984 pixels outside the asynchronously restored parked cursor rectangle,
plus glyph/tag data and black margins. `evidence/` contains the test results
and actual emulator captures.

Historical experiment03/04 notes remain in separate README files. Their older
presentation benchmarks and timings do not validate or measure this new
mixed-mode compositor. Only `build/frontier` is the packaged current executable.
Original reference source and vendor credits/licensing are retained.
