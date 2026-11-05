 .text
* Flight-only changes. All hooks preserve the original registers and flags.
hud_begin_frame:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 moveq #0,d7
 tst.b L5eb6_a6_base+42
 bpl hud_mode_ready
 tst.b L5eb6_a6_base+536
 bpl hud_mode_ready
 moveq #1,d7
hud_mode_ready:
 move.w d7,hud_active
 cmp.w hud_previous,d7
 beq hud_begin_done
 move.w d7,hud_previous
 lea hud_extent_table,a0
hud_patch_next:
 move.l (a0)+,d0
 beq hud_patch_done
 movea.l d0,a1
 move.w (a0)+,d1
 move.l (a0)+,d2
 move.l (a0)+,d3
 tst.w d7
 beq hud_patch_old
 move.l d3,d2
hud_patch_old:
 cmp.w #4,d1
 beq hud_patch_long
 move.w d2,(a1)
 bra hud_patch_next
hud_patch_long:
 move.l d2,(a1)
 bra hud_patch_next
hud_patch_done:
 move.w #158,L63880+4
 move.w #1,L63876+6
 tst.w d7
 beq hud_begin_done
 move.w #1,L63880+4
 move.w #31,L63876+6
hud_begin_done:
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
hud_redirect:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 tst.w hud_active
 beq hud_redirect_done
 lea hud_rows,a0
 moveq #49,d0
hud_clear_rows:
 clr.l (a0)+
 dbra d0,hud_clear_rows
 bsr native_clear_used_rows
 lea hud_buffer,a0
 moveq #0,d1
 move.w #1999,d0
hud_clear:
 move.l d1,(a0)+
 move.l d1,(a0)+
 move.l d1,(a0)+
 move.l d1,(a0)+
 move.l d1,(a0)+
 move.l d1,(a0)+
 move.l d1,(a0)+
 move.l d1,(a0)+
 dbra d0,hud_clear
 movem.l L5d9e_logscreen,d0-d3
 movem.l d0-d3,hud_saved_screens
 move.l #hud_buffer,d0
 move.l d0,L5d9e_logscreen
 move.l d0,L5da2_physcreen
 move.l d0,L5da6_logscreen2
 move.l d0,L5daa_physcreen2
 move.w #1,hud_redirected
 jsr L6f174
 lea L6f502_scanner_bmp,a0
 moveq #64,d0
 move.w #168,d1
 jsr A5_BlitBmp(a5)
 * Reuse Frontier's scanner/grid/contact drawing on its separate black plane.
 movea.l 674(a6),a0
 btst #2,161(a0)
 beq hud_message_only
 move.b 908(a6),-(a7)
 st 908(a6)
 jsr L6f2aa
 move.b (a7)+,908(a6)
hud_message_only:
 jsr hud_message
hud_redirect_done:
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
hud_restore:
 move.w sr,-(a7)
 movem.l d0-d3,-(a7)
 tst.w hud_redirected
 beq hud_restore_done
 movem.l hud_saved_screens,d0-d3
 movem.l d0-d3,L5d9e_logscreen
 clr.w hud_redirected
hud_restore_done:
 movem.l (a7)+,d0-d3
 move.w (a7)+,ccr
 rts
* Index zero is transparent; 255 marks an opaque black text shadow.
* The original scanner works on its black indexed plane, so its readback is intact.
hud_present_row_safe:
 move.l a3,-(a7)
 lea hud_rows,a3
 tst.b 0(a3,d7.w)
 movea.l (a7)+,a3
 beq hud_row_empty
 movem.l d0-d6/a0-a5,-(a7)
 bsr hud_row
 movem.l (a7)+,d0-d6/a0-a5
hud_row_empty:
 tst.w hud_active
 beq native_present_done
 movem.l d0-d6/a0-a5,-(a7)
 bsr native_present_row
 movem.l (a7)+,d0-d6/a0-a5
native_present_done:
 rts
hud_row:
 lea hud_buffer,a0
 move.w d7,d0
 mulu #320,d0
 adda.l d0,a0
 lea $20e00,a1
 move.w d7,d0
 lsl.w #7,d0
 adda.w d0,a1
 lea main_dither,a2
 moveq #63,d6
 cmp.w #168,d7
 bcs hud_group
 lea panel_dither,a2
 adda.w #80,a0
 adda.w #32,a1
 moveq #31,d6
