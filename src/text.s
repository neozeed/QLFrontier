 .text
* One bit per indexed pixel says this pixel is solid UI text. Tags follow the
* two screen buffers, including clears, spans, bitmaps and screen copies.
* a0 -> a1=tag base (zero if not a screen), d2=byte offset.
text_find:
 move.l a0,d2
 sub.l #screen_a,d2
 lea text_mask_a,a1
 cmp.l #64000,d2
 bcs text_find_done
 move.l a0,d2
 sub.l #screen_b,d2
 lea text_mask_b,a1
 cmp.l #64000,d2
 bcs text_find_done
 suba.l a1,a1
text_find_done:
 rts
* Single-pixel callers need no span-length clipping or temporary d1 value.
text_clear_pixel_at_a0:
 movem.l d0/d2/a1,-(a7)
 bsr text_find
 move.l a1,d0
 beq text_clear_pixel_done
 move.l d2,d0
 lsr.l #3,d0
 adda.l d0,a1
 bclr d2,(a1)
text_clear_pixel_done:
 movem.l (a7)+,d0/d2/a1
 rts
text_clear_span:
 movem.l d0-d3/a1,-(a7)
 and.l #$ffff,d1
 bsr text_find
 move.l a1,d0
 beq text_clear_done
 move.l #64000,d3
 sub.l d2,d3
 cmp.l d3,d1
 bls text_clear_size
 move.l d3,d1
text_clear_size:
 tst.l d1
 beq text_clear_done
 move.l d2,d0
 lsr.l #3,d0
 adda.l d0,a1
 cmp.w #1,d1
 beq text_clear_pixel
 and.w #7,d2
 beq text_clear_bulk
 moveq #8,d0
 sub.w d2,d0
 cmp.w d0,d1
 bcc text_clear_head_full
 * The entire interval is within one tag byte.
 moveq #1,d3
 lsl.w d1,d3
 subq.w #1,d3
 lsl.w d2,d3
 not.b d3
 and.b d3,(a1)
 bra text_clear_done
text_clear_head_full:
 moveq #1,d3
 lsl.w d2,d3
 subq.w #1,d3
 and.b d3,(a1)+
 sub.w d0,d1
text_clear_bulk:
 * Align the tag address before any 68000 word/long access.
 cmp.w #8,d1
 bcs text_clear_tail
 move.l a1,d0
 btst #0,d0
 beq text_clear_longs
 clr.b (a1)+
 subq.w #8,d1
text_clear_longs:
 cmp.w #32,d1
 bcs text_clear_bytes
 clr.l (a1)+
 sub.w #32,d1
 bra text_clear_longs
text_clear_bytes:
 cmp.w #8,d1
 bcs text_clear_tail
 clr.b (a1)+
 subq.w #8,d1
 bra text_clear_bytes
text_clear_tail:
 tst.w d1
 beq text_clear_done
 moveq #-1,d3
 lsl.b d1,d3
 and.b d3,(a1)
 bra text_clear_done
text_clear_pixel:
 bclr d2,(a1)
text_clear_done:
 movem.l (a7)+,d0-d3/a1
 rts
text_copy_masks:
 movem.l d0-d6/a0-a3,-(a7)
 movea.l 4(a4),a0
 bsr text_find
 movea.l a1,a2
 move.l d2,d4
 movea.l (a4),a0
 bsr text_find
 move.l a1,d0
 beq text_copy_done
 move.l a2,d0
 bne text_copy_source
 move.l 8(a4),d1
 bsr text_clear_span
 bra text_copy_done
text_copy_source:
 move.l 8(a4),d1
 move.l d2,d3
 move.l d4,d0
 or.l d2,d0
 or.l d1,d0
 and.w #7,d0
 bne text_copy_bits
 lsr.l #3,d2
 adda.l d2,a1
 lsr.l #3,d4
 adda.l d4,a2
 lsr.l #3,d1
 beq text_copy_done
