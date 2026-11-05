* All routines below are entered with the wrapper's register snapshot.
impl_Call_PlaySFX:
impl_Call_NotifyMousePos:
impl_Call_InformScreens:
impl_Call_UpdateScreen:
 rts
impl_Call_MemSet:
 moveq #0,d0
 bra fill_buffer
impl_Call_MemSetBlue:
 moveq #14,d0
fill_buffer:
 move.l (a4),d1
 movea.l 4(a4),a0
 tst.l d1
 beq service_done
 jsr text_clear_span
 bra fill_bytes
service_done:
 rts
impl_Call_Memcpy:
 jsr text_copy_masks
 movea.l (a4),a0
 movea.l 4(a4),a1
 move.l 8(a4),d0
 beq service_done
copy_loop:
 move.b (a1)+,(a0)+
 subq.l #1,d0
 bne copy_loop
 rts
* Translate the surviving 160-byte pseudo-row offsets into indexed rows.
legacy_row:
 movea.l 44(a5),a0
 move.l a0,d2
 tst.w hud_redirected
 beq legacy_game_buffer
 lea hud_buffer,a1
 bra legacy_selected
legacy_game_buffer:
 lea screen_b,a1
 cmpa.l a1,a0
 bcc legacy_selected
 lea screen_a,a1
legacy_selected:
 sub.l a1,d2
 add.l d2,d2
 movea.l a1,a0
 adda.l d2,a0
 rts
impl_Call_HLine:
 movea.l 44(a5),a0
 move.w 6(a5),d0
 lsr.w #2,d0
 moveq #0,d1
 move.w 22(a5),d1
 moveq #0,d2
 move.w 18(a5),d2
 adda.l d2,a0
 bra draw_span
impl_Call_OldHLine:
 bsr legacy_row
 move.w (a4),d0
 lsr.w #2,d0
 moveq #0,d1
 move.w 22(a5),d1
 lsr.w #1,d1
 moveq #0,d2
 move.w 18(a5),d2
 adda.l d2,a0
 bra draw_span
impl_Call_PutPix:
 bsr legacy_row
 moveq #0,d2
 move.w 18(a5),d2
 adda.l d2,a0
 jsr hud_mark_a0
 move.w (a4),d0
 lsr.w #2,d0
 jsr text_clear_pixel_at_a0
 move.b d0,(a0)
 rts
impl_Call_FillLine:
 bsr legacy_row
 move.w (a4),d0
 lsr.w #2,d0
 move.w #320,d1
 bra draw_span
impl_Call_BackHLine:
 bsr legacy_row
 jsr hud_mark_a0
 move.w (a4),d0
 lsr.w #2,d0
 move.w 30(a5),d2
 moveq #15,d1
back_span:
 add.w d2,d2
 bcc back_next
 tst.b (a0)
 bne back_next
 jsr text_clear_pixel_at_a0
 move.b d0,(a0)
back_next:
 addq.l #1,a0
 dbra d1,back_span
 rts
* Preserve indexed pixels; batch only their memory stores.
draw_span:
 jsr text_clear_span
 jsr hud_mark_a0
 and.l #$ffff,d1
fill_bytes:
 tst.l d1
 beq service_done
 cmp.l #8,d1
 bcs fill_bytes_tail
 move.l a0,d2
 btst #0,d2
 beq fill_bytes_aligned
 move.b d0,(a0)+
 subq.l #1,d1
fill_bytes_aligned:
 moveq #0,d2
 move.b d0,d2
 move.w d2,d3
 lsl.w #8,d2
 or.w d3,d2
 move.w d2,d3
 swap d2
 move.w d3,d2
 cmp.l #16,d1
 bcs fill_bytes_longs
fill_bytes_block:
 move.l d2,(a0)+
 move.l d2,(a0)+
 move.l d2,(a0)+
 move.l d2,(a0)+
 sub.l #16,d1
 cmp.l #16,d1
 bcc fill_bytes_block
fill_bytes_longs:
 cmp.l #4,d1
 bcs fill_bytes_tail
 move.l d2,(a0)+
 subq.l #4,d1
 bra fill_bytes_longs
