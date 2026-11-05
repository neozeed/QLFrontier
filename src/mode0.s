 .text
ql_build_dither:
 lea rgb_dither,a0
 lea main_dither,a1
 move.w #4095,d0
qd_zero:
 move.l (a0),(a1)+
 dbra d0,qd_zero
 rts
ql_present_safe:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 bsr ql_present
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_present:
 tst.b display_dirty
 beq present_done
 movea.l display_buffer,a0
 move.l a0,d0
 beq present_done
 clr.b display_dirty
 lea $20e18,a1
 moveq #0,d7
present_row:
 lea main_dither,a2
 cmp.w #168,d7
 bcs present_main
 lea panel_dither,a2
present_main:
 move.w d7,d6
 and.w #3,d6
 lsl.w #4,d6
 adda.w d6,a2
 moveq #39,d5
present_group:
 moveq #0,d0
 moveq #0,d2
 move.b (a0)+,d2
 lsl.w #6,d2
 or.w 0(a2,d2.w),d0
 moveq #0,d2
 move.b (a0)+,d2
 lsl.w #6,d2
 or.w 2(a2,d2.w),d0
 moveq #0,d2
 move.b (a0)+,d2
 lsl.w #6,d2
 or.w 4(a2,d2.w),d0
 moveq #0,d2
 move.b (a0)+,d2
 lsl.w #6,d2
 or.w 6(a2,d2.w),d0
 moveq #0,d2
 move.b (a0)+,d2
 lsl.w #6,d2
 or.w 8(a2,d2.w),d0
 moveq #0,d2
 move.b (a0)+,d2
 lsl.w #6,d2
 or.w 10(a2,d2.w),d0
 moveq #0,d2
 move.b (a0)+,d2
 lsl.w #6,d2
 or.w 12(a2,d2.w),d0
 moveq #0,d2
 move.b (a0)+,d2
 lsl.w #6,d2
 or.w 14(a2,d2.w),d0
 move.w d0,(a1)+
 dbra d5,present_group
 jsr mode0_text_row_safe
 adda.w #48,a1
 addq.w #1,d7
 cmp.w #200,d7
 bne present_row
present_done:
 rts
* Expand a 4x4 dither into pre-shifted Mode 4 words for eight positions.
expand_colour:
 moveq #3,d6
expand_row:
 moveq #7,d4
 moveq #0,d5
expand_pixel:
 move.w d5,d3
 and.w #3,d3
 move.b 0(a2,d3.w),d0
 moveq #0,d1
 btst #0,d0
 beq expand_green
 bset d4,d1
expand_green:
 btst #1,d0
 beq expand_store
 move.w d4,d3
 addq.w #8,d3
 bset d3,d1
expand_store:
 cmp.w (a1),d1
 beq expand_same
 st display_dirty
expand_same:
 move.w d1,(a1)+
 addq.w #1,d5
 dbra d4,expand_pixel
 addq.l #4,a2
 dbra d6,expand_row
 rts

* Readability only: original glyph coordinates, screen extent and panel remain.
native_text_position:
 move.w d1,native_x
 move.w d2,native_y
 rts
native_text_char:
 jmp text_char
hud_mark_a0:
hud_mark_rows:
 rts
mode0_init_guards:
 move.l #$6b1dca55,text_guard_after
 move.l #$6b1dca55,screen_a_guard
 move.l #$6b1dca55,screen_b_guard
 move.l #$6b1dca55,stack_top_guard
 rts
mode0_text_row_safe:
 movem.l d0-d6/a0-a5,-(a7)
 movea.l display_buffer,a0
 bsr text_find
 move.l a1,d0
 beq text_present_done
 movea.l a0,a2
 move.w d7,d0
 mulu #320,d0
 adda.l d0,a2
 movea.l a1,a0
 move.w d7,d0
 mulu #40,d0
 adda.l d0,a0
 movea.l a0,a3
 moveq #9,d0
text_row_scan:
 tst.l (a3)+
 bne text_row_found
 dbra d0,text_row_scan
 bra text_present_done
text_row_found:
 lea $20e18,a1
 move.w d7,d0
 lsl.w #7,d0
 adda.w d0,a1
 moveq #39,d6
text_word:
 move.b (a0)+,d3
 beq mode0_word_skip
 move.w (a1),d1
 btst #0,d3
 beq mode0_pixel_skip_0
 tst.b 0(a2)
 bne mode0_pixel_white_0
 and.w #$7f7f,d1
 bra mode0_pixel_skip_0
mode0_pixel_white_0:
 or.w #$8080,d1
mode0_pixel_skip_0:
 btst #1,d3
 beq mode0_pixel_skip_1
 tst.b 1(a2)
 bne mode0_pixel_white_1
 and.w #$bfbf,d1
 bra mode0_pixel_skip_1
mode0_pixel_white_1:
 or.w #$4040,d1
mode0_pixel_skip_1:
 btst #2,d3
 beq mode0_pixel_skip_2
 tst.b 2(a2)
 bne mode0_pixel_white_2
 and.w #$dfdf,d1
 bra mode0_pixel_skip_2
mode0_pixel_white_2:
 or.w #$2020,d1
mode0_pixel_skip_2:
 btst #3,d3
 beq mode0_pixel_skip_3
 tst.b 3(a2)
 bne mode0_pixel_white_3
 and.w #$efef,d1
 bra mode0_pixel_skip_3
mode0_pixel_white_3:
 or.w #$1010,d1
mode0_pixel_skip_3:
 btst #4,d3
 beq mode0_pixel_skip_4
 tst.b 4(a2)
 bne mode0_pixel_white_4
 and.w #$f7f7,d1
 bra mode0_pixel_skip_4
mode0_pixel_white_4:
 or.w #$0808,d1
mode0_pixel_skip_4:
 btst #5,d3
 beq mode0_pixel_skip_5
 tst.b 5(a2)
 bne mode0_pixel_white_5
 and.w #$fbfb,d1
 bra mode0_pixel_skip_5
mode0_pixel_white_5:
 or.w #$0404,d1
mode0_pixel_skip_5:
 btst #6,d3
 beq mode0_pixel_skip_6
 tst.b 6(a2)
 bne mode0_pixel_white_6
 and.w #$fdfd,d1
 bra mode0_pixel_skip_6
mode0_pixel_white_6:
 or.w #$0202,d1
mode0_pixel_skip_6:
 btst #7,d3
 beq mode0_pixel_skip_7
 tst.b 7(a2)
 bne mode0_pixel_white_7
 and.w #$fefe,d1
 bra mode0_pixel_skip_7
mode0_pixel_white_7:
 or.w #$0101,d1
mode0_pixel_skip_7:
 move.w d1,(a1)
mode0_word_skip:
 addq.l #2,a1
 addq.l #8,a2
 dbra d6,text_word
text_present_done:
 movem.l (a7)+,d0-d6/a0-a5
 rts

