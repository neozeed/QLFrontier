"""Independent pixel oracle for Mode 4 menus, including solid native text."""
from pathlib import Path
import re,sys
r=Path(__file__).resolve().parents[1]
ram=Path(sys.argv[1]).read_bytes();code=(r/'build/frontier8').read_bytes();b=ram.find(code[8:20])-8
assert b>=0
ls={n:int(v,16) for n,v in re.findall(r'^(\w+)\s+([0-9A-F]{8})\*?',(r/'build/frontier8.MAP').read_text(),re.M)}
def value(n,size=4):return int.from_bytes(ram[b+ls[n]:b+ls[n]+size],'big')
assert value('DISPLAY_MODE',2)==4
screen=value('DISPLAY_BUFFER');assert screen in (b+ls['SCREEN_A'],b+ls['SCREEN_B'])
mask=b+ls['TEXT_MASK_A' if screen==b+ls['SCREEN_A'] else 'TEXT_MASK_B']
flat=value('MENU_FLAT_BACKGROUND',2)
native=b+ls['NATIVE_TEXT']
errors=[];tagged=0
for y in range(200):
 palette=b+ls['MENU_MAIN' if y<168 else 'MENU_PANEL']
 for x in range(512):
  sx=x//8*5+(0,0,1,2,2,3,4,4)[x%8];p=y*320+sx;index=ram[screen+p]
  tag=(ram[mask+p//8]>>(p%8))&1
  if y>=168 and sx<64:
   expected=3 if y>=180 and sx<48 and ram[native+y*256+sx]==2 else 0
  elif tag:
   expected=3 if index else 0;tagged+=1
  elif flat and index==14:expected=0
  else:expected=(ram[palette+index*4+(y%4)]>>(6-2*(x%4)))&3
  a=0x20e00+y*128+(x//8)*2;word=int.from_bytes(ram[a:a+2],'big')
  actual=((word>>(7-x%8))&1)|(((word>>(15-x%8))&1)<<1)
  # The original cursor is restored/redrawn asynchronously at the parked
  # top-left position. Exclude its 16-source-pixel rectangle from this snapshot.
  if not (x<26 and y<16) and actual!=expected:errors.append((x,y,actual,expected))
assert not errors,(len(errors),errors[:10])
assert tagged>1000,tagged
assert not any(ram[0x20000:0x20e00]),'top margin'
assert not any(ram[0x27200:0x28000]),'bottom margin'
# Options heading: every glyph bit is present in its source tag plane.
if len(sys.argv)>2 and sys.argv[2]=='options':
 x=6;y=9;font=b+ls['QL_FONT']
 for c in 'Level ':x+=ram[font+(ord(c)-32)*10+9]
 for c in 'of Shape Detail:':
  f=ram[font+(ord(c)-32)*10:font+(ord(c)-32)*10+10]
  for yy in range(8):
   for xx in range(f[9]):
    p=(y+yy)*320+x+xx
    if f[yy]&(0x80>>xx):
     assert ram[mask+p//8]&(1<<(p%8)),(c,x+xx,y+yy,'missing foreground tag')
     assert ram[screen+p]==15,(c,x+xx,y+yy,'glyph foreground')
    else:
     # Original background painting can replace zero-valued letter backing.
     assert ram[screen+p]==0 or (flat and ram[screen+p]==14),(c,x+xx,y+yy,'glyph background')
  x+=f[9]
print(f'PASS: 101,984 Mode 4 pixels outside cursor rectangle; {tagged:,} solid text samples; opaque clock/date; black margins')
