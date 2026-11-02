# JAS / as68 modern-host update — 25 October 2026

Modified version of the supplied qdos-gcc-utils-v2 sources. Original copyright
and redistribution restrictions remain in the source files.

Build just the assembler on macOS or Linux:

    make -C as68 clean
    make -C as68 CC=cc
    ./as68/as68 shell.s -o shell.o

Install this as68 binary in place of the previous assembler. The executable
name and command line are retained. No emulation or 32-bit compiler is required.
Use a clean build to avoid mixing objects built with different structure layouts.

## What changed

* Source and object use separate fopen streams, never freopen(stdin/stdout).
  Object output stays in the named file; diagnostics stay on stderr.
* Stream read, write and final close errors return failure. Partial output is
  closed and removed after assembly failure. Input-open failure does not delete
  an existing object. Source/output inode aliases are rejected before truncation.
* Missing -o arguments are diagnosed; default output names are dynamically
  allocated instead of copied into a 32-byte stack buffer.
* Symbol-name union indices use uint32_t, keeping the intended eight-byte layout
  on LP64 hosts. Other long values are intentionally retained: label-difference
  records currently carry pointers through long, which works on macOS/Linux LP64.
* SROFF integers and record markers are explicitly encoded as big-endian bytes.
  No host-alignment-sensitive short/long stores are used in the encoding helpers.
  Endian compiler switches are unnecessary for the default SROFF build.
* Removed out-of-bounds swap calls: a symbol/segment word was swapped as TWO
  words, and the BSS size as FOUR longwords. These corrupted surrounding memory.
* Fixed the USELINE/USE_LINE build typo, enabled source-line diagnostics, supplied
  explicit int declarations required by modern compilers, and bounded string
  tokens and SROFF names instead of overflowing buffers/length bytes.
* scripts/as now uses Python 3 and argv lists, supports paths with spaces, and
  preprocesses into a private temporary directory. It never renames or rewrites
  the source. Set QDOS_AS68 to select the assembler, QDOS_CPP to select cpp.
  The historical first-line '#' preprocessing convention is retained.

The assembler already builds an in-memory intermediate representation; it
does not need source rewinds or object seeks to write its SROFF stream.

## Verification

    python3 as68/tests/check.py

Passed on x86-64 Linux with GCC, both optimized and with:
    CFLAGS='-O1 -g -std=gnu99 -fsanitize=address,undefined -fno-omit-frame-pointer'
    LDFLAGS='-fsanitize=address,undefined'
    ASAN_OPTIONS=detect_leaks=0

Checks include fixed expected SROFF bytes for constants, FB escaping and BSS
size; failed opens; missing -o; source/output and hard-link aliases; long default
filenames; malformed input cleanup; preprocessing with spaces in paths; and 32
concurrent full shell.s assemblies producing identical hashes.

The original binary aborted with stack-smashing detection on the supplied
shell.s. The modified binary assembles it successfully under both builds.
Leak detection is disabled for the historical process-lifetime allocation arena.

## Scope and limits

Native macOS execution and Apple Clang compilation have not been run here:
please test the clean build on your Mac. The intermittent macOS file failures
cannot be conclusively attributed without your failing logs, but concrete memory
corruption and unsafe wrapper handling have been removed.

This is an assembler/driver update, not a linker or library-manager port.
The other tools remain as supplied. Historical Atari object-output branches
and Makefile.qdos/Makefile.NT are not validated by this update.
Windows LLP64 is not claimed: pointer-through-long label differences need a
separate change there. There was no available working original shell.o for a
byte comparison, nor a full EliteQL tree for a complete link/gameplay test.
The supplied shell.s and regression tests are included.

SROFF embeds the exact output filename; use the same output spelling when
comparing objects. Names exceeding the one-byte SROFF length are diagnosed.
A failed build removes its partial object; it does not preserve a previous object
once that destination has been successfully opened for writing.
