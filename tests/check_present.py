"""Check native display packing against a Python oracle; report 200-frame timing.
Usage: python3 tests/check_present.py PATH_TO_BUILD 4|8
Requires presentbench, presentbench.MAP, bench.ram and ../src/tables.s.
"""
from pathlib import Path
import re,sys,json
b=Path(sys.argv[1]);mode=int(sys.argv[2]);assert mode in (4,8)
hud=len(sys.argv)>3 and sys.argv[3]=='hud'
name='hudbench' if hud else 'presentbench'
ram=(b/('hudbench.ram' if hud else 'bench.ram')).read_bytes();code=(b/name).read_bytes()
base=ram.find(code[8:20])-8;assert base>=0
labels={n:int(v,16) for n,v in re.findall(r'^(\w+)\s+([0-9A-F]{8})\*?',(b/(name+'.MAP')).read_text(),re.M)}
def value(n):
 a=base+labels[n];return int.from_bytes(ram[a:a+4],'big')
assert value('BENCH_DONE')==0x42454e43,'benchmark did not finish'
s=(b.parent/'src/tables.s').read_text().split('rgb_dither:')[1].split('ql_keymap:')[0]
table=[]
for line in s.splitlines():
 if 'dc.b' in line:table.extend(int(x.strip()) for x in line.split('dc.b')[1].split(','))
expected=bytearray(32768)
for y in range(200):
 if mode==8:
  for group in range(64):
   word=0
   for k,dx in enumerate([0,1,3,4]):
    idx=(y*320+group*5+dx)&255;c=table[((idx*17+(0x987 if y>=168 and not hud else 0))&4095)*16+(y&3)*4+k]
    mask=((0x8000 if c&4 else 0)|(0x80 if c&2 else 0)|(0x40 if c&1 else 0))>>(2*k)
    word|=mask
    if hud and (y<168 or 80<=group*5+dx<240):
     mark=idx&31
     if mark in (0,1):
      c=table[((15*17+(0x987 if y>=168 else 0))&4095)*16] if mark==0 else 0
      mask=((0x8000 if c&4 else 0)|(0x80 if c&2 else 0)|(0x40 if c&1 else 0))>>(2*k)
      word=(word&(~(0x80c0>>(2*k))&65535))|mask
   pos=(y+28)*128+group*2
   expected[pos:pos+2]=word.to_bytes(2,'big')
 else:
  for group in range(40):
   word=0
   for k in range(8):
    x=group*8+k;idx=(y*320+x)&255
    c=table[((idx*17)&4095)*16+(y&3)*4+(x&3)]
    word|=((1<<(7-k)) if c&1 else 0)|((1<<(15-k)) if c&2 else 0)
   pos=(y+28)*128+24+group*2
   expected[pos:pos+2]=word.to_bytes(2,'big')
actual=ram[0x20000:0x28000]
assert actual==expected, f'packed framebuffer mismatch: {sum(a!=b for a,b in zip(actual,expected))} bytes'
result={'mode':mode,'dither':'4x4','hud_synthetic':hud,'frames':200,'ticks_50hz':value('BENCH_TICKS'),'ms_per_conversion_at_speed8':value('BENCH_TICKS')*20/200,'framebuffer_bytes_verified':32768}
print(json.dumps(result,indent=2))
