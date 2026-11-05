 .text
* Keep Mode 8 for flight; Mode 4 expands all 320 UI pixels to 512 without loss.
select_display_mode:
 movem.l d0-d3/a0-a3,-(a7)
 moveq #4,d1
 tst.w hud_active
 beq mode_selected
 moveq #8,d1
mode_selected:
 cmp.w display_mode,d1
 beq mode_unchanged
 move.w d1,display_mode
 moveq #$10,d0
 moveq #-1,d2
 trap #1
 lea $20000,a0
 move.w #8191,d0
mode_clear_screen:
 clr.l (a0)+
 dbra d0,mode_clear_screen
mode_unchanged:
 movem.l (a7)+,d0-d3/a0-a3
 rts
menu_cache_colour:
 movem.l d0-d2/a0,-(a7)
 move.l a1,d1
 sub.l #main_dither,d1
 lea menu_main,a0
 cmp.l #512,d1
 bcs menu_cache_index
 move.l a1,d1
 sub.l #panel_dither,d1
 lea menu_panel,a0
menu_cache_index:
 add.w d1,d1
 adda.w d1,a0
 lsl.l #2,d0
 lea menu_rgb,a3
 move.l 0(a3,d0.l),(a0)
 movem.l (a7)+,d0-d2/a0
 rts
present_mode4:
 clr.w menu_flat_background
 btst #0,L5eb6_a6_base+536
 bne menu_background_ready
 move.w #1,menu_flat_background
menu_background_ready:
 movea.l display_buffer,a0
 bsr text_find
 movea.l a1,a6
 movea.l display_buffer,a0
 lea $20e00,a1
 moveq #0,d7
menu_row:
 lea menu_main,a2
 cmp.w #168,d7
 bcs menu_palette_ready
 lea menu_panel,a2
menu_palette_ready:
 move.w d7,d0
 and.w #3,d0
 adda.w d0,a2
 lea native_text,a5
 moveq #0,d0
 move.w d7,d0
 lsl.l #8,d0
 adda.l d0,a5
 moveq #0,d6
menu_word:
 moveq #0,d1
 moveq #0,d2
 move.b 0(a0),d2
 move.w d6,d3
 add.w #0,d3
 cmp.w #168,d7
 bcs menu_not_clock_0
 cmp.w #64,d3
 bcc menu_not_clock_0
 moveq #0,d0
 cmp.w #180,d7
 bcs menu_pack_0
 cmp.w #48,d3
 bcc menu_pack_0
 cmp.b #2,0(a5,d3.w)
 bne menu_pack_0
 move.w #$8080,d0
 bra menu_pack_0
menu_not_clock_0:
 move.w d3,d4
 lsr.w #3,d4
 btst d3,0(a6,d4.w)
 beq menu_dither_0
 moveq #0,d0
 tst.b d2
 beq menu_pack_0
 move.w #$8080,d0
 bra menu_pack_0
menu_dither_0:
 cmp.w #14,d2
 bne menu_colour_0
 tst.w menu_flat_background
 beq menu_colour_0
 moveq #0,d0
 bra menu_pack_0
menu_colour_0:
 lsl.w #2,d2
 moveq #0,d0
 move.b 0(a2,d2.w),d0
 lsr.w #6,d0
 and.w #3,d0
 add.w d0,d0
 lea menu_masks,a3
 move.w 0(a3,d0.w),d0
menu_pack_0:
 or.w d0,d1
 moveq #0,d2
 move.b 0(a0),d2
 move.w d6,d3
 add.w #0,d3
 cmp.w #168,d7
 bcs menu_not_clock_1
 cmp.w #64,d3
 bcc menu_not_clock_1
 moveq #0,d0
 cmp.w #180,d7
 bcs menu_pack_1
 cmp.w #48,d3
 bcc menu_pack_1
 cmp.b #2,0(a5,d3.w)
 bne menu_pack_1
 move.w #$8080,d0
 bra menu_pack_1
menu_not_clock_1:
 move.w d3,d4
 lsr.w #3,d4
 btst d3,0(a6,d4.w)
 beq menu_dither_1
 moveq #0,d0
 tst.b d2
 beq menu_pack_1
 move.w #$8080,d0
 bra menu_pack_1
menu_dither_1:
 cmp.w #14,d2
 bne menu_colour_1
 tst.w menu_flat_background
 beq menu_colour_1
 moveq #0,d0
 bra menu_pack_1
