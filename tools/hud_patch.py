"""Apply audited immediate-only raster extent changes; retain original code sizes."""
import re
def patch_hud(s):
 # Enlarge both original scanline workspaces for 200 rows. Merely changing
 # clipping would overrun their old 168-row arrays.
 a=s.index('L3506e:');b=s.index('L35886_obsolete:',a)
 t=s[a:b]
 t=t.replace('-3366(a7)','-4006(a7)')
 t=t.replace('movea.l\ta7,a6', 'movem.l\td0-7,-(a7)\n\t\tmovem.l\td0-7,-(a7)\n\t\tmovea.l\ta7,a6',1)
 t=t.replace('A5_RedrawMouse(a5)','400(a5)')
 t=re.sub(r'\b(672|1008|1344|1680|2016|2352|2688|3024|3360)\(a5\)',lambda m:str(int(m[1])*400//336)+'(a5)',t)
 t=re.sub(r'\b(3696|3698|3700|3702|3704)\(',lambda m:str(int(m[1])+704)+'(',t)
 t=t.replace('#$150,','#$190,').replace('#$2a0,','#$320,').replace('#$540,','#$640,')
 s=s[:a]+t+s[b:]
 a=s.index('L358aa:');b=s.index('L35c3a:',a)
 t=s[a:b].replace('21912','26072').replace('21910','26070').replace('21574','25670').replace('21578','25674').replace('334(a4)','398(a4)').replace('moveq\t#20,d4','moveq\t#24,d4')
 s=s[:a]+t+s[b:]
 out=[];entries=[]
 for i,line in enumerate(s.splitlines(),1):
  m=re.search(r'\b(cmpi?\.[wl]|move\.[wl])\s+#(\$(?:a7|a8|a9|a7c0|a8c0)|53760)\b',line)
  if i<21400 and m:
   old=int(m[2][1:],16) if m[2].startswith('$') else int(m[2]); new=old+(10240 if old==53760 else 8192 if old>655 else 32)
   label='hud_extent_%d'%len(entries)
   # Preserve an existing branch label and insert an alias before the instruction.
   line=line[:m.start()]+label+':\n\t\t'+line[m.start():]
   entries.append((label,4 if m[1].endswith('.l') else 2,old,new))
  out.append(line)
 s='\n'.join(out)+'\n'
 s=s.replace('L428c6_3dViewLoop:', 'L428c6_3dViewLoop:\n jsr hud_begin_frame')
 old='l429b8:\tjsr\tL3866e_Draw3DView\n\t\tjsr\tL45854_CallAllModfuncs20'
 new='l429b8:\tjsr\tL3866e_Draw3DView\n jsr hud_redirect\n\t\tjsr\tL45854_CallAllModfuncs20\n jsr hud_restore'
 assert old in s;s=s.replace(old,new)
 s+='\n .text\nhud_extent_table:\n'
 for label,size,old,new in entries:s+=f' dc.l {label}+2\n dc.w {size}\n dc.l {old},{new}\n'
 s+=' dc.l 0\n'
 return s,entries
