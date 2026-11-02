from pathlib import Path
r=Path(__file__).resolve().parents[1]
s=(r/'tests/presentbench.s').read_text()
s=s.replace(' * Time 200', ''' lea hud_buffer,a0
 move.w #63999,d0
 moveq #0,d1
hb_fill:
 move.b d1,d2
 and.b #31,d2
 bne hb_shadow
 move.b #15,(a0)
 bra hb_next
hb_shadow:
 cmp.b #1,d2
 bne hb_next
 move.b #255,(a0)
hb_next:
 addq.l #1,a0
 addq.b #1,d1
 dbra d0,hb_fill
 lea hud_rows,a0
 move.w #199,d0
hb_rows:
 st (a0)+
 dbra d0,hb_rows
 move.w #1,hud_active
 * Time 200''')
s=(r/'build/frontier.s').read_text().replace(' jmp L426e2_main',' jmp presentbench')+'\n'+s
(r/'build/hudbench.s').write_text(s)
