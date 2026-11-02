from pathlib import Path
r=Path(__file__).resolve().parents[1]
s=(r/'build/frontier.s').read_text().replace(' jmp L426e2_main',' jmp presentbench')
s+='\n'+(r/'tests/presentbench.s').read_text()
(r/'build/presentbench.s').write_text(s)
