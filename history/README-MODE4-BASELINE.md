# Frontier QL — experimental native JAS build

A first running Sinclair QL adaptation of the supplied FrontVM 2004 source.
The original Frontier game, world data and integer 3D renderer execute as
native 68000 code. There is no FrontVM interpreter inside the executable.
The supplied source is derived from the Atari ST version, not the Amiga
edition shown on the box.

Verified in QLBox R24 with embedded Minerva, 1 MB RAM, Mode 4 and CPU speed 8.
This is an experimental playable prototype, not a fully tested game release.
A stock 128 KB QL cannot hold this build. Physical QL hardware has not been tested.

## Run in QLBox

Extract the archive, then run from its directory (substitute your QLBox path):

```sh
/path/to/qlbox --no-config --rom minerva --ram 1m --no-qsound --speed 8 --run build/frontier
```

Use the SDL/windowed QLBox executable for interactive play. The supplied
`build/frontier` is the QDOS executable; the JAS tools are host build tools.
The `--run` host-path loader handles the executable's appended XTcc dataspace
metadata. A plain copy to a real QDOS filesystem may require executable header
metadata to be set by its transfer/loader tool; that deployment is unverified.

Press **1** in the intro to enter the starting game. Original letter, number,
arrow and F1–F5 controls are forwarded to the game. **Shift+F1–F5** supplies
**F6–F10**; the original shifted F6–F10 ASCII variants are consequently unavailable.
**Ctrl+Esc** removes the job cleanly. QLBox's QIMSI mouse interface is supported;
use QLBox's Ctrl+F9 capture toggle. Mouse interaction still needs broader testing.

Sound effects and music are silent. Keep `--no-qsound`: the tested QLBox expanded
RAM configuration requires it. `--speed 8` is an emulator acceleration setting,
not a claim of stock 68008 performance. The default emulator timing is `fast`.
Screenshots in `evidence/` are unscaled 512×256 captures from the emulator.

## Build and verify

Requirements: POSIX make, a host C compiler and Python 3. The modern-host JAS
assembler and QDOS linker sources are included; no cross C compiler is needed.

```sh
make
make check
make build/filetest
/path/to/qlbox-headless --no-config --rom minerva --ram 1m --no-qsound --speed 8 --run build/filetest --frames 1000
```

The file test returns zero on success and 42 on an assertion failure. Run in a
writable extracted directory. It creates and deletes `QPORT.CMD` in the directory
mounted by `--run`. Do not keep an existing file with that name there.

`make check` rebuilds the unmodified-source JAS translation and compares all
537,120 loaded bytes with the reference image produced by FrontVM's original
assembler. It also checks all 6,638 explicitly encoded branch displacements in
the native port and rejects remaining active VM hostcall/RTE instructions.
Byte equivalence applies to the unmodified conversion; the native port deliberately
changes platform calls, startup and event pumping.

`make clean && make && make check` rebuilds generated sources from scratch.
The complete generated JAS translation unit is `build/frontier.s`; assembling it
uses `as68 -N`. The Python scripts run only at build time.

## Implementation map

| Original facility | Native QL implementation |
|---|---|
| 68000 game, galaxy, simulation and integer 3D code | Retained, translated to JAS syntax with explicit branch encodings |
| VM hcall/hostcall instructions | ABI-preserving assembly wrappers and QDOS services |
| VM screens at fixed addresses | Two job-owned 320×200 indexed buffers, 128,000 bytes total |
| 256-entry RGB444 palettes | Build-time ordered-dither lookup; palette changes expand to pre-shifted Mode 4 masks |
| Host presentation | 320×200 viewport at (96,28), packed into the 512×256 Mode 4 screen |
| VBL and input interrupt handlers | QDOS poll hook counts ticks; cooperative pump invokes original routines |
| ST keyboard scan codes | QDOS IPC KEYROW scanning, press/release queue, QL mapping |
| Host mouse | QLBox QIMSI relative mouse packets |
| GEMDOS files | QDOS channels, root WIN1_ directory, DOS-style names converted to QDOS names |
| Sound calls | Silent return paths; no samples or sound hardware required |
| Startup and quit | Relocation, job-owned BSS/stack, poll-hook attach/unlink and QDOS job removal |

No blanket floating-point-to-fixed-point rewrite was needed. FrontVM's host float
polygon routines were already inactive in this supplied assembly. The active game
rendering math remains the original integer/scaled arithmetic. The dithering
lookup generator also uses integer arithmetic.

The linked image is 610,272 bytes including relocation and loader metadata.
Code/data plus BSS/stack occupy 834,572 bytes before QDOS job overhead. The stack
reservation is 64 KB. The 64 KB RGB dither table and two 16 KB expanded palette
caches are deliberate speed/memory trades. No promise is made for smaller RAM.

Mode 4 has black, red, green and white here; dithering cannot reproduce arbitrary
blue/cyan faithfully. The viewport preserves Frontier's 320×200 coordinates and
avoids a scaling pass. Screen publication converts eight pixels into one packed
word at a time. Host float shading and sound have not been added.

## Test coverage and remaining work

Confirmed in the emulator:

- Original JAS image equivalence and native branch-range checks.
- Animated intro including FRONTIER title, ships and ringed planet.
- Keyboard transition into the real starting cockpit and planetary view.
- F2 opens the galactic map, with original system labels and selection text.
- Shift+F1 queues ST F6; subsequent release leaves no held keys in the adapter.
- Ctrl+Esc exits with status zero, after unlinking the poll hook.
- File-service create/write/close/reopen/read-back, EOF, directory enumeration,
  deletion and missing-file return; final test uses unmodified QLBox-headless.

Not yet validated: complete save/load UI round-trip, combat, hyperspace, docking,
all mission paths, extended play, physical hardware and accurate 68008 timing.
The file selector currently enumerates only root WIN1_ `.CMD` names up to 13
characters; nested-directory browsing and full GEMDOS error compatibility are
not implemented. Mouse handling has been implemented from QLBox's interface but
has not received the same interactive coverage as keyboard input.

Observed guest frame counters vary by scene; one intro sample reached about 7
FPS at 8×, while a later cockpit sample showed 2 FPS. These are snapshots, not
a controlled benchmark. Do not infer stock QL playability from them. Further
performance work should measure scene costs and reduce full-screen conversions.

The optional `tests/qlbox-r24-harness.patch` adds timed physical-key injection
and register diagnostics to the supplied R24 emulator source for repeatable
headless UI checks. Apply it to a separate R24 checkout with `patch -p1`, then
`make -B qlbox-headless`. Set `FRONTIER_EVENTS` to a supplied `.events` file;
its columns are emulator frame, QL keycode, modifier mask, down/up. UI tests
normally reach their frame limit (exit 124); `quit.events` must exit zero.
The game's `build/frontier` does not depend on this emulator instrumentation.

## Source provenance

`reference/fe2.s`, the font/cursor reference C files, and the reference image
come from the user's supplied `frontvm-20040517` source. The original provenance
notice is preserved in `reference/FrontVM-README.txt`. Frontier game code/data
retain their original attribution; this package does not relicense them.
`vendor/as68` and `vendor/ld` are from the supplied modern-host QDOS GCC R3
package; their notices and modernization notes are preserved. `vendor/lib/libc.a`
is supplied for the linker's library lookup; no C runtime startup is used.
