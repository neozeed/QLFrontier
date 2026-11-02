#!/usr/bin/env python3
from pathlib import Path
import re
root=Path(__file__).resolve().parents[1]
s=(root/'reference/fe2.s').read_text()
s=re.sub(r'\b([da])([0-7])-([0-7])\b',r'\1\2-\1\3',s)
out=[' .text']
for line in s.splitlines():
 if re.match(r'\s*dc.b\s+"',line):
  st=line.split('"',1)[1].rsplit('"',1)[0].replace('""','"')
  line='\tdc.b '+','.join('$%02x'%ord(c) for c in st)
 line=re.sub(r'^\s*hcall\s+#(\w+).*$',r'\tdc.w $000b,\1',line)
 line=re.sub(r'^\s*hostcall\s*$',r'\tdc.w $000a',line)
 line=re.sub(r'\b(b[a-z]+)\.s\b',r'\1.b',line)
 line=re.sub(r'(\$[0-9a-fA-F]+)\.w',r'\1',line)
 if re.search(r'\bmovem\.',line) and '(pc' in line:
  line=re.sub(r'(\w+)\(pc',r'\1-2(pc',line)
 mimm=re.search(r'\bmove\.l\s+#([^,]+),d([0-7])',line)
 if mimm and not line.lstrip().startswith('*'):
  line=line[:mimm.start()]+'dc.w $%04x\n dc.l %s'%(0x203c+(int(mimm[2])<<9),mimm[1])
 m=re.search(r'\b(bra|bsr|bhi|bls|bcc|bcs|bne|beq|bvc|bvs|bpl|bmi|bge|blt|bgt|ble)\.(b|w)\s+(\w+)',line)
 if m and not line.lstrip().startswith('*'):
  op,size,dest=m.groups(); code=0x60+['bra','bsr','bhi','bls','bcc','bcs','bne','beq','bvc','bvs','bpl','bmi','bge','blt','bgt','ble'].index(op)
  label='branch_%d'%len(out)
  prefix=line[:m.start()]
  line=prefix+label+':\n'
  if size=='b': line+=' dc.b $%02x\n dc.b %s-%s-2'%(code,dest,label)
  else: line+=' dc.w $%04x\n dc.w %s-%s-2'%(code<<8,dest,label)
 out.append(line)
out+=[' .globl '+x for x in re.findall(r'^\s*(\w+):',s,re.M)]
out+=[' .globl image_end','image_end:']
(root/'build/equivalence.s').write_text('\n'.join(out)+'\n')
