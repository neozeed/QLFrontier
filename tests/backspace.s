 .text
backspace_test:
 jsr scan_keyboard
 cmp.w #6,key_tail
 bcs backspace_test
 lea key_queue,a0
 lea backspace_expected,a1
 moveq #5,d0
backspace_compare:
 cmpm.b (a0)+,(a1)+
 bne backspace_fail
 dbra d0,backspace_compare
 moveq #0,d3
 bra backspace_exit
backspace_fail:
 moveq #42,d3
backspace_exit:
 move.l d3,-(a7)
 lea poll_link,a0
 moveq #$1d,d0
 trap #1
 move.l (a7)+,d3
 moveq #-1,d1
 moveq #5,d0
 trap #1
backspace_expected: dc.b $1d,$0e,$9d,$8e,$4b,$cb
