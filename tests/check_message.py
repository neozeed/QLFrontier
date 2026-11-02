"""Check the game's launch warning, native font, black backing and normal expiry."""
from pathlib import Path
import re,sys
r=Path(__file__).resolve().parents[1]
code=(r/'build/frontier8').read_bytes()
m={n:int(v,16) for n,v in re.findall(r'^(\w+)\s+([0-9A-F]{8})\*?',(r/'build/frontier8.MAP').read_text(),re.M)}
def snapshot(path):
 ram=Path(path).read_bytes();b=ram.find(code[8:20])-8;assert b>=0
 return ram,b,b+m['L5EB6_A6_BASE']
ram,b,g=snapshot(sys.argv[1]);assert ram[g+115]&2
assert int.from_bytes(ram[g+906:g+908],'big')==96
plane=ram[b+m['NATIVE_TEXT']:b+m['NATIVE_TEXT']+51200]
font=b+m['QL_FONT']
for text,y in [('Message from Sirocco Station:',170),('Launching without clearance is not',180),('permitted here. Pay a $500 fine.',190)]:
 x=64
 for c in text:
  f=ram[font+(ord(c)-32)*10:font+(ord(c)-32)*10+10]
  for yy in range(8):
   for xx in range(f[9]):
    assert plane[(y+yy)*256+x+xx]==(2 if f[yy]&(128>>xx) else 1),(c,x,y)
  x+=f[9]
for y in range(168,200):
 for x in range(64,256):
  v=plane[y*256+x];assert v in (1,2)
  a=0x20e00+y*128+x//4*2
  actual=(int.from_bytes(ram[a:a+2],'big')<<((x%4)*2))&0x80c0
  assert actual==(0x80c0 if v==2 else 0),(x,y,'physical pixel')
ram,b,g=snapshot(sys.argv[2]);assert not ram[g+115]&2
plane=ram[b+m['NATIVE_TEXT']:b+m['NATIVE_TEXT']+51200]
for y in range(168,200):assert not any(plane[y*256+64:y*256+256])
assert ram[g+908]!=0,'Original scanner not restored'
print('PASS: original station warning; all native glyph strokes; 6,144 solid Mode 8 pixels; original expiry removes overlay and restores scanner')
