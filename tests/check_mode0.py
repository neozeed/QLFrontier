"""Original-sized Mode 4 framebuffer oracle: only tagged text bypasses dithering."""
from pathlib import Path
import re,sys
r=Path(__file__).resolve().parents[1];ram=Path(sys.argv[1]).read_bytes();code=(r/'build/frontier0').read_bytes();base=ram.find(code[8:20])-8;assert base>=0
ls={n:int(v,16) for n,v in re.findall(r'^(\w+)\s+([0-9A-F]{8})\*?',(r/'build/frontier0.MAP').read_text(),re.M)}
def v(n,size=4):return int.from_bytes(ram[base+ls[n]:base+ls[n]+size],'big')
for n in ['TEXT_GUARD_AFTER','SCREEN_A_GUARD','SCREEN_B_GUARD','STACK_TOP_GUARD']:assert v(n)==0x6b1dca55,n
assert int.from_bytes(ram[base+ls['L63880']+4:base+ls['L63880']+6],'big')==158
assert 'HUD_EXTENT_TABLE' not in ls
print('PASS: four guards; original HUD position and unextended viewport')
if len(sys.argv)>2 and sys.argv[2]=='pixels':
 screen=v('DISPLAY_BUFFER');assert screen in (base+ls['SCREEN_A'],base+ls['SCREEN_B'])
 mask=base+ls['TEXT_MASK_A' if screen==base+ls['SCREEN_A'] else 'TEXT_MASK_B'];errors=[];tags=0
 for y in range(200):
  pal=base+ls['MAIN_DITHER' if y<168 else 'PANEL_DITHER']
  for x in range(320):
   p=y*320+x;index=ram[screen+p];tag=ram[mask+p//8]&(1<<(p%8))
   if tag:expected=0x8080 if index else 0;tags+=1
   else:
    a=pal+index*64+(y%4)*16+(x%8)*2
    expected=(int.from_bytes(ram[a:a+2],'big')<<(x%8))&0x8080
   a=0x20e18+y*128+(x//8)*2
   actual=(int.from_bytes(ram[a:a+2],'big')<<(x%8))&0x8080
   if not(x<16 and y<16) and actual!=expected:errors.append((x,y,actual,expected))
 assert not errors,(len(errors),errors[:10]);assert tags>1000
 for y in range(256):
  row=ram[0x20000+y*128:0x20000+(y+1)*128]
  assert not any(row if y<28 or y>=228 else row[:24]+row[104:]),('margin',y)
 print(f'PASS: 63,744 pixels outside parked cursor; {tags:,} solid text pixels; original dither, panel split and margins')
