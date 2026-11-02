#!/usr/bin/env python3
"""Focused stream, SROFF encoding and full EliteQL source regressions."""
import concurrent.futures
import hashlib
import os
from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
assembler = str(root / "as68")
os.environ.setdefault("ASAN_OPTIONS", "detect_leaks=0") # old one-shot allocation arena

def invoke(*args, ok=True, cwd=None):
    r = subprocess.run([assembler, *map(str, args)], cwd=cwd, capture_output=True)
    assert (r.returncode == 0) == ok, (args, r.returncode, r.stderr.decode())
    assert not r.stdout, "object bytes leaked to stdout"
    return r

with tempfile.TemporaryDirectory() as tmp:
    d = Path(tmp)
    src = d / "test.s"
    obj = d / "test.o"
    src.write_text(".text\n.data4 0x12345678\n.data2 0x80fb\n.bss\n.space 0x1234\n")
    invoke(src, "-o", obj)
    data = obj.read_bytes()
    assert b"\xfb\x04\xff\xff\x12\x34\x56\x78\x80\xfb\xfb" in data
    assert b"\xfb\x04\xff\xfd\xfb\x05\x00\x00\x12\x34\xfb\x13" in data
    original = src.read_bytes()
    invoke(src, "-o", src, ok=False)
    assert src.read_bytes() == original
    alias = d / "alias.s"
    os.link(src, alias)
    invoke(src, "-o", alias, ok=False)
    assert src.read_bytes() == original
    invoke(d / "missing.s", "-o", obj, ok=False)
    assert obj.read_bytes() == data
    invoke(src, "-o", d / "missing" / "out.o", ok=False)
    invoke(src, "-o", ok=False)
    longsrc = d / ("x" * 100 + ".s")
    longsrc.write_bytes(original)
    invoke(longsrc, cwd=d)
    assert (d / ("x" * 100 + ".o")).exists()
    src.write_text(".text\nthis_is_invalid!\n")
    invoke(src, "-o", obj, ok=False)
    assert not obj.exists()
    # Same output basename: SROFF embeds the exact filename, so use isolated cwds.
    def shell_test(i):
        work = d / str(i)
        work.mkdir()
        invoke(root / "tests" / "shell.s", "-o", "shell.o", cwd=work)
        return hashlib.sha256((work / "shell.o").read_bytes()).hexdigest()
    with concurrent.futures.ThreadPoolExecutor(max_workers=8) as pool:
        hashes = list(pool.map(shell_test, range(32)))
    assert len(set(hashes)) == 1
    wrapper = root.parent / "scripts" / "as"
    src = d / "input with spaces.s"
    src.write_text('# preprocess\n#define NUMBER 0x12345678\n.text\n.data4 NUMBER\n')
    original = src.read_bytes()
    env = dict(os.environ, QDOS_AS68=assembler)
    r = subprocess.run([str(wrapper), str(src), "-o", str(obj)], env=env, capture_output=True)
    assert r.returncode == 0, r.stderr
    assert src.read_bytes() == original
    assert b"\x12\x34\x56\x78" in obj.read_bytes()
print("PASS: SROFF bytes, file failures, aliases, long paths, wrapper, 32 concurrent shell assemblies")
