from pathlib import Path
import re
r=Path(__file__).resolve().parents[1]
s=(r/'reference/fe2.s').read_text()
names=sorted(set(re.findall(r'^\s*hcall\s+#(\w+)',s,re.M)))
text=['* Native QDOS service ABI. A4 points at original stack arguments.','* A5 points at saved D0-D7/A0-A6 (four bytes each).']
for n in names+['gemdos']:
 label='ql_'+n
 text += [label+':',' move.w sr,-(a7)',' movem.l d0-d7/a0-a6,-(a7)',' lea 66(a7),a4',' lea (a7),a5',' jsr impl_'+n,' movem.l (a7)+,d0-d7/a0-a6',' move.w (a7)+,ccr',' rts']
(r/'src/wrappers.s').write_text('\n'.join(text)+'\n')
# Original embedded font, exactly as used by the VM.
c=(r/'reference/fe2.c').read_text()
a=c.split('static const unsigned char font_bmp[] = {')[1].split('};')[0]
vals=[int(x,16) for x in re.findall('0x([0-9a-f]+)',a)]
out=['ql_font:']
for i in range(0,len(vals),16):out+=[' dc.b '+','.join('$%02x'%v for v in vals[i:i+16])]
# 4x4 ordered RGB cube dithering; 16 samples per RGB444 colour.
bayer=[0,8,2,10,12,4,14,6,3,11,1,9,15,7,13,5]
out+=[' even','rgb_dither:']
for rgb in range(4096):
 levels=[(((rgb>>shift)&15)*16+7)//15 for shift in (4,8,0)]
 vals=[sum(bit for bit,level in zip((4,2,1),levels) if level>t) for t in bayer]
 out+=[' dc.b '+','.join(str(v) for v in vals)]
# Four packed two-bit rows per RGB444 colour for high-resolution UI screens.
colors=[(0,0,0),(15,0,0),(0,15,0),(15,15,15)]
out+=[' even','menu_rgb:']
for rgb in range(4096):
 target=[(rgb>>8)&15,(rgb>>4)&15,rgb&15];best=None
 for a in range(4):
  for b in range(a,4):
   for n in range(17):
    err=sum(w*(target[k]*16-(colors[a][k]*(16-n)+colors[b][k]*n))**2 for k,w in enumerate([3,6,2]))
    candidate=(err,n,a,b)
    if best is None or candidate<best:best=candidate
 _,n,a,b=best
 phases=[b if t<n else a for t in bayer]
 packed=[sum(phases[y*4+x]<<(6-2*x) for x in range(4)) for y in range(4)]
 out+=[' dc.b '+','.join(map(str,packed))]
# QL key number -> Atari ST scan code. F6-F10 use Shift+F1-F5.
alpha=[0x1c,0x2c,0x2b,0x1e,0xc,0x24,0x26,0x1a,0x12,0x1f,0x22,0x18,0x2e,6,0x17,0x1d,0xb,0x14,0x23,0xe,0xf,4,0x11,3,0x16,0x29]
st=[0x1e,0x30,0x2e,0x20,0x12,0x21,0x22,0x23,0x17,0x24,0x25,0x26,0x32,0x31,0x18,0x19,0x10,0x13,0x1f,0x14,0x16,0x2f,0x11,0x2d,0x15,0x2c]
keys=[0]*64
for q,a in zip(alpha,st): keys[q]=a
for q,a in zip([0xd,0x1b,9,0x19,0x3e,0x3a,0xa,0x3f,8,0x10],[0xb,2,3,4,5,6,7,8,9,10]):keys[q]=a
for q,a in {0:0x2a,1:0x1d,2:0x38,0x39:0x3b,0x3b:0x3c,0x3c:0x3d,0x38:0x3e,0x3d:0x3f,0x32:0x48,0x37:0x50,0x31:0x4b,0x34:0x4d,0x36:0x39,0x30:0x1c,0x13:0xf,0x33:1,0x20:0x1a,0x28:0x1b,0x27:0x27,7:0x33,0x2a:0x34,5:0x35,0x35:0x2b,0x2f:0x28,0x15:0xc,0x25:0xd,0x2d:0x29}.items(): keys[q]=a
out+=['ql_keymap:',' dc.b '+','.join(str(x) for x in keys),' even']
c=(r/'reference/hostcall.c').read_text()
a=c.split('static const char mouse_bmp[256] = {')[1].split('};')[0]
vals=[int(x) for x in re.findall(r'-?\d+',a)]
assert len(vals)==256
out+=['cursor_pixels:']
for i in range(0,256,16):out+=[' dc.b '+','.join(str(v) for v in vals[i:i+16])]
out+=[' even']
(r/'src/tables.s').write_text('\n'.join(out)+'\n')
