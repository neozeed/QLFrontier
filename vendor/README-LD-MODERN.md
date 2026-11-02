# QDOS linker modern-host update — v4, 25 October 2026

This package retains the working v3 JAS assembler update and updates ld/ldold.c.
Original source copyright notices remain intact. Changes are marked in source.

## Build

    make -C as68 clean
    make -C as68 CC=cc
    make -C ld clean
    make -C ld CC=cc

Replace your installed linker with ld/ld (the same installation path used for the
previous binary). No warning suppression flags are needed. Default linker flags
enable -Wall -Wextra -Wformat=2. The linker remains C and has no Python runtime
dependency. Python 3 is used by the optional regression tests and the v3 assembler
wrapper.

## Changes

* POSIX includes, case-insensitive string routines, strupr and compatibility
  definitions now apply on macOS as well as Linux; Apple hosts use POSIX default
  library paths and file permissions.
* Fixed printf format/type mismatches and const correctness. Strong warning
  checks pass without suppression.
* Replaced relocation-list pointers stored in long with actual pointer types.
* Replaced native long stores in the relocation terminator with exactly four
  zero bytes. A 64-bit long previously wrote beyond the intended format.
* Target integer reads are explicitly sequenced big-endian operations, with
  defined 32-bit sign extension for negative relocation addends. The old
  get_byte()+get_byte() expressions did not specify read order and used signed
  shifts with undefined behaviour.
* Use memmove when moving overlapping section storage.
* Read errors and interrupted reads are handled correctly. All output writes,
  including alignment padding and XTcc dataspace trailers, complete short writes
  and report failures. Program-size accounting starts at zero.
* SROFF names support all 255 bytes instead of overflowing an 80-byte parser
  buffer or silently truncating symbols at 39 bytes. File/map buffers are larger
  and guarded; symbol-ID tables allocate their inclusive endpoint.
* Guard missing -o, short -m options, bounded response-file storage, empty QLLIB,
  relocation widths, and section offsets.
* Undefined symbols, duplicate symbols and relocation range errors return a
  nonzero exit status. Previously main computed that status and returned zero.

## Tests

    python3 as68/tests/check.py
    python3 ld/tests/check.py

Validated on x86-64 Linux with GCC, both optimized and with address/undefined-
behaviour sanitizers. The optimized linker passes compilation with:

    -O2 -std=c99 -D_DEFAULT_SOURCE -Wall -Wextra -Wformat=2 -Werror

The linker tests compare exact expected program, relocation and XTcc bytes;
exercise signed addends, selective library loading, names over 40 characters,
map output and existing whitespace-separated @response files; check undefined/
duplicate symbols, truncated input, missing files/options, output-open failures
and /dev/full write failures.

The assembler tests still pass, including 32 concurrent shell.s assemblies.
Leak detection is disabled for the historical process-lifetime allocation arena.

## Limits

Native Apple Clang compilation and execution on macOS remain to be tested on
your Mac. No full EliteQL application/library tree was available for an end-to-end
game build or gameplay test. Please rebuild EliteQL with this linker and retain
your previous binary until that succeeds.

Historical command-line conventions remain: -sSTARTUP, -lNAME, -LPATH, -o OUTPUT.
The linker still automatically searches crt.o and libc.a unless a different
startup is selected with -s. @response files retain their old whitespace-based
syntax; quoted names inside them are not added by this update. Direct command
line paths containing spaces work when shell-quoted.

This is a focused modern POSIX host update, not a complete malformed-object
security audit or a Windows/QDOS-native toolchain port. Historical platform
branches outside the default XTC68 POSIX build are untested. SLB is unchanged.
See README-JAS-MODERN.md for the assembler update. JAS-MODERN.patch captures the
v3 assembler changes; LD-MODERN.patch captures this linker update.