text_copy_bytes:
 move.b (a2)+,(a1)+
 subq.l #1,d1
 bne text_copy_bytes
 bra text_copy_done
text_copy_bits:
 tst.l d1
 beq text_copy_done
 move.l d3,d0
 lsr.l #3,d0
 lea 0(a1,d0.l),a3
 bclr d3,(a3)
 move.l d4,d0
 lsr.l #3,d0
 btst d4,0(a2,d0.l)
 beq text_copy_next
 bset d3,(a3)
text_copy_next:
 addq.l #1,d3
 addq.l #1,d4
 subq.l #1,d1
 bra text_copy_bits
text_copy_done:
 movem.l (a7)+,d0-d6/a0-a3
 rts
* UI glyphs always retain their original 320-wide coordinates. Mode 4
* expands every source pixel; this must not depend on stale flight state.
text_char:
 movem.l d0/d2-d7/a0-a4,-(a7)
 sub.w #32,d3
 mulu #10,d3
 lea ql_font,a2
 adda.l d3,a2
 moveq #0,d6
 move.b 9(a2),d6
 movea.l L5da6_logscreen2,a0
 bsr text_find
 move.l a1,d0
 beq text_char_done
 movea.l a1,a3
 movea.l a0,a1
 move.w native_y,d7
 moveq #7,d2
text_glyph_row:
 cmp.w #200,d7
 bcc text_glyph_next
 moveq #0,d5
text_glyph_pixel:
 moveq #0,d0
 move.w native_x,d0
 add.w d5,d0
 cmp.w #320,d0
 bcc text_glyph_skip
text_glyph_offset:
 move.w d7,d4
 mulu #320,d4
 add.l d0,d4
 clr.b 0(a1,d4.l)
 moveq #7,d0
 sub.w d5,d0
 btst d0,(a2)
 beq text_glyph_black
 move.b #15,0(a1,d4.l)
text_glyph_black:
 move.l d4,d0
 lsr.l #3,d0
 bset d4,0(a3,d0.l)
text_glyph_skip:
 addq.w #1,d5
 cmp.w d6,d5
 bcs text_glyph_pixel
text_glyph_next:
 addq.l #1,a2
 addq.w #1,d7
 dbra d2,text_glyph_row
text_char_done:
 add.w d6,native_x
 add.l d6,d1
 movem.l (a7)+,d0/d2-d7/a0-a4
 rts
text_present_row_safe:
 movem.l d0-d6/a0-a5,-(a7)
 tst.w hud_active
 bne text_panel_ready
 cmp.w #168,d7
 bcs text_panel_ready
 lea $20e00,a1
 move.w d7,d0
 lsl.w #7,d0
 adda.w d0,a1
 moveq #12,d0
text_hide_transport:
 clr.w (a1)+
 dbra d0,text_hide_transport
text_panel_ready:
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
 lea $20e00,a1
 move.w d7,d0
 lsl.w #7,d0
 adda.w d0,a1
 moveq #0,d2
 moveq #63,d6
text_word:
 move.w (a1),d1
 moveq #0,d5
text_pixel:
 move.w d2,d4
 lsr.w #3,d4
 btst d2,0(a0,d4.w)
 beq text_pixel_next
 move.w #$80c0,d0
 lsr.w d5,d0
 tst.b 0(a2,d2.w)
 bne text_pixel_white
 not.w d0
 and.w d0,d1
 bra text_pixel_next
text_pixel_white:
 or.w d0,d1
text_pixel_next:
 addq.w #1,d2
 addq.w #2,d5
 cmp.w #4,d5
 bne text_pixel_step
 addq.w #1,d2
text_pixel_step:
 cmp.w #8,d5
 bne text_pixel
 move.w d1,(a1)+
 dbra d6,text_word
text_present_done:
 movem.l (a7)+,d0-d6/a0-a5
 rts

