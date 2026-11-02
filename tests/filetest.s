 .text
filetest:
 move.w #0,-(a7)
 pea ft_name
 move.w #$3c,-(a7)
 move.l #1,ft_step
 jsr ql_gemdos
 addq.l #8,a7
 cmp.l #64,d0
 bne ft_fail
 move.w d0,ft_handle
 pea ft_payload
 move.l #16,-(a7)
 move.w ft_handle,-(a7)
 move.w #$40,-(a7)
 move.l #2,ft_step
 jsr ql_gemdos
 adda.w #12,a7
 cmp.l #16,d0
 bne ft_fail
 bsr ft_close
 move.w #0,-(a7)
 pea ft_name
 move.w #$3d,-(a7)
 move.l #3,ft_step
 jsr ql_gemdos
 addq.l #8,a7
 cmp.l #64,d0
 bne ft_fail
 move.w d0,ft_handle
 pea ft_buffer
 move.l #32,-(a7)
 move.w ft_handle,-(a7)
 move.w #$3f,-(a7)
 move.l #4,ft_step
 jsr ql_gemdos
 adda.w #12,a7
 cmp.l #16,d0
 bne ft_fail
 lea ft_buffer,a0
 lea ft_payload,a1
 moveq #15,d1
ft_cmp:
 cmpm.b (a0)+,(a1)+
 bne ft_fail
 dbra d1,ft_cmp
 bsr ft_close
 pea ft_dta
 move.w #$1a,-(a7)
 move.l #5,ft_step
 jsr ql_gemdos
 addq.l #6,a7
 move.w #0,-(a7)
 pea ft_mask
 move.w #$4e,-(a7)
 move.l #6,ft_step
 jsr ql_gemdos
 addq.l #8,a7
 tst.l d0
 bne ft_fail
ft_find_name:
 lea ft_dta+30,a0
 lea ft_name,a1
ft_name_cmp:
 move.b (a1)+,d0
 cmp.b (a0)+,d0
 bne ft_next
 tst.b d0
 bne ft_name_cmp
 cmp.l #16,ft_dta+26
 bne ft_fail
 pea ft_name
 move.l #7,ft_step
 jsr ql_Call_Fdelete
 addq.l #4,a7
 tst.l d0
 bne ft_fail
 move.w #0,-(a7)
 pea ft_name
 move.w #$3d,-(a7)
 move.l #8,ft_step
 jsr ql_gemdos
 addq.l #8,a7
 cmp.l #-33,d0
 bne ft_fail
 lea poll_link,a0
 moveq #$1d,d0
 trap #1
 moveq #-1,d1
 moveq #0,d3
 moveq #5,d0
 trap #1
ft_next:
 move.w #$4f,-(a7)
 jsr ql_gemdos
 addq.l #2,a7
 tst.l d0
 bne ft_fail
 bra ft_find_name
ft_fail:
 lea poll_link,a0
 moveq #$1d,d0
 trap #1
 moveq #-1,d1
 move.l ft_step,d3
 moveq #5,d0
 trap #1
ft_close:
 move.w ft_handle,-(a7)
 move.w #$3e,-(a7)
 move.l #9,ft_step
 jsr ql_gemdos
 addq.l #4,a7
 tst.l d0
 bne ft_fail
 rts
ft_name: dc.b 'QPORT',0
ft_mask: dc.b '*.*',0
ft_payload: dc.b 'QL file I/O test!'
 even
ft_handle: dc.w 0
ft_buffer: ds.b 32
ft_dta: ds.b 64
ft_step: dc.l 0
