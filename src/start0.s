 .text
 .globl ql_start
ql_start:
 bra.w ql_reloc
 dc.l 0
 dc.w $4afb,8
 dc.b $46,$72,$6f,$6e,$74,$69,$65,$72
 even
ql_reloc:
 lea ql_start(pc),a0
 move.l a0,d7
 dc.w $203c
 dc.l file_end
 lea 0(a0,d0.l),a1
 move.l (a1)+,d0
 beq ql_relocated
 adda.l d0,a0
ql_fix:
 add.l d7,(a0)
ql_nextfix:
 moveq #0,d0
 move.b (a1)+,d0
 beq ql_relocated
 cmp.w #1,d0
 bne ql_fixnext
 adda.w #254,a0
 bra ql_nextfix
ql_fixnext:
 adda.w d0,a0
 bra ql_fix
ql_relocated:
 lea file_end,a0
 lea mem_end,a1
ql_zero:
 cmpa.l a1,a0
 bcc ql_zero_done
 clr.b (a0)+
 bra ql_zero
ql_zero_done:
 lea stack_end,a7
 moveq #$10,d0
 moveq #0,d1
 moveq #-1,d2
 trap #1
 move.l #ql_tick,poll_link+4
 lea poll_link,a0
 moveq #$1c,d0
 trap #1
 move.l #screen_a,L5d9e_logscreen
 move.l #screen_b,L5da2_physcreen
 move.l #screen_a,L5da6_logscreen2
 move.l #screen_b,L5daa_physcreen2
 lea $20000,a0
 move.w #8191,d0
ql_cls:
 clr.l (a0)+
 dbra d0,ql_cls
 jsr ql_build_dither
 jsr mode0_init_guards
 jmp L426e2_main
ql_tick:
 addq.l #1,pending_ticks
 rts
ql_quit:
 lea poll_link,a0
 moveq #$1d,d0
 trap #1
 moveq #-1,d1
 moveq #0,d3
 moveq #5,d0
 trap #1
 bra ql_quit