hud_group:
 move.w (a1),d1
 moveq #0,d3
 move.b (a0)+,d3
 beq hud_skip_0
 moveq #0,d4
 cmp.b #255,d3
 beq hud_opaque_0
 add.w d3,d3
 move.w 0(a2,d3.w),d4
hud_opaque_0:
 and.w #$7f3f,d1
 or.w d4,d1
hud_skip_0:
 moveq #0,d3
 move.b (a0)+,d3
 beq hud_skip_1
 moveq #0,d4
 cmp.b #255,d3
 beq hud_opaque_1
 add.w d3,d3
 move.w 0(a2,d3.w),d4
 lsr.w #2,d4
hud_opaque_1:
 and.w #$dfcf,d1
 or.w d4,d1
hud_skip_1:
 addq.l #1,a0
 moveq #0,d3
 move.b (a0)+,d3
 beq hud_skip_2
 moveq #0,d4
 cmp.b #255,d3
 beq hud_opaque_2
 add.w d3,d3
 move.w 0(a2,d3.w),d4
 lsr.w #4,d4
hud_opaque_2:
 and.w #$f7f3,d1
 or.w d4,d1
hud_skip_2:
 moveq #0,d3
 move.b (a0)+,d3
 beq hud_skip_3
 moveq #0,d4
 cmp.b #255,d3
 beq hud_opaque_3
 add.w d3,d3
 move.w 0(a2,d3.w),d4
 lsr.w #6,d4
hud_opaque_3:
 and.w #$fdfc,d1
 or.w d4,d1
hud_skip_3:
 move.w d1,(a1)+
 dbra d6,hud_group
 rts

hud_init_guards:
 move.l #$6b1dca55,hud_guard_before
 move.l #$6b1dca55,hud_guard_after
 move.l #$6b1dca55,text_guard_after
 move.l #$6b1dca55,screen_a_guard
 move.l #$6b1dca55,screen_b_guard
 move.l #$6b1dca55,stack_top_guard
 rts

hud_mark_a0:
 tst.w hud_redirected
 beq hud_mark_return
 movem.l d0/a3,-(a7)
 move.l a0,d0
 sub.l #hud_buffer,d0
 cmp.l #64000,d0
 bcc hud_mark_a0_done
 divu #320,d0
 lea hud_rows,a3
 st 0(a3,d0.w)
hud_mark_a0_done:
 movem.l (a7)+,d0/a3
hud_mark_return:
 rts
hud_mark_rows:
 tst.w hud_redirected
 beq hud_mark_return
 movem.l d0-d1/a3,-(a7)
 lea hud_rows,a3
 tst.w d1
 ble hud_mark_rows_done
 subq.w #1,d1
hud_mark_rows_loop:
 cmp.w #200,d0
 bcc hud_mark_rows_next
 st 0(a3,d0.w)
hud_mark_rows_next:
 addq.w #1,d0
 dbra d1,hud_mark_rows_loop
hud_mark_rows_done:
 movem.l (a7)+,d0-d1/a3
 rts

* Native 256-pixel text plane: zero transparent, 1 opaque black, 2 white.
* Keep the original string cursor/return value in d1; native_x advances independently.
native_text_position:
 clr.w native_clock
 movem.l d0/d2,-(a7)
 move.w d1,d0
 tst.w hud_redirected
 bne native_position_hud
 cmp.w #169,d2
 bne native_position_fps
 cmp.w #1,d0
 beq native_position_clock
 cmp.w #32,d0
 beq native_position_clock
native_position_fps:
 tst.w hud_active
 beq native_position_store
 cmp.w #20,d0
 bne native_position_store
 cmp.w #5,d2
 bne native_position_store
 move.w #1,native_clock
 moveq #16,d0
 bra native_position_store
native_position_hud:
 tst.w hud_message_origin
 beq native_position_check_clock
 sub.w hud_message_origin,d0
 add.w #64,d0
 bra native_position_store
