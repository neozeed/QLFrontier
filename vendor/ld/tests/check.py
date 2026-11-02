#!/usr/bin/env python3
"""Linker regressions with exact program/relocation bytes."""
import os
from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
assembler = root.parent / "as68" / "as68"
linker = root / "ld"
os.environ.setdefault("ASAN_OPTIONS", "detect_leaks=0")

with tempfile.TemporaryDirectory(prefix="qdos-ld-") as tmp:
    d = Path(tmp)
    env = dict(os.environ, QLLIB=str(d))
    def assemble(name, text):
        (d / (name + ".s")).write_text(text)
        subprocess.run([str(assembler), str(d / (name + ".s")), "-o", str(d / (name + ".o"))], check=True)
    def link(*args, ok=True):
        r = subprocess.run([str(linker), "-scrt.o", *args], cwd=d, env=env, capture_output=True)
        assert (r.returncode == 0) == ok, (args, r.returncode, r.stdout, r.stderr)
        assert b"runtime error:" not in r.stderr and b"AddressSanitizer" not in r.stderr, r.stderr
        return r
    assemble("crt", ".text\n.globl entry\nentry: rts\n")
    (d / "libc.a").write_bytes(b"")
    assemble("main", ".text\n.globl foo\nfoo: .data4 entry\n.data\n.data4 0x12345678\n.bss\n.space 32\n")
    link("main.o", "-o", "program", "-ms", "-v")
    # RTS, relocated pointer to entry at offset 0, DATA, relocation offset 2,
    # terminator and even padding, XTcc trailer, dataspace 144.
    expected = bytes.fromhex("4e7500000000123456780000000200005854636300000090")
    assert (d / "program").read_bytes() == expected
    assert "ENTRY" in (d / "program.MAP").read_text()
    assemble("negative", ".text\n.data4 entry-2\n")
    link("negative.o", "-o", "negative")
    assert (d / "negative").read_bytes()[2:6] == b"\xff" * 3 + b"\xfe"
    assemble("missing", ".text\n.data4 missing_symbol\n")
    link("missing.o", "-o", "missing", ok=False)
    assemble("duplicate", ".text\n.globl entry\nentry: rts\n")
    link("duplicate.o", "-o", "duplicate", ok=False)
    link("main.o", "-o", ok=False)
    link("not-present.o", ok=False)
    (d / "broken.o").write_bytes(b"\xfb\x06\x10tiny")
    link("broken.o", ok=False)
    # Selective library loading and a symbol beyond the former 40-byte truncation.
    symbol = "symbol_" + "x" * 90
    assemble("reference", ".text\n.data4 " + symbol + "\n")
    assemble("member", ".text\n.globl " + symbol + "\n" + symbol + ": .data2 0x1234\n")
    (d / "libtest.a").write_bytes((d / "member.o").read_bytes())
    link("reference.o", "-ltest", "-o", "library", "-ms")
    assert (d / "library").read_bytes()[:8] == bytes.fromhex("4e75000000061234")
    # Response file compatibility.
    (d / "inputs.rsp").write_text("main.o\n")
    link("@inputs.rsp", "-o", "response")
    assert (d / "response").read_bytes() == expected
    # Open failure must be reported.
    link("main.o", "-o", "absent/output", ok=False)
    if Path("/dev/full").exists():
        link("main.o", "-o", "/dev/full", ok=False)
print("PASS: exact program bytes, relocation, negative addend, library selection, long symbols, maps, response file, errors")
