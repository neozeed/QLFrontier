 .data
 even
ipc_keyrow:
 dc.b 9,1,0,0,0,0,0,2
drive_name:
 dc.w 5
 dc.b $77,$69,$6e,$31,$5f
 even
mouse_buttons:
 dc.w $f8
 .globl file_end
file_end:
 .bss
poll_link: ds.l 2
pending_ticks: ds.l 1
display_buffer: ds.l 1
display_dirty: ds.w 1
key_head: ds.w 1
key_tail: ds.w 1
key_rows: ds.b 8
key_codes: ds.b 64
key_queue: ds.b 256
cursor_saved: ds.b 256
main_dither: ds.b 16384
panel_dither: ds.b 16384
file_channels: ds.l 32
dta_ptr: ds.l 1
dir_channel: ds.l 1
dir_header: ds.b 64
path_buf: ds.b 66
hud_redirected: ds.w 1
native_clock: ds.w 1
native_x: ds.w 1
native_y: ds.w 1
text_mask_a: ds.b 8000
text_mask_b: ds.b 8000
text_guard_after: ds.l 1
screen_a: ds.b 64000
screen_a_guard: ds.l 1
screen_b: ds.b 64000
screen_b_guard: ds.l 1
stack_base: ds.b 65536
stack_end:
stack_top_guard: ds.l 1
main_palette_keys: ds.w 256
panel_palette_keys: ds.w 256
mem_end:
