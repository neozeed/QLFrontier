"""Reference conversion plus frozen variant regressions."""
from pathlib import Path
import re,subprocess,os,hashlib,json
r=Path(__file__).resolve().parents[1];os.chdir(r)
subprocess.run(['python3','tools/convert_equivalence.py'],check=True)
subprocess.run(['vendor/as68/as68','-N','build/equivalence.s','-o','build/equivalence.o'],check=True)
subprocess.run(['vendor/ld/ld','-Sbuild/equivalence.o','build/empty.o','-o','build/equivalence.bin','-ms'],env=dict(os.environ,QLLIB='vendor/lib'),check=True)
p=(r/'reference/original.prg').read_bytes();size=int.from_bytes(p[2:6],'big');assert size==537120
assert (r/'build/equivalence.bin').read_bytes()[:size]==p[28:28+size]
print('PASS: all 537,120 original loaded bytes match the JAS conversion')
for mode in [0,8]:
 s=(r/f'build/frontier{mode}.s').read_text();m=(r/f'build/frontier{mode}.MAP').read_text()
 labels={n.upper():int(v,16) for n,v in re.findall(r'^(\w+)\s+([0-9A-F]{8})\*?',m,re.M)}
 n=0
 for width,dest,origin in re.findall(r'dc\.([bw])\s+(\w+)-(branch_\d+)-2',s):
  delta=labels[dest.upper()]-labels[origin.upper()]-2
  assert (-128<=delta<=127 and delta!=0) if width=='b' else -32768<=delta<=32767
  n+=1
 assert not re.search(r'^\s*(hcall|hostcall|rte)\b',s,re.M)
 origin=None
 for line in s.splitlines():
  lab=re.match(r'\s*(\w+):',line)
  if lab:origin=lab[1].upper()
  branch=re.match(r'\s*b(?:sr|ra|eq|ne|cs|cc|hi|ls|lt|le|gt|ge|mi|pl|vs|vc)(?:\.[swb])?\s+(\w+)\s*$',line)
  if branch and origin in labels and branch[1].upper() in labels:
   assert abs(labels[branch[1].upper()]-labels[origin])<32000,(mode,origin,branch[1],'native branch too far')
 print(f'PASS: frontier{mode}: {n:,} original-game branches; no VM opcodes/RTE')
baseline=json.loads((r/'tests/baselines.json').read_text())
sha=lambda x:hashlib.sha256(x).hexdigest()
# Mode 8 now replays active communications; retain original Mode 0 baselines.
assert sha((r/'build/game0.s').read_bytes())==baseline['game0_experiment01']
t=(r/'build/platform0.s').read_text().split('rgb_dither:')[1].split('ql_keymap:')[0]
data=bytes(int(v.strip()[1:],16) if v.strip().startswith('$') else int(v.strip()) for line in t.splitlines() if line.startswith(' dc.b ') for v in line[6:].split(','))
assert len(data)==65536 and sha(data)==baseline['mode0_dither_experiment01']
print('PASS: frontier0 game source and dither table identical to experiment01')

t=(r/'build/platform0.s').read_text();a=t.index('impl_Call_SetMainPalette:');end=' dbra d7,ext_palette_next\n rts\n';b=t.index(end,a)+len(end)
assert sha(t[a:b].encode())==baseline['mode0_palette_services']
print('PASS: original Mode 4 palette upload and extended-colour cache layout')
