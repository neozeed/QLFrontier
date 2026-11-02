"""Validate an original encrypted save and stable fields after an actual menu load."""
from pathlib import Path
import re,sys
r=Path(__file__).resolve().parents[1]
p=Path(sys.argv[1]).read_bytes()
assert p[:2]==b'\0\x11' and len(p)%2==0
state=0x12350fd4;data=bytearray()
for i in range(2,len(p)-4,2):
 v=int.from_bytes(p[i:i+2],'big')^(state&65535)
 data+=v.to_bytes(2,'big')
 state=(state+(v if v<32768 else v-65536))&0xffffffff
 state=((state<<1)|(state>>31))&0xffffffff
assert state==int.from_bytes(p[-4:],'big'),'Original save checksum'
def unpack(pos,size):
 out=bytearray()
 while len(out)<size:
  v=data[pos];pos+=1;out.append(v)
  if v==0 and len(out)<size:
   count=data[pos];pos+=1;out.extend(bytes(count))
 assert len(out)==size
 return pos,out
pos,objects=unpack(0,0x80ee)
saved=bytearray(data[pos:pos+524]);pos+=524
pos,tail=unpack(pos,0x3662);saved+=tail
assert len(saved)==14446
ram=Path(sys.argv[2]).read_bytes();exe=(r/'build/frontier8').read_bytes()
b=ram.find(exe[8:20])-8;assert b>=0
m={n:int(v,16) for n,v in re.findall(r'^(\w+)\s+([0-9A-F]{8})\*?',(r/'build/frontier8.MAP').read_text(),re.M)}
g=b+m['L5EB6_A6_BASE']
for start,end,name in [(528,532,'date'),(726,730,'system'),(754,818,'cargo/equipment state'),(14400,14428,'commander name')]:
 assert ram[g+start:g+end]==saved[start:end],name
assert ram[g+10469]==0,'Still in file menu'
assert int.from_bytes(ram[g+16828:g+16832],'big')==len(p),'Selected save length'
assert int.from_bytes(ram[b+m['HUD_ACTIVE']:b+m['HUD_ACTIVE']+2],'big')==1
print(f'PASS: original encrypted {len(p):,}-byte save/checksum; fresh menu load restores commander, date, system and manifest; flight resumes')
