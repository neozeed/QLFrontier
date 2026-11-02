"""Select display-only fragments; both builds share game, services and text code."""
from pathlib import Path
import re
r=Path(__file__).resolve().parents[1]
read=lambda p:(r/p).read_text()
shared=read('src/services.s');tables=read('src/tables.s');text=read('src/text.s')
(r/'build/platform8.s').write_text(''.join(read('src/'+n+'.s') for n in ['wrappers','services','tables','data','hud','text','menu']))
# Original Mode 4 converter/cache expansion; retain all shared native services.
a=shared.index('ql_build_dither:');b=shared.index('* Four planes',a)
shared=shared[:a]+shared[b:]
shared=shared[:shared.index('expand_colour:')]
shared=shared.replace(' jsr menu_cache_colour\n','').replace('main_dither+32,a1','main_dither+1024,a1')
a=shared.index(' tst.w hud_redirected\n beq legacy_game_buffer');b=shared.index('legacy_game_buffer:',a)
shared=shared[:a]+shared[b:]
# Same nearest-colour table as prototype01, unpacked from the shared generator.
a=tables.index('rgb_dither:');b=tables.index('menu_rgb:',a);end=tables.index('ql_keymap:',b)
packed=[int(v.strip()) for line in tables[b:end].splitlines() if line.startswith(' dc.b ') for v in line[6:].split(',')]
assert len(packed)==16384
rows=['rgb_dither:']
for i in range(0,len(packed),4):
 values=[(v>>shift)&3 for v in packed[i:i+4] for shift in [6,4,2,0]]
 rows.append(' dc.b '+','.join(map(str,values)))
tables=tables[:a]+'\n'.join(rows)+'\n even\n'+tables[end:]
text=text[:text.index('text_present_row_safe:')]
(r/'build/platform0.s').write_text(read('src/wrappers.s')+shared+read('src/mode0.s')+text+tables+read('src/data0.s'))