fill_bytes_tail:
 tst.l d1
 beq service_done
fill_bytes_byte:
 move.b d0,(a0)+
 subq.l #1,d1
 bne fill_bytes_byte
 rts
impl_Call_SetScreenBase:
 move.l (a4),display_buffer
 st display_dirty
 rts
impl_Call_NotifyOfScrFlip:
 st display_dirty
 rts
impl_Call_SetMainPalette:
 movea.l (a4),a0
 lea main_dither,a1
 bra palette16
impl_Call_SetCtrlPalette:
 movea.l (a4),a0
 lea panel_dither,a1
palette16:
 moveq #15,d7
palette_next:
 moveq #0,d0
 move.w (a0)+,d0
 and.w #$fff,d0
 bsr palette_colour
 dbra d7,palette_next
 rts
impl_Call_MakeExtPalette:
 movea.l (a4),a0
 move.w (a0)+,d7
 lsr.w #2,d7
 beq service_done
 subq.w #1,d7
 lea main_dither+32,a1
ext_palette_next:
 moveq #0,d0
 move.w (a0)+,d0
 and.w #$fff,d0
 bsr palette_colour
 add.w #64,(a0)+
 dbra d7,ext_palette_next
 rts
* One valid RGB444 key per destination colour, including extended colours.
* Bit 15 marks validity so the initial black upload still populates tables.
palette_colour:
 move.l a1,d1
 sub.l #main_dither,d1
 lea main_palette_keys,a3
 cmp.l #512,d1
 bcs palette_key_index
 move.l a1,d1
 sub.l #panel_dither,d1
 lea panel_palette_keys,a3
palette_key_index:
 * Mode 0 scales its 64-byte expanded entries to two-byte keys here.
 move.w d0,d2
 or.w #$8000,d2
 cmp.w 0(a3,d1.w),d2
 beq palette_key_hit
 move.w d2,0(a3,d1.w)
 jsr menu_cache_colour
 lsl.l #4,d0
 lea rgb_dither,a2
 adda.l d0,a2
 jmp expand_colour
palette_key_hit:
 addq.l #2,a1
 rts
ql_build_dither:
 * BSS is already clear; palettes populate compact caches on demand.
 rts
ql_present_safe:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 bsr ql_present
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_present:
 tst.w hud_redirected
 bne present_done
 tst.b display_dirty
 beq present_done
 movea.l display_buffer,a0
 move.l a0,d0
 beq present_done
 clr.b display_dirty
 jsr select_display_mode
 tst.w hud_active
 bne present_mode8
 jmp present_mode4
present_mode8:
 lea $20e00,a1
 moveq #0,d7
present_row:
 lea main_dither,a2
 tst.w hud_active
 bne present_main
 cmp.w #168,d7
 bcs present_main
 lea panel_dither,a2
present_main:
 move.w d7,d6
 and.w #3,d6
 lsl.w #8,d6
 lsl.w #3,d6
 adda.w d6,a2
 lea 512(a2),a3
 lea 1024(a2),a4
 lea 1536(a2),a5
 moveq #63,d5
present_group:
 * Four output pixels sample centres of five source pixels: 0,1,3,4.
 moveq #0,d2
 move.b (a0)+,d2
 add.w d2,d2
 move.w 0(a2,d2.w),d0
 moveq #0,d2
 move.b (a0)+,d2
 add.w d2,d2
 or.w 0(a3,d2.w),d0
 addq.l #1,a0
 moveq #0,d2
 move.b (a0)+,d2
 add.w d2,d2
 or.w 0(a4,d2.w),d0
 moveq #0,d2
 move.b (a0)+,d2
 add.w d2,d2
 or.w 0(a5,d2.w),d0
 move.w d0,(a1)+
 dbra d5,present_group
 jsr text_present_row_safe
 tst.w hud_active
 beq present_without_hud
 jsr hud_present_row_safe
present_without_hud:
 addq.w #1,d7
 cmp.w #200,d7
 bne present_row
present_done:
 rts