native_position_check_clock:
 cmp.w #169,d2
 bne native_position_flight
 cmp.w #1,d0
 beq native_position_clock
 cmp.w #32,d0
 bne native_position_flight
native_position_clock:
 move.w #1,native_clock
 move.w #181,d2
 cmp.w #32,d0
 bne native_position_store
 moveq #1,d0
 move.w #191,d2
 bra native_position_store
native_position_flight:
 cmp.w #1,d2
 bne native_position_scale
 cmp.w #216,d0
 bcs native_status_first
 sub.w #216,d0
 add.w #103,d0
 move.w #11,d2
 bra native_position_store
native_status_first:
 cmp.w #150,d0
 bcs native_status_second
 sub.w #150,d0
 add.w #103,d0
 move.w #21,d2
 bra native_position_store
native_status_second:
 cmp.w #76,d0
 bcs native_status_actual
 sub.w #76,d0
 add.w #185,d0
 bra native_position_store
native_status_actual:
 add.w #101,d0
 bra native_position_store
native_position_scale:
 tst.w hud_active
 beq native_position_store
 mulu #4,d0
 divu #5,d0
native_position_store:
 move.w d0,native_x
 move.w d2,native_y
 movem.l (a7)+,d0/d2
 rts
* Clear complete used text rows; rows not marked have remained transparent.
native_clear_used_rows:
 lea native_rows,a0
 lea native_text,a1
 moveq #0,d2
 move.w #199,d0
native_clear_row:
 tst.b (a0)+
 beq native_clear_row_empty
 clr.b -1(a0)
 moveq #7,d1
native_clear_block:
 move.l d2,(a1)+
 move.l d2,(a1)+
 move.l d2,(a1)+
 move.l d2,(a1)+
 move.l d2,(a1)+
 move.l d2,(a1)+
 move.l d2,(a1)+
 move.l d2,(a1)+
 dbra d1,native_clear_block
 bra native_clear_row_next
native_clear_row_empty:
 adda.w #256,a1
native_clear_row_next:
 dbra d0,native_clear_row
 rts
* d0=x, d2=y (already clipped), d6=width. Scratch d3-d5/a3 only.
* Out-of-range x gets conservative full-row bounds, preserving wrap behaviour.
native_mark_span:
 moveq #0,d4
 move.w d0,d4
 move.w d4,d5
 cmp.w #256,d4
 bcc native_mark_full
 add.w d6,d5
 cmp.w d4,d5
 bne native_mark_end
 addq.w #1,d5
native_mark_end:
 cmp.w #256,d5
 bls native_mark_ready
 move.w #256,d5
 bra native_mark_ready
native_mark_full:
 moveq #0,d4
 move.w #256,d5
native_mark_ready:
 moveq #0,d3
 move.w d2,d3
 lea native_rows,a3
 tst.b 0(a3,d3.w)
 bne native_mark_merge
 st 0(a3,d3.w)
 add.w d3,d3
 lea native_left,a3
 move.w d4,0(a3,d3.w)
 lea native_right,a3
 move.w d5,0(a3,d3.w)
 rts
native_mark_merge:
 add.w d3,d3
 lea native_left,a3
 cmp.w 0(a3,d3.w),d4
 bcc native_mark_right
 move.w d4,0(a3,d3.w)
native_mark_right:
 lea native_right,a3
 cmp.w 0(a3,d3.w),d5
 bls native_mark_done
 move.w d5,0(a3,d3.w)
native_mark_done:
 rts
native_text_char:
 movem.l d0/d2-d7/a0-a3,-(a7)
 sub.w #32,d3
 mulu #10,d3
 lea ql_font,a2
 adda.l d3,a2
 moveq #0,d6
 move.b 9(a2),d6
 move.w native_x,d0
 move.w native_y,d2
 moveq #7,d7
native_glyph_row:
 cmp.w #200,d2
 bcc native_glyph_next
 bsr native_mark_span
 lea native_text,a1
 moveq #0,d3
 move.w d2,d3
 lsl.l #8,d3
 adda.l d3,a1
 move.b (a2),d3
 moveq #0,d5
native_glyph_pixel:
 move.w d0,d4
 add.w d5,d4
 cmp.w #256,d4
 bcc native_glyph_skip
 move.b #1,0(a1,d4.w)
 btst #7,d3
 beq native_glyph_skip
 move.b #2,0(a1,d4.w)
