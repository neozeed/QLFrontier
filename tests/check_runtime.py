"""Check guard words and live raster extent switches in a captured QLBox RAM image."""
from pathlib import Path
import re,sys
r=Path(__file__).resolve().parents[1]
ram=Path(sys.argv[1]).read_bytes();expected=int(sys.argv[2])
code=(r/'build/frontier8').read_bytes();base=ram.find(code[8:20])-8;assert base>=0
labels={n:int(v,16) for n,v in re.findall(r'^(\w+)\s+([0-9A-F]{8})\*?',(r/'build/frontier8.MAP').read_text(),re.M)}
def value(a,n=4):return int.from_bytes(ram[a:a+n],'big')
for name in ['HUD_GUARD_BEFORE','HUD_GUARD_AFTER','SCREEN_A_GUARD','SCREEN_B_GUARD','STACK_TOP_GUARD','TEXT_GUARD_AFTER']:
 assert value(base+labels[name])==0x6b1dca55,name
assert value(base+labels['HUD_ACTIVE'],2)==expected,'Wrong flight/map mode'
p=base+labels['HUD_EXTENT_TABLE'];count=0
while value(p):
 address=value(p);size=value(p+4,2);old=value(p+6);new=value(p+10)
 assert value(address,size)==(new if expected else old),(hex(address),old,new)
 count+=1;p+=14
assert count>40
assert value(base+labels['L63880']+4,2)==(1 if expected else 158)
assert value(base+labels['DISPLAY_MODE'],2)==(8 if expected else 4)
print(f'PASS: 6 boundary guards;  {count} raster extents; status position; HUD={expected}')