menu_colour_1:
 lsl.w #2,d2
 moveq #0,d0
 move.b 0(a2,d2.w),d0
 lsr.w #4,d0
 and.w #3,d0
 add.w d0,d0
 lea menu_masks,a3
 move.w 0(a3,d0.w),d0
menu_pack_1:
 lsr.w #1,d0
 or.w d0,d1
 moveq #0,d2
 move.b 1(a0),d2
 move.w d6,d3
 add.w #1,d3
 cmp.w #168,d7
 bcs menu_not_clock_2
 cmp.w #64,d3
 bcc menu_not_clock_2
 moveq #0,d0
 cmp.w #180,d7
 bcs menu_pack_2
 cmp.w #48,d3
 bcc menu_pack_2
 cmp.b #2,0(a5,d3.w)
 bne menu_pack_2
 move.w #$8080,d0
 bra menu_pack_2
menu_not_clock_2:
 move.w d3,d4
 lsr.w #3,d4
 btst d3,0(a6,d4.w)
 beq menu_dither_2
 moveq #0,d0
 tst.b d2
 beq menu_pack_2
 move.w #$8080,d0
 bra menu_pack_2
menu_dither_2:
 cmp.w #14,d2
 bne menu_colour_2
 tst.w menu_flat_background
 beq menu_colour_2
 moveq #0,d0
 bra menu_pack_2
menu_colour_2:
 lsl.w #2,d2
 moveq #0,d0
 move.b 0(a2,d2.w),d0
 lsr.w #2,d0
 and.w #3,d0
 add.w d0,d0
 lea menu_masks,a3
 move.w 0(a3,d0.w),d0
menu_pack_2:
 lsr.w #2,d0
 or.w d0,d1
 moveq #0,d2
 move.b 2(a0),d2
 move.w d6,d3
 add.w #2,d3
 cmp.w #168,d7
 bcs menu_not_clock_3
 cmp.w #64,d3
 bcc menu_not_clock_3
 moveq #0,d0
 cmp.w #180,d7
 bcs menu_pack_3
 cmp.w #48,d3
 bcc menu_pack_3
 cmp.b #2,0(a5,d3.w)
 bne menu_pack_3
 move.w #$8080,d0
 bra menu_pack_3
menu_not_clock_3:
 move.w d3,d4
 lsr.w #3,d4
 btst d3,0(a6,d4.w)
 beq menu_dither_3
 moveq #0,d0
 tst.b d2
 beq menu_pack_3
 move.w #$8080,d0
 bra menu_pack_3
menu_dither_3:
 cmp.w #14,d2
 bne menu_colour_3
 tst.w menu_flat_background
 beq menu_colour_3
 moveq #0,d0
 bra menu_pack_3
menu_colour_3:
 lsl.w #2,d2
 moveq #0,d0
 move.b 0(a2,d2.w),d0
 and.w #3,d0
 add.w d0,d0
 lea menu_masks,a3
 move.w 0(a3,d0.w),d0
menu_pack_3:
 lsr.w #3,d0
 or.w d0,d1
 moveq #0,d2
 move.b 2(a0),d2
 move.w d6,d3
 add.w #2,d3
 cmp.w #168,d7
 bcs menu_not_clock_4
 cmp.w #64,d3
 bcc menu_not_clock_4
 moveq #0,d0
 cmp.w #180,d7
 bcs menu_pack_4
 cmp.w #48,d3
 bcc menu_pack_4
 cmp.b #2,0(a5,d3.w)
 bne menu_pack_4
 move.w #$8080,d0
 bra menu_pack_4
menu_not_clock_4:
 move.w d3,d4
 lsr.w #3,d4
 btst d3,0(a6,d4.w)
 beq menu_dither_4
 moveq #0,d0
 tst.b d2
 beq menu_pack_4
 move.w #$8080,d0
 bra menu_pack_4
menu_dither_4:
 cmp.w #14,d2
 bne menu_colour_4
 tst.w menu_flat_background
 beq menu_colour_4
 moveq #0,d0
 bra menu_pack_4
menu_colour_4:
 lsl.w #2,d2
 moveq #0,d0
 move.b 0(a2,d2.w),d0
 lsr.w #6,d0
 and.w #3,d0
 add.w d0,d0
 lea menu_masks,a3
 move.w 0(a3,d0.w),d0
