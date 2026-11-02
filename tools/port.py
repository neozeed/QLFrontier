from pathlib import Path
import re,runpy
r=Path(__file__).resolve().parents[1]
import sys
mode=int(sys.argv[1])
assert mode in (0,8)
s=(r/'reference/fe2.s').read_text()
import sys
sys.path.insert(0,str(r/'tools'))
if mode==8:
 from hud_patch import patch_hud
 s,extents=patch_hud(s)
 (r/'build/hud-extents.txt').write_text('\n'.join(map(str,extents))+'\n')
s=s.replace('move.w\t#$2000,sr','nop\n nop')
# Startup obtains buffers from the QDOS job allocation.
s=re.sub(r'\s*move.l\t#\$(100000|f0000),L5d\w+','',s)
s=re.sub(r'\s*move.l\t#L41e2a_vblank,\$70.w','',s)
s=re.sub(r'\s*move.l\t#InputHandler,\$74.w','',s)
s=re.sub(r'\s*move.l\t#L41d6a,\$18.w','',s)
# Call these as ordinary subroutines from a cooperative event pump.
s=s.replace('\t\trte','\t\trts')
# Shift+QL F1-F5 supplies F6-F10; keep those ASCII results unshifted.
s=s.replace('$c6,$c7,$c8,$c9,$ca', '$f6,$f7,$f8,$f9,$fa')
s=s.replace('l429e6:\ttst.b', 'l429e6:\tjsr ql_pump\n\t\ttst.b')
s=s.replace('bra.w\tL429f6', 'jmp ql_quit')
# Preserve the exact 14-byte span trampoline spacing, despite 6-byte JSRs.
a=s.index('line_draw_col:');b=s.index('new_linecrap:')
s=s[:a]+s[a:b].replace('\t\tnop\n','')+s[b:]
s=re.sub(r'^\s*hcall\s+#(\w+)\s*$',r'\tjsr ql_\1',s,flags=re.M)
s=re.sub(r'^\s*hostcall\s*$',r'\tjsr ql_gemdos',s,flags=re.M)
# Every busy frame wait must service the tick queue, including waits in menus.
s=s.replace('tst.w\tL5eb2_vblank_waits','jsr ql_pump\n\t\ttst.w\tL5eb2_vblank_waits')
# Do not recurse from the original VBL routine.
a=s.index('L41e2a_vblank:');b=s.index('count_vblanks:',a)
s=s[:a]+s[a:b].replace('jsr ql_pump\n\t\t','')+s[b:]
for label in ['L41b2e_FlipScreen','L41cd6_GetAsciiKey','L41d14_GetAsciiKey2']:
 s=s.replace(label+':',label+':\n jsr ql_pump')
# Presentation happens on frame publication and when pumping menu/cursor activity.
s=s.replace('jsr ql_Call_NotifyOfScrFlip','jsr ql_Call_NotifyOfScrFlip\n jsr ql_present_safe')
if mode==8:
 # Keep the FPS digits clear of the parked mouse pointer.
 a=s.index('L41b2e_FlipScreen:');b=s.index('L41b80_LogToLog2:',a)
 s=s[:a]+s[a:b].replace('move.w\t#5,d5','move.w\t#20,d5')+s[b:]
 # Shorten the equipment heading without moving subsequent string-table entries.
 s=s.replace('"SHIP EQUIPMENT STATUS - "\n\t\tdc.b\t$ff,$30,$18,$0', '"Equipment: "\n\t\tdc.b\t$ff,$30,$18,$0\n\t\tds.b\t13')
# Reuse the proven converter, operating on the modified source separately.
code=(r/'tools/convert_equivalence.py').read_text()
code=code.replace("s=(root/'reference/fe2.s').read_text()",'s=PORT_SOURCE')
code=code.replace("(root/'build/equivalence.s')",f"(root/'build/game{mode}.s')")
exec(compile(code,str(r/'tools/convert_equivalence.py'),'exec'),{'__file__':str(r/'tools/convert_equivalence.py'),'PORT_SOURCE':s})
# Normalized game plus native platform support form one JAS translation unit.
parts=[(r/('src/start.s' if mode==8 else 'src/start0.s')).read_text(),(r/f'build/game{mode}.s').read_text(),(r/f'build/platform{mode}.s').read_text()]
alltext='\n'.join(parts)
labels=[]
for line in alltext.splitlines():
 if not line.lstrip().startswith('*'): labels+=re.findall(r'\b([A-Za-z_]\w*):',line)
existing=set(re.findall(r'\.globl\s+(\w+)',alltext))
alltext+='\n'+''.join(' .globl '+x+'\n' for x in labels if x not in existing)
(r/f'build/frontier{mode}.s').write_text(alltext)