* Four planes, width in 16-pixel words; source starts with a 4-byte header.
impl_Call_BlitBmp:
 movem.l d0-d1,-(a7)
 move.w 6(a4),d0
 move.w 2(a4),d1
 jsr hud_mark_rows
 movem.l (a7)+,d0-d1
 move.w (a4),d6
 move.w 2(a4),d7
 movea.l 8(a4),a0
 addq.l #4,a0
 movea.l 12(a4),a1
 moveq #0,d0
 move.w 6(a4),d0
 mulu #320,d0
 adda.l d0,a1
 adda.w 4(a4),a1
 move.w d6,d0
 mulu d7,d0
 add.l d0,d0
 movea.l a0,a2
 adda.l d0,a2
 movea.l a2,a3
 adda.l d0,a3
 movea.l a3,a6
 adda.l d0,a6
 subq.w #1,d7
bmp_row:
 movem.l d0-d1/a0,-(a7)
 movea.l a1,a0
 move.w d6,d1
 lsl.w #4,d1
 jsr text_clear_span
 movem.l (a7)+,d0-d1/a0
 move.l a1,-(a7)
 move.w d6,-(a7)
 subq.w #1,d6
bmp_word:
 move.w (a0)+,d0
 move.w (a2)+,d1
 move.w (a3)+,d2
 move.w (a6)+,d3
 moveq #15,d5
bmp_pixel:
 moveq #0,d4
 add.w d3,d3
 addx.b d4,d4
 add.w d2,d2
 addx.b d4,d4
 add.w d1,d1
 addx.b d4,d4
 add.w d0,d0
 addx.b d4,d4
 move.b d4,(a1)+
 dbra d5,bmp_pixel
 dbra d6,bmp_word
 move.w (a7)+,d6
 movea.l (a7)+,a1
 adda.w #320,a1
 dbra d7,bmp_row
 rts
impl_Call_DrawStr:
 moveq #0,d7
 bra draw_string
impl_Call_DrawStrShadowed:
 moveq #1,d7
draw_string:
 movea.l 32(a5),a0
 move.l 4(a5),d1
 move.l 8(a5),d2
 move.l (a5),d0
 move.l d1,d6
 jsr native_text_position
str_next:
 moveq #0,d3
 move.b (a0)+,d3
 beq str_done
 cmp.w #32,d3
 bcc str_glyph
 cmp.w #13,d3
 beq str_newline
 cmp.w #1,d3
 beq str_colour
 cmp.w #30,d3
 beq str_x
 cmp.w #31,d3
 bne str_next
 moveq #0,d1
 move.b (a0)+,d1
 add.w d1,d1
 moveq #0,d2
 move.b (a0)+,d2
 jsr native_text_position
 bra str_next
str_x:
 moveq #0,d1
 move.b (a0)+,d1
 add.w d1,d1
 jsr native_text_position
 bra str_next
str_colour:
 moveq #0,d0
 move.b (a0)+,d0
 bra str_next
str_newline:
 add.w #10,d2
 move.l d6,d1
 jsr native_text_position
 bra str_next
str_glyph:
 cmp.w #316,d1
 bgt str_next
 cmp.w #192,d2
 bhi str_next
 movem.l d0-d3/d6-d7/a0,-(a7)
str_no_shadow:
 bsr draw_char
 move.l d1,4(a7)
 movem.l (a7)+,d0-d3/d6-d7/a0
 bra str_next
str_done:
 move.l d1,4(a5)
 rts
draw_char:
 tst.w native_clock
 bne draw_native_clock
 tst.w hud_redirected
 beq indexed_text_char
draw_native_clock:
 jmp native_text_char
indexed_text_char:
 jmp text_char
impl_Call_BlitCursor:
 moveq #1,d7
 bra cursor_blit
impl_Call_RestoreUnderCursor:
 moveq #0,d7
