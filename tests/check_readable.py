"""Check native glyphs and their physical Mode 8 pixels from an emulator RAM dump."""
from pathlib import Path
import re,sys
r=Path(__file__).resolve().parents[1]
ram=Path(sys.argv[1]).read_bytes();code=(r/'build/frontier8').read_bytes()
b=ram.find(code[8:20])-8;assert b>=0
labels={n:int(v,16) for n,v in re.findall(r'^(\w+)\s+([0-9A-F]{8})\*?',(r/'build/frontier8.MAP').read_text(),re.M)}
plane=ram[b+labels['NATIVE_TEXT']:b+labels['NATIVE_TEXT']+51200]
font=b+labels['QL_FONT']
assert set(plane)<={0,1,2}
def physical(x,y):
 a=0x20e00+y*128+(x//4)*2
 w=int.from_bytes(ram[a:a+2],'big')
 return (w << ((x%4)*2)) & 0x80c0
def glyphs(text,x,y):
 for c in text:
  f=ram[font+(ord(c)-32)*10:font+(ord(c)-32)*10+10]
  for yy in range(8):
   for xx in range(f[9]):
    expected=2 if f[yy] & (0x80>>xx) else 1
    assert plane[(y+yy)*256+x+xx]==expected,(c,x+xx,y+yy,'native glyph')
    assert physical(x+xx,y+yy)==(0x80c0 if expected==2 else 0),(c,x+xx,y+yy,'physical glyph')
  x+=f[9]
for text,x,y in [('Actual:',103,1),('Set:',185,1),('Alt.',103,21),('Relative to:',103,11),('1-Jan-3200',1,191)]:
 glyphs(text,x,y)
# Blank margins in the clock panel are opaque black, never scene dithering.
for y in [180,189,190,199]:
 for x in range(48):assert physical(x,y)==0,(x,y,'opaque panel')
assert any(plane[181*256:189*256]),'clock missing'
print('PASS: unscaled font strokes and solid physical pixels; reflowed fields/date; opaque clock panel')

# The original FPS formatter now writes directly to the flight text plane.
count=0
for y in range(5,13):
 for x in range(16,36):
  pixel=plane[y*256+x]
  if pixel:
   assert physical(x,y)==(0x80c0 if pixel==2 else 0)
   count+=1
assert count>=24,count
print('PASS: real FPS text reaches Mode 8 as solid, uncollapsed pixels')
