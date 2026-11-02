from pathlib import Path
import sys
r=Path(__file__).resolve().parents[1]
s=(r/'build/frontier8.s').read_text().replace(' jmp L426e2_main',' jmp filetest')
t=(r/'tests/filetest.s').read_text()
if len(sys.argv)>1 and sys.argv[1]=='numbered':t=t.replace("'QPORT'", "'QPORT._01'")
s+='\n'+t
(r/'build/filetest.s').write_text(s)