menu_pack_4:
 lsr.w #4,d0
 or.w d0,d1
 moveq #0,d2
 move.b 3(a0),d2
 move.w d6,d3
 add.w #3,d3
 cmp.w #168,d7
 bcs menu_not_clock_5
 cmp.w #64,d3
 bcc menu_not_clock_5
 moveq #0,d0
 cmp.w #180,d7
 bcs menu_pack_5
 cmp.w #48,d3
 bcc menu_pack_5
 cmp.b #2,0(a5,d3.w)
 bne menu_pack_5
 move.w #$8080,d0
 bra menu_pack_5
menu_not_clock_5:
 move.w d3,d4
 lsr.w #3,d4
 btst d3,0(a6,d4.w)
 beq menu_dither_5
 moveq #0,d0
 tst.b d2
 beq menu_pack_5
 move.w #$8080,d0
 bra menu_pack_5
menu_dither_5:
 cmp.w #14,d2
 bne menu_colour_5
 tst.w menu_flat_background
 beq menu_colour_5
 moveq #0,d0
 bra menu_pack_5
menu_colour_5:
 lsl.w #2,d2
 moveq #0,d0
 move.b 0(a2,d2.w),d0
 lsr.w #4,d0
 and.w #3,d0
 add.w d0,d0
 lea menu_masks,a3
 move.w 0(a3,d0.w),d0
menu_pack_5:
 lsr.w #5,d0
 or.w d0,d1
 moveq #0,d2
 move.b 4(a0),d2
 move.w d6,d3
 add.w #4,d3
 cmp.w #168,d7
 bcs menu_not_clock_6
 cmp.w #64,d3
 bcc menu_not_clock_6
 moveq #0,d0
 cmp.w #180,d7
 bcs menu_pack_6
 cmp.w #48,d3
 bcc menu_pack_6
 cmp.b #2,0(a5,d3.w)
 bne menu_pack_6
 move.w #$8080,d0
 bra menu_pack_6
menu_not_clock_6:
 move.w d3,d4
 lsr.w #3,d4
 btst d3,0(a6,d4.w)
 beq menu_dither_6
 moveq #0,d0
 tst.b d2
 beq menu_pack_6
 move.w #$8080,d0
 bra menu_pack_6
menu_dither_6:
 cmp.w #14,d2
 bne menu_colour_6
 tst.w menu_flat_background
 beq menu_colour_6
 moveq #0,d0
 bra menu_pack_6
menu_colour_6:
 lsl.w #2,d2
 moveq #0,d0
 move.b 0(a2,d2.w),d0
 lsr.w #2,d0
 and.w #3,d0
 add.w d0,d0
 lea menu_masks,a3
 move.w 0(a3,d0.w),d0
menu_pack_6:
 lsr.w #6,d0
 or.w d0,d1
 moveq #0,d2
 move.b 4(a0),d2
 move.w d6,d3
 add.w #4,d3
 cmp.w #168,d7
 bcs menu_not_clock_7
 cmp.w #64,d3
 bcc menu_not_clock_7
 moveq #0,d0
 cmp.w #180,d7
 bcs menu_pack_7
 cmp.w #48,d3
 bcc menu_pack_7
 cmp.b #2,0(a5,d3.w)
 bne menu_pack_7
 move.w #$8080,d0
 bra menu_pack_7
menu_not_clock_7:
 move.w d3,d4
 lsr.w #3,d4
 btst d3,0(a6,d4.w)
 beq menu_dither_7
 moveq #0,d0
 tst.b d2
 beq menu_pack_7
 move.w #$8080,d0
 bra menu_pack_7
menu_dither_7:
 cmp.w #14,d2
 bne menu_colour_7
 tst.w menu_flat_background
 beq menu_colour_7
 moveq #0,d0
 bra menu_pack_7
menu_colour_7:
 lsl.w #2,d2
 moveq #0,d0
 move.b 0(a2,d2.w),d0
 and.w #3,d0
 add.w d0,d0
 lea menu_masks,a3
 move.w 0(a3,d0.w),d0
menu_pack_7:
 lsr.w #7,d0
 or.w d0,d1
 move.w d1,(a1)+
 addq.l #5,a0
 addq.w #5,d6
 cmp.w #320,d6
 bne menu_word
 adda.w #40,a6
 addq.w #1,d7
 cmp.w #200,d7
 bne menu_row
 rts
menu_masks:
 dc.w $0000,$0080,$8000,$8080