cursor_blit:
 movea.l 8(a4),a0
 move.l 4(a4),d0
 mulu #320,d0
 adda.l d0,a0
 adda.l (a4),a0
 lea cursor_pixels,a1
 lea cursor_saved,a2
 * Interior cursor: clip once, then copy/save rows without per-pixel bounds.
 * Stack arguments are longs; coordinates occupy their low words.
 move.w 2(a4),d0
 cmp.w #304,d0
 bhi cursor_clipped
 move.w 6(a4),d0
 cmp.w #184,d0
 bhi cursor_clipped
 move.l a0,d0
 btst #0,d0
 bne cursor_clipped
 moveq #15,d5
 tst.w d7
 beq cursor_fast_restore
cursor_fast_draw_row:
 move.l (a0)+,(a2)+
 move.l (a0)+,(a2)+
 move.l (a0)+,(a2)+
 move.l (a0)+,(a2)+
 suba.w #16,a0
 moveq #15,d6
cursor_fast_draw_pixel:
 move.b (a1)+,d0
 bmi cursor_fast_transparent
 move.b d0,(a0)
cursor_fast_transparent:
 addq.l #1,a0
 dbra d6,cursor_fast_draw_pixel
 adda.w #304,a0
 dbra d5,cursor_fast_draw_row
 bra cursor_finished
cursor_fast_restore:
 move.l (a2)+,(a0)+
 move.l (a2)+,(a0)+
 move.l (a2)+,(a0)+
 move.l (a2)+,(a0)+
 adda.w #304,a0
 dbra d5,cursor_fast_restore
 bra cursor_finished
cursor_clipped:
 moveq #0,d5
cursor_row:
 moveq #0,d6
cursor_col:
 move.l (a4),d0
 add.w d6,d0
 cmp.w #320,d0
 bcc cursor_skip
 move.l 4(a4),d0
 add.w d5,d0
 cmp.w #200,d0
 bcc cursor_skip
 tst.w d7
 beq cursor_restore
 move.b (a0),(a2)
 move.b (a1),d0
 bmi cursor_skip
 move.b d0,(a0)
 bra cursor_skip
cursor_restore:
 move.b (a2),(a0)
cursor_skip:
 addq.l #1,a0
 addq.l #1,a1
 addq.l #1,a2
 addq.w #1,d6
 cmp.w #16,d6
 bne cursor_col
 adda.w #304,a0
 addq.w #1,d5
 cmp.w #16,d5
 bne cursor_row
cursor_finished:
 st display_dirty
 rts
* Cooperative processing: poll task only increments pending_ticks.
ql_pump:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 move.l pending_ticks,d7
 beq pump_done
 sub.l d7,pending_ticks
 move.l d7,-(a7)
 bsr scan_keyboard
pump_keys:
 jsr InputHandler
 move.w key_head,d0
 cmp.w key_tail,d0
 bne pump_keys
 move.l (a7)+,d7
pump_ticks:
 move.l d7,-(a7)
 jsr L41e2a_vblank
 move.l (a7)+,d7
 subq.l #1,d7
 bne pump_ticks
 * Flight publishes its completed scene at FlipScreen. Keep all tick/input
 * processing above, but defer palette/cursor dirtiness to that publication.
 * Use the same original state flags as the flight HUD, in both variants.
 tst.b L5eb6_a6_base+42
 bpl pump_present
 tst.b L5eb6_a6_base+536
 bmi pump_done
pump_present:
 bsr ql_present
pump_done:
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
scan_keyboard:
 moveq #0,d7
scan_row:
 lea ipc_keyrow,a3
 moveq #7,d0
 sub.w d7,d0
 move.b d0,6(a3)
 moveq #$11,d0
 trap #1
 lea key_rows,a0
 move.b 0(a0,d7.w),d2
 move.b d1,0(a0,d7.w)
 eor.b d1,d2
 moveq #0,d6
scan_bit:
 btst d6,d2
 beq scan_nextbit
 move.w d7,d0
 lsl.w #3,d0
 add.w d6,d0
 lea ql_keymap,a1
 moveq #0,d3
 move.b 0(a1,d0.w),d3
 beq scan_nextbit
 lea key_codes,a1
 btst d6,d1
 bne scan_keydown
 move.b 0(a1,d0.w),d3
 or.w #$80,d3
 bra scan_press