native_glyph_skip:
 add.b d3,d3
 addq.w #1,d5
 cmp.w d6,d5
 bcs native_glyph_pixel
native_glyph_next:
 addq.l #1,a2
 addq.w #1,d2
 dbra d7,native_glyph_row
 add.w d6,native_x
 add.l d6,d1
 movem.l (a7)+,d0/d2-d7/a0-a3
 rts
native_present_row:
 cmp.w #180,d7
 bcs native_present_text
 lea $20e00,a1
 move.w d7,d0
 lsl.w #7,d0
 adda.w d0,a1
 moveq #5,d6
native_panel_clear:
 clr.l (a1)+
 dbra d6,native_panel_clear
native_present_text:
 lea native_rows,a0
 tst.b 0(a0,d7.w)
 beq native_row_done
 lea native_text,a0
 moveq #0,d0
 move.w d7,d0
 lsl.l #8,d0
 adda.l d0,a0
 lea $20e00,a1
 move.w d7,d0
 lsl.w #7,d0
 adda.w d0,a1
 * Round occupied bounds outward to the four-pixel Mode 8 word.
 move.w d7,d0
 add.w d0,d0
 lea native_left,a2
 moveq #0,d2
 move.w 0(a2,d0.w),d2
 and.w #$fffc,d2
 lea native_right,a2
 move.w 0(a2,d0.w),d6
 addq.w #3,d6
 and.w #$fffc,d6
 sub.w d2,d6
 beq native_row_done
 adda.w d2,a0
 lsr.w #1,d2
 adda.w d2,a1
 lsr.w #2,d6
 subq.w #1,d6
native_text_word:
 move.w (a1),d1
 move.b (a0)+,d3
 beq native_skip_0
 cmp.b #2,d3
 beq native_white_0
 and.w #$7f3f,d1
 bra native_skip_0
native_white_0:
 or.w #$80c0,d1
native_skip_0:
 move.b (a0)+,d3
 beq native_skip_1
 cmp.b #2,d3
 beq native_white_1
 and.w #$dfcf,d1
 bra native_skip_1
native_white_1:
 or.w #$2030,d1
native_skip_1:
 move.b (a0)+,d3
 beq native_skip_2
 cmp.b #2,d3
 beq native_white_2
 and.w #$f7f3,d1
 bra native_skip_2
native_white_2:
 or.w #$080c,d1
native_skip_2:
 move.b (a0)+,d3
 beq native_skip_3
 cmp.b #2,d3
 beq native_white_3
 and.w #$fdfc,d1
 bra native_skip_3
native_white_3:
 or.w #$0203,d1
native_skip_3:
 move.w d1,(a1)+
 dbra d6,native_text_word
native_row_done:
 rts


* Replay only the original active communication's formatter, not its queue,
* sound, panel selection, or lifetime logic. Omit the portrait to save space.
hud_message:
 cmp.w #96,906(a6)
 bne hud_message_return
 btst #1,115(a6)
 beq hud_message_return
 lea native_text+43072,a1
 moveq #64,d0
 move.w #168,d2
 move.w #192,d6
 moveq #31,d7
hud_message_back_row:
 bsr native_mark_span
 moveq #47,d1
hud_message_back_word:
 move.l #$01010101,(a1)+
 dbra d1,hud_message_back_word
 adda.w #64,a1
 addq.w #1,d2
 dbra d7,hud_message_back_row
 movem.l 11690(a6),d0-d3/d7/a2-a3
 tst.w d7
 bmi hud_message_plain
 btst #0,d7
 bne hud_message_direct
 exg a3,a2
 move.w d0,d1
 lea 246(a3),a3
 movem.w L76104,d0/d4-d7
 bra hud_message_format
hud_message_direct:
 movem.w L76106,d4-d7
 bra hud_message_format
hud_message_plain:
 movem.w L7610e,d4-d7
hud_message_format:
 move.w d5,hud_message_origin
 jsr A5_FmtDrawStrToPhys(a5)
 clr.w hud_message_origin
hud_message_return:
 rts
 .bss
hud_message_origin: ds.w 1
