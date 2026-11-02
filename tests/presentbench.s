 .text
presentbench:
 moveq #0,d2
 lea main_dither,a1
 bsr bench_palette
 move.w #$987,d2
 lea panel_dither,a1
 bsr bench_palette
 lea screen_a,a0
 move.l a0,display_buffer
 move.w #63999,d0
 moveq #0,d1
bench_fill:
 move.b d1,(a0)+
 addq.b #1,d1
 dbra d0,bench_fill
 * Time 200 complete publications using the independent QDOS 50 Hz poll hook.
 clr.l pending_ticks
 move.w #199,d7
bench_loop:
 st display_dirty
 jsr ql_present_safe
 dbra d7,bench_loop
 move.l pending_ticks,bench_ticks
 move.l #$42454e43,bench_done
bench_wait:
 bra bench_wait
bench_ticks: dc.l 0
bench_done: dc.l 0
 .globl bench_ticks
 .globl bench_done

bench_palette:
 move.w #255,d7
bench_palette_loop:
 move.l d2,d0
 lsl.l #4,d0
 lea rgb_dither,a2
 adda.l d0,a2
 jsr expand_colour
 add.w #17,d2
 and.w #$fff,d2
 dbra d7,bench_palette_loop
 rts