scan_keydown:
 * QL Backspace is CTRL+Left (also emitted by QLBox's host Backspace).
 * Remember the translated make code so release remains $8e even if CTRL
 * is released before Left. Plain Left keeps its original $4b scan code.
 cmp.b #$4b,d3
 bne scan_function_key
 btst #1,key_rows
 beq scan_remember
 moveq #$0e,d3
 bra scan_remember
scan_function_key:
 cmp.b #$3b,d3
 bcs scan_remember
 cmp.b #$3f,d3
 bhi scan_remember
 btst #0,key_rows
 beq scan_remember
 addq.b #5,d3
scan_remember:
 move.b d3,0(a1,d0.w)
scan_press:
 lea key_queue,a1
 move.w key_tail,d0
 move.b d3,0(a1,d0.w)
 addq.w #1,d0
 and.w #255,d0
 move.w d0,key_tail
scan_nextbit:
 addq.w #1,d6
 cmp.w #8,d6
 bne scan_bit
 addq.w #1,d7
 cmp.w #8,d7
 bne scan_row
 * CTRL+ESC cleanly unlinks the poll routine and removes this job.
 btst #1,key_rows
 beq scan_return
 btst #3,key_rows+6
 beq scan_return
 jmp ql_quit
scan_return:
 rts
impl_Call_GetKeyboardEvent:
 moveq #0,d0
 move.w key_head,d1
 cmp.w key_tail,d1
 beq key_none
 lea key_queue,a0
 move.b 0(a0,d1.w),d0
 addq.w #1,d1
 and.w #255,d1
 move.w d1,key_head
key_none:
 move.l d0,(a5)
 rts
impl_Call_GetMouseInput:
 movea.l (a4),a0
 moveq #31,d7
mouse_more:
 move.b $fedf,d0
 cmp.b #$ff,d0
 beq mouse_done
 btst #0,d0
 beq mouse_done
 move.b $fedd,d3
 move.b $fede,d0
 move.b $fedd,d1
 move.b $fede,d0
 move.b $fedd,d2
 move.b $fede,d0
 move.b $fedd,d0
 move.b $fede,d0
 ext.w d1
 ext.w d2
 add.w d1,(a0)
 sub.w d2,2(a0)
 move.w #$f8,d0
 btst #0,d3
 beq mouse_no_left
 or.w #2,d0
mouse_no_left:
 btst #1,d3
 beq mouse_no_right
 or.w #1,d0
mouse_no_right:
 move.w d0,mouse_buttons
 dbra d7,mouse_more
mouse_done:
 move.w mouse_buttons,4(a0)
 rts
* GEMDOS-shaped file API backed by QDOS channels, never fake successful I/O.
impl_Call_Fdelete:
 movea.l (a4),a1
 bsr ql_path
 moveq #-1,d1
 moveq #4,d0
 trap #2
 bra file_result
impl_gemdos:
 move.w (a4)+,d0
 cmp.w #$1a,d0
 beq file_dta
 cmp.w #$3c,d0
 beq file_create
 cmp.w #$3d,d0
 beq file_open
 cmp.w #$3e,d0
 beq file_close
 cmp.w #$3f,d0
 beq file_read
 cmp.w #$40,d0
 beq file_write
 cmp.w #$4e,d0
 beq file_first
 cmp.w #$4f,d0
 beq file_next
 moveq #-32,d0
 bra file_result
file_dta:
 move.l (a4),dta_ptr
 moveq #0,d0
 bra file_result
file_create:
 moveq #3,d3
 bra file_open_common
file_open:
 moveq #1,d3
file_open_common:
 movea.l (a4),a1
 bsr ql_path
 moveq #-1,d1
 moveq #1,d0
 trap #2
 tst.l d0
 bne file_error
 lea file_channels,a1
 moveq #0,d1
file_slot:
 tst.l 0(a1,d1.w)
 beq file_slot_found
 addq.w #4,d1
 cmp.w #128,d1
 bne file_slot
 moveq #2,d0
 trap #2
 moveq #-35,d0
 bra file_result
file_slot_found:
 move.l a0,0(a1,d1.w)
 lsr.w #2,d1
 add.w #64,d1
 move.l d1,d0
 bra file_result
file_handle:
 moveq #0,d0
 move.w (a4),d0
 sub.w #64,d0
 cmp.w #32,d0
 bcc file_badhandle
 lsl.w #2,d0
 lea file_channels,a2
 adda.w d0,a2
 movea.l (a2),a0
 move.l a0,d0
 beq file_badhandle
 moveq #0,d0
 rts
file_badhandle:
 moveq #-37,d0
 rts
file_close:
 bsr file_handle
 tst.l d0
 bne file_result
 clr.l (a2)
 moveq #2,d0
 trap #2
 bra file_result
file_read:
 moveq #3,d7
 bra file_transfer
file_write:
 moveq #7,d7
file_transfer:
 bsr file_handle
 tst.l d0
 bne file_result
 move.l 2(a4),d6
 movea.l 6(a4),a1
 moveq #0,d5
file_chunk:
 tst.l d6
 beq file_count
 move.l d6,d2
 cmp.l #32767,d2
 bls file_chunk_size
 move.l #32767,d2
file_chunk_size:
 moveq #-1,d3
 move.l d7,d0
 trap #3
 moveq #0,d4
 move.w d1,d4
 add.l d4,d5
 sub.l d4,d6
 tst.l d0
 beq file_chunk
 cmp.l #-10,d0
 beq file_count
 tst.l d5
 bne file_count
 bra file_error
file_count:
 move.l d5,d0
 bra file_result
file_error:
 * QDOS file-not-found and EOF become the expected GEMDOS codes.
 cmp.l #-7,d0
 bne file_error_other
 moveq #-33,d0
 bra file_result
file_error_other:
 moveq #-1,d0
file_result:
 move.l d0,(a5)
 rts
* Convert a NUL-terminated DOS path to a QDOS counted name below WIN1_.
ql_path:
 lea path_buf,a0
 lea 2(a0),a2
 move.b #$77,(a2)+
 move.b #$69,(a2)+
 move.b #$6e,(a2)+
 move.b #$31,(a2)+
 move.b #$5f,(a2)+
 cmp.b #$3a,1(a1)
 bne path_slashes
 addq.l #2,a1
path_slashes:
 cmp.b #$5c,(a1)
 bne path_copy
 addq.l #1,a1
 bra path_slashes
path_copy:
 moveq #55,d2
path_char:
 move.b (a1)+,d0
 beq path_done
 cmp.b #$5c,d0
 bne path_store
 moveq #$5f,d0
path_store:
 move.b d0,(a2)+
 dbra d2,path_char
path_done:
 move.l a2,d0
 sub.l a0,d0
 subq.w #2,d0
 move.w d0,(a0)
 rts
file_first:
 move.l dir_channel,d0
 beq dir_open
 movea.l d0,a0
 moveq #2,d0
 trap #2
 clr.l dir_channel
dir_open:
 lea drive_name,a0
 moveq #-1,d1
 moveq #4,d3
 moveq #1,d0
 trap #2
 tst.l d0
 bne file_error
 move.l a0,dir_channel
file_next:
 move.l dir_channel,d0
 beq dir_end
 movea.l d0,a0
 lea dir_header,a1
 moveq #64,d2
 moveq #-1,d3
 moveq #3,d0
 trap #3
 tst.l d0
 bne dir_close
 move.w dir_header+14,d0
 cmp.w #1,d0
 bcs file_next
 cmp.w #12,d0
 bhi file_next
 * Frontier defaults to extensionless saves; optional suffixes are ._01 etc.
 * Its original selector requests *.*, not just .CMD.
 tst.b dir_header+5
 bne file_next
 lea dir_header+16,a0
 movea.l dta_ptr,a1
 clr.b 21(a1)
 clr.l 22(a1)
 * QDOS directory lengths include the 64-byte header; GEMDOS wants payload.
 move.l dir_header,d1
 sub.l #64,d1
 move.l d1,26(a1)
 adda.w #30,a1
 subq.w #1,d0
dir_copy:
 move.b (a0)+,(a1)+
 dbra d0,dir_copy
 clr.b (a1)
 moveq #0,d0
 bra file_result
dir_close:
 movea.l dir_channel,a0
 moveq #2,d0
 trap #2
 clr.l dir_channel
dir_end:
 moveq #-49,d0
 bra file_result

* Four row phases and four 512-byte banks per row. No flash bits.
expand_colour:
 lea mode8_masks,a3
 moveq #0,d0
 move.b 0(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 cmp.w 0(a1),d1
 beq expand_same_0_0
 st display_dirty
expand_same_0_0:
 move.w d1,0(a1)
 moveq #0,d0
 move.b 1(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 lsr.w #2,d1
 cmp.w 512(a1),d1
 beq expand_same_0_1
 st display_dirty
expand_same_0_1:
 move.w d1,512(a1)
 moveq #0,d0
 move.b 2(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 lsr.w #4,d1
 cmp.w 1024(a1),d1
 beq expand_same_0_2
 st display_dirty
expand_same_0_2:
 move.w d1,1024(a1)
 moveq #0,d0
 move.b 3(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 lsr.w #6,d1
 cmp.w 1536(a1),d1
 beq expand_same_0_3
 st display_dirty
expand_same_0_3:
 move.w d1,1536(a1)
 moveq #0,d0
 move.b 4(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 cmp.w 2048(a1),d1
 beq expand_same_1_0
 st display_dirty
expand_same_1_0:
 move.w d1,2048(a1)
 moveq #0,d0
 move.b 5(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 lsr.w #2,d1
 cmp.w 2560(a1),d1
 beq expand_same_1_1
 st display_dirty
expand_same_1_1:
 move.w d1,2560(a1)
 moveq #0,d0
 move.b 6(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 lsr.w #4,d1
 cmp.w 3072(a1),d1
 beq expand_same_1_2
 st display_dirty
expand_same_1_2:
 move.w d1,3072(a1)
 moveq #0,d0
 move.b 7(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 lsr.w #6,d1
 cmp.w 3584(a1),d1
 beq expand_same_1_3
 st display_dirty
expand_same_1_3:
 move.w d1,3584(a1)
 moveq #0,d0
 move.b 8(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 cmp.w 4096(a1),d1
 beq expand_same_2_0
 st display_dirty
expand_same_2_0:
 move.w d1,4096(a1)
 moveq #0,d0
 move.b 9(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 lsr.w #2,d1
 cmp.w 4608(a1),d1
 beq expand_same_2_1
 st display_dirty
expand_same_2_1:
 move.w d1,4608(a1)
 moveq #0,d0
 move.b 10(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 lsr.w #4,d1
 cmp.w 5120(a1),d1
 beq expand_same_2_2
 st display_dirty
expand_same_2_2:
 move.w d1,5120(a1)
 moveq #0,d0
 move.b 11(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 lsr.w #6,d1
 cmp.w 5632(a1),d1
 beq expand_same_2_3
 st display_dirty
expand_same_2_3:
 move.w d1,5632(a1)
 moveq #0,d0
 move.b 12(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 cmp.w 6144(a1),d1
 beq expand_same_3_0
 st display_dirty
expand_same_3_0:
 move.w d1,6144(a1)
 moveq #0,d0
 move.b 13(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 lsr.w #2,d1
 cmp.w 6656(a1),d1
 beq expand_same_3_1
 st display_dirty
expand_same_3_1:
 move.w d1,6656(a1)
 moveq #0,d0
 move.b 14(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 lsr.w #4,d1
 cmp.w 7168(a1),d1
 beq expand_same_3_2
 st display_dirty
expand_same_3_2:
 move.w d1,7168(a1)
 moveq #0,d0
 move.b 15(a2),d0
 add.w d0,d0
 move.w 0(a3,d0.w),d1
 lsr.w #6,d1
 cmp.w 7680(a1),d1
 beq expand_same_3_3
 st display_dirty
expand_same_3_3:
 move.w d1,7680(a1)
 addq.l #2,a1
 rts
mode8_masks:
 dc.w $0000,$0040,$0080,$00c0,$8000,$8040,$8080,$80c0
