; Minimal all-assembly QDOS foreground shell. Uses the recovered linker's
; relocatable job startup, but bypasses C initialization, stdio and malloc.
.sect .text
.sect .rom
.sect .data
.sect .bss
.sect .data
.align 2
.globl __Cstart
.globl __stack
.globl __prog_name
__Cstart: .data4 asm_main
__stack: .data4 2048
__prog_name: .ascii "EliteQL 1.0 RC5a\0"
.align 2
asm_stats:
 .data4 0x45514248,0x36383030
asm_frames: .data4 0
asm_ticks: .data4 0
asm_free: .data4 0
asm_count: .data2 1
asm_paused: .data2 0
asm_model: .data2 4
asm_ready: .data2 0
asm_snapshot: .data4 0
asm_uncapped: .data2 0
asm_ship_debug: .data4 asm_ships
asm_vector_debug: .data4 asm_vectors
asm_params_debug: .data4 asm_params
asm_controls_debug: .data4 asm_controls
asm_status_debug: .data4 asm_status
asm_mcnt_debug: .data4 asm_mcnt
asm_dials_debug: .data4 _dials_last_status
asm_laser_debug: .data4 asm_laser
asm_hits_debug: .data4 asm_hits
asm_kills_debug: .data4 asm_kills
asm_cloud_debug: .data4 asm_clouds
asm_ai_params_debug: .data4 asm_ai_params
asm_dead_debug: .data4 asm_dead
asm_mode_debug: .data4 asm_mode
asm_rng_debug: .data4 asm_laser+5
asm_ai_calls_debug: .data4 asm_ai_calls
asm_ai_events_debug: .data4 asm_ai_events
asm_ecm_debug: .data4 asm_ecm
asm_launch_debug: .data4 asm_launches
asm_player_debug: .data4 asm_player
asm_planet_debug: .data4 asm_planet
asm_pods_debug: .data4 asm_pods
asm_cargo_debug: .data4 asm_cargo
asm_scooped_debug: .data4 asm_scooped
asm_debris_debug: .data4 asm_debris
asm_full_debug: .data4 asm_full
asm_commander_debug: .data4 asm_commander
asm_page_debug: .data4 asm_page
asm_equipment_debug: .data4 asm_equipment
asm_compass_debug: .data4 asm_compass
asm_losses_debug: .data4 asm_losses
asm_docked_debug: .data4 asm_docked
asm_market_debug: .data4 asm_market
asm_selection_debug: .data4 asm_market_selection
asm_travel_debug: .data4 asm_travel
asm_nav_debug: .data4 asm_nav
asm_arrival_debug: .data4 asm_arriving
asm_fit_debug: .data4 _ship_fit
asm_shop_debug: .data4 asm_shop
asm_ambient_debug: .data4 asm_ambient
asm_encounter_debug: .data4 asm_enc_params
asm_spawn_count_debug: .data4 asm_enc_spawns
asm_world_debug: .data4 asm_world
asm_station_debug: .data4 asm_station
asm_warp_debug: .data4 asm_warp_result
asm_warps_debug: .data4 asm_warps
asm_placeholder_debug: .data4 asm_placeholder
asm_planet_cache_debug: .data4 asm_planet_cache
asm_altitude_debug: .data4 asm_altitude
asm_view_debug: .data4 asm_view
asm_police_debug: .data4 asm_police_launches
asm_sight_debug: .data4 asm_sight
asm_shop_view_debug: .data4 asm_shop_view
asm_computer_debug: .data4 asm_computer_docks
asm_dust_debug: .data4 asm_dust
asm_dust_valid_debug: .data4 asm_dust_valid
asm_snapshot_size_debug: .data4 asm_snapshot_size
asm_snapshot_rle_debug: .data4 asm_snapshot_rle
asm_tunnel_debug: .data4 asm_tunnel_phase
asm_chart_cursor_debug: .data4 asm_chart_cursor
asm_sound_debug: .data4 asm_sound
release_debug: .data4 _release_mode
local_debug: .data4 asm_local_chart
flow_debug: .data4 flow_state
config_debug: .data4 flow_config
name_debug: .data4 flow_name
universe_debug: .data4 uni_state
universe_active_debug: .data4 uni_active
universe_slot_debug: .data4 asm_slot
universe_add_debug: .data4 uni_allocate
universe_remove_debug: .data4 uni_remove_current
universe_cloud_debug: .data4 asm_cloud
universe_models_debug: .data4 _models
cheat_debug: .data4 cheat_active
asm_snapshot_size: .data4 32768
asm_snapshot_rle: .data2 0
asm_tunnel_phase: .data2 0
asm_chart_cursor: .data1 0,0
asm_sound: .space 24
asm_sound_carry: .data2 0
asm_sound_ecm: .data1 0
asm_sound_dead: .data1 0
.align 2
asm_dust: .space 168
asm_dust_valid: .data2 0
asm_shop_view: .data2 0
asm_computer_docks: .data4 0
asm_view: .data2 0
asm_view_keys: .data2 0
asm_police_launches: .data4 0
asm_view_inwk: .space 36
asm_planet_view: .space 36
asm_altitude: .data2 255
asm_planet_cache: .space 80
asm_placeholder: .space 36
.align 2
asm_world: .data2 0
asm_warp_result: .data2 0
asm_warp_key: .data2 0
asm_warp_timer: .data2 0
asm_warps: .data4 0
asm_ambient: .data2 0
asm_deep_key: .data2 0
asm_enc_spawns: .data4 0
asm_enc_params: .space 8
asm_enc_output: .space 202
asm_trader: .space 40
asm_chart: .data2 0
asm_solar_legal: .data2 0
asm_shop: .data2 0
asm_travel: .space 64
asm_nav: .data2 0
asm_nav_keys: .data2 0
asm_nav_step: .data2 0
asm_nav_tries: .data2 0
asm_arriving: .data2 0
asm_arrival_rng: .data4 0
asm_docked: .data2 0
asm_market_selection: .data2 0
asm_market_keys: .data2 0
asm_market_result: .data2 0
asm_keep_launch: .data2 0
asm_keep: .space 34
asm_market: .space 34
asm_compass: .data1 0,0,0,0
asm_losses: .data4 0
asm_bomb_held: .data2 0
asm_commander: .data4 1000
 .data1 0,0,0,0,0,0
asm_page: .data2 0
asm_page_key: .data2 0
asm_salvage: .data2 0
asm_cargo: .space 17
asm_equipment: .data1 255,255,127,0,0
asm_scooped: .data4 0
asm_debris: .data4 0
asm_full: .data4 0
asm_planet: .space 36
asm_pods: .data4 0
asm_spawn_kind: .data2 6
asm_player: .data1 4,0,255,0
asm_mkeys: .data1 0,0,0,0
asm_ecm: .data1 0,0
asm_launches: .data4 0
asm_dead: .data2 0
asm_mode: .data2 0
asm_ai_calls: .data4 0
asm_ai_events: .data4 0
asm_ai_params: .data1 1,70,16,0,0,0
asm_slot: .data2 0
asm_cloud: .data4 0
asm_station: .data4 0
asm_hits: .data4 0
asm_kills: .data4 0
; Fixed reproducible scene seed, NOT the original game's clock initialization.
asm_laser: .data1 0,0,0,128,96,90,111,23,201,0,0,0
asm_fire_key: .data1 0
asm_sight: .data1 0
asm_params: .data1 0,0,1,0
asm_controls: .data1 128,128,0,0,0,0,0,0,0,0,0,0,1
asm_keys: .data1 0,0,0,0,0,0
asm_status: .data1 255,255,255,0,0
asm_mcnt: .data1 0
.align 2
asm_dead_text: .ascii "DESTROYED - N NEW COMMANDER\0"
.align 2
asm_fps_text: .ascii "FPS 00.0  SPEED 00"
asm_msl_text: .ascii " M4 -"
asm_cargo_text: .ascii " C00"
asm_view_text: .ascii " FRONT\0"
asm_view_names: .ascii "FRONTREAR LEFT RIGHT"
.align 2
asm_poll: .data4 0,asm_clock
asm_ipc: .data1 9,1,0,0,0,0,1,2
.sect .text
.extern _equipment_damage
.extern _bomb_key
.extern _bomb_ship
.extern _bomb_tick
.extern _dock_check
.extern _market_init
.extern _market_trade
.extern _launch_legal
.extern _tactics_vector
.extern _move_planet
.extern _compass_frame
.extern _commander_tally
.extern _commander_settle
.extern _commander_rank
.extern _commander_tick
.extern _render_cache
.extern _elite_random
.extern _scoop_step
.extern _debris_count
.extern _cargo_tumble
.extern _player_damage
.extern _pod_step
.extern _tactics_cnt
.extern _missile_icons
.extern _friendly_missile
.extern _player_missile_init
.extern _hostile_missile
.extern _spawn_child
.extern _ecm_step
.extern _tactics_step
.extern _tactics_due
.extern _explosion_start
.extern _explosion_frame
.extern _cloud_xor
.extern _render_exploding
.extern _render_inwk
.extern _laser_fire
.extern _laser_tick
.extern _laser_hit
.extern _ship_damage
.extern _ship_angry
.extern _laser_xor
.extern _sight_xor
.extern _dials_frame
.extern _dials_last_status
.extern _energy_step
.extern _scanner_frame
.extern _scanner_reset
.extern _control_step
.extern _keyboard_drain
.extern _models
.extern _render_ship
.extern _tidy_ship
.extern _move_ship
.extern _motion_position
.extern _motion_matrix
.extern _live_matrix
.globl _exit
asm_clock:
 addq.l #1,asm_ticks
 rts
asm_main:
 ; Preserve the entire caller bitmap, using lossless word RLE when smaller.
 clr.l -(sp)
 clr.l -(sp)
 pea 0x20000
 jsr _screen_pack
 lea 12(sp),sp
 move.l #32768,asm_snapshot_size
 clr.w asm_snapshot_rle
 cmp.l #32768,d0
 bhs snapshot_allocate
 move.l d0,asm_snapshot_size
 move.w #1,asm_snapshot_rle
snapshot_allocate:
 moveq #0x18,d0
 move.l asm_snapshot_size,d1
 moveq #-1,d2
 trap #1
 tst.l d0
 bne _exit
 move.l a0,asm_snapshot
 tst.w asm_snapshot_rle
 beq snapshot_raw
 move.l asm_snapshot_size,-(sp)
 move.l a0,-(sp)
 pea 0x20000
 jsr _screen_pack
 lea 12(sp),sp
 tst.l d0
 bpl snapshot_saved
 ; Another foreground writer changed the bitmap between passes. Bounds were
 ; checked before every packet; exit without changing its display or mode.
 move.l asm_snapshot,a0
 moveq #0x19,d0
 trap #1
 clr.l asm_snapshot
 moveq #-3,d0
 bra _exit
snapshot_raw:
 move.l a0,a1
 move.l #0x20000,a0
 move.w #8191,d0
asm_save_screen:
 move.l (a0)+,(a1)+
 dbra d0,asm_save_screen
snapshot_saved:
 moveq #0x10,d0
 moveq #-1,d1
 moveq #-1,d2
 trap #1
 move.w d1,asm_oldmode
 move.w d2,asm_olddisplay
 moveq #0x10,d0
 moveq #8,d1
 moveq #0,d2
 trap #1
 move.l #0x20000,a0
 move.w #8191,d0
asm_clear_screen:
 clr.l (a0)+
 dbra d0,asm_clear_screen
 bsr asm_labels
 bsr asm_setup
 tst.w _release_mode
 beq startup_ready
 bsr release_commander
 bsr flow_remember
 bsr flow_title_load
startup_ready:
 lea asm_poll,a0
 moveq #0x1c,d0
 trap #1
 moveq #6,d0
 trap #1
 move.l d1,asm_free
 move.w #1,asm_ready
asm_loop:
 bsr asm_sound_poll
 move.l asm_ticks,d0
 addq.l #5,d0
 move.l d0,asm_deadline
 ; Scan the IPC keyboard at 10 Hz even in uncapped render mode.
 move.l asm_ticks,d0
 cmp.l asm_nextkeys,d0
 blt asm_draw_begin
 addq.l #5,d0
 move.l d0,asm_nextkeys
 jsr _keyboard_drain
 tst.w _release_mode
 beq flow_normal
 tst.w flow_state
 bne flow_dispatch
 tst.w asm_dead
 beq flow_normal
 bsr flow_death
 bra flow_dispatch
flow_normal:
 tst.w flow_release_gate
 beq flow_release_clear
 bsr flow_read_key
 tst.w flow_held
 bne asm_update_stats
 clr.w flow_release_gate
flow_release_clear:
 tst.w _release_mode
 beq cheat_poll_done
 bsr cheat_poll
 tst.w d0
 bne asm_update_stats
cheat_poll_done:
 ; Modal commander page: freezes simulation, preserves the pre-existing pause.
 moveq #1,d0
 bsr asm_keyrow
 btst #3,d0
 beq flow_not_escape
 tst.w _release_mode
 beq flow_escape_legacy
 move.w asm_docked,d0
 or.w asm_nav,d0
 or.w asm_page,d0
 or.w asm_shop,d0
 beq flow_escape_legacy
 bsr menu_escape
 bra asm_update_stats
flow_escape_legacy:
 tst.w asm_paused
 beq asm_finish
 tst.w _release_mode
 beq asm_finish
 bsr flow_title_load
 bra asm_update_stats
flow_not_escape:
 tst.w asm_paused
 beq flow_not_config
 tst.w _release_mode
 beq flow_not_config
 bsr flow_pause
 bra asm_update_stats
flow_not_config:
 tst.w _release_mode
 beq flow_cargo_done
 bsr flow_cargo_keys
flow_cargo_done:
 bsr asm_navigation_keys
 tst.w d0
 bne asm_update_stats
 tst.w asm_docked
 beq asm_flight_keys
 bsr dock_status_keys
 tst.w asm_page
 bne asm_update_stats
 bsr asm_dock_keys
 bra asm_update_stats
asm_flight_keys:
 bsr asm_computer_key
 tst.w asm_docked
 bne asm_dock_commit
 bsr asm_view_keys_poll
 tst.w _release_mode
 bne asm_deep_done
 moveq #6,d0
 bsr asm_keyrow
 and.w #32,d0
 move.w asm_deep_key,d1
 eor.w d0,d1
 move.w d0,asm_deep_key
 and.w d0,d1
 beq asm_deep_done
 tst.w asm_page
 bne asm_deep_done
 move.w #3,asm_mode
 move.w #3,asm_salvage
 move.w #12,asm_count
 bsr asm_launch
 clr.l -(sp)
 moveq #0,d0
 move.b asm_travel+24,d0
 move.l d0,-(sp)
 pea asm_travel+16
 pea asm_planet
 jsr _solar_planet
 lea 16(sp),sp
 bsr asm_copy_placeholder
 bra asm_update_stats
asm_deep_done:
 moveq #4,d0
 bsr asm_keyrow
 and.w #128,d0
 move.w asm_warp_key,d1
 eor.w d0,d1
 move.w d0,asm_warp_key
 and.w d0,d1
 beq asm_warp_key_done
 tst.w asm_page
 bne asm_warp_key_done
 tst.w asm_paused
 bne asm_warp_key_done
 tst.w asm_dead
 bne asm_warp_key_done
 bsr asm_warp
asm_warp_key_done:
 moveq #6,d0
 bsr asm_keyrow
 and.w #4,d0
 move.w asm_page_key,d1
 eor.w d0,d1
 move.w d0,asm_page_key
 and.w d0,d1
 beq asm_page_key_done
 cmp.w #2,asm_page
 bne flow_page_toggle_0
 move.w #1,asm_page
flow_page_toggle_0:
 eor.w #1,asm_page
 bsr asm_clear_view
 tst.w asm_page
 beq asm_page_close
 bsr asm_commander_page
 bra asm_page_key_done
asm_page_close:
 bsr asm_restore_view
asm_page_key_done:
 tst.w asm_page
 bne asm_update_stats
 moveq #2,d0
 bsr asm_keyrow
 move.w d0,asm_row2
 btst #4,d0
 beq asm_bench_done
 btst #4,asm_old2+1
 bne asm_bench_done
 tst.w _release_mode
 bne asm_bench_done
 eor.w #1,asm_uncapped
asm_bench_done:
 move.w asm_row2,asm_old2
 moveq #1,d0
 bsr asm_keyrow
 move.w d0,asm_row1
 btst #3,d0
 bne asm_finish
 tst.w _release_mode
 bne release_pause_key
 btst #6,d0
 beq asm_pause_done
 btst #6,asm_old1+1
 bne asm_pause_done
 eor.w #1,asm_paused
 bra asm_pause_done
release_pause_key:
 moveq #0,d0
 bsr asm_keyrow
 and.w #32,d0
 move.w release_pause_old,d1
 eor.w d0,d1
 move.w d0,release_pause_old
 and.w d0,d1
 beq asm_pause_done
 eor.w #1,asm_paused
 move.w #1,flow_held
asm_pause_done:
 move.w asm_row1,asm_old1
 moveq #7,d0
 bsr asm_keyrow
 move.w d0,asm_row7
 btst #6,d0
 beq asm_next_done
 btst #6,asm_old7+1
 bne asm_next_done
 tst.w _release_mode
 beq dev_next_model
 tst.w asm_dead
 beq asm_next_done
 bsr asm_setup
 bsr release_commander
 bra asm_update_stats
dev_next_model:
 addq.w #1,asm_model
 cmp.w #10,asm_model
 blt asm_next_valid
 clr.w asm_model
asm_next_valid:
 move.w asm_model,d0
 lsl.w #2,d0
 lea _models,a0
 move.l 0(a0,d0.w),asm_ships
 bsr asm_setup
asm_next_done:
 move.w asm_row7,asm_old7
 tst.w _release_mode
 bne asm_port_key_done
 moveq #4,d0
 bsr asm_keyrow
 btst #3,d0
 beq asm_check_fleet
 cmp.w #1,asm_count
 beq asm_check_fleet
 move.w #1,asm_count
 clr.w asm_mode
 bsr asm_setup
asm_check_fleet:
 moveq #4,d0
 bsr asm_keyrow
 btst #1,d0
 beq asm_check_two
 cmp.w #2,asm_mode
 bne asm_start_encounter
 tst.w asm_dead
 beq asm_check_two
asm_start_encounter:
 move.w #3,asm_count
 move.w #2,asm_mode
 bsr asm_setup
asm_check_two:
 moveq #6,d0
 bsr asm_keyrow
 btst #1,d0
 beq asm_move
 cmp.w #1,asm_mode
 beq asm_move
 move.w #12,asm_count
 move.w #1,asm_mode
 bsr asm_setup
asm_move:
 moveq #0,d0
 bsr asm_keyrow
 btst #6,d0
 beq asm_check_salvage
 tst.w asm_salvage
 bne asm_missile_scene
 cmp.w #3,asm_mode
 bne asm_missile_scene
 tst.w asm_dead
 beq asm_check_ecm
asm_missile_scene:
 clr.w asm_salvage
 move.w #12,asm_count
 move.w #3,asm_mode
 bsr asm_setup
asm_check_salvage:
 moveq #0,d0
 bsr asm_keyrow
 btst #2,d0
 beq asm_check_ecm
 cmp.w #3,asm_mode
 bne asm_salvage_scene
 tst.w asm_salvage
 beq asm_salvage_scene
 tst.w asm_dead
 beq asm_check_ecm
asm_salvage_scene:
 move.w #1,asm_salvage
 move.w #12,asm_count
 move.w #3,asm_mode
 bsr asm_setup
asm_check_ecm:
 moveq #0,d0
 bsr asm_keyrow
 btst #7,d0
 beq asm_port_key_done
 cmp.w #3,asm_mode
 bne asm_start_port
 cmp.w #2,asm_salvage
 bne asm_start_port
 tst.w asm_dead
 beq asm_port_key_done
asm_start_port:
 move.w #2,asm_salvage
 move.w #12,asm_count
 move.w #3,asm_mode
 bsr asm_setup
asm_port_key_done:
 tst.b asm_equipment
 beq asm_ecm_key_done
 moveq #6,d0
 bsr asm_keyrow
 btst #4,d0
 beq asm_ecm_key_done
 tst.b asm_ecm
 bne asm_ecm_key_done
 move.b #32,asm_ecm
 move.b #255,asm_ecm+1
asm_ecm_key_done:
 moveq #5,d0
 bsr asm_keyrow
 and.w #32,d0
 move.w d0,asm_bomb_held
 moveq #6,d0
 bsr asm_keyrow
 btst #6,d0
 sne asm_mkeys
 btst #7,d0
 sne asm_mkeys+1
 moveq #2,d0
 bsr asm_keyrow
 btst #6,d0
 sne asm_mkeys+2
 ; Map raw QL keys to original DOKEY/KY1/KY2 held states.
 ; Rate updates run once per simulation frame below, not per scan.
 lea asm_keys,a0
 move.w asm_row1,d0
 btst #1,d0
 sne (a0)
 btst #4,d0
 sne 1(a0)
 ; Traditional flight mapping: Down pulls up, Up pushes down.
 btst #7,d0
 sne 2(a0)
 btst #2,d0
 sne 3(a0)
 tst.w _release_mode
 bne release_flight_keys
 moveq #4,d0
 bsr asm_keyrow
 lea asm_keys,a0
 btst #4,d0
 sne 4(a0)
 moveq #2,d0
 bsr asm_keyrow
 lea asm_keys,a0
 btst #1,d0
 sne 5(a0)
 moveq #3,d0
 bsr asm_keyrow
 btst #4,d0
 sne asm_fire_key
 bra asm_draw_begin
release_flight_keys:
 ; Electron KYTB primary keys; unshifted comma/period/slash work too.
 ; Existing arrow pitch/roll values are aliases, OR with these held keys.
 moveq #7,d0
 bsr asm_keyrow
 btst #7,d0
 beq release_roll_right
 move.b #255,asm_keys
release_roll_right:
 moveq #2,d0
 bsr asm_keyrow
 btst #2,d0
 beq release_pull_up
 move.b #255,asm_keys+1
release_pull_up:
 moveq #7,d0
 bsr asm_keyrow
 btst #3,d0
 beq release_pitch_down
 move.b #255,asm_keys+2
release_pitch_down:
 moveq #3,d0
 bsr asm_keyrow
 btst #3,d0
 beq release_speed
 move.b #255,asm_keys+3
release_speed:
 move.w asm_row1,d0
 btst #6,d0
 sne asm_keys+4
 moveq #7,d0
 bsr asm_keyrow
 btst #5,d0
 sne asm_keys+5
 moveq #2,d0
 bsr asm_keyrow
 btst #1,d0
 beq release_fire
 move.b #255,asm_keys+5
release_fire:
 moveq #4,d0
 bsr asm_keyrow
 btst #4,d0
 sne asm_fire_key
 moveq #3,d0
 bsr asm_keyrow
 btst #4,d0
 beq asm_draw_begin
 move.b #255,asm_fire_key
asm_draw_begin:
 tst.w cheat_active
 bne asm_update_stats
 tst.w flow_state
 bne asm_wait
 tst.w asm_nav
 bne asm_update_stats
 tst.w asm_docked
 bne asm_update_stats
 tst.w asm_page
 bne asm_update_stats
 tst.w asm_dead
 bne asm_update_stats
 tst.w asm_paused
 bne asm_update_stats
 ; Original M% reseeds RAND from planet x_lo at each flight update.
 move.b asm_planet,asm_laser+5
 pea asm_sound
 jsr _sound_tick
 addq.l #4,sp
 pea asm_travel
 jsr _travel_tick
 addq.l #4,sp
 tst.w d0
 bne asm_arrival
 moveq #0,d0
 move.w asm_bomb_held,d0
 move.l d0,-(sp)
 pea asm_equipment+2
 jsr _bomb_key
 addq.l #8,sp
 bsr asm_player_input
 pea asm_keys
 pea asm_controls
 jsr _control_step
 addq.l #8,sp
 move.b asm_controls+4,asm_params
 move.b asm_controls+5,asm_params+1
 move.b asm_controls+12,asm_params+2
 ; Original planet orientation is live in real-world sorties.
 tst.w asm_world
 beq planet_tidy_done
 move.b asm_mcnt,d0
 and.b #15,d0
 bne planet_tidy_done
 pea asm_planet
 jsr _tidy_ship
 addq.l #4,sp
planet_tidy_done:
 ; Planet follows original full-width player-relative movement.
 clr.b asm_params+3
 clr.l -(sp)
 pea asm_params
 pea asm_planet
 jsr _move_planet
 lea 12(sp),sp
 tst.w asm_world
 beq planet_rotation_done
 pea asm_params
 pea asm_planet
 jsr _rotate_body
 addq.l #8,sp
planet_rotation_done:
 tst.w asm_world
 beq planet_draw_done
 moveq #0,d0
 move.w asm_view,d0
 move.l d0,-(sp)
 pea asm_planet
 pea asm_planet_view
 jsr _view_transform
 lea 12(sp),sp
 pea asm_planet_view
 pea asm_planet_cache
 pea 0x20000
 jsr _planet_frame
 lea 12(sp),sp
planet_draw_done:
 ; MA68 calls NOISE only after all firing gates pass; NO3 carry reaches LASLI.
 bsr asm_current_laser
 move.w d0,d2
 clr.w asm_sound_carry
 tst.b asm_laser
 bne laser_sound_ready
 tst.b asm_fire_key
 beq laser_sound_ready
 cmp.b #242,asm_status+3
 bhs laser_sound_ready
 tst.b d2
 beq laser_sound_ready
 moveq #0,d0
 bsr asm_sound_event
laser_sound_ready:
 moveq #0,d0
 move.w asm_sound_carry,d0
 move.l d0,-(sp)
 moveq #0,d0
 move.b d2,d0
 move.l d0,-(sp)
 moveq #0,d0
 move.b asm_fire_key,d0
 move.l d0,-(sp)
 pea asm_status
 pea asm_laser
 jsr _laser_fire
 lea 20(sp),sp
 tst.l d0
 beq asm_fire_drawn
 pea asm_laser
 pea 0x20000
 jsr _laser_xor
 addq.l #8,sp
 move.b #1,asm_laser+9
asm_fire_drawn:
 clr.w asm_slot
 lea asm_ships,a5
 move.w asm_count,d7
 subq.w #1,d7
asm_draw_loop:
 tst.w uni_active
 bne uni_draw_entry
 lea asm_vectors,a0
 move.w asm_count,d0
 subq.w #1,d0
 sub.w d7,d0
 move.w d0,asm_slot
uni_slot_ready:
 mulu.w #448,d0
 lea asm_clouds,a1
 adda.l d0,a1
 move.l a1,asm_cloud
 move.w asm_slot,d0
 mulu.w #36,d0
 adda.l d0,a0
 move.l a0,a4
 moveq #0,d0
 move.b asm_equipment+2,d0
 move.l d0,-(sp)
 move.l (a5),a0
 move.w 28(a0),d0
 move.l d0,-(sp)
 move.l a4,-(sp)
 jsr _bomb_ship
 lea 12(sp),sp
 tst.l d0
 beq asm_bomb_ship_done
 pea asm_commander
 jsr _commander_tally
 addq.l #4,sp
asm_bomb_ship_done:
 btst #7,31(a4)
 beq asm_pending_done
 btst #5,31(a4)
 bne asm_pending_done
 pea asm_laser+5
 move.l (a5),-(sp)
 move.l asm_cloud,-(sp)
 move.l a4,-(sp)
 bsr asm_sound_explosion
 jsr _explosion_start
 lea 16(sp),sp
 bsr asm_abort_target
asm_pending_done:
 move.b 31(a4),d0
 and.b #160,d0
 beq asm_live_ship
 cmp.b #32,d0
 beq asm_no_tidy
 move.w #1,14(a5)
 bra asm_render_current
asm_live_ship:
 ; Original MVEIT part 1 scheduling: (MCNT XOR XSAV) AND 15.
 move.b 31(a4),d0
 and.b #160,d0
 bne asm_no_tidy
 move.w asm_slot,d0
 tst.w uni_active
 beq uni_tidy_index
 addq.w #1,d0
uni_tidy_index:
 moveq #0,d1
 move.b asm_mcnt,d1
 eor.w d1,d0
 and.w #15,d0
 bne asm_no_tidy
 move.l a4,-(sp)
 jsr _tidy_ship
 addq.l #4,sp
asm_no_tidy:
 ; Original cadence, with universe-dependent types left outside this entry.
 moveq #0,d0
 move.w asm_slot,d0
 tst.w uni_active
 beq uni_tactics_index
 addq.w #1,d0
uni_tactics_index:
 move.l d0,-(sp)
 moveq #0,d0
 move.b asm_mcnt,d0
 move.l d0,-(sp)
 move.l (a5),a0
 moveq #0,d0
 move.w 28(a0),d0
 move.l d0,-(sp)
 move.l a4,-(sp)
 jsr _tactics_due
 lea 16(sp),sp
 tst.l d0
 beq asm_ai_done
 tst.w asm_dead
 bne asm_ai_done
 move.l (a5),a0
 cmp.w #7,28(a0)
 beq asm_station_ai
 cmp.w #11,28(a0)
 beq asm_pod_ai
 cmp.w #8,28(a0)
 beq asm_ai_allowed
 cmp.w #6,28(a0)
 bhi asm_ai_done
 bra asm_ai_allowed
asm_pod_ai:
 moveq #0,d0
 move.b _tactics_cnt,d0
 move.l d0,-(sp)
 pea asm_planet
 move.l a4,-(sp)
 jsr _pod_step
 lea 12(sp),sp
 bra asm_ai_done
asm_ai_allowed:
 clr.b asm_ai_params+3
 tst.l asm_station
 beq station_zone_ready
 move.b #1,asm_ai_params+3
station_zone_ready:
 move.w 28(a0),d0
 move.b d0,asm_ai_params
 move.w 24(a0),d0
 move.b d0,asm_ai_params+1
 move.w 30(a0),d0
 move.b d0,asm_ai_params+2
 move.b asm_ecm,asm_ai_params+4
 pea asm_status
 pea asm_laser+5
 pea asm_ai_params
 move.l a4,-(sp)
 cmp.b #8,asm_ai_params
 bne asm_normal_ai
 tst.b asm_ecm
 bne asm_hostile_path
 btst #6,32(a4)
 bne asm_hostile_path
 ; The friendly entry has a different ABI, discard the common arguments.
 lea 16(sp),sp
 moveq #0,d0
 move.b 32(a4),d0
 lsr.w #1,d0
 and.w #31,d0
 tst.w uni_active
 beq uni_friendly_index
 subq.w #1,d0
 bmi asm_friendly_invalid
 tst.w d0
 bne uni_friendly_index
 tst.l asm_station
 bne uni_friendly_index
 lea asm_placeholder,a0
 moveq #7,d1
 bra asm_friendly_target
uni_friendly_index:
 cmp.w #12,d0
 bhs asm_friendly_invalid
 move.w d0,d1
 mulu.w #272,d1
 lea asm_ships,a0
 adda.l d1,a0
 move.l (a0),a0
 moveq #0,d1
 move.w 28(a0),d1
 mulu.w #36,d0
 lea asm_vectors,a0
 adda.l d0,a0
 tst.w uni_active
 bne asm_friendly_target
 btst #7,31(a0)
 bne asm_friendly_invalid
 bra asm_friendly_target
asm_friendly_invalid:
 suba.l a0,a0
 moveq #0,d1
asm_friendly_target:
 pea asm_laser+5
 move.l d1,-(sp)
 move.l a0,-(sp)
 move.l a4,-(sp)
 jsr _friendly_missile
 lea 16(sp),sp
 cmp.w #7,d0
 bne asm_friendly_not_ecm
 move.b #32,asm_ecm
 moveq #0,d0
 bra asm_ai_result
asm_friendly_not_ecm:
 cmp.w #6,d0
 blo asm_ai_result
 ; TA35 collateral blast uses the existing explicit-carry adapter.
 move.b #1,asm_ai_params+4
 pea asm_status
 pea asm_laser+5
 pea asm_ai_params
 move.l a4,-(sp)
asm_hostile_path:
 tst.b asm_ai_params+4
 beq asm_missile_no_tally
 pea asm_commander
 jsr _commander_tally
 addq.l #4,sp
asm_missile_no_tally:
 jsr _hostile_missile
 bra asm_ai_return
asm_normal_ai:
 jsr _tactics_step
asm_ai_return:
 lea 16(sp),sp
asm_ai_result:
 addq.l #1,asm_ai_calls
 cmp.w #1,d0
 bne asm_ai_not_launch
 bsr asm_spawn_missile
 moveq #0,d0
asm_ai_not_launch:
 cmp.w #2,d0
 bne asm_ai_not_escape
 move.w #9,asm_spawn_kind
 bsr asm_spawn_missile
 move.w #6,asm_spawn_kind
 moveq #0,d0
asm_ai_not_escape:
 cmp.w #3,d0
 blo asm_ai_not_hit
 addq.l #1,asm_ai_events
 move.w d0,-(sp)
 moveq #8,d0
 bsr asm_sound_event
 move.w (sp)+,d0
asm_ai_not_hit:
 cmp.w #4,d0
 bne asm_ai_no_ouch
 bsr asm_equipment_ouch
 moveq #4,d0
asm_ai_no_ouch:
 cmp.w #5,d0
 bne asm_ai_done
 move.w #1,asm_dead
asm_ai_done:
 btst #7,31(a4)
 beq asm_ai_alive
 pea asm_laser+5
 move.l (a5),-(sp)
 move.l asm_cloud,-(sp)
 move.l a4,-(sp)
 bsr asm_sound_explosion
 jsr _explosion_start
 lea 16(sp),sp
 bsr asm_abort_target
asm_ai_alive:
 move.l (a5),a0
 move.w 22(a0),d0
 move.b d0,asm_params+3
 pea asm_params
 move.l a4,-(sp)
 jsr _move_ship
 addq.l #8,sp
 pea 4(a5)
 move.l a4,-(sp)
 jsr _motion_position
 addq.l #8,sp
 eor.w #1,d0
 move.w d0,14(a5)
 bsr asm_farof
 tst.w d0
 bne asm_render_current
 bsr asm_contact
 tst.w asm_docked
 bne asm_dock_commit
 move.b 31(a4),d0
 and.b #160,d0
 bne asm_no_hit
 bsr asm_view_ship
 tst.b asm_player+1
 beq asm_lock_done
 move.l (a5),a0
 moveq #0,d0
 move.w 26(a0),d0
 move.l d0,-(sp)
 moveq #0,d0
 move.w 28(a0),d0
 move.l d0,-(sp)
 pea asm_view_inwk
 jsr _laser_hit
 lea 12(sp),sp
 tst.l d0
 beq asm_lock_done
 move.w asm_slot,d0
 move.b d0,asm_player+2
 clr.b asm_player+1
 moveq #32,d0
 bsr asm_sound_event
asm_lock_done:
 ; Original HITCH follows PLUT: test view-space INWK, damage world state.
 tst.b asm_laser+1
 beq asm_no_hit
 move.l (a5),a0
 moveq #0,d0
 move.w 26(a0),d0
 move.l d0,-(sp)
 moveq #0,d0
 move.w 28(a0),d0
 move.l d0,-(sp)
 pea asm_view_inwk
 jsr _laser_hit
 lea 12(sp),sp
 tst.l d0
 beq asm_no_hit
 addq.l #1,asm_hits
 bsr asm_sound_hit
 move.l (a5),a0
 moveq #0,d0
 move.w 28(a0),d0
 move.l d0,-(sp)
 moveq #0,d0
 move.b asm_laser+1,d0
 move.l d0,-(sp)
 move.l a4,-(sp)
 jsr _ship_damage
 lea 12(sp),sp
 cmp.w #2,d0
 bne asm_hit_survived
 pea asm_commander
 jsr _commander_tally
 addq.l #4,sp
 bsr asm_drop_cargo
 ; LL9 initializes a real original explosion cloud at the kill boundary.
 pea asm_laser+5
 move.l (a5),-(sp)
 move.l asm_cloud,-(sp)
 move.l a4,-(sp)
 bsr asm_sound_explosion
 jsr _explosion_start
 lea 16(sp),sp
 bsr asm_abort_target
 addq.l #1,asm_kills
 bra asm_no_hit
asm_hit_survived:
 move.l asm_station,-(sp)
 move.l (a5),a0
 moveq #0,d0
 move.w 28(a0),d0
 move.l d0,-(sp)
 move.l a4,-(sp)
 jsr _ship_angry
 lea 12(sp),sp
asm_no_hit:
asm_render_current:
 bsr asm_view_ship
 pea asm_matrix
 pea asm_view_inwk
 jsr _motion_matrix
 addq.l #8,sp
 move.l #asm_matrix,_live_matrix
 clr.w _render_exploding
 move.l #asm_view_inwk,_render_inwk
 btst #5,31(a4)
 beq asm_render_effect_ready
 move.w #1,_render_exploding
asm_render_effect_ready:
 move.l a5,-(sp)
 pea 0x20000
 jsr _render_ship
 addq.l #8,sp
 move.b asm_view_inwk+31,31(a4)
 clr.l _live_matrix
 clr.l _render_inwk
 clr.w _render_exploding
 btst #5,31(a4)
 beq asm_cloud_done
 move.l asm_cloud,a0
 tst.b 2(a0)
 beq asm_cloud_done
 pea asm_laser+5
 move.l a0,-(sp)
 pea asm_view_inwk
 pea 0x20000
 jsr _explosion_frame
 lea 16(sp),sp
 move.b asm_view_inwk+31,31(a4)
 btst #7,31(a4)
 beq asm_cloud_done
 move.l asm_cloud,a0
 clr.b 2(a0)
 move.l (a5),a0
 moveq #0,d0
 move.w 38(a0),d0
 move.l d0,-(sp)
 move.w 28(a0),d0
 move.l d0,-(sp)
 pea asm_commander
 jsr _commander_settle
 lea 12(sp),sp
asm_cloud_done:
 tst.w uni_active
 bne uni_draw_complete
 lea 272(a5),a5
 dbra d7,asm_draw_loop
uni_draw_finished:
 moveq #0,d0
 move.w asm_count,d0
 move.l d0,-(sp)
 pea asm_vectors
 pea 0x20000
 jsr _scanner_frame
 lea 12(sp),sp
 moveq #0,d0
 move.b asm_mcnt,d0
 move.l d0,-(sp)
 move.b asm_equipment+3,asm_status+4
 pea asm_status
 jsr _energy_step
 addq.l #8,sp
 tst.w asm_warp_timer
 beq warp_timer_done
 subq.w #1,asm_warp_timer
warp_timer_done:
 move.b asm_mcnt,d0
 and.b #31,d0
 cmp.b #10,d0
 bne altitude_tick_done
 cmp.b #50,asm_status+2
 bhi altitude_no_warning
 moveq #4,d0
 bsr asm_message
 moveq #32,d0
 bsr asm_sound_event
altitude_no_warning:
 tst.w asm_world
 beq altitude_tick_done
 ; Original LL5 incoming Q is an explicit zero scratch boundary here.
 clr.l -(sp)
 pea asm_planet
 jsr _planet_altitude
 addq.l #8,sp
 move.w d0,d1
 and.w #255,d0
 move.w d0,asm_altitude
 btst #8,d1
 beq altitude_tick_done
 move.w #1,asm_dead
altitude_tick_done:
 bsr asm_station_tick
 pea asm_status
 pea asm_ecm
 jsr _ecm_step
 addq.l #8,sp
 bsr asm_ecm_sound
 ; MA23 erases pulse lines when LASCT falls below 8.
 tst.b asm_laser+9
 beq asm_laser_end
 cmp.b #8,asm_laser
 bhs asm_laser_end
 bsr asm_erase_laser
asm_laser_end:
 pea asm_equipment+2
 jsr _bomb_tick
 addq.l #4,sp
 moveq #1,d0
 bsr asm_dust_run
 moveq #0,d2
 move.b asm_commander+7,d2
 pea asm_commander
 jsr _commander_tick
 addq.l #4,sp
 ; me2/mes9's final LSR de determines C when a message expires.
 cmp.w #1,d2
 bne message_carry_ready
 clr.b asm_dust+166
 cmp.b #3,asm_commander+8
 bne message_carry_ready
 move.b #1,asm_dust+166
message_carry_ready:
 subq.b #1,asm_mcnt
 bne asm_no_encounter_tick
 bsr asm_encounters
asm_no_encounter_tick:
 ; MLOOP's SBC #4 uses the actual preceding STARS/message/encounter carry.
 moveq #0,d0
 move.b asm_dust+166,d0
 move.l d0,-(sp)
 pea asm_laser
 jsr _laser_tick
 addq.l #8,sp
 bsr asm_draw_dials
 addq.l #1,asm_frames
 bra asm_update_stats
asm_dock_commit:
 moveq #8,d0
 bsr asm_tunnel
 clr.b asm_player+1
 move.b #255,asm_player+2
 move.w #2,asm_salvage
 clr.b asm_travel+11
 clr.b asm_travel+13
 ; GOIN/RES4 state boundary. Tunnel/text and local scene are QL adapters.
 move.b #255,asm_status
 move.b #255,asm_status+1
 move.b #255,asm_status+2
 clr.b asm_status+3
 clr.w asm_ecm
 clr.b asm_laser
 clr.b asm_laser+1
 clr.b asm_laser+9
 clr.w asm_market_keys
 bsr asm_draw_dials
 bsr asm_clear_view
 bsr asm_market_page
 bra asm_update_stats
asm_update_stats:
 moveq #0,d0
 tst.w asm_dead
 sne d0
 cmp.b asm_sound_dead,d0
 beq death_sound_done
 move.b d0,asm_sound_dead
 tst.b d0
 beq death_sound_done
 moveq #24,d0
 bsr asm_sound_event
death_sound_done:
 bsr asm_fps
 tst.w asm_uncapped
 bne asm_loop
asm_wait:
 bsr asm_sound_poll
 move.l asm_deadline,d0
 sub.l asm_ticks,d0
 ble asm_loop
 moveq #8,d0
 moveq #-1,d1
 moveq #1,d3
 suba.l a1,a1
 trap #1
 bra asm_wait
asm_finish:
 ; Wait for release so autorepeat cannot inject the exit key into BASIC.
 clr.w asm_release_quiet
asm_release_wait:
 jsr _keyboard_drain
 clr.w asm_release_keys
 clr.w asm_release_row
asm_release_scan:
 move.w asm_release_row,d0
 bsr asm_keyrow
 or.w d0,asm_release_keys
 addq.w #1,asm_release_row
 cmp.w #8,asm_release_row
 blt asm_release_scan
 tst.w asm_release_keys
 beq asm_release_idle
 clr.w asm_release_quiet
 bra asm_release_tick
asm_release_idle:
 addq.w #1,asm_release_quiet
 cmp.w #3,asm_release_quiet
 bge asm_release_done
asm_release_tick:
 moveq #8,d0
 moveq #-1,d1
 moveq #1,d3
 suba.l a1,a1
 trap #1
 bra asm_release_wait
asm_release_done:
 pea asm_sound
 jsr _sound_stop
 addq.l #4,sp
 jsr _keyboard_drain
 clr.w asm_ready
 lea asm_poll,a0
 moveq #0x1d,d0
 trap #1
 moveq #0x10,d0
 move.w asm_oldmode,d1
 move.w asm_olddisplay,d2
 trap #1
 tst.w asm_snapshot_rle
 beq snapshot_restore_raw
 pea 0x20000
 move.l asm_snapshot,-(sp)
 jsr _screen_unpack
 addq.l #8,sp
 bra snapshot_restored
snapshot_restore_raw:
 move.l asm_snapshot,a0
 move.l #0x20000,a1
 move.w #8191,d0
asm_restore_screen:
 move.l (a0)+,(a1)+
 dbra d0,asm_restore_screen
snapshot_restored:
 move.l asm_snapshot,a0
 moveq #0x19,d0
 trap #1
 clr.l asm_snapshot
 moveq #0,d0
_exit:
 move.l d0,d3
 moveq #-1,d1
 moveq #5,d0
 trap #1
 bra _exit
; Row in D0, byte result in D0. MT.IPCOM clobbers D5/D7/A3.
asm_keyrow:
 move.b d0,asm_ipc+6
 lea asm_ipc,a3
 moveq #0x11,d0
 trap #1
 moveq #0,d0
 move.b d1,d0
 rts
; Erase all old caches before changing between one and twelve ships.
asm_erase_laser:
 tst.b asm_laser+9
 beq asm_erase_laser_done
 pea asm_laser
 pea 0x20000
 jsr _laser_xor
 addq.l #8,sp
 clr.b asm_laser+9
 clr.b asm_laser+2
asm_erase_laser_done:
 rts
asm_setup:
 clr.w uni_active
 clr.l _encounter_pool
 tst.w asm_dust_valid
 beq dust_setup_clean
 moveq #3,d0
 bsr asm_dust_run
dust_setup_clean:
 clr.w asm_dust_valid
 clr.w asm_shop_view
 clr.l asm_computer_docks
 clr.w asm_view
 clr.l asm_police_launches
 bsr asm_view_label
 pea asm_planet_cache
 pea 0x20000
 jsr _render_cache
 addq.l #8,sp
 clr.w asm_planet_cache+12
 move.w #255,asm_altitude
 clr.w asm_chart
 clr.w asm_local_chart
 clr.w asm_shop
 clr.w asm_docked
 clr.w asm_market_keys
 clr.w asm_market_selection
 clr.w asm_market_result
 tst.w asm_keep_launch
 bne asm_market_kept
 move.b #22,_ship_fit
 move.b #15,_ship_fit+1
 clr.w _ship_fit+2
 clr.l _ship_fit+4
 pea asm_travel
 jsr _travel_init
 addq.l #4,sp
 clr.w asm_nav
 clr.w asm_nav_keys
 clr.w asm_ambient
 clr.w asm_world
 clr.l asm_warps
 clr.w asm_warp_result
 clr.w asm_warp_timer
 clr.l asm_enc_spawns
 clr.b asm_enc_params+5
 ; Initial Lave market, fluctuation0.
 clr.l -(sp)
 move.l #5,-(sp)
 pea asm_market
 jsr _market_init
 lea 12(sp),sp
asm_market_kept:
 ; Erase all old particle caches before clearing their authoritative state.
 lea asm_clouds,a4
 moveq #11,d7
asm_cloud_reset_loop:
 moveq #0,d0
 move.w 56(a4),d0
 move.l d0,-(sp)
 pea 58(a4)
 pea 0x20000
 jsr _cloud_xor
 lea 12(sp),sp
 lea 448(a4),a4
 dbra d7,asm_cloud_reset_loop
 lea asm_clouds,a0
 move.w #1343,d0
asm_cloud_zero:
 clr.l (a0)+
 dbra d0,asm_cloud_zero
 lea asm_cargo,a0
 moveq #21,d0
asm_cargo_zero:
 clr.b 0(a0,d0.w)
 dbra d0,asm_cargo_zero
 move.b #255,asm_equipment
 move.b #255,asm_equipment+1
 move.b #127,asm_equipment+2
 clr.l asm_losses
 clr.w asm_bomb_held
 clr.l asm_compass
 move.l #1000,asm_commander
 clr.l asm_commander+4
 clr.w asm_commander+8
 clr.l asm_scooped
 clr.l asm_debris
 clr.l asm_full
 clr.l asm_pods
 move.w #6,asm_spawn_kind
 clr.b _tactics_cnt
 lea asm_planet,a0
 moveq #35,d0
asm_planet_zero:
 clr.b 0(a0,d0.w)
 dbra d0,asm_planet_zero
 move.b #1,asm_planet+2
 move.b #4,asm_planet+8
 move.b #4,asm_player
 clr.b asm_player+1
 move.b #255,asm_player+2
 clr.b asm_player+3
 clr.w asm_ecm
 clr.l asm_launches
 clr.w asm_dead
 clr.l asm_ai_calls
 clr.l asm_ai_events
 bsr asm_erase_laser
 tst.b _ship_fit+1
 beq asm_sight_ready
 tst.b asm_sight
 bne asm_sight_ready
 pea 0x20000
 jsr _sight_xor
 addq.l #4,sp
 move.b #1,asm_sight
asm_sight_ready:
 clr.b asm_laser
 clr.b asm_laser+1
 clr.b asm_laser+2
 clr.l asm_hits
 clr.l asm_kills
 clr.l asm_station
 pea 0x20000
 jsr _scanner_reset
 addq.l #4,sp
 lea asm_ships,a5
 moveq #11,d7
asm_erase_all:
 clr.w 14(a5)
 clr.l (a5)
 move.l a5,-(sp)
 pea 0x20000
 jsr _render_ship
 addq.l #8,sp
 lea 272(a5),a5
 dbra d7,asm_erase_all
 lea asm_ships,a5
 lea asm_fleet_positions,a4
 lea _models,a3
 moveq #0,d7
asm_setup_loop:
 move.w d7,d0
 cmp.w #10,d0
 blt asm_setup_model
 sub.w #10,d0
asm_setup_model:
 lsl.w #2,d0
 move.l 0(a3,d0.w),(a5)
 move.w (a4)+,4(a5)
 move.w (a4)+,6(a5)
 move.w #2400,8(a5)
 move.w d7,d0
 mulu.w #21,d0
 add.w #128,d0
 and.w #255,d0
 move.w d0,10(a5)
 lea 272(a5),a5
 addq.w #1,d7
 cmp.w asm_count,d7
 blt asm_setup_loop
 cmp.w #1,asm_count
 bne asm_setup_done
 move.w asm_model,d0
 lsl.w #2,d0
 move.l 0(a3,d0.w),asm_ships
 clr.w asm_ships+4
 clr.w asm_ships+6
 move.w #640,asm_ships+8
asm_setup_done:
 cmp.w #2,asm_mode
 blo asm_encounter_ready
 move.w #-160,asm_ships+4
 clr.w asm_ships+6
 move.w #1400,asm_ships+8
 move.w #160,asm_ships+272+4
 clr.w asm_ships+272+6
 move.w #1400,asm_ships+272+8
 clr.w asm_ships+544+4
 move.w #-160,asm_ships+544+6
 move.w #1400,asm_ships+544+8
asm_encounter_ready:
 cmp.w #3,asm_mode
 bne asm_salvage_models_done
 tst.w asm_salvage
 beq asm_salvage_models_done
 lea _models,a0
 move.l 12(a0),asm_ships
 move.l 16(a0),asm_ships+272
asm_salvage_models_done:
 cmp.w #3,asm_mode
 bne asm_port_models_done
 cmp.w #2,asm_salvage
 bne asm_port_models_done
 lea _models,a0
 move.l 20(a0),asm_ships
 move.l 12(a0),asm_ships+272
 clr.w asm_ships+4
 clr.w asm_ships+6
 move.w #1200,asm_ships+8
 move.w #-500,asm_ships+272+4
 move.w #2600,asm_ships+272+8
 move.w #500,asm_ships+544+4
 move.w #2600,asm_ships+544+8
asm_port_models_done:
 bsr asm_reset_vectors
 cmp.w #3,asm_mode
 bne asm_port_pose_done
 cmp.w #2,asm_salvage
 bne asm_port_pose_done
 lea asm_vectors+32,a0
 move.l a0,asm_station
 ; Test approach pose: original Coriolis, slot horizontal, nose toward player.
 clr.b asm_vectors+27
 clr.b asm_vectors+29
 clr.b asm_vectors+30
 clr.b asm_vectors+32
 clr.b asm_vectors+18
 clr.b asm_vectors+22
 move.b #96,asm_vectors+16
 move.b #224,asm_vectors+24
asm_port_pose_done:
 cmp.w #3,asm_mode
 bne asm_not_deep_setup
 cmp.w #3,asm_salvage
 bne asm_not_deep_setup
 lea asm_vectors,a0
 moveq #11,d0
asm_deep_clear:
 move.b #160,31(a0)
 clr.b 32(a0)
 lea 36(a0),a0
 dbra d0,asm_deep_clear
 clr.l asm_station
asm_not_deep_setup:
 moveq #0,d0
 bsr asm_dust_run
 move.w #1,asm_dust_valid
 move.b #255,asm_status
 move.b #255,asm_status+1
 move.b #255,asm_status+2
 clr.b asm_status+3
 clr.b asm_status+4
 clr.b asm_mcnt
 bsr asm_draw_dials
 rts
 ; Fixed-slot lifetime rule: no missile/lock may retarget a recycled record.
asm_abort_target:
 tst.w uni_active
 beq uni_abort_legacy
 rts
uni_abort_legacy:
 movem.l d0-d3/a0-a2,-(sp)
 move.w asm_slot,d0
 cmp.b asm_player+2,d0
 bne asm_abort_followers
 move.b #255,asm_player+2
 clr.b asm_player+1
 moveq #5,d0
 bsr asm_message
asm_abort_followers:
 move.w asm_slot,d0
 add.b d0,d0
 or.b #128,d0
 lea asm_vectors,a0
 lea asm_ships,a1
 moveq #11,d3
asm_abort_loop:
 move.l (a1),a2
 move.l a2,d2
 beq asm_abort_next
 cmp.w #8,28(a2)
 bne asm_abort_next
 cmp.b 32(a0),d0
 bne asm_abort_next
 move.b 31(a0),d1
 and.b #160,d1
 bne asm_abort_next
 or.b #128,31(a0)
asm_abort_next:
 lea 272(a1),a1
 lea 36(a0),a0
 dbra d3,asm_abort_loop
 movem.l (sp)+,d0-d3/a0-a2
 rts
asm_drop_cargo:
 cmp.w #3,asm_mode
 bne asm_drop_done
 movem.l d2-d7/a2-a3,-(sp)
 move.l (a5),a0
 pea asm_laser+5
 moveq #0,d0
 move.w 36(a0),d0
 move.l d0,-(sp)
 move.w 28(a0),d0
 move.l d0,-(sp)
 jsr _debris_count
 lea 12(sp),sp
 move.w d0,d5
 beq asm_drop_restore
 move.w #8,asm_spawn_kind
asm_drop_loop:
 bsr asm_spawn_missile
 subq.w #1,d5
 bne asm_drop_loop
 move.w #6,asm_spawn_kind
asm_drop_restore:
 movem.l (sp)+,d2-d7/a2-a3
asm_drop_done:
 rts
asm_equipment_ouch:
 movem.l d2-d7/a2-a6,-(sp)
 ; OOPS calls EXNO3 before OUCH; retain NO3 priority result as DORND C.
 moveq #24,d0
 bsr asm_sound_event
 moveq #0,d0
 move.w asm_sound_carry,d0
 move.l d0,-(sp)
 moveq #0,d0
 move.b asm_commander+7,d0
 move.l d0,-(sp)
 pea asm_laser+5
 pea asm_cargo
 jsr _equipment_damage
 lea 16(sp),sp
 tst.l d0
 beq asm_equipment_ouch_done
 addq.l #1,asm_losses
 subq.w #1,d0
 lea asm_commodity_names,a0
 cmp.w #17,d0
 blo asm_loss_name
 sub.w #17,d0
 lea asm_equipment_names,a0
asm_loss_name:
 lsl.w #4,d0
 adda.w d0,a0
 lea asm_loss_text,a1
 moveq #15,d0
asm_loss_copy:
 move.b (a0)+,(a1)+
 dbra d0,asm_loss_copy
 move.b #22,asm_commander+7
 move.b #3,asm_commander+8
asm_equipment_ouch_done:
 movem.l (sp)+,d2-d7/a2-a6
 rts
asm_contact:
 move.l (a5),a0
 cmp.w #7,28(a0)
 bne asm_contact_nonstation
 cmp.w #3,asm_mode
 bne asm_contact_done
 moveq #0,d0
 move.b asm_controls+12,d0
 move.l d0,-(sp)
 move.l a4,-(sp)
 jsr _dock_check
 addq.l #8,sp
 tst.l d0
 beq asm_contact_done
 cmp.w #1,d0
 bne asm_dock_not_success
 move.w #1,asm_docked
 bra asm_contact_done
asm_dock_not_success:
 cmp.w #3,d0
 bne asm_dock_dent
 move.w #1,asm_dead
 bra asm_contact_done
asm_dock_dent:
 move.b #1,asm_controls+12
 move.b #1,asm_params+2
 clr.l -(sp)
 moveq #0,d0
 move.b 8(a4),d0
 move.l d0,-(sp)
 move.l #5,-(sp)
 pea asm_status
 jsr _player_damage
 lea 16(sp),sp
 cmp.w #2,d0
 bne asm_dock_dent_alive
 move.w #1,asm_dead
 bra asm_contact_done
asm_dock_dent_alive:
 bsr asm_sound_contact
 cmp.w #1,d0
 bne asm_contact_done
 bsr asm_equipment_ouch
 bra asm_contact_done
asm_contact_nonstation:
 cmp.w #3,asm_mode
 bne asm_contact_done
 moveq #0,d0
 move.b _ship_fit,d0
 move.l d0,-(sp)
 pea asm_laser+5
 pea asm_cargo
 moveq #0,d0
 move.b asm_equipment+1,d0
 move.l d0,-(sp)
 move.l (a5),a0
 moveq #0,d0
 move.w 28(a0),d0
 move.l d0,-(sp)
 move.l a4,-(sp)
 jsr _scoop_step
 lea 24(sp),sp
 tst.l d0
 beq asm_contact_done
 cmp.w #3,d0
 beq asm_collision
 cmp.w #1,d0
 bne asm_contact_full
 addq.l #1,asm_scooped
 bra asm_contact_remove
asm_contact_full:
 addq.l #1,asm_full
 moveq #24,d0
 bsr asm_sound_event
asm_contact_remove:
 or.b #160,31(a4)
 bsr asm_abort_target
 bra asm_contact_done
asm_collision:
 moveq #0,d0
 move.b 35(a4),d0
 move.w d0,d1
 and.w #1,d1
 move.l d1,-(sp)
 moveq #0,d1
 move.b 8(a4),d1
 move.l d1,-(sp)
 lsr.w #1,d0
 or.w #128,d0
 move.l d0,-(sp)
 pea asm_status
 jsr _player_damage
 lea 16(sp),sp
 cmp.w #1,d0
 bne asm_collision_no_ouch
 bsr asm_equipment_ouch
 moveq #1,d0
asm_collision_no_ouch:
 cmp.w #2,d0
 bne asm_collision_alive
 move.w #1,asm_dead
asm_collision_alive:
 pea asm_laser+5
 move.l (a5),-(sp)
 move.l asm_cloud,-(sp)
 move.l a4,-(sp)
 bsr asm_sound_contact
 jsr _explosion_start
 lea 16(sp),sp
 bsr asm_abort_target
asm_contact_done:
 rts
asm_player_input:
 cmp.w #3,asm_mode
 bne asm_player_input_done
 tst.b asm_mkeys+1
 beq asm_player_arm
 moveq #40,d0
 bsr asm_sound_event
 clr.b asm_player+1
 move.b #255,asm_player+2
asm_player_arm:
 tst.b asm_mkeys
 beq asm_player_fire
 tst.b asm_player
 beq asm_player_fire
 tst.b asm_player+2
 bpl asm_player_fire
 move.b #255,asm_player+1
asm_player_fire:
 tst.b asm_mkeys+2
 beq asm_player_input_done
 tst.b asm_player+2
 bmi asm_player_input_done
 moveq #0,d0
 move.b asm_player+2,d0
 mulu.w #36,d0
 lea asm_vectors,a0
 adda.l d0,a0
 tst.w uni_active
 bne uni_player_fire_allowed
 move.b 31(a0),d0
 and.b #160,d0
 bne asm_player_unlock
uni_player_fire_allowed:
 move.b #1,asm_player+3
 bsr asm_spawn_missile
 clr.b asm_player+3
 move.l a0,d0
 bne player_missile_launched
 moveq #7,d0
 bsr asm_message
 bra asm_player_input_done
player_missile_launched:
 subq.b #1,asm_player
 moveq #0,d0
 move.b asm_player+2,d0
 move.w d0,d1
 mulu.w #272,d1
 lea asm_ships,a0
 adda.l d1,a0
 move.l (a0),a0
 moveq #0,d1
 move.w 28(a0),d1
 mulu.w #36,d0
 lea asm_vectors,a0
 adda.l d0,a0
 move.l asm_station,-(sp)
 move.l d1,-(sp)
 move.l a0,-(sp)
 jsr _ship_angry
 lea 12(sp),sp
asm_player_unlock:
 clr.b asm_player+1
 move.b #255,asm_player+2
asm_player_input_done:
 rts
asm_spawn_missile:
 cmp.w #3,asm_mode
 bne asm_spawn_return
 movem.l d2-d7/a2-a6,-(sp)
 tst.w uni_active
 bne uni_spawn_allocate
 lea asm_vectors+108,a2
 lea asm_ships+816,a3
 lea asm_clouds+1344,a6
 moveq #8,d6
asm_spawn_find:
 move.b 31(a2),d0
 and.b #160,d0
 cmp.b #160,d0
 bne asm_spawn_next
 tst.w 56(a6)
 bne asm_spawn_next
uni_spawn_ready:
 ; The production allocator appends at the original first empty FRIN slot.
 lea _models,a0
 move.w asm_spawn_kind,d0
 lsl.w #2,d0
 move.l 0(a0,d0.w),(a3)
 tst.b asm_player+3
 beq asm_spawn_enemy
 moveq #0,d0
 move.b asm_controls+12,d0
 move.l d0,-(sp)
 moveq #0,d0
 move.b asm_player+2,d0
 tst.w uni_active
 beq uni_player_target
 addq.w #1,d0
uni_player_target:
 move.l d0,-(sp)
 move.l a2,-(sp)
 jsr _player_missile_init
 lea 12(sp),sp
 bra asm_spawn_initialized
asm_spawn_enemy:
 move.l (a3),-(sp)
 move.l a2,-(sp)
 move.l a4,-(sp)
 jsr _spawn_child
 lea 12(sp),sp
asm_spawn_initialized:
 cmp.w #8,asm_spawn_kind
 bne asm_spawn_no_tumble
 pea asm_laser+5
 move.l a2,-(sp)
 jsr _cargo_tumble
 addq.l #8,sp
 addq.l #1,asm_debris
asm_spawn_no_tumble:
 cmp.w #8,asm_spawn_kind
 beq asm_count_spawned
 clr.w 14(a3)
 clr.b 2(a6)
 cmp.w #9,asm_spawn_kind
 bne asm_count_missile
 addq.l #1,asm_pods
 bra asm_count_spawned
asm_count_missile:
 addq.l #1,asm_launches
 tst.b asm_player+3
 bne sound_own_missile
 moveq #6,d0
 bsr asm_message
sound_own_missile:
 moveq #48,d0
 bsr asm_sound_event
asm_count_spawned:
 move.l a2,a0
 bra asm_spawn_end
asm_spawn_next:
 lea 36(a2),a2
 lea 272(a3),a3
 lea 448(a6),a6
 dbra d6,asm_spawn_find
uni_spawn_full:
 cmp.w #8,asm_spawn_kind
 bne asm_spawn_failed
 ; SFS1 consumes its tumble RNG before NWSHP discovers a full pool.
 move.l #1,-(sp)
 pea asm_laser+5
 jsr _elite_random
 addq.l #8,sp
asm_spawn_failed:
 suba.l a0,a0
asm_spawn_end:
 movem.l (sp)+,d2-d7/a2-a6
asm_spawn_return:
 rts
asm_draw_dials:
 moveq #0,d0
 move.b asm_ecm,d0
 move.l d0,-(sp)
 move.l asm_station,-(sp)
 pea 0x20000
 jsr _dashboard_bulbs
 lea 12(sp),sp
 moveq #0,d0
 move.b asm_mcnt,d0
 move.l d0,-(sp)
 pea asm_status
 pea asm_controls
 pea 0x20000
 jsr _dials_frame
 lea 16(sp),sp
 moveq #0,d0
 move.b asm_travel+9,d0
 move.l d0,-(sp)
 pea 0x20000
 jsr _dials_fuel
 addq.l #8,sp
 moveq #0,d0
 move.w asm_altitude,d0
 move.l d0,-(sp)
 pea 0x20000
 jsr _dials_altitude
 addq.l #8,sp
 pea asm_player
 pea 0x20000
 jsr _missile_icons
 addq.l #8,sp
 clr.l -(sp)
 pea asm_compass
 pea asm_planet
 cmp.w #3,asm_mode
 bne asm_compass_target_done
 tst.l asm_station
 beq asm_compass_target_done
 move.l asm_station,d0
 sub.l #32,d0
 move.l d0,(sp)
 move.l #1,8(sp)
asm_compass_target_done:
 pea 0x20000
 jsr _compass_frame
 lea 16(sp),sp
 rts
asm_reset_vectors:
 clr.b asm_params
 clr.b asm_params+1
 move.b #1,asm_params+2
 move.w asm_controls+2,-(sp)
 lea asm_controls,a0
 moveq #12,d0
asm_clear_controls:
 clr.b 0(a0,d0.w)
 dbra d0,asm_clear_controls
 move.b #128,(a0)
 move.b #128,1(a0)
 move.b #1,12(a0)
 move.w (sp)+,asm_controls+2
 lea asm_vectors,a0
 lea asm_ships,a1
 moveq #11,d0
asm_reset_vector:
 moveq #35,d1
asm_zero_vector:
 clr.b 0(a0,d1.w)
 dbra d1,asm_zero_vector
 move.b #0xe0,14(a0)
 move.b #0x60,18(a0)
 move.b #0x60,22(a0)
 ; Copy scene coordinates into authoritative original INWK format.
 moveq #0,d4
 moveq #4,d5
 moveq #2,d6
asm_seed_coordinate:
 move.w 0(a1,d5.w),d2
 moveq #0,d3
 tst.w d2
 bpl asm_seed_positive
 neg.w d2
 move.w #128,d3
asm_seed_positive:
 move.b d2,0(a0,d4.w)
 lsr.w #8,d2
 move.b d2,1(a0,d4.w)
 move.b d3,2(a0,d4.w)
 addq.w #3,d4
 addq.w #2,d5
 dbra d6,asm_seed_coordinate
 move.b #2,27(a0)
 move.l (a1),d2
 beq asm_seed_station_done
 move.l d2,a3
 move.w 24(a3),d2
 move.b d2,35(a0)
 cmp.w #7,28(a3)
 bne asm_seed_energy_done
 lea 32(a0),a2
 move.l a2,asm_station
asm_seed_energy_done:
 tst.w 22(a3)
 bne asm_seed_station_done
 clr.b 27(a0)
asm_seed_station_done:
 cmp.w #2,asm_mode
 blo asm_seed_passive
 ; Deterministic aggressive encounter initialization, not a universe spawner.
 move.b #240,32(a0)
 cmp.w #3,asm_mode
 bne asm_seed_passive
 cmp.w #9,d0
 blo asm_seed_unused
 move.w 30(a3),d2
 and.b #7,d2
 move.b d2,31(a0)
 bra asm_seed_passive
asm_seed_unused:
 move.b #160,31(a0)
 clr.b 32(a0)
asm_seed_passive:
 move.b #32,29(a0)
 move.b #16,30(a0)
 lea 36(a0),a0
 lea 272(a1),a1
 dbra d0,asm_reset_vector
 rts
 ; Update a small status strip once per second; never clear the flight view.
asm_fps:
 move.l asm_ticks,d1
 sub.l asm_stat_ticks,d1
 cmp.l #50,d1
 blt fps_return
 move.l asm_ticks,asm_stat_ticks
 move.l asm_frames,d0
 sub.l asm_stat_frames,d0
 move.l asm_frames,asm_stat_frames
 mulu.w #500,d0
 divu.w d1,d0
 and.l #65535,d0
 cmp.w #999,d0
 ble fps_bounded
 move.w #999,d0
fps_bounded:
 divu.w #10,d0
 move.l d0,d2
 swap d2
 add.b #48,d2
 move.b d2,asm_fps_text+7
 and.l #65535,d0
 divu.w #10,d0
 move.l d0,d2
 swap d2
 add.b #48,d2
 move.b d2,asm_fps_text+5
 add.b #48,d0
 move.b d0,asm_fps_text+4
 moveq #0,d0
 move.b asm_params+2,d0
 divu.w #10,d0
 move.l d0,d2
 swap d2
 add.b #48,d2
 move.b d2,asm_fps_text+17
 add.b #48,d0
 move.b d0,asm_fps_text+16
 move.l #0x27c00,a0
 move.w #255,d0
fps_clear:
 clr.l (a0)+
 dbra d0,fps_clear
 move.b asm_player,d0
 add.b #48,d0
 move.b d0,asm_msl_text+2
 move.b #45,asm_msl_text+4
 tst.b asm_player+1
 beq asm_hud_lock
 move.b #65,asm_msl_text+4
asm_hud_lock:
 move.b asm_player+2,d0
 bmi asm_hud_ready
 add.b #48,d0
 move.b d0,asm_msl_text+4
asm_hud_ready:
 lea asm_cargo,a0
 moveq #12,d1
 moveq #0,d0
asm_hud_cargo_sum:
 moveq #0,d2
 move.b (a0)+,d2
 add.w d2,d0
 dbra d1,asm_hud_cargo_sum
 divu.w #10,d0
 move.w d0,d2
 add.b #48,d2
 move.b d2,asm_cargo_text+2
 swap d0
 add.b #48,d0
 move.b d0,asm_cargo_text+3
 lea asm_fps_text,a4
 tst.w _release_mode
 beq hud_release_ready
 lea asm_fps_text+9,a4
hud_release_ready:
 tst.b asm_commander+7
 beq asm_hud_message_done
 moveq #0,d0
 move.b asm_commander+8,d0
 cmp.w #4,d0
 blo hud_legacy_message
 subq.w #4,d0
 lsl.w #2,d0
 lea asm_flight_messages,a0
 move.l 0(a0,d0.w),a4
 bra asm_hud_message_done
hud_legacy_message:
 move.l asm_commander,d0
 lea asm_bounty_message,a0
 moveq #10,d1
 bsr asm_decimal
 move.b asm_bounty_message+9,asm_bounty_message+10
 move.b #46,asm_bounty_message+9
 lea asm_bounty_message,a0
 moveq #7,d0
hud_cash_spaces:
 cmp.b #48,(a0)
 bne hud_cash_ready
 move.b #32,(a0)+
 dbra d0,hud_cash_spaces
hud_cash_ready:
 lea asm_bounty_message,a4
 cmp.b #3,asm_commander+8
 bne asm_hud_not_loss
 lea asm_loss_text,a4
 bra asm_hud_message_done
asm_hud_not_loss:
 cmp.b #2,asm_commander+8
 bne asm_hud_message_done
 lea asm_rank_message,a4
asm_hud_message_done:
 tst.w asm_warp_timer
 beq asm_hud_warp_done
 lea asm_warp_locked_text,a4
 cmp.w #1,asm_warp_result
 bne asm_hud_warp_done
 lea asm_warp_success_text,a4
asm_hud_warp_done:
 tst.b asm_travel+11
 beq asm_hud_no_hyper
 moveq #0,d0
 move.b asm_travel+11,d0
 lea asm_hyper_digits,a0
 moveq #2,d1
 bsr asm_decimal
 lea asm_hyper_line,a4
asm_hud_no_hyper:
 tst.w asm_dead
 beq asm_status_text
 lea asm_dead_text,a4
asm_status_text:
 move.w #248,d6
 bsr asm_text
fps_return:
 rts
; Native presentation adapter; source arithmetic/state lives in commander.s.
asm_dock_keys:
 moveq #0,d4
 moveq #1,d0
 bsr asm_keyrow
 btst #2,d0
 beq dock_key_down
 bset #0,d4
dock_key_down:
 btst #7,d0
 beq dock_key_buy
 bset #1,d4
dock_key_buy:
 moveq #2,d0
 bsr asm_keyrow
 btst #4,d0
 beq dock_key_sell
 bset #2,d4
dock_key_sell:
 moveq #3,d0
 bsr asm_keyrow
 btst #3,d0
 beq dock_key_launch
 bset #3,d4
dock_key_launch:
 moveq #4,d0
 bsr asm_keyrow
 btst #0,d0
 beq dock_key_shop
 bset #4,d4
dock_key_shop:
 moveq #6,d0
 bsr asm_keyrow
 btst #0,d0
 beq dock_key_load
 bset #5,d4
dock_key_load:
 moveq #5,d0
 bsr asm_keyrow
 btst #7,d0
 beq dock_key_edges
 bset #6,d4
dock_key_edges:
 moveq #0,d0
 bsr asm_keyrow
 btst #1,d0
 beq dock_f2
 bset #7,d4
dock_f2:
 btst #3,d0
 beq dock_f3
 bset #8,d4
dock_f3:
 btst #4,d0
 beq dock_f4
 bset #9,d4
dock_f4:
 btst #0,d0
 beq dock_fkeys_done
 bset #10,d4
dock_fkeys_done:
 move.w asm_market_keys,d0
 eor.w d4,d0
 and.w d4,d0
 move.w d4,asm_market_keys
 move.w d0,d4
 beq dock_keys_done
 btst #5,d4
 beq dock_not_shop_toggle
 eor.w #1,asm_shop
 clr.w asm_market_selection
 clr.w asm_market_result
 bra dock_page_refresh
dock_not_shop_toggle:
 btst #4,d4
 bne asm_launch
 btst #0,d4
 beq dock_select_down
 subq.w #1,asm_market_selection
 bpl dock_select_down
 move.w #16,asm_market_selection
 tst.w asm_shop
 beq dock_select_down
 move.w #11,asm_market_selection
dock_select_down:
 btst #1,d4
 beq dock_transaction
 addq.w #1,asm_market_selection
 moveq #17,d0
 tst.w asm_shop
 beq dock_select_limit
 moveq #12,d0
dock_select_limit:
 cmp.w asm_market_selection,d0
 bhi dock_transaction
 clr.w asm_market_selection
dock_transaction:
 tst.w asm_shop
 bne asm_shop_transaction
 move.w d4,d0
 and.w #12,d0
 beq dock_page_refresh
 moveq #0,d0
 btst #3,d4
 beq dock_trade_args
 moveq #1,d0
dock_trade_args:
 move.l d0,-(sp)
 moveq #0,d0
 move.w asm_market_selection,d0
 move.l d0,-(sp)
 pea asm_market
 pea asm_cargo
 pea asm_commander
 jsr _market_trade
 lea 20(sp),sp
 move.w d0,asm_market_result
dock_page_refresh:
 bsr asm_clear_view
 tst.w asm_shop
 beq dock_show_market
 bsr asm_shop_page
 bra dock_keys_done
dock_show_market:
 bsr asm_market_page
dock_keys_done:
 rts
asm_launch:
 tst.w asm_arriving
 bne tunnel_launch_done
 moveq #8,d0
 bsr asm_tunnel
tunnel_launch_done:
 ; Keep commander, equipment, cargo and remaining missiles across the local
 ; sortie reset. Market AVL persists; no free ammo/bomb/equipment replenishment.
 lea asm_commander,a0
 lea asm_keep,a1
 moveq #9,d0
launch_keep_cmd:
 move.b (a0)+,(a1)+
 dbra d0,launch_keep_cmd
 lea asm_cargo,a0
 moveq #21,d0
launch_keep_cargo:
 move.b (a0)+,(a1)+
 dbra d0,launch_keep_cargo
 move.b asm_player,(a1)
 bsr asm_clear_view
 clr.w asm_dust_valid
 clr.w asm_planet_cache+12
 lea asm_ships,a0
 lea asm_clouds,a1
 moveq #11,d0
launch_clear_caches:
 clr.w 12(a0)
 clr.w 56(a1)
 lea 272(a0),a0
 lea 448(a1),a1
 dbra d0,launch_clear_caches
 clr.b asm_sight
 clr.b asm_laser+9
 clr.w asm_page
 clr.w asm_paused
 move.w #1,asm_keep_launch
 bsr asm_setup
 clr.w asm_keep_launch
 lea asm_keep,a0
 lea asm_commander,a1
 moveq #9,d0
launch_restore_cmd:
 move.b (a0)+,(a1)+
 dbra d0,launch_restore_cmd
 lea asm_cargo,a1
 moveq #21,d0
launch_restore_cargo:
 move.b (a0)+,(a1)+
 dbra d0,launch_restore_cargo
 move.b (a0),asm_player
 clr.b asm_commander+7
 clr.b asm_commander+8
 tst.w asm_arriving
 bne launch_arrival_pose
 pea asm_cargo
 pea asm_commander
 jsr _launch_legal
 addq.l #8,sp
 ; TT110/SOS1/NWSPS native launch pose.
 cmp.w #3,asm_salvage
 beq launch_arrival_pose
 pea asm_vectors
 pea asm_planet
 jsr _station_launch
 addq.l #8,sp
 move.l asm_ships,a0
 move.w 24(a0),d0
 move.b d0,asm_vectors+35
 move.b #12,asm_controls+12
 move.b #12,asm_params+2
launch_arrival_pose:
 move.w #1,asm_world
 bsr asm_ambient_begin
 tst.w asm_arriving
 bne launch_empty_world
 cmp.w #3,asm_salvage
 bne launch_world_ready
launch_empty_world:
 move.b #160,asm_vectors+31
 clr.b asm_vectors+32
 clr.l asm_station
launch_world_ready:
 bsr asm_draw_dials
 rts
asm_market_page:
 move.b asm_travel+22,d0
 add.b #48,d0
 move.b d0,asm_market_economy
 lea asm_market_title,a4
 moveq #0,d6
 bsr asm_text
 move.l asm_commander,d0
 lea asm_cash_digits,a0
 moveq #10,d1
 bsr asm_decimal
 move.b asm_cash_digits+9,asm_cash_digits+10
 move.b #46,asm_cash_digits+9
 lea asm_cash_line,a4
 moveq #10,d6
 bsr asm_text
 lea asm_market_header,a4
 moveq #22,d6
 bsr asm_text
 clr.w asm_page_item
 lea asm_commodity_names,a5
market_page_loop:
 lea asm_market_line+1,a0
 moveq #11,d0
market_copy_name:
 move.b (a5)+,(a0)+
 dbra d0,market_copy_name
 addq.l #4,a5
 move.w asm_page_item,d2
 lea asm_market,a0
 moveq #0,d0
 move.b 0(a0,d2.w),d0
 lsl.w #2,d0
 lea asm_price_digits,a0
 moveq #4,d1
 bsr asm_decimal
 move.b asm_price_digits+3,asm_price_digits+4
 move.b #46,asm_price_digits+3
 lea asm_market,a0
 moveq #0,d0
 move.b 17(a0,d2.w),d0
 lea asm_stock_digits,a0
 moveq #3,d1
 bsr asm_decimal
 lea asm_cargo,a0
 moveq #0,d0
 move.b 0(a0,d2.w),d0
 lea asm_held_digits,a0
 moveq #3,d1
 bsr asm_decimal
 move.b #32,asm_market_line
 cmp.w asm_market_selection,d2
 bne market_no_arrow
 move.b #62,asm_market_line
market_no_arrow:
 move.b #84,asm_market_unit
 move.b #32,asm_market_unit+1
 cmp.w #13,d2
 blo market_unit_done
 cmp.w #16,d2
 beq market_unit_done
 move.b #75,asm_market_unit
 move.b #71,asm_market_unit+1
 cmp.w #15,d2
 bne market_unit_done
 move.b #71,asm_market_unit
 move.b #32,asm_market_unit+1
market_unit_done:
 move.w d2,d6
 lsl.w #3,d6
 add.w #32,d6
 lea asm_market_line,a4
 bsr asm_text
 addq.w #1,asm_page_item
 cmp.w #17,asm_page_item
 blo market_page_loop
 lea asm_market_help,a4
 move.w #172,d6
 moveq #16,d7
 bsr asm_text_at
 move.w asm_market_result,d0
 lsl.w #2,d0
 lea asm_market_messages,a0
 move.l 0(a0,d0.w),a4
 move.w #184,d6
 bsr asm_text
 rts
asm_clear_view:
 move.l #0x20000,a0
 move.w #6143,d0
asm_clear_view_loop:
 clr.l (a0)+
 dbra d0,asm_clear_view_loop
 rts
asm_restore_view:
 tst.w asm_dust_valid
 beq dust_restore_done
 moveq #3,d0
 bsr asm_dust_run
dust_restore_done:
 pea asm_planet_cache
 pea 0x20000
 jsr _render_cache
 addq.l #8,sp
 lea asm_ships,a5
 lea asm_clouds,a6
 moveq #11,d7
asm_restore_loop:
 movem.l d7/a5-a6,-(sp)
 move.l a5,-(sp)
 pea 0x20000
 jsr _render_cache
 addq.l #8,sp
 moveq #0,d0
 move.w 56(a6),d0
 move.l d0,-(sp)
 pea 58(a6)
 pea 0x20000
 jsr _cloud_xor
 lea 12(sp),sp
 movem.l (sp)+,d7/a5-a6
 lea 272(a5),a5
 lea 448(a6),a6
 dbra d7,asm_restore_loop
 tst.b asm_sight
 beq asm_restore_laser
 pea 0x20000
 jsr _sight_xor
 addq.l #4,sp
asm_restore_laser:
 tst.b asm_laser+9
 beq asm_restore_done
 pea asm_laser
 pea 0x20000
 jsr _laser_xor
 addq.l #8,sp
asm_restore_done:
 rts
; Format unsigned 32-bit D0 as D1 fixed decimal digits at A0. No 68020 divide.
asm_decimal:
 movem.l d2-d5,-(sp)
 adda.w d1,a0
 subq.w #1,d1
asm_decimal_loop:
 move.l d0,d2
 swap d2
 and.l #65535,d2
 divu.w #10,d2
 move.w d2,d3
 clr.w d2
 move.w d0,d2
 divu.w #10,d2
 move.w d2,d0
 swap d0
 move.w d3,d0
 swap d0
 swap d2
 add.b #48,d2
 move.b d2,-(a0)
 dbra d1,asm_decimal_loop
 movem.l (sp)+,d2-d5
 rts
asm_commander_page:
 tst.w _release_mode
 beq flow_cargo_page
 cmp.w #2,asm_page
 bne flow_status
flow_cargo_page:
 lea asm_page_title,a4
 tst.w _release_mode
 beq flow_cargo_title
 lea flow_status_title,a4
flow_cargo_title:
 moveq #4,d6
 bsr asm_text
 tst.w _release_mode
 beq flow_cargo_cash
 lea flow_name,a4
 moveq #4,d6
 moveq #98,d7
 bsr asm_text_at
flow_cargo_cash:
 move.l asm_commander,d0
 lea asm_cash_digits,a0
 moveq #10,d1
 bsr asm_decimal
 ; Ten decimal tenths digits -> nine integral digits, dot, final digit.
 move.b asm_cash_digits+9,asm_cash_digits+10
 move.b #46,asm_cash_digits+9
 lea asm_cash_digits,a0
 moveq #7,d0
asm_cash_trim:
 cmp.b #48,(a0)
 bne asm_cash_trim_done
 move.b #32,(a0)+
 dbra d0,asm_cash_trim
asm_cash_trim_done:
 lea asm_cash_line,a4
 moveq #20,d6
 bsr asm_text
 pea asm_commander
 jsr _commander_rank
 addq.l #4,sp
 subq.w #1,d0
 lsl.w #2,d0
 lea asm_rank_names,a0
 move.l 0(a0,d0.w),a4
 moveq #36,d6
 bsr asm_text
 lea asm_clean,a4
 tst.b asm_commander+6
 beq asm_page_legal
 lea asm_offender,a4
 cmp.b #50,asm_commander+6
 blo asm_page_legal
 lea asm_fugitive,a4
asm_page_legal:
 moveq #48,d6
 bsr asm_text
 moveq #0,d0
 move.b asm_commander+5,d0
 lsl.w #8,d0
 move.b asm_commander+4,d0
 lea asm_tally_digits,a0
 moveq #5,d1
 bsr asm_decimal
 lea asm_tally_line,a4
 moveq #60,d6
 bsr asm_text
 lea asm_commodity_names,a5
 lea asm_cargo,a6
 clr.w asm_page_item
asm_page_cargo_loop:
 lea asm_cargo_line,a0
 moveq #11,d0
asm_page_copy_name:
 move.b (a5)+,(a0)+
 dbra d0,asm_page_copy_name
 addq.l #4,a5
 move.b #32,(a0)+
 moveq #0,d0
 move.b (a6)+,d0
 moveq #3,d1
 bsr asm_decimal
 move.b #84,asm_cargo_unit
 move.b #32,asm_cargo_unit+1
 cmp.w #16,asm_page_item
 beq asm_page_cargo_unit
 cmp.w #13,asm_page_item
 blo asm_page_cargo_unit
 move.b #75,asm_cargo_unit
 move.b #71,asm_cargo_unit+1
 cmp.w #15,asm_page_item
 bne asm_page_cargo_unit
 move.b #71,asm_cargo_unit
 move.b #32,asm_cargo_unit+1
asm_page_cargo_unit:
 moveq #0,d6
 move.w asm_page_item,d6
 divu.w #9,d6
 move.w d6,d7
 mulu.w #128,d7
 addq.w #8,d7
 swap d6
 mulu.w #12,d6
 add.w #72,d6
 lea asm_cargo_line,a4
 bsr asm_text_at
 addq.w #1,asm_page_item
 cmp.w #17,asm_page_item
 blo asm_page_cargo_loop
 lea asm_equipment,a0
 lea asm_equipment_line,a1
 lea asm_equipment_fields,a2
 moveq #3,d1
asm_page_equipment_loop:
 moveq #0,d0
 move.b (a2)+,d0
 move.b #78,0(a1,d0.w)
 tst.b (a0)+
 beq asm_page_equipment_next
 move.b #89,0(a1,d0.w)
asm_page_equipment_next:
 dbra d1,asm_page_equipment_loop
 lea asm_equipment_line,a4
 move.w #184,d6
 bsr asm_text
 rts

; Original dashboard is copied by scanner_reset during scene setup.
asm_labels:
 rts
asm_text:
 move.w #32,d7
asm_text_at:
text_character:
 cmp.w #251,d7
 bhi text_done
 cmp.w #185,d6
 bhi text_done
 moveq #0,d0
 move.b (a4)+,d0
 beq text_done
 sub.w #32,d0
 mulu.w #7,d0
 lea asm_font,a3
 adda.w d0,a3
 moveq #0,d5
text_row:
 moveq #0,d4
 move.b (a3)+,d4
 moveq #0,d3
text_bit:
 btst #4,d4
 beq text_next_bit
 move.w d6,d0
 add.w d5,d0
 mulu.w #128,d0
 move.w d7,d1
 add.w d3,d1
 move.w d1,d2
 lsr.w #2,d1
 add.w d1,d1
 add.w d1,d0
 move.l #0x20000,a0
 adda.l d0,a0
 and.w #3,d2
 add.w d2,d2
 lea text_masks(pc),a1
 move.w 0(a1,d2.w),d1
 or.w d1,(a0)
text_next_bit:
 lsl.w #1,d4
 addq.w #1,d3
 cmp.w #5,d3
 blt text_bit
 addq.w #1,d5
 cmp.w #7,d5
 blt text_row
 addq.w #6,d7
 bra text_character
text_done:
 rts
text_masks: .data2 0x80c0,0x2030,0x080c,0x0203
label1: .ascii "ELITE / 68000 ASM TEST\0"
label2: .ascii "N RESET  1 SOLO   2 FLEET\0"
label3: .ascii "ARROWS FLY A/Z SPEED SPACE PAUSE\0"
label4: .ascii "B UNCAP / CAP   ESC EXIT\0"
.align 2
asm_fleet_positions:
 .data2 -675,350,-225,350,225,350,675,350
 .data2 -675,0,-225,0,225,0,675,0
 .data2 -675,-350,-225,-350,225,-350,675,-350
.sect .bss
.align 2
asm_ships: .space 3264
asm_deadline: .space 4
asm_oldmode: .space 2
asm_olddisplay: .space 2
asm_old1: .space 2
asm_old7: .space 2
asm_row1: .space 2
asm_row7: .space 2
asm_row2: .space 2
asm_old2: .space 2
asm_nextkeys: .space 4
asm_stat_frames: .space 4
asm_stat_ticks: .space 4

.sect .rom
asm_font:
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,4,4,31,4,4,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,31,0,0,0
 .data1 0,0,0,0,0,4,4
 .data1 1,2,2,4,8,8,16
 .data1 14,17,19,21,25,17,14
 .data1 4,12,4,4,4,4,14
 .data1 14,17,1,2,4,8,31
 .data1 30,1,1,14,1,1,30
 .data1 2,6,10,18,31,2,2
 .data1 31,16,16,30,1,1,30
 .data1 14,16,16,30,17,17,14
 .data1 31,1,2,4,8,8,8
 .data1 14,17,17,14,17,17,14
 .data1 14,17,17,15,1,1,14
 .data1 0,4,4,0,4,4,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 16,8,4,2,4,8,16
 .data1 14,17,1,2,4,0,4
 .data1 0,0,0,0,0,0,0
 .data1 14,17,17,31,17,17,17
 .data1 30,17,17,30,17,17,30
 .data1 15,16,16,16,16,16,15
 .data1 30,17,17,17,17,17,30
 .data1 31,16,16,30,16,16,31
 .data1 31,16,16,30,16,16,16
 .data1 15,16,16,23,17,17,15
 .data1 17,17,17,31,17,17,17
 .data1 31,4,4,4,4,4,31
 .data1 7,2,2,2,18,18,12
 .data1 17,18,20,24,20,18,17
 .data1 16,16,16,16,16,16,31
 .data1 17,27,21,21,17,17,17
 .data1 17,25,21,19,17,17,17
 .data1 14,17,17,17,17,17,14
 .data1 30,17,17,30,16,16,16
 .data1 14,17,17,17,21,18,13
 .data1 30,17,17,30,20,18,17
 .data1 15,16,16,14,1,1,30
 .data1 31,4,4,4,4,4,4
 .data1 17,17,17,17,17,17,14
 .data1 17,17,17,17,17,10,4
 .data1 17,17,17,21,21,21,10
 .data1 17,17,10,4,10,17,17
 .data1 17,17,10,4,4,4,4
 .data1 31,1,2,4,8,16,31
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0
 .data1 0,0,0,0,0,0,0

.sect .bss
.align 2
asm_vectors: .space 432
asm_matrix: .space 18

.sect .bss
.align 2
asm_release_keys: .space 2
asm_release_row: .space 2
asm_release_quiet: .space 2

.sect .bss
.align 2
asm_clouds: .space 5376

.sect .data
.align 2
asm_page_item: .data2 0
asm_page_title: .ascii "COMMANDER JAMESON / 6 RETURN\0"
asm_cash_line: .ascii "CASH "
asm_cash_digits: .ascii "000000000.0 CR\0"
asm_tally_line: .ascii "KILLS "
asm_tally_digits: .ascii "00000  /  HOLD 20 T\0"
asm_cargo_line: .ascii "             000 "
asm_cargo_unit: .ascii "T \0"
asm_clean: .ascii "LEGAL: CLEAN\0"
asm_offender: .ascii "LEGAL: OFFENDER\0"
asm_fugitive: .ascii "LEGAL: FUGITIVE\0"
asm_bounty_message: .ascii "000000000.0 CR\0"
asm_rank_message: .ascii "RIGHT ON COMMANDER!\0"
.align 2
asm_rank_names: .data4 asm_rank_0,asm_rank_1,asm_rank_2,asm_rank_3,asm_rank_4,asm_rank_5,asm_rank_6,asm_rank_7,asm_rank_8
asm_rank_0: .ascii "RATING: HARMLESS\0"
asm_rank_1: .ascii "RATING: MOSTLY HARMLESS\0"
asm_rank_2: .ascii "RATING: POOR\0"
asm_rank_3: .ascii "RATING: AVERAGE\0"
asm_rank_4: .ascii "RATING: ABOVE AVERAGE\0"
asm_rank_5: .ascii "RATING: COMPETENT\0"
asm_rank_6: .ascii "RATING: DANGEROUS\0"
asm_rank_7: .ascii "RATING: DEADLY\0"
asm_rank_8: .ascii "RATING: ELITE\0"
asm_commodity_names:
 .ascii "FOOD            "
 .ascii "TEXTILES        "
 .ascii "RADIOACTIVES    "
 .ascii "SLAVES          "
 .ascii "LIQUOR/WINES    "
 .ascii "LUXURIES        "
 .ascii "NARCOTICS       "
 .ascii "COMPUTERS       "
 .ascii "MACHINERY       "
 .ascii "ALLOYS          "
 .ascii "FIREARMS        "
 .ascii "FURS            "
 .ascii "MINERALS        "
 .ascii "GOLD            "
 .ascii "PLATINUM        "
 .ascii "GEM-STONES      "
 .ascii "ALIEN ITEMS     "

.align 2

.sect .data
asm_equipment_line: .ascii "ECM N SCOOPS N BOMB N UNIT N\0"
asm_equipment_fields: .data1 4,13,20,27
asm_equipment_names:
 .ascii "ECM SYSTEM      "
 .ascii "FUEL SCOOPS     "
 .ascii "ENERGY BOMB     "
 .ascii "ENERGY UNIT     "
 .ascii "DOCK COMPUTER   "
asm_loss_text: .ascii "                DESTROYED\0"
.align 2

.sect .data
asm_market_title: .ascii "DOCKED / LOCAL MARKET / ECONOMY "
asm_market_economy: .ascii "5\0"
asm_market_header: .ascii " ITEM         PRICE STOCK HOLD\0"
asm_market_line: .ascii "              "
asm_price_digits: .ascii "000.0 "
asm_stock_digits: .ascii "000 "
asm_held_digits: .ascii "000 "
asm_market_unit: .ascii "T \0"
asm_market_help: .ascii "UP/DN  B BUY1  S SELLALL  L LAUNCH\0"
.align 2
asm_market_messages: .data4 market_ok,market_stock,market_hold,market_cash
market_ok: .ascii "READY\0"
market_stock: .ascii "NO STOCK\0"
market_hold: .ascii "HOLD FULL\0"
market_cash: .ascii "NOT ENOUGH CASH\0"
.align 2

.sect .text
; Navigation UI owns keys only while open. 9 toggles, H/G starts from flight.
asm_navigation_keys:
 moveq #0,d4
 moveq #5,d0
 bsr asm_keyrow
 btst #4,d0
 beq nav_nine
 bset #3,d4
nav_nine:
 btst #7,d0
 beq nav_no_home
 bset #11,d4
nav_no_home:
 btst #0,d0
 beq nav_h
 bset #0,d4
nav_h:
 moveq #4,d0
 bsr asm_keyrow
 btst #6,d0
 beq nav_no_distance
 bset #10,d4
nav_no_distance:
 btst #2,d0
 beq nav_g
 bset #1,d4
nav_g:
 moveq #3,d0
 bsr asm_keyrow
 btst #2,d0
 beq nav_gal_key
 bset #8,d4
nav_gal_key:
 btst #6,d0
 beq nav_r
 bset #2,d4
nav_r:
nav_arrows:
 tst.w asm_nav
 beq nav_edges
 moveq #1,d0
 bsr asm_keyrow
 btst #2,d0
 beq nav_down
 bset #4,d4
nav_down:
 btst #7,d0
 beq nav_left
 bset #5,d4
nav_left:
 btst #1,d0
 beq nav_right
 bset #6,d4
nav_right:
 btst #4,d0
 beq nav_chart_key
 bset #7,d4
nav_chart_key:
 moveq #7,d0
 bsr asm_keyrow
 btst #4,d0
 beq nav_no_local
 bset #12,d4
nav_no_local:
 moveq #2,d0
 bsr asm_keyrow
 btst #3,d0
 beq nav_edges
 bset #9,d4
nav_edges:
 move.w asm_nav_keys,d0
 eor.w d4,d0
 and.w d4,d0
 move.w d4,asm_nav_keys
 move.w d0,d4
 tst.w asm_chart
 beq nav_no_cursor_repeat
 tst.w asm_nav
 beq nav_no_cursor_repeat
 move.w asm_nav_keys,d0
 and.w #240,d0
 or.w d0,d4
nav_no_cursor_repeat:
 btst #8,d4
 beq nav_no_escape
 tst.w asm_page
 bne nav_no_escape
 tst.w asm_docked
 bne nav_no_escape
 tst.w asm_dead
 bne nav_no_escape
 pea asm_travel
 pea asm_cargo
 pea asm_commander
 jsr _escape_commander
 lea 12(sp),sp
 tst.w d0
 beq nav_no_escape
 clr.w asm_nav
 move.w #3,asm_mode
 move.w #2,asm_salvage
 move.w #12,asm_count
 move.w #1,asm_arriving
 bsr asm_launch
 clr.w asm_arriving
 move.w #1,asm_docked
 bsr asm_clear_view
 bsr asm_market_page
 bra nav_consumed
nav_no_escape:
 ; Countdown is live flight, selection remains frozen until arrival.
 tst.b asm_travel+11
 bne nav_not_consumed
 tst.w asm_page
 bne nav_not_consumed
 btst #0,d4
 beq nav_actions
 eor.w #1,asm_nav
 bsr asm_clear_view
 tst.w asm_nav
 bne nav_redraw
 tst.w asm_docked
 beq nav_close_flight
 clr.w asm_shop
 bsr asm_market_page
 bra nav_consumed
nav_close_flight:
 bsr asm_restore_view
 bra nav_consumed
nav_actions:
 tst.w asm_dead
 bne nav_no_start
 btst #1,d4
 bne nav_start_normal
 btst #2,d4
 bne nav_start_galaxy
nav_no_start:
 tst.w asm_nav
 beq nav_not_consumed
 btst #3,d4
 beq nav_select
 tst.w asm_docked
 beq nav_consumed
 pea asm_commander
 pea asm_travel
 jsr _travel_refuel
 addq.l #8,sp
 move.b d0,asm_travel+15
 beq nav_refueled
 move.b #6,asm_travel+15
 bra nav_redraw
nav_refueled:
 clr.b asm_mcnt
 bsr asm_draw_dials
 bra nav_redraw
nav_select:
 btst #12,d4
 beq nav_not_local
 eor.w #1,asm_local_chart
 move.w #1,asm_chart
 bsr asm_chart_from_target
 bra nav_redraw
nav_not_local:
 btst #9,d4
 beq nav_select_system
 eor.w #1,asm_chart
 beq nav_chart_to_data
 bsr asm_chart_from_target
 bra nav_redraw
nav_chart_to_data:
 bsr asm_chart_snap
 bra nav_redraw
nav_select_system:
 tst.w asm_chart
 beq nav_data_select
 btst #10,d4
 bne nav_chart_snap
 btst #11,d4
 bne nav_chart_home
 and.w #240,d4
 beq nav_consumed
 bsr asm_chart_move
 bra nav_consumed
nav_chart_snap:
 bsr asm_chart_snap
 bra nav_redraw
nav_chart_home:
 move.b asm_travel+19,asm_chart_cursor
 move.b asm_travel+17,asm_chart_cursor+1
 bra nav_redraw
nav_data_select:
 tst.w d4
 beq nav_consumed
 move.w #1,asm_nav_step
 btst #4,d4
 bne nav_decrement
 btst #6,d4
 beq nav_direction_ready
nav_decrement:
 move.w #-1,asm_nav_step
nav_direction_ready:
 move.w #255,asm_nav_tries
nav_find:
 clr.b asm_travel+15
 moveq #0,d0
 move.b asm_travel+8,d0
 add.w asm_nav_step,d0
 and.w #255,d0
 move.l d0,-(sp)
 pea asm_travel
 jsr _travel_select
 addq.l #8,sp
 move.w asm_nav_keys,d0
 and.w #192,d0
 beq nav_redraw
 pea asm_travel+40
 pea asm_travel+16
 jsr _galaxy_distance
 addq.l #8,sp
 tst.w d0
 beq nav_find_next
 moveq #0,d1
 move.b asm_travel+9,d1
 cmp.w d1,d0
 bls nav_redraw
nav_find_next:
 subq.w #1,asm_nav_tries
 bpl nav_find
 bra nav_redraw
nav_start_normal:
 tst.w asm_chart
 beq nav_normal_ready
 tst.w asm_nav
 beq nav_normal_ready
 bsr asm_chart_snap
nav_normal_ready:
 moveq #0,d0
 bra nav_start
nav_start_galaxy:
 moveq #1,d0
nav_start:
 moveq #0,d1
 move.w asm_docked,d1
 move.l d1,-(sp)
 move.l d0,-(sp)
 pea asm_travel
 jsr _travel_start
 lea 12(sp),sp
 tst.w d0
 bne nav_start_failed
 tst.w asm_nav
 beq nav_consumed
 clr.w asm_nav
 bsr asm_clear_view
 bsr asm_restore_view
 bra nav_consumed
nav_start_failed:
 move.w #1,asm_nav
nav_redraw:
 bsr asm_clear_view
 tst.w asm_chart
 beq nav_text_page
 bsr asm_chart_page
 bra nav_consumed
nav_text_page:
 bsr asm_nav_page
nav_consumed:
 moveq #1,d0
 rts
nav_not_consumed:
 moveq #0,d0
 rts
asm_arrival:
 move.w #1,asm_arriving
 moveq #4,d0
 bsr asm_tunnel
 moveq #0,d0
 move.b asm_commander+6,d0
 cmp.b #2,asm_travel+13
 bne solar_keep_carry
 moveq #0,d0
solar_keep_carry:
 move.w d0,asm_solar_legal
 move.w #1,asm_arriving
 ; GVL's DORND boundary uses explicit carry0; sound RNG is not reproduced.
 clr.l -(sp)
 pea asm_laser+5
 jsr _elite_random
 addq.l #8,sp
 and.l #255,d0
 lea asm_laser+5,a0
 lea asm_arrival_rng,a1
 moveq #3,d1
arrival_keep_rng:
 move.b (a0)+,(a1)+
 dbra d1,arrival_keep_rng
 move.l d0,-(sp)
 pea asm_commander
 pea asm_travel
 jsr _travel_arrive
 lea 12(sp),sp
 move.w #3,asm_mode
 move.w #2,asm_salvage
 move.w #12,asm_count
 move.w #1,asm_arriving
 bsr asm_launch
 clr.w asm_arriving
 moveq #0,d0
 move.w asm_solar_legal,d0
 move.l d0,-(sp)
 move.b asm_travel+24,d0
 move.l d0,-(sp)
 pea asm_travel+16
 pea asm_planet
 jsr _solar_planet
 lea 16(sp),sp
 bsr asm_copy_placeholder
 lea asm_arrival_rng,a0
 lea asm_laser+5,a1
 moveq #3,d1
arrival_restore_rng:
 move.b (a0)+,(a1)+
 dbra d1,arrival_restore_rng
 ; RES2/SOLAR's restored RNG must be consumed by the real new star field.
 moveq #3,d0
 bsr asm_dust_run
 moveq #0,d0
 bsr asm_dust_run
 moveq #0,d0
 move.b asm_travel+14,d0
 move.l d0,-(sp)
 move.b asm_travel+22,d0
 move.l d0,-(sp)
 pea asm_market
 jsr _market_init
 lea 12(sp),sp
 bra asm_update_stats
asm_nav_page:
 bra presentation_system
legacy_nav_page:
 moveq #0,d0
 move.b asm_travel+6,d0
 addq.w #1,d0
 lea nav_gal_digit,a0
 moveq #1,d1
 bsr asm_decimal
 lea nav_title,a4
 moveq #4,d6
 bsr asm_text
 lea nav_current,a4
 moveq #22,d6
 bsr asm_text
 lea asm_travel+25,a4
 moveq #34,d6
 bsr asm_text
 lea nav_target,a4
 moveq #52,d6
 bsr asm_text
 lea asm_travel+49,a4
 moveq #64,d6
 bsr asm_text
 moveq #0,d0
 move.b asm_travel+8,d0
 lea nav_index,a0
 moveq #3,d1
 bsr asm_decimal
 moveq #0,d0
 move.b asm_travel+46,d0
 lea nav_econ,a0
 moveq #1,d1
 bsr asm_decimal
 moveq #0,d0
 move.b asm_travel+47,d0
 lea nav_gov,a0
 moveq #1,d1
 bsr asm_decimal
 moveq #0,d0
 move.b asm_travel+48,d0
 addq.w #1,d0
 lea nav_tech,a0
 moveq #2,d1
 bsr asm_decimal
 lea nav_details,a4
 moveq #80,d6
 bsr asm_text
 pea asm_travel+40
 pea asm_travel+16
 jsr _galaxy_distance
 addq.l #8,sp
 lea nav_distance,a0
 moveq #4,d1
 bsr asm_decimal
 move.b nav_distance+3,nav_distance+4
 move.b #46,nav_distance+3
 moveq #0,d0
 move.b asm_travel+9,d0
 lea nav_fuel,a0
 moveq #2,d1
 bsr asm_decimal
 move.b nav_fuel+1,nav_fuel+2
 move.b #46,nav_fuel+1
 move.b #78,nav_drive
 tst.b asm_travel+10
 beq nav_no_drive
 move.b #89,nav_drive
nav_no_drive:
 lea nav_range,a4
 moveq #96,d6
 bsr asm_text
 lea nav_help1,a4
 moveq #116,d6
 bsr asm_text
 lea nav_help2,a4
 move.w #128,d6
 bsr asm_text
 lea nav_help3,a4
 move.w #140,d6
 bsr asm_text
 lea nav_help4,a4
 move.w #152,d6
 bsr asm_text
 moveq #0,d0
 move.b asm_travel+15,d0
 lsl.w #2,d0
 lea nav_errors,a0
 move.l 0(a0,d0.w),a4
 move.w #176,d6
 bsr asm_text
 rts
.sect .data
asm_hyper_line: .ascii "HYPERSPACE "
asm_hyper_digits: .ascii "00 - HOLD COURSE\0"
nav_title: .ascii "NAVIGATION / GALAXY "
nav_gal_digit: .ascii "1\0"
nav_current: .ascii "CURRENT SYSTEM\0"
nav_target: .ascii "DESTINATION\0"
nav_details: .ascii "ID "
nav_index: .ascii "000  ECON "
nav_econ: .ascii "0 GOV "
nav_gov: .ascii "0 TECH "
nav_tech: .ascii "00\0"
nav_range: .ascii "DIST "
nav_distance: .ascii "000.0 FUEL "
nav_fuel: .ascii "7.0 GDRV "
nav_drive: .ascii "Y\0"
nav_help1: .ascii "LEFT/RIGHT NEXT WITHIN FUEL\0"
nav_help2: .ascii "UP/DN ALL SYSTEMS  C CHART\0"
nav_help3: .ascii "H HYPERSPACE  G NEXT GALAXY\0"
nav_help4: .ascii "DOCKED R REFUEL  9 CLOSE\0"
 .align 2
nav_errors: .data4 nav_ok,nav_dock,nav_busy,nav_zero,nav_far,nav_no,nav_cash
nav_ok: .ascii "READY - REFUEL COST 0.2 CR/UNIT\0"
nav_dock: .ascii "LAUNCH BEFORE HYPERSPACE\0"
nav_busy: .ascii "COUNTDOWN IN PROGRESS\0"
nav_zero: .ascii "SELECT ANOTHER SYSTEM\0"
nav_far: .ascii "HYPERSPACE RANGE?\0"
nav_no: .ascii "NO GALACTIC HYPERDRIVE\0"
nav_cash: .ascii "NOT ENOUGH CASH FOR FUEL\0"
.align 2

.sect .text
asm_shop_transaction:
 moveq #0,d0
 btst #7,d4
 bne shop_choose_view
 moveq #1,d0
 btst #8,d4
 bne shop_choose_view
 moveq #2,d0
 btst #9,d4
 bne shop_choose_view
 moveq #3,d0
 btst #10,d4
 beq shop_view_chosen
shop_choose_view:
 move.w d0,asm_shop_view
 bra dock_page_refresh
shop_view_chosen:
 btst #3,d4
 bne asm_save_commander
 btst #6,d4
 bne asm_load_commander
 btst #2,d4
 beq dock_page_refresh
 moveq #0,d0
 move.w asm_shop_view,d0
 move.l d0,-(sp)
 moveq #0,d0
 move.w asm_market_selection,d0
 move.l d0,-(sp)
 pea asm_travel
 pea asm_player
 pea asm_cargo
 pea asm_commander
 jsr _shop_buy_view
 lea 24(sp),sp
 move.w d0,asm_market_result
 bne shop_no_fuel_reset
 tst.w asm_market_selection
 bne shop_no_fuel_reset
 clr.b asm_mcnt
shop_no_fuel_reset:
 bsr asm_draw_dials
 bra dock_page_refresh
asm_shop_page:
 lea shop_title,a4
 moveq #0,d6
 bsr asm_text
 move.l asm_commander,d0
 lea asm_cash_digits,a0
 moveq #10,d1
 bsr asm_decimal
 move.b asm_cash_digits+9,asm_cash_digits+10
 move.b #46,asm_cash_digits+9
 lea asm_cash_line,a4
 moveq #10,d6
 bsr asm_text
 move.w asm_shop_view,d0
 mulu.w #5,d0
 lea asm_view_names,a0
 adda.w d0,a0
 lea shop_view_name,a1
 moveq #4,d0
shop_view_name_copy:
 move.b (a0)+,(a1)+
 dbra d0,shop_view_name_copy
 lea shop_view_line,a4
 moveq #18,d6
 bsr asm_text
 clr.w asm_page_item
shop_page_loop:
 move.w asm_page_item,d0
 lsl.w #2,d0
 lea shop_names,a0
 move.l 0(a0,d0.w),a4
 move.w asm_page_item,d6
 mulu.w #12,d6
 add.w #28,d6
 bsr asm_text
 cmp.w asm_market_selection,d0
 ; Text routines clobber data registers, so compare authoritative indices.
 move.w asm_page_item,d0
 cmp.w asm_market_selection,d0
 bne shop_page_next
 lea shop_arrow,a4
 move.w asm_page_item,d6
 mulu.w #12,d6
 add.w #28,d6
 moveq #24,d7
 bsr asm_text_at
shop_page_next:
 addq.w #1,asm_page_item
 cmp.w #12,asm_page_item
 blo shop_page_loop
 lea shop_help,a4
 move.w #174,d6
 bsr asm_text
 move.w asm_market_result,d0
 lsl.w #2,d0
 lea shop_messages,a0
 move.l 0(a0,d0.w),a4
 move.w #184,d6
 bsr asm_text
 rts
.sect .data
shop_title: .ascii "EQUIP SHIP / 8 RETURNS TO MARKET\0"
shop_view_line: .ascii "LASER "
shop_view_name: .ascii "FRONT  F1-F4 SELECT VIEW\0"
shop_arrow: .ascii ">\0"
shop_help: .ascii "B BUY S SAVE O LOAD 8 BACK L GO\0"
.align 2
shop_names: .data4 shop0,shop1,shop2,shop3,shop4,shop5,shop6,shop7,shop8,shop9,shop10,shop11
shop0: .ascii "FUEL              0.2 CR/UNIT\0"
shop1: .ascii "MISSILE                30 CR\0"
shop2: .ascii "LARGE CARGO BAY       400 CR\0"
shop3: .ascii "ECM SYSTEM            600 CR\0"
shop4: .ascii "EXTRA PULSE LASER     400 CR\0"
shop5: .ascii "EXTRA BEAM LASER     1000 CR\0"
shop6: .ascii "FUEL SCOOPS           525 CR\0"
shop7: .ascii "ESCAPE POD           1000 CR\0"
shop8: .ascii "ENERGY BOMB           900 CR\0"
shop9: .ascii "ENERGY UNIT          1500 CR\0"
shop10: .ascii "DOCK COMPUTER        1000 CR\0"
shop11: .ascii "GALACTIC DRIVE      5000 CR\0"
.align 2
shop_messages: .data4 shop_ok,shop_cash,shop_present,shop_tech,shop_absent,save_ok,load_ok,save_error,load_error
shop_ok: .ascii "READY / PRICES SUBJECT TO TECH\0"
shop_cash: .ascii "NOT ENOUGH CASH\0"
shop_present: .ascii "ALREADY PRESENT / MISSILES FULL\0"
shop_tech: .ascii "NOT AVAILABLE AT THIS TECH LEVEL\0"
shop_absent: .ascii "NOT IMPLEMENTED - NO CHARGE\0"
.align 2

.sect .text
asm_save_commander:
 tst.w _release_mode
 beq flow_save_actual
 move.w #4,flow_state
 bra flow_name_start
flow_save_actual:
 lea save_buffer,a0
 moveq #36,d0
save_zero:
 clr.l (a0)+
 dbra d0,save_zero
 move.l #0x45514132,save_buffer
 moveq #0,d6
 bsr save_copy
 move.l _ship_fit+4,save_buffer+144
 bsr save_checksum
 move.l d0,save_buffer+4
 move.l #1,-(sp)
 pea save_buffer
 jsr _commander_io
 addq.l #8,sp
 move.w #5,asm_market_result
 tst.l d0
 bne flow_save_failed
 bsr flow_remember
 bra dock_page_refresh
flow_save_failed:
 move.w #7,asm_market_result
 bra dock_page_refresh
asm_load_commander:
 tst.w _release_mode
 beq flow_load_actual
 move.w #3,flow_state
 bra flow_name_start
flow_load_actual:
 clr.l save_buffer+144
 clr.l -(sp)
 pea save_buffer
 jsr _commander_io
 addq.l #8,sp
 tst.l d0
 bne save_bad_load
 cmp.l #0x45514131,save_buffer
 beq save_version_valid
 cmp.l #0x45514132,save_buffer
 bne save_bad_load
save_version_valid:
 bsr save_checksum
 cmp.l save_buffer+4,d0
 bne save_bad_load
 ; Payload: commander10,cargo22,travel64,market34,missile1,fit2.
 cmp.b #7,save_buffer+46
 bhi save_bad_load
 cmp.b #70,save_buffer+49
 bhi save_bad_load
 tst.b save_buffer+51
 bne save_bad_load
 cmp.b #4,save_buffer+138
 bhi save_bad_load
 move.b save_buffer+139,d0
 cmp.b #22,d0
 beq save_fit_valid
 cmp.b #37,d0
 bne save_bad_load
save_fit_valid:
 move.b save_buffer+140,d0
 beq save_laser_valid
 cmp.b #15,d0
 beq save_laser_valid
 cmp.b #143,d0
 bne save_bad_load
save_laser_valid:
 lea save_buffer+144,a0
 moveq #2,d1
save_side_validate:
 move.b (a0)+,d0
 beq save_side_next
 cmp.b #15,d0
 beq save_side_next
 cmp.b #143,d0
 bne save_bad_load
save_side_next:
 dbra d1,save_side_validate
 moveq #1,d6
 bsr save_copy
 move.l save_buffer+144,_ship_fit+4
 clr.b asm_commander+7
 clr.b asm_commander+8
 clr.b asm_player+1
 move.b #255,asm_player+2
 bsr asm_draw_dials
 move.w #6,asm_market_result
 bsr flow_remember
 bra dock_page_refresh
save_bad_load:
 move.w #8,asm_market_result
 bra dock_page_refresh
save_copy:
 lea save_parts,a2
 lea save_buffer+8,a1
 moveq #5,d7
save_part:
 move.l (a2)+,a0
 move.w (a2)+,d0
 subq.w #1,d0
save_byte:
 tst.w d6
 bne save_restore_byte
 move.b (a0)+,(a1)+
 bra save_byte_done
save_restore_byte:
 move.b (a1)+,(a0)+
save_byte_done:
 dbra d0,save_byte
 dbra d7,save_part
 rts
save_checksum:
 lea save_buffer+8,a0
 moveq #0,d0
 move.w #135,d1
 cmp.l #0x45514131,save_buffer
 beq save_sum
 move.w #139,d1
save_sum:
 rol.l #1,d0
 moveq #0,d2
 move.b (a0)+,d2
 add.l d2,d0
 dbra d1,save_sum
 rts
.sect .data
.align 2
save_parts: .data4 asm_commander
 .data2 10
 .data4 asm_cargo
 .data2 22
 .data4 asm_travel
 .data2 64
 .data4 asm_market
 .data2 34
 .data4 asm_player
 .data2 1
 .data4 _ship_fit
 .data2 4
save_buffer: .space 148
save_ok: .ascii "SAVED WIN1_ELITESAVE\0"
load_ok: .ascii "COMMANDER LOADED\0"
save_error: .ascii "SAVE FAILED - CHECK WIN1\0"
load_error: .ascii "LOAD FAILED - STATE UNCHANGED\0"
.align 2

.sect .text
asm_chart_page:
 tst.w asm_local_chart
 bne presentation_local
 lea chart_title,a4
 moveq #4,d6
 bsr asm_text
 lea asm_travel+25,a4
 moveq #14,d6
 bsr asm_text
 lea asm_travel+49,a4
 moveq #14,d6
 move.w #160,d7
 bsr asm_text_at
 pea asm_chart_cursor
 pea asm_travel
 pea 0x20000
 jsr _galaxy_chart_cursor
 lea 12(sp),sp
 pea asm_travel+40
 pea asm_travel+16
 jsr _galaxy_distance
 addq.l #8,sp
 lea chart_distance_digits,a0
 moveq #4,d1
 bsr asm_decimal
 move.b chart_distance_digits+3,chart_distance_digits+4
 move.b #46,chart_distance_digits+3
 lea chart_distance,a4
 move.w #156,d6
 bsr asm_text
 lea chart_help,a4
 move.w #170,d6
 bsr asm_text
 lea chart_help2,a4
 move.w #182,d6
 bsr asm_text
 rts
.sect .data
chart_title: .ascii "GALACTIC CHART / CURRENT > TARGET\0"
chart_distance: .ascii "DISTANCE "
chart_distance_digits: .ascii "000.0 LIGHT YEARS\0"
chart_help: .ascii "ARROWS MOVE D SELECT O HOME\0"
chart_help2: .ascii "H JUMP G GALAXY C DATA 9 CLOSE\0"
.align 2

.sect .text
asm_ambient_begin:
 tst.w _release_mode
 beq uni_ambient_legacy
 move.w #1,uni_active
 pea uni_state
 jsr _universe_reset
 addq.l #4,sp
 tst.w asm_arriving
 bne uni_ambient_legacy
 cmp.w #3,asm_salvage
 beq uni_ambient_legacy
 move.b #7,uni_state+1
uni_ambient_legacy:
 move.w #1,asm_ambient
 clr.b asm_enc_params+5
 ; A launched/arrived scene has no scripted fighters. Slot0 remains station.
 lea asm_vectors+36,a0
 moveq #10,d0
ambient_clear:
 move.b #160,31(a0)
 clr.b 32(a0)
 lea 36(a0),a0
 dbra d0,ambient_clear
 ; Original types5 and6 share geometry but have distinct AI identities.
 lea _models,a0
 move.l 16(a0),a0
 lea asm_trader,a1
 moveq #9,d0
ambient_trader_copy:
 move.l (a0)+,(a1)+
 dbra d0,ambient_trader_copy
 move.w #6,asm_trader+28
 rts
asm_encounters:
 tst.w asm_ambient
 beq encounter_done
 cmp.w #3,asm_mode
 bne encounter_done
 clr.b asm_enc_params
 clr.b asm_enc_params+1
 clr.b asm_enc_params+2
 clr.b asm_enc_params+7
 move.b asm_travel+23,asm_enc_params+3
 move.b asm_commander+6,asm_enc_params+4
 ; TT100/me3 inherits the final STARS/PIXEL carry (DEC preserves C).
 move.b asm_dust+166,asm_enc_params+6
 lea asm_vectors,a4
 lea asm_ships,a5
 lea asm_clouds,a6
 moveq #11,d7
encounter_inventory:
 move.b 31(a4),d0
 and.b #160,d0
 cmp.b #160,d0
 bne encounter_occupied
 tst.w 56(a6)
 bne encounter_inventory_next
 addq.b #1,asm_enc_params+7
 bra encounter_inventory_next
encounter_occupied:
 tst.b d0
 bne encounter_inventory_next
 move.l (a5),a0
 move.w 28(a0),d0
 cmp.w #7,d0
 bne encounter_asteroid
 move.b #1,asm_enc_params
 bra encounter_inventory_next
encounter_asteroid:
 cmp.w #9,d0
 bne encounter_cop
 addq.b #1,asm_enc_params+1
encounter_cop:
 cmp.w #2,d0
 bne encounter_inventory_next
 addq.b #1,asm_enc_params+2
encounter_inventory_next:
 lea 36(a4),a4
 lea 272(a5),a5
 lea 448(a6),a6
 dbra d7,encounter_inventory
 bsr uni_encounter_plan
 pea asm_cargo
 pea asm_enc_params
 pea asm_laser+5
 pea asm_enc_output
 jsr _encounter_step
 lea 16(sp),sp
 move.b d0,asm_dust+166
 clr.l _encounter_pool
encounter_emit:
 lea asm_enc_output+2,a2
 move.w asm_enc_output,d6
 subq.w #1,d6
 bmi encounter_done
encounter_insert:
 tst.w uni_active
 bne uni_encounter_allocate
 lea asm_vectors,a4
 lea asm_ships,a5
 lea asm_clouds,a6
 moveq #11,d7
encounter_find:
 move.b 31(a4),d0
 and.b #160,d0
 cmp.b #160,d0
 bne encounter_find_next
 tst.w 56(a6)
 bne encounter_find_next
uni_encounter_ready:
 move.w (a2),d0
 cmp.w #6,d0
 bne encounter_model_find
 lea asm_trader,a0
 bra encounter_model_ready
encounter_model_find:
 lea _models,a1
 moveq #9,d1
encounter_model_loop:
 move.l (a1)+,a0
 cmp.w 28(a0),d0
 beq encounter_model_ready
 dbra d1,encounter_model_loop
 bra encounter_record_next
encounter_model_ready:
 move.l a0,(a5)
 lea 2(a2),a1
 move.l a4,a3
 moveq #35,d0
encounter_record_copy:
 move.b (a1)+,(a3)+
 dbra d0,encounter_record_copy
 move.w 24(a0),d0
 move.b d0,35(a4)
 move.w 30(a0),d0
 and.b #7,d0
 move.b d0,31(a4)
 clr.w 12(a5)
 clr.w 14(a5)
 clr.b 2(a6)
 cmp.w #7,28(a0)
 bne encounter_not_station
 lea 32(a4),a1
 move.l a1,asm_station
encounter_not_station:
 addq.l #1,asm_enc_spawns
 bra encounter_record_next
encounter_find_next:
 lea 36(a4),a4
 lea 272(a5),a5
 lea 448(a6),a6
 dbra d7,encounter_find
encounter_record_next:
 lea 40(a2),a2
 dbra d6,encounter_insert
encounter_done:
 rts

.sect .text
asm_farof:
 moveq #0,d0
 tst.w asm_ambient
 beq farof_done
 move.b 31(a4),d0
 and.w #160,d0
 bne farof_stay
 cmp.b #224,1(a4)
 bhi farof_leave
 cmp.b #224,4(a4)
 bhi farof_leave
 cmp.b #224,7(a4)
 bls farof_stay
farof_leave:
 move.b #160,31(a4)
 clr.b 32(a4)
 move.l asm_cloud,a0
 clr.b 2(a0)
 move.w #1,14(a5)
 move.l (a5),a0
 cmp.w #7,28(a0)
 bne farof_unlock
 clr.l asm_station
 lea asm_placeholder,a0
 moveq #8,d0
farof_placeholder_clear:
 clr.b 0(a0,d0.w)
 dbra d0,farof_placeholder_clear
 move.b #6,asm_placeholder+5
farof_unlock:
 bsr asm_abort_target
 moveq #1,d0
 rts
farof_stay:
 moveq #0,d0
farof_done:
 rts

.sect .text
asm_station_tick:
 tst.w asm_world
 beq station_tick_done
 tst.l asm_station
 bne station_tick_done
 move.b asm_mcnt,d0
 and.b #31,d0
 bne station_tick_done
 pea asm_planet
 pea asm_enc_output+4
 jsr _station_candidate
 addq.l #8,sp
 tst.w d0
 beq station_tick_done
 move.w #1,asm_enc_output
 move.w #7,asm_enc_output+2
 bsr encounter_emit
station_tick_done:
 rts
asm_warp:
 tst.w asm_world
 beq warp_shell_return
 move.w #2,asm_warp_result
 move.w #32,asm_warp_timer
 tst.b asm_travel+11
 bne warp_shell_done
 moveq #0,d2
 tst.l asm_station
 bne warp_shell_block
 lea asm_vectors,a0
 lea asm_ships,a1
 moveq #11,d1
warp_ship_loop:
 move.b 31(a0),d0
 and.b #160,d0
 cmp.b #160,d0
 beq warp_ship_next
 move.l (a1),a2
 move.w 28(a2),d0
 cmp.w #9,d0
 blo warp_shell_block
 cmp.w #11,d0
 bhi warp_shell_block
warp_ship_next:
 lea 36(a0),a0
 lea 272(a1),a1
 dbra d1,warp_ship_loop
 bra warp_shell_try
warp_shell_block:
 moveq #1,d2
warp_shell_try:
 move.l d2,-(sp)
 pea asm_placeholder
 pea asm_planet
 jsr _warp_world
 lea 12(sp),sp
 tst.w d0
 beq warp_shell_done
 move.w #1,asm_warp_result
 addq.l #1,asm_warps
 move.b #1,asm_mcnt
 clr.b asm_enc_params+5
 moveq #3,d0
 bsr asm_dust_run
 moveq #4,d0
 bsr asm_dust_run
 bra warp_shell_return
warp_shell_done:
 cmp.w #2,asm_warp_result
 bne warp_shell_return
 moveq #40,d0
 bsr asm_sound_event
warp_shell_return:
 rts

.sect .data
asm_warp_locked_text: .ascii "IN-SYSTEM JUMP LOCKED\0"
asm_warp_success_text: .ascii "IN-SYSTEM JUMP\0"
.align 2

.sect .text
asm_copy_placeholder:
 lea asm_planet,a0
 lea asm_placeholder,a1
 moveq #8,d0
copy_placeholder_loop:
 move.b (a0)+,(a1)+
 dbra d0,copy_placeholder_loop
 rts

.sect .text
asm_view_ship:
 moveq #0,d0
 move.w asm_view,d0
 move.l d0,-(sp)
 move.l a4,-(sp)
 pea asm_view_inwk
 jsr _view_transform
 lea 12(sp),sp
 pea 4(a5)
 pea asm_view_inwk
 jsr _motion_position
 addq.l #8,sp
 eor.w #1,d0
 move.w d0,14(a5)
 move.b 31(a4),d0
 and.b #160,d0
 cmp.b #160,d0
 bne view_ship_done
 move.w #1,14(a5)
view_ship_done:
 rts
asm_view_keys_poll:
 moveq #0,d0
 bsr asm_keyrow
 and.w #27,d0
 move.w asm_view_keys,d1
 eor.w d0,d1
 move.w d0,asm_view_keys
 and.w d0,d1
 beq view_keys_done
 tst.w asm_page
 bne view_keys_done
 tst.w asm_paused
 bne view_keys_done
 tst.w asm_dead
 bne view_keys_done
 moveq #0,d2
 btst #1,d1
 bne view_select
 moveq #1,d2
 btst #3,d1
 bne view_select
 moveq #2,d2
 btst #4,d1
 bne view_select
 moveq #3,d2
view_select:
 cmp.w asm_view,d2
 beq view_keys_done
 move.w d2,asm_view
 bsr asm_view_label
 bsr asm_clear_view
 moveq #2,d0
 bsr asm_dust_run
 move.w #1,asm_dust_valid
 clr.w asm_planet_cache+12
 lea asm_ships,a0
 lea asm_clouds,a1
 moveq #11,d0
view_clear_cache:
 clr.w 12(a0)
 clr.w 56(a1)
 lea 272(a0),a0
 lea 448(a1),a1
 dbra d0,view_clear_cache
 clr.b asm_laser+9
 clr.b asm_laser+1
 clr.b asm_laser+2
 clr.b asm_sight
 bsr asm_current_laser
 tst.b d0
 beq view_keys_done
 pea 0x20000
 jsr _sight_xor
 addq.l #4,sp
 move.b #1,asm_sight
view_keys_done:
 rts
asm_view_label:
 move.w asm_view,d0
 mulu.w #5,d0
 lea asm_view_names,a0
 adda.w d0,a0
 lea asm_view_text+1,a1
 moveq #4,d0
view_label_copy:
 move.b (a0)+,(a1)+
 dbra d0,view_label_copy
 rts
asm_station_ai:
 movem.l d2-d7/a2-a6,-(sp)
 moveq #0,d2
 lea asm_vectors,a0
 lea asm_ships,a1
 moveq #11,d1
station_count_police:
 move.b 31(a0),d0
 and.b #160,d0
 cmp.b #160,d0
 beq station_count_next
 move.l (a1),a2
 cmp.w #2,28(a2)
 bne station_count_next
 addq.w #1,d2
station_count_next:
 lea 36(a0),a0
 lea 272(a1),a1
 dbra d1,station_count_police
 move.l d2,-(sp)
 pea asm_laser+5
 move.l a4,-(sp)
 pea asm_enc_output+4
 jsr _station_police
 lea 16(sp),sp
 tst.w d0
 beq station_ai_restore
 move.l asm_enc_spawns,d2
 move.w #1,asm_enc_output
 move.w #2,asm_enc_output+2
 bsr encounter_emit
 cmp.l asm_enc_spawns,d2
 beq station_ai_restore
 addq.l #1,asm_police_launches
station_ai_restore:
 movem.l (sp)+,d2-d7/a2-a6
 bra asm_ai_done

.sect .text
asm_current_laser:
 moveq #0,d0
 move.w asm_view,d0
 move.l d0,-(sp)
 pea _ship_fit
 jsr _laser_fitting
 addq.l #8,sp
 rts
asm_computer_key:
 tst.w asm_page
 bne computer_key_done
 tst.w asm_paused
 bne computer_key_done
 tst.w asm_dead
 bne computer_key_done
 cmp.w #3,asm_mode
 bne computer_key_done
 move.l asm_station,d0
 beq computer_key_done
 move.l d0,a0
 moveq #0,d0
 move.b (a0),d0
 move.l d0,-(sp)
 move.l #255,-(sp)
 moveq #0,d0
 move.b asm_equipment+4,d0
 move.l d0,-(sp)
 ; QL C = row2 bit3 (key code 0x2b); Electron KY19 is 0xff when held.
 moveq #2,d0
 bsr asm_keyrow
 btst #3,d0
 beq computer_key_up
 move.l #255,d0
 bra computer_key_test
computer_key_up:
 moveq #0,d0
computer_key_test:
 move.l d0,-(sp)
 jsr _computer_dock
 lea 16(sp),sp
 tst.w d0
 beq computer_key_done
 move.w #1,asm_docked
 addq.l #1,asm_computer_docks
computer_key_done:
 rts

; Hardware-neutral dust wrapper, called at original end-of-flight-loop boundary.
asm_dust_run:
 movem.l d0-d7/a0-a6,-(sp)
 pea 0x20000
 move.l d0,-(sp)
 moveq #0,d0
 move.w asm_view,d0
 move.l d0,-(sp)
 pea asm_laser+5
 pea asm_params
 pea asm_dust
 jsr _dust_run
 lea 24(sp),sp
 movem.l (sp)+,d0-d7/a0-a6
 rts

; Original HFS2/HFS1/HFL1/HFL2 radius sequence and XOR ring accumulation.
; QL pacing adapter yields two 50-Hz ticks per radius group; gameplay is frozen.
asm_tunnel:
 movem.l d0-d7/a0-a6,-(sp)
 move.w d0,d7
 moveq #48,d0
 cmp.w #4,d7
 bne tunnel_sound_ready
 moveq #56,d0
tunnel_sound_ready:
 bsr asm_sound_event
 bsr asm_clear_view
 clr.w asm_dust_valid
 moveq #0,d6
 tunnel_group:
 move.w d6,d5
 and.w #7,d5
 addq.w #8,d5
 move.w d6,asm_tunnel_phase
 addq.w #1,asm_tunnel_phase
 tunnel_ring:
 move.l d7,-(sp)
 move.l d5,-(sp)
 pea asm_planet_cache
 pea 0x20000
 jsr _circle_ring
 lea 16(sp),sp
 add.w d5,d5
 cmp.w #160,d5
 blo tunnel_ring
 ; MT.SUSJB: wait only for visual pacing, with no RNG or mechanics update.
 movem.l d5-d7,-(sp)
 moveq #8,d0
 moveq #-1,d1
 moveq #2,d3
 suba.l a1,a1
 trap #1
 movem.l (sp)+,d5-d7
 bsr asm_sound_poll
 addq.w #1,d6
 cmp.w #16,d6
 blo tunnel_group
 clr.w asm_tunnel_phase
 clr.w asm_planet_cache+12
 movem.l (sp)+,d0-d7/a0-a6
 rts

asm_chart_from_target:
 move.b asm_travel+43,asm_chart_cursor
 move.b asm_travel+41,asm_chart_cursor+1
 rts
asm_chart_snap:
 moveq #0,d0
 move.b asm_chart_cursor+1,d0
 move.l d0,-(sp)
 move.b asm_chart_cursor,d0
 move.l d0,-(sp)
 pea asm_travel
 jsr _chart_nearest
 lea 12(sp),sp
 move.l d0,-(sp)
 pea asm_travel
 jsr _travel_select
 addq.l #8,sp
 bra asm_chart_from_target
asm_chart_move:
 bsr presentation_cursor
 bra chart_movement
chart_movement_unused:
 pea asm_chart_cursor
 pea 0x20000
 jsr _chart_cursor_xor
 addq.l #8,sp
chart_movement:
 moveq #0,d0
 btst #6,d4
 beq chart_move_right
 moveq #-1,d0
chart_move_right:
 btst #7,d4
 beq chart_move_x
 moveq #1,d0
chart_move_x:
 move.l d0,-(sp)
 moveq #0,d0
 move.b asm_chart_cursor,d0
 move.l d0,-(sp)
 jsr _chart_move
 addq.l #8,sp
 move.b d0,asm_chart_cursor
 moveq #0,d0
 btst #4,d4
 beq chart_move_down
 moveq #-1,d0
chart_move_down:
 btst #5,d4
 beq chart_move_y
 moveq #1,d0
chart_move_y:
 move.l d0,-(sp)
 moveq #0,d0
 move.b asm_chart_cursor+1,d0
 move.l d0,-(sp)
 jsr _chart_move
 addq.l #8,sp
 move.b d0,asm_chart_cursor+1
 bsr presentation_cursor
 rts

.sect .data
.align 2
asm_flight_messages: .data4 message_energy,message_target,message_incoming,message_jammed
message_energy: .ascii "ENERGY LOW\0"
message_target: .ascii "TARGET LOST\0"
message_incoming: .ascii "INCOMING MISSILE\0"
message_jammed: .ascii "MISSILE JAMMED\0"
.align 2
.sect .text
asm_message:
 move.b d0,asm_commander+8
 move.b #22,asm_commander+7
 rts
asm_sound_event:
 tst.b flow_config
 bne flow_sound_muted
 movem.l d0-d7/a0-a6,-(sp)
 move.l asm_ticks,-(sp)
 move.l d0,-(sp)
 pea asm_sound
 jsr _sound_event
 lea 12(sp),sp
 move.w d0,asm_sound_carry
 bsr asm_sound_poll
 movem.l (sp)+,d0-d7/a0-a6
 rts
flow_sound_muted:
 clr.w asm_sound_carry
 rts
asm_sound_poll:
 movem.l d0-d7/a0-a6,-(sp)
 move.l asm_ticks,-(sp)
 pea asm_sound
 jsr _sound_poll
 addq.l #8,sp
 movem.l (sp)+,d0-d7/a0-a6
 rts
asm_sound_hit:
 move.l d0,-(sp)
 moveq #24,d0
 bsr asm_sound_event
 moveq #16,d0
 bsr asm_sound_event
 move.l (sp)+,d0
 rts
asm_ecm_sound:
 moveq #0,d0
 tst.b asm_ecm
 sne d0
 cmp.b asm_sound_ecm,d0
 beq ecm_sound_done
 move.b d0,asm_sound_ecm
 tst.b d0
 beq ecm_sound_off
 moveq #64,d0
 bra ecm_sound_send
ecm_sound_off:
 moveq #72,d0
ecm_sound_send:
 bsr asm_sound_event
ecm_sound_done:
 rts

asm_sound_explosion:
 movem.l d0/a0,-(sp)
 move.l (a5),a0
 cmp.w #8,28(a0)
 beq sound_missile_explosion
 bsr asm_sound_hit
 bra sound_explosion_done
sound_missile_explosion:
 moveq #24,d0
 bsr asm_sound_event
sound_explosion_done:
 movem.l (sp)+,d0/a0
 rts

asm_sound_contact:
 move.l d0,-(sp)
 tst.w asm_dead
 bne sound_contact_done
 moveq #24,d0
 bsr asm_sound_event
sound_contact_done:
 move.l (sp)+,d0
 rts

.sect .text
release_commander:
 ; Default NA% (Q%=FALSE):100Cr, four missiles, pulse front, no upgrades.
 clr.b asm_travel+10
 lea asm_equipment,a0
 moveq #4,d0
release_clear_equipment:
 clr.b 0(a0,d0.w)
 dbra d0,release_clear_equipment
 move.b #22,_ship_fit
 move.b #15,_ship_fit+1
 clr.w _ship_fit+2
 clr.l _ship_fit+4
 move.w #3,asm_mode
 move.w #2,asm_salvage
 move.w #12,asm_count
 move.w #1,asm_docked
 move.w #1,asm_page
 bsr asm_clear_view
 bsr asm_commander_page
 rts
dock_status_keys:
 moveq #6,d0
 bsr asm_keyrow
 and.w #4,d0
 move.w asm_page_key,d1
 eor.w d0,d1
 move.w d0,asm_page_key
 and.w d0,d1
 beq dock_status_done
 cmp.w #2,asm_page
 bne flow_page_toggle_1
 move.w #1,asm_page
flow_page_toggle_1:
 eor.w #1,asm_page
 bsr asm_clear_view
 tst.w asm_page
 beq dock_status_market
 bsr asm_commander_page
 rts
dock_status_market:
 bsr asm_market_page
dock_status_done:
 rts
.sect .data
.align 2
asm_local_chart: .data2 0
.sect .text
presentation_cursor:
 tst.w asm_local_chart
 bne local_cursor
 pea asm_chart_cursor
 pea 0x20000
 jsr _chart_cursor_xor
 addq.l #8,sp
 rts
; TT105 uses wrapped byte differences, then explicit CLC before projection.
local_cursor:
 moveq #0,d0
 move.b asm_chart_cursor,d0
 sub.b asm_travel+19,d0
 cmp.b #38,d0
 blo local_cursor_x
 cmp.b #230,d0
 blo local_cursor_done
local_cursor_x:
 lsl.b #2,d0
 add.b #104,d0
 move.w d0,local_cross_x
 moveq #0,d1
 move.b asm_chart_cursor+1,d1
 sub.b asm_travel+17,d1
 cmp.b #38,d1
 blo local_cursor_y
 cmp.b #220,d1
 blo local_cursor_done
local_cursor_y:
 add.b d1,d1
 add.b #90,d1
 move.w local_cross_x,d0
 moveq #8,d5
 bra local_cross
local_cursor_done:
 rts
; Source TT15 cross geometry, native QL line rasterizer.
local_cross:
 movem.l d0-d7/a0-a6,-(sp)
 move.w d0,local_cross_x
 move.w d1,local_cross_y
 move.w d5,local_cross_size
 move.w d0,d2
 move.w d1,d3
 sub.w d5,d0
 bpl local_left_ok
 clr.w d0
local_left_ok:
 add.w d5,d2
 cmp.w #255,d2
 bls local_right_ok
 move.w #255,d2
local_right_ok:
 move.l #0x20000,a0
 jsr xor_segment
 move.w local_cross_x,d0
 move.w d0,d2
 move.w local_cross_y,d1
 move.w d1,d3
 sub.w local_cross_size,d1
 bpl local_top_ok
 clr.w d1
local_top_ok:
 add.w local_cross_size,d3
 move.l #0x20000,a0
 jsr xor_segment
 movem.l (sp)+,d0-d7/a0-a6
 rts
presentation_local:
 lea local_title,a4
 moveq #4,d6
 bsr asm_text
 move.l #2,-(sp)
 moveq #0,d0
 move.b asm_travel+9,d0
 move.l d0,-(sp)
 move.l #90,-(sp)
 move.l #104,-(sp)
 pea local_circle
 pea 0x20000
 jsr _circle_xy
 lea 24(sp),sp
 moveq #104,d0
 moveq #90,d1
 moveq #16,d5
 bsr local_cross
 bsr local_cursor
 lea local_rows,a0
 moveq #24,d0
local_clear_rows:
 clr.b 0(a0,d0.w)
 dbra d0,local_clear_rows
 clr.w local_index
 pea local_record
 clr.l -(sp)
 pea asm_travel
 jsr _galaxy_system
 lea 12(sp),sp
local_system_loop:
 pea local_xy
 pea asm_travel+16
 pea local_record
 jsr _local_position
 lea 12(sp),sp
 tst.w d0
 beq local_next
 move.w local_xy+2,d0
 lsr.w #3,d0
 lea local_rows,a0
 tst.b 0(a0,d0.w)
 beq local_label
 addq.w #1,d0
 tst.b 0(a0,d0.w)
 beq local_label
 subq.w #2,d0
 tst.b 0(a0,d0.w)
 bne local_dot
local_label:
 cmp.w #3,d0
 blo local_next
 move.b #255,0(a0,d0.w)
 move.w d0,d6
 lsl.w #3,d6
 move.w local_xy,d7
 lsr.w #3,d7
 addq.w #1,d7
 lsl.w #3,d7
 lea local_record+9,a4
 bsr asm_text_at
local_dot:
 ; CPIX4/CPIX2 original three-pixel double-height dot, native word-pixel adapter.
 move.w local_xy,d0
 move.w d0,d2
 addq.w #2,d2
 move.w local_xy+2,d1
 move.w d1,d3
 move.l #0x20000,a0
 jsr xor_segment
 move.w local_xy,d0
 move.w d0,d2
 addq.w #2,d2
 move.w local_xy+2,d1
 subq.w #1,d1
 move.w d1,d3
 move.l #0x20000,a0
 jsr xor_segment
local_next:
 pea local_record
 move.l #1,-(sp)
 pea local_record
 jsr _galaxy_system
 lea 12(sp),sp
 addq.w #1,local_index
 cmp.w #256,local_index
 blo local_system_loop
 lea local_help,a4
 move.w #176,d6
 moveq #4,d7
 bsr asm_text_at
 rts
presentation_system:
 pea system_info
 pea asm_travel+40
 jsr _system_details
 addq.l #8,sp
 lea system_title,a4
 moveq #4,d6
 bsr asm_text
 lea asm_travel+49,a4
 moveq #16,d6
 bsr asm_text
 moveq #0,d0
 move.b asm_travel+46,d0
 lsl.w #2,d0
 lea system_economies,a0
 move.l 0(a0,d0.w),a4
 moveq #34,d6
 bsr asm_text
 moveq #0,d0
 move.b asm_travel+47,d0
 lsl.w #2,d0
 lea system_governments,a0
 move.l 0(a0,d0.w),a4
 moveq #46,d6
 bsr asm_text
 moveq #0,d0
 move.b asm_travel+48,d0
 addq.w #1,d0
 lea system_tech,a0
 moveq #2,d1
 bsr asm_decimal
 lea system_tech_line,a4
 moveq #58,d6
 bsr asm_text
 moveq #0,d0
 move.w system_info,d0
 lea system_population,a0
 moveq #2,d1
 bsr asm_decimal
 move.b system_population+1,system_population+2
 move.b #46,system_population+1
 lea system_pop_line,a4
 moveq #70,d6
 bsr asm_text
 lea system_species,a1
 btst #7,asm_travel+44
 bne system_alien
 lea system_human,a0
 bsr system_append
 bra system_species_ready
system_alien:
 moveq #0,d0
 move.b system_info+6,d0
 cmp.w #3,d0
 bhs system_second
 lsl.w #2,d0
 lea system_first_words,a0
 move.l 0(a0,d0.w),a0
 bsr system_append
system_second:
 moveq #0,d0
 move.b system_info+7,d0
 cmp.w #6,d0
 bhs system_third
 lsl.w #2,d0
 lea system_second_words,a0
 move.l 0(a0,d0.w),a0
 bsr system_append
system_third:
 moveq #0,d0
 move.b system_info+8,d0
 cmp.w #6,d0
 bhs system_animal
 lsl.w #2,d0
 lea system_third_words,a0
 move.l 0(a0,d0.w),a0
 bsr system_append
system_animal:
 moveq #0,d0
 move.b system_info+9,d0
 lsl.w #2,d0
 lea system_animal_words,a0
 move.l 0(a0,d0.w),a0
 bsr system_append
system_species_ready:
 clr.b (a1)
 lea system_species,a4
 moveq #82,d6
 moveq #4,d7
 bsr asm_text_at
 moveq #0,d0
 move.w system_info+2,d0
 lea system_product,a0
 moveq #5,d1
 bsr asm_decimal
 lea system_product_line,a4
 moveq #94,d6
 bsr asm_text
 moveq #0,d0
 move.w system_info+4,d0
 lea system_radius,a0
 moveq #5,d1
 bsr asm_decimal
 lea system_radius_line,a4
 moveq #106,d6
 bsr asm_text
 pea asm_travel+40
 pea asm_travel+16
 jsr _galaxy_distance
 addq.l #8,sp
 lea system_distance,a0
 moveq #4,d1
 bsr asm_decimal
 move.b system_distance+3,system_distance+4
 move.b #46,system_distance+3
 lea system_distance_line,a4
 moveq #118,d6
 bsr asm_text
 lea system_help,a4
 move.w #140,d6
 bsr asm_text
 lea nav_help3,a4
 move.w #152,d6
 bsr asm_text
 lea nav_help4,a4
 move.w #164,d6
 bsr asm_text
 moveq #0,d0
 move.b asm_travel+15,d0
 lsl.w #2,d0
 lea nav_errors,a0
 move.l 0(a0,d0.w),a4
 move.w #180,d6
 bsr asm_text
 rts
system_append:
 move.b (a0)+,d0
 beq system_append_done
 move.b d0,(a1)+
 bra system_append
system_append_done:
 rts
.sect .data
.align 2
local_index: .data2 0
local_cross_x: .data2 0
local_cross_y: .data2 0
local_cross_size: .data2 0
local_xy: .space 4
local_record: .space 24
local_rows: .space 26
local_circle: .space 144
system_info: .space 10
system_species: .space 48
local_title: .ascii "SHORT RANGE CHART\0"
local_help: .ascii "ARROWS MOVE D SELECT O HOME V GALAXY\0"
system_title: .ascii "DATA ON SYSTEM\0"
system_tech_line: .ascii "TECH.LEVEL: "
system_tech: .ascii "00\0"
system_pop_line: .ascii "POPULATION: "
system_population: .ascii "0.0 BILLION\0"
system_product_line: .ascii "PRODUCTIVITY: "
system_product: .ascii "00000 M CR\0"
system_radius_line: .ascii "AVERAGE RADIUS: "
system_radius: .ascii "00000 KM\0"
system_distance_line: .ascii "DISTANCE: "
system_distance: .ascii "000.0 LIGHT YEARS\0"
system_help: .ascii "ARROWS BROWSE C GALAXY V LOCAL\0"
system_human: .ascii "HUMAN COLONIALS\0"
.align 2
.align 2
system_economies: .data4 system_economies0,system_economies1,system_economies2,system_economies3,system_economies4,system_economies5,system_economies6,system_economies7
system_economies0: .ascii "RICH INDUSTRIAL\0"
system_economies1: .ascii "AVERAGE INDUSTRIAL\0"
system_economies2: .ascii "POOR INDUSTRIAL\0"
system_economies3: .ascii "MAINLY INDUSTRIAL\0"
system_economies4: .ascii "MAINLY AGRICULTURAL\0"
system_economies5: .ascii "RICH AGRICULTURAL\0"
system_economies6: .ascii "AVERAGE AGRICULTURAL\0"
system_economies7: .ascii "POOR AGRICULTURAL\0"
.align 2
system_governments: .data4 system_governments0,system_governments1,system_governments2,system_governments3,system_governments4,system_governments5,system_governments6,system_governments7
system_governments0: .ascii "ANARCHY\0"
system_governments1: .ascii "FEUDAL\0"
system_governments2: .ascii "MULTI-GOVERNMENT\0"
system_governments3: .ascii "DICTATORSHIP\0"
system_governments4: .ascii "COMMUNIST\0"
system_governments5: .ascii "CONFEDERACY\0"
system_governments6: .ascii "DEMOCRACY\0"
system_governments7: .ascii "CORPORATE STATE\0"
.align 2
system_first_words: .data4 system_first_words0,system_first_words1,system_first_words2
system_first_words0: .ascii "LARGE \0"
system_first_words1: .ascii "FIERCE \0"
system_first_words2: .ascii "SMALL \0"
.align 2
system_second_words: .data4 system_second_words0,system_second_words1,system_second_words2,system_second_words3,system_second_words4,system_second_words5
system_second_words0: .ascii "GREEN \0"
system_second_words1: .ascii "RED \0"
system_second_words2: .ascii "YELLOW \0"
system_second_words3: .ascii "BLUE \0"
system_second_words4: .ascii "BLACK \0"
system_second_words5: .ascii "HARMLESS \0"
.align 2
system_third_words: .data4 system_third_words0,system_third_words1,system_third_words2,system_third_words3,system_third_words4,system_third_words5
system_third_words0: .ascii "SLIMY \0"
system_third_words1: .ascii "BUG-EYED \0"
system_third_words2: .ascii "HORNED \0"
system_third_words3: .ascii "BONY \0"
system_third_words4: .ascii "FAT \0"
system_third_words5: .ascii "FURRY \0"
.align 2
system_animal_words: .data4 system_animal_words0,system_animal_words1,system_animal_words2,system_animal_words3,system_animal_words4,system_animal_words5,system_animal_words6,system_animal_words7
system_animal_words0: .ascii "RODENTS\0"
system_animal_words1: .ascii "FROGS\0"
system_animal_words2: .ascii "LIZARDS\0"
system_animal_words3: .ascii "LOBSTERS\0"
system_animal_words4: .ascii "BIRDS\0"
system_animal_words5: .ascii "HUMANOIDS\0"
system_animal_words6: .ascii "FELINES\0"
system_animal_words7: .ascii "INSECTS\0"

.sect .data
.align 2
release_pause_old: .data2 0

; RC3: Electron BR1/QU5/TITLE/DEATH2 and QDOS filename/keyboard adapters.
; flow_state: 0 flight/bay, 1 Cobra question, 2 Mamba ready,
; 3 load name, 4 save name, 5 DEATH animation.
.sect .data
.align 2
flow_state: .data2 0
flow_config: .data1 0,0,0,0
; DNOIZ, PATG, FLH, reserved. DAMP/DJD live in asm_controls+2/+3.
flow_name: .ascii "JAMESON\0"
flow_saved_name: .ascii "JAMESON\0"
flow_edit: .space 8
flow_saved: .space 148
flow_held: .data2 0
flow_key: .data2 0
flow_row: .data2 0
flow_bits: .data2 0
flow_from_title: .data2 0
flow_name_len: .data2 0
flow_death_count: .data2 0
flow_index: .data2 0
flow_death_flags: .data2 0
flow_random_carry: .data2 0
flow_cargo_held: .data2 0
flow_release_gate: .data2 0
flow_title_params: .data1 3,0,0,0
flow_title_text: .ascii "---- E L I T E ----\0"
flow_credit: .ascii "BY D.BRABEN & I.BELL\0"
flow_copyright: .ascii "(C) ACORNSOFT 1984\0"
flow_question: .ascii "LOAD NEW COMMANDER (Y/N)?\0"
flow_ready_text: .ascii "PRESS FIRE OR SPACE, COMMANDER\0"
flow_game_over: .ascii "GAME OVER\0"
flow_death_continue: .ascii "PRESS SPACE TO CONTINUE\0"
flow_load_text: .ascii "LOAD COMMANDER NAME:\0"
flow_save_text: .ascii "SAVE COMMANDER NAME:\0"
flow_edit_help: .ascii "ENTER ACCEPTS / LEFT DELETES\0"
flow_edit_cancel: .ascii "ESC CANCELS - 7 LETTERS OR DIGITS\0"
flow_edit_legacy: .ascii "EMPTY ENTER LOADS OLD ELITESAVE\0"
flow_legacy_file: .ascii "WIN1_ELITESAVE"
 .align 2
flow_default_name: .ascii "JAMESON\0"
.align 2
.sect .text
flow_remember:
 movem.l d0-d7/a0-a6,-(sp)
 moveq #0,d6
 bsr save_copy
 move.l _ship_fit+4,save_buffer+144
 lea save_buffer,a0
 lea flow_saved,a1
 moveq #36,d0
flow_remember_loop:
 move.l (a0)+,(a1)+
 dbra d0,flow_remember_loop
 move.l flow_name,flow_saved_name
 move.l flow_name+4,flow_saved_name+4
 movem.l (sp)+,d0-d7/a0-a6
 rts
flow_restore:
 bsr asm_setup
 bsr release_commander
 lea flow_saved,a0
 lea save_buffer,a1
 moveq #36,d0
flow_restore_loop:
 move.l (a0)+,(a1)+
 dbra d0,flow_restore_loop
 moveq #1,d6
 bsr save_copy
 move.l save_buffer+144,_ship_fit+4
 move.l flow_saved_name,flow_name
 move.l flow_saved_name+4,flow_name+4
 clr.b asm_commander+7
 clr.b asm_commander+8
 clr.b asm_player+1
 move.b #255,asm_player+2
 clr.w asm_dead
 clr.w asm_paused
 clr.w asm_nav
 clr.w asm_chart
 clr.w asm_local_chart
 clr.w asm_shop
 move.b asm_travel+7,asm_travel+8
 lea asm_travel+16,a0
 lea asm_travel+40,a1
 moveq #5,d0
flow_ping:
 move.l (a0)+,(a1)+
 dbra d0,flow_ping
 rts
flow_title_load:
 move.w #1,flow_state
 move.w #1,flow_from_title
 move.l _models+16,d0
 bra flow_title_init
flow_title_ready:
 bsr flow_restore
 move.w #2,flow_state
 move.l _models+8,d0
flow_title_init:
 move.l d0,-(sp)
 clr.w asm_paused
 clr.w asm_dead
 clr.b asm_sound_dead
 clr.w asm_dust_valid
 bsr asm_clear_view
 lea asm_ships,a0
 move.w #815,d0
flow_zero_cache:
 clr.l (a0)+
 dbra d0,flow_zero_cache
 lea asm_vectors,a0
 move.w #107,d0
flow_zero_vectors:
 clr.l (a0)+
 dbra d0,flow_zero_vectors
 move.l (sp)+,asm_ships
 move.b #96,asm_vectors+14
 move.b #96,asm_vectors+18
 move.b #96,asm_vectors+22
 move.b #96,asm_vectors+7
 move.b #127,asm_vectors+29
 move.b #127,asm_vectors+30
 clr.b asm_mcnt
 move.w #1,flow_held
 rts
; Scan all QL IPC matrix rows, returning one ASCII key on a fresh press.
; Modifiers do not change the Electron command meaning.
flow_read_key:
 clr.w flow_row
 move.w #-1,flow_key
flow_read_row:
 move.w flow_row,d0
 bsr asm_keyrow
 move.w d0,flow_bits
 moveq #0,d2
flow_read_bit:
 btst d2,d0
 beq flow_read_next
 moveq #7,d1
 sub.w flow_row,d1
 lsl.w #3,d1
 add.w d2,d1
 lea flow_keymap,a0
 move.b 0(a0,d1.w),d1
 and.w #255,d1
 beq flow_read_next
 move.w d1,flow_key
flow_read_next:
 addq.w #1,d2
 cmp.w #8,d2
 blo flow_read_bit
 addq.w #1,flow_row
 cmp.w #8,flow_row
 blo flow_read_row
 move.w flow_key,d0
 cmp.w #-1,d0
 bne flow_key_down
 clr.w flow_held
 rts
flow_key_down:
 tst.w flow_held
 bne flow_key_repeat
 move.w #1,flow_held
 rts
flow_key_repeat:
 moveq #-1,d0
 rts
flow_dispatch:
 bsr flow_read_key
 move.w d0,flow_key
 cmp.w #5,flow_state
 beq flow_death_frame
 cmp.w #3,flow_state
 bhs flow_name_frame
 cmp.w #1,flow_state
 bne flow_ready_keys
 cmp.w #89,d0
 beq flow_title_yes
 cmp.w #-1,d0
 beq flow_title_frame
 cmp.w #27,d0
 beq asm_finish
 bsr flow_title_ready
 bra asm_wait
flow_title_yes:
 move.w #3,flow_state
 bsr flow_name_start
 bra asm_wait
flow_ready_keys:
 cmp.w #-1,d0
 beq flow_title_frame
 cmp.w #27,d0
 beq asm_finish
 ; TITLE returns on any key in the actual Electron instructions.
 bsr flow_restore
 move.w #1,flow_release_gate
 clr.w flow_state
 clr.w flow_from_title
 move.w #1,asm_page
 move.w #1,asm_docked
 bsr asm_clear_view
 bsr asm_draw_dials
 bsr asm_commander_page
 bra asm_wait
flow_title_frame:
 cmp.b #1,asm_vectors+7
 beq flow_title_near
 subq.b #1,asm_vectors+7
flow_title_near:
 move.b asm_mcnt,d0
 and.w #15,d0
 bne flow_title_tidy_done
 pea asm_vectors
 jsr _tidy_ship
 addq.l #4,sp
flow_title_tidy_done:
 pea flow_title_params
 pea asm_vectors
 jsr _move_ship
 addq.l #8,sp
 subq.b #1,asm_mcnt
 move.b #128,asm_vectors+6
 clr.b asm_vectors
 clr.b asm_vectors+3
 lea asm_vectors,a4
 lea asm_ships,a5
 bsr flow_render
 ; Repainting text uses OR pixels, so repeated text is harmless.
 lea flow_title_text,a4
 moveq #16,d6
 bsr asm_text
 tst.b flow_config+1
 beq flow_no_credit
 lea flow_credit,a4
 moveq #32,d6
 bsr asm_text
flow_no_credit:
 lea flow_question,a4
 cmp.w #1,flow_state
 beq flow_prompt
 lea flow_ready_text,a4
flow_prompt:
 move.w #160,d6
 bsr asm_text
 lea flow_copyright,a4
 move.w #176,d6
 bsr asm_text
 bra asm_wait
flow_render:
 pea 4(a5)
 move.l a4,-(sp)
 jsr _motion_position
 addq.l #8,sp
 eor.w #1,d0
 move.w d0,14(a5)
 pea asm_matrix
 move.l a4,-(sp)
 jsr _motion_matrix
 addq.l #8,sp
 move.l #asm_matrix,_live_matrix
 move.l a4,_render_inwk
 move.l a5,-(sp)
 pea 0x20000
 jsr _render_ship
 addq.l #8,sp
 clr.l _live_matrix
 clr.l _render_inwk
 rts
flow_name_start:
 move.w #1,flow_held
 move.l flow_name,flow_edit
 move.l flow_name+4,flow_edit+4
 clr.w flow_name_len
 lea flow_edit,a0
flow_name_length:
 move.w flow_name_len,d0
 tst.b 0(a0,d0.w)
 beq flow_name_paint
 addq.w #1,flow_name_len
 cmp.w #7,flow_name_len
 blo flow_name_length
flow_name_paint:
 bsr asm_clear_view
 lea flow_load_text,a4
 cmp.w #4,flow_state
 bne flow_name_prompt
 lea flow_save_text,a4
flow_name_prompt:
 moveq #32,d6
 bsr asm_text
 lea flow_edit,a4
 moveq #64,d6
 bsr asm_text
 lea flow_edit_help,a4
 move.w #128,d6
 bsr asm_text
 lea flow_edit_cancel,a4
 move.w #144,d6
 bsr asm_text
 lea flow_edit_legacy,a4
 move.w #160,d6
 bsr asm_text
 rts
flow_name_frame:
 cmp.w #-1,d0
 beq asm_wait
 cmp.w #27,d0
 beq flow_name_cancel
 cmp.w #13,d0
 beq flow_name_accept
 cmp.w #8,d0
 beq flow_name_delete
 cmp.w #48,d0
 blo asm_wait
 cmp.w #57,d0
 bls flow_name_append
 cmp.w #65,d0
 blo asm_wait
 cmp.w #90,d0
 bhi asm_wait
flow_name_append:
 move.w flow_name_len,d1
 cmp.w #7,d1
 bhs asm_wait
 lea flow_edit,a0
 move.b d0,0(a0,d1.w)
 addq.w #1,flow_name_len
 clr.b 1(a0,d1.w)
 bra flow_name_redraw
flow_name_delete:
 tst.w flow_name_len
 beq asm_wait
 subq.w #1,flow_name_len
 move.w flow_name_len,d1
 lea flow_edit,a0
 clr.b 0(a0,d1.w)
flow_name_redraw:
 bsr flow_name_paint
 bra asm_wait
flow_name_accept:
 tst.w flow_name_len
 bne flow_named_file
 cmp.w #3,flow_state
 bne asm_wait
 move.w #14,_commander_filename
 lea flow_legacy_file,a0
 lea _commander_filename+2,a1
 moveq #13,d0
flow_legacy_copy:
 move.b (a0)+,(a1)+
 dbra d0,flow_legacy_copy
 move.l flow_default_name,flow_edit
 move.l flow_default_name+4,flow_edit+4
 bra flow_named_load
flow_named_file:
 ; Empty name imports legacy WIN1_ELITESAVE; named files use WIN1_<name>.
 lea flow_edit,a0
 lea _commander_filename+7,a1
 move.w flow_name_len,d0
 move.w d0,d1
 addq.w #5,d1
 move.w d1,_commander_filename
 subq.w #1,d0
flow_filename_loop:
 move.b (a0)+,(a1)+
 dbra d0,flow_filename_loop
 cmp.w #4,flow_state
 beq flow_name_save
flow_named_load:
 bsr flow_load_actual
 cmp.w #6,asm_market_result
 bne flow_load_error
 move.l flow_edit,flow_name
 move.l flow_edit+4,flow_name+4
 bsr flow_remember
 tst.w flow_from_title
 beq flow_name_bay
 bsr flow_title_ready
 bra asm_wait
flow_load_error:
 bsr flow_name_paint
 lea load_error,a4
 moveq #96,d6
 bsr asm_text
 bra asm_wait
flow_name_save:
 move.l flow_name,-(sp)
 move.l flow_name+4,-(sp)
 move.l flow_edit,flow_name
 move.l flow_edit+4,flow_name+4
 bsr flow_save_actual
 cmp.w #5,asm_market_result
 beq flow_save_name_ok
 move.l (sp)+,flow_name+4
 move.l (sp)+,flow_name
 bra flow_name_bay
flow_save_name_ok:
 addq.l #8,sp
flow_name_bay:
 move.w #1,flow_release_gate
 clr.w flow_state
 bsr asm_clear_view
 tst.w asm_page
 beq flow_name_market
 bsr asm_commander_page
 bra asm_wait
flow_name_market:
 tst.w asm_shop
 beq flow_name_market_only
 bsr asm_shop_page
 bra asm_wait
flow_name_market_only:
 bsr asm_market_page
 bra asm_wait
flow_name_cancel:
 tst.w flow_from_title
 bne flow_cancel_title
 bsr menu_escape
 bra asm_wait
flow_cancel_title:
 bsr flow_title_load
 bra asm_wait
; FREEZE/DKS3 options: configuration bytes persist across death/restart.
; FLH has no readers in the Electron source: preserve its inert flag.
flow_pause:
 bsr flow_read_key
 cmp.w #1,d0
 beq flow_resume
 cmp.w #83,d0
 beq flow_sound_on
 cmp.w #81,d0
 beq flow_sound_off
 cmp.w #2,d0
 beq flow_toggle_damp
 cmp.w #65,d0
 beq flow_toggle_centre
 cmp.w #88,d0
 beq flow_toggle_author
 cmp.w #70,d0
 bne flow_pause_done
 not.b flow_config+2
 bra flow_config_beep
flow_toggle_author:
 not.b flow_config+1
 bra flow_config_beep
flow_toggle_damp:
 not.b asm_controls+2
 bra flow_config_beep
flow_toggle_centre:
 not.b asm_controls+3
 bra flow_config_beep
flow_sound_on:
 clr.b flow_config
 bra flow_pause_done
flow_sound_off:
 move.b #255,flow_config
 pea asm_sound
 jsr _sound_stop
 addq.l #4,sp
 bra flow_pause_done
flow_resume:
 clr.w asm_paused
 move.w #32,release_pause_old
 rts
flow_config_beep:
 moveq #32,d0
 bsr asm_sound_event
flow_pause_done:
 rts

.sect .data
flow_keymap: .data1 0,0,0,88,86,0,78,0,56,50,54,81,69,48,84,85,57,87,73,0,82,0,89,79,76,51,72,49,65,80,68,74,0,2,75,83,70,0,71,0,0,90,0,67,66,0,77,0,13,8,0,27,0,0,32,0,0,0,53,0,0,1,52,55
.align 2
.sect .text
; DEATH D1: four canisters, Ze random signs, ROR pitch and killed flag,
; fq1 reversed side vector and ROL DELTA. ASL twice makes DELTA=12,
; despite the contradictory source comment saying divide by four.
flow_death:
 moveq #24,d0
 bsr asm_sound_event
 move.l _models+32,d0
 bsr flow_title_init
 move.w #5,flow_state
 move.w #50,flow_death_count
 move.b #146,asm_mcnt
 clr.w flow_index
 lea asm_clouds,a0
 move.w #1343,d0
flow_death_zero:
 clr.l (a0)+
 dbra d0,flow_death_zero
 move.b #3,asm_params
 clr.b asm_params+1
 clr.b asm_params+2
 clr.w asm_view
 moveq #0,d0
 bsr asm_dust_run
flow_death_spawn:
 move.w flow_index,d0
 mulu.w #36,d0
 lea asm_vectors,a4
 adda.l d0,a4
 moveq #35,d0
flow_death_inwk:
 clr.b 0(a4,d0.w)
 dbra d0,flow_death_inwk
 clr.l -(sp)
 pea asm_laser+5
 jsr _elite_random
 addq.l #8,sp
 and.b #128,d0
 move.b d0,2(a4)
 swap d0
 and.b #128,d0
 move.b d0,5(a4)
 ; Ze falls through DORND2 (CLC).
 clr.l -(sp)
 pea asm_laser+5
 jsr _elite_random
 addq.l #8,sp
 move.w d0,flow_random_carry
 move.b #32,(a4)
 eor.b #42,d0
 move.b d0,3(a4)
 or.b #80,d0
 move.b d0,6(a4)
 swap d0
 and.b #143,d0
 move.b d0,29(a4)
 move.b d0,d1
 and.w #1,d1
 move.w d1,flow_death_flags
 lsr.b #1,d0
 ; ROR inserts DORND2's carry into bit7, then AND #87.
 btst #0,flow_random_carry
 beq flow_death_pitch
 or.b #128,d0
flow_death_pitch:
 and.b #135,d0
 move.b d0,30(a4)
 move.b #96,14(a4)
 move.b #96,18(a4)
 move.b #224,22(a4)
 move.b #24,27(a4)
 add.b d1,27(a4)
 move.b #1,33(a4)
 move.w flow_index,d0
 mulu.w #272,d0
 lea asm_ships,a5
 adda.l d0,a5
 move.l _models+32,(a5)
 tst.w flow_death_flags
 beq flow_death_not_killed
 move.w flow_index,d0
 mulu.w #448,d0
 lea asm_clouds,a0
 adda.l d0,a0
 move.b #128,31(a4)
 pea asm_laser+5
 move.l (a5),-(sp)
 move.l a0,-(sp)
 move.l a4,-(sp)
 jsr _explosion_start
 lea 16(sp),sp
flow_death_not_killed:
 addq.w #1,flow_index
 cmp.w #4,flow_index
 blo flow_death_spawn
 lea asm_keys,a0
 moveq #5,d0
flow_death_keys_zero:
 clr.b 0(a0,d0.w)
 dbra d0,flow_death_keys_zero
 move.b #128,asm_controls+1
 clr.b asm_controls+12
 move.b #3,asm_params
 clr.b asm_params+1
 clr.b asm_params+2
 clr.b asm_params+3
 clr.w asm_view
 rts
flow_death_frame:
 tst.w flow_death_count
 bne flow_death_animate
 cmp.w #32,flow_key
 bne asm_wait
 bsr flow_title_load
 bra asm_wait
flow_death_animate:
 move.b asm_vectors,asm_laser+5
 pea asm_sound
 jsr _sound_tick
 addq.l #4,sp
 pea asm_keys
 pea asm_controls
 jsr _control_step
 addq.l #8,sp
 move.b asm_controls+4,asm_params
 move.b asm_controls+5,asm_params+1
 clr.w flow_index
flow_death_ship:
 move.w flow_index,d0
 mulu.w #36,d0
 lea asm_vectors,a4
 adda.l d0,a4
 move.w flow_index,d0
 mulu.w #272,d0
 lea asm_ships,a5
 adda.l d0,a5
 move.b 31(a4),d0
 and.w #160,d0
 bne flow_death_tidy_done
 move.b asm_mcnt,d0
 move.w flow_index,d1
 eor.w d1,d0
 and.w #15,d0
 bne flow_death_tidy_done
 move.l a4,-(sp)
 jsr _tidy_ship
 addq.l #4,sp
flow_death_tidy_done:
 move.b #15,asm_params+3
 pea asm_params
 move.l a4,-(sp)
 jsr _move_ship
 addq.l #8,sp
 clr.w _render_exploding
 btst #5,31(a4)
 beq flow_death_render
 move.w #1,_render_exploding
flow_death_render:
 bsr flow_render
 clr.w _render_exploding
 btst #5,31(a4)
 beq flow_death_ship_next
 move.w flow_index,d0
 mulu.w #448,d0
 lea asm_clouds,a0
 adda.l d0,a0
 pea asm_laser+5
 move.l a0,-(sp)
 move.l a4,-(sp)
 pea 0x20000
 jsr _explosion_frame
 lea 16(sp),sp
flow_death_ship_next:
 addq.w #1,flow_index
 cmp.w #4,flow_index
 blo flow_death_ship
 moveq #1,d0
 bsr asm_dust_run
 lea flow_game_over,a4
 moveq #96,d6
 moveq #96,d7
 bsr asm_text_at
 ; MA23 saturating LASCT-4, then D2 DEC. From50 exactly10 updates.
 subq.b #1,asm_mcnt
 subq.w #5,flow_death_count
 bne asm_wait
 ; Requested QL presentation change: hold the final frame. A key held
 ; through the animation cannot dismiss it; release before fresh Space.
 move.w #1,flow_held
 lea flow_death_continue,a4
 moveq #112,d6
 bsr asm_text
 bra asm_wait

; STATUS fields derive from STATUS/st6/st5/st3/stqv/st, with native QL layout.
; Cargo remains on its own page (7); equipment includes all four laser views.
flow_status:
 lea flow_status_title,a4
 moveq #4,d6
 bsr asm_text
 lea flow_name,a4
 moveq #4,d6
 move.w #98,d7
 bsr asm_text_at
 lea flow_present,a4
 moveq #20,d6
 bsr asm_text
 lea asm_travel+25,a4
 moveq #20,d6
 move.w #152,d7
 bsr asm_text_at
 lea flow_target,a4
 moveq #32,d6
 bsr asm_text
 lea asm_travel+49,a4
 moveq #32,d6
 move.w #152,d7
 bsr asm_text_at
 lea flow_docked,a4
 tst.w asm_docked
 bne flow_condition
 lea flow_green,a4
 lea asm_vectors,a0
 lea asm_ships,a1
 moveq #11,d0
flow_condition_scan:
 btst #7,31(a0)
 bne flow_condition_next
 move.l (a1),a2
 cmp.w #7,28(a2)
 beq flow_condition_next
 cmp.w #9,28(a2)
 beq flow_condition_next
 lea flow_yellow,a4
 cmp.b #128,asm_status+2
 bhs flow_condition
 lea flow_red,a4
 bra flow_condition
flow_condition_next:
 lea 36(a0),a0
 lea 272(a1),a1
 dbra d0,flow_condition_scan
flow_condition:
 moveq #44,d6
 bsr asm_text
 moveq #0,d0
 move.b asm_travel+9,d0
 divu.w #10,d0
 add.b #48,d0
 move.b d0,flow_fuel_digits
 swap d0
 add.b #48,d0
 move.b d0,flow_fuel_digits+2
 lea flow_fuel,a4
 moveq #56,d6
 bsr asm_text
 move.l asm_commander,d0
 lea asm_cash_digits,a0
 moveq #10,d1
 bsr asm_decimal
 move.b asm_cash_digits+9,asm_cash_digits+10
 move.b #46,asm_cash_digits+9
 lea asm_cash_digits,a0
 moveq #7,d0
flow_cash_trim:
 cmp.b #48,(a0)
 bne flow_cash_ready
 move.b #32,(a0)+
 dbra d0,flow_cash_trim
flow_cash_ready:
 lea asm_cash_line,a4
 moveq #68,d6
 bsr asm_text
 lea asm_clean,a4
 tst.b asm_commander+6
 beq flow_legal
 lea asm_offender,a4
 cmp.b #50,asm_commander+6
 blo flow_legal
 lea asm_fugitive,a4
flow_legal:
 moveq #80,d6
 bsr asm_text
 pea asm_commander
 jsr _commander_rank
 addq.l #4,sp
 subq.w #1,d0
 lsl.w #2,d0
 lea asm_rank_names,a0
 move.l 0(a0,d0.w),a4
 moveq #92,d6
 bsr asm_text
 ; Equipment: two columns of up to six lines, preserving Electron order.
 clr.w flow_index
 clr.w flow_equipment_count
flow_equipment_loop:
 move.w flow_index,d0
 lsl.w #2,d0
 lea flow_equipment_flags,a0
 move.l 0(a0,d0.w),a0
 tst.b (a0)
 beq flow_equipment_next
 lea flow_equipment_names,a0
 move.l 0(a0,d0.w),a4
 bsr flow_equipment_print
flow_equipment_next:
 addq.w #1,flow_index
 cmp.w #7,flow_index
 blo flow_equipment_loop
 clr.w flow_index
flow_laser_loop:
 lea flow_laser_offsets,a0
 move.w flow_index,d0
 moveq #0,d1
 move.b 0(a0,d0.w),d1
 lea _ship_fit,a0
 move.b 0(a0,d1.w),d1
 beq flow_laser_next
 lea flow_pulse,a4
 tst.b d1
 bpl flow_laser_type
 lea flow_beam,a4
flow_laser_type:
 lea flow_laser_line,a0
 moveq #11,d1
flow_laser_copy:
 move.b (a4)+,(a0)+
 dbra d1,flow_laser_copy
 move.w flow_index,d0
 mulu.w #5,d0
 lea asm_view_names,a0
 adda.w d0,a0
 lea flow_laser_line+12,a1
 moveq #4,d0
flow_laser_view:
 move.b (a0)+,(a1)+
 dbra d0,flow_laser_view
 lea flow_laser_line,a4
 bsr flow_equipment_print
flow_laser_next:
 addq.w #1,flow_index
 cmp.w #4,flow_index
 blo flow_laser_loop
 lea flow_status_help,a4
 move.w #180,d6
 bsr asm_text
 rts
flow_equipment_print:
 move.w flow_equipment_count,d6
 moveq #8,d7
 cmp.w #6,d6
 blo flow_equipment_row
 subq.w #6,d6
 move.w #136,d7
flow_equipment_row:
 mulu.w #11,d6
 add.w #110,d6
 bsr asm_text_at
 addq.w #1,flow_equipment_count
 rts
.sect .data
.align 2
flow_equipment_count: .data2 0
flow_equipment_flags: .data4 _ship_fit+2,asm_equipment+1,asm_equipment,asm_equipment+2,asm_equipment+3,asm_equipment+4,asm_travel+10
flow_equipment_names: .data4 flow_escape,flow_scoops,flow_ecm,flow_bomb,flow_energy,flow_computer,flow_galactic
flow_status_title: .ascii "COMMANDER\0"
flow_present: .ascii "PRESENT SYSTEM:\0"
flow_target: .ascii "HYPERSPACE SYSTEM:\0"
flow_docked: .ascii "CONDITION: DOCKED\0"
flow_green: .ascii "CONDITION: GREEN\0"
flow_yellow: .ascii "CONDITION: YELLOW\0"
flow_red: .ascii "CONDITION: RED\0"
flow_fuel: .ascii "FUEL: "
flow_fuel_digits: .ascii "7.0 LIGHT YEARS\0"
flow_escape: .ascii "ESCAPE CAPSULE\0"
flow_scoops: .ascii "FUEL SCOOPS\0"
flow_ecm: .ascii "E.C.M. SYSTEM\0"
flow_bomb: .ascii "ENERGY BOMB\0"
flow_energy: .ascii "ENERGY UNIT\0"
flow_computer: .ascii "DOCKING COMPUTER\0"
flow_galactic: .ascii "GALACTIC HYPERSPACE\0"
flow_pulse: .ascii "PULSE LASER "
flow_beam: .ascii "BEAM LASER  "
flow_laser_line: .ascii "PULSE LASER FRONT\0"
flow_laser_offsets: .data1 1,4,5,6
flow_status_help: .ascii "6 MARKET/STATUS  7 CARGO  0 CHEATS\0"
.align 2
.sect .text
flow_cargo_keys:
 moveq #0,d0
 bsr asm_keyrow
 and.w #128,d0
 move.w flow_cargo_held,d1
 eor.w d0,d1
 move.w d0,flow_cargo_held
 and.w d0,d1
 beq flow_cargo_return
 tst.w asm_nav
 bne flow_cargo_return
 tst.w asm_shop
 bne flow_cargo_return
 move.w #2,asm_page
 bsr asm_clear_view
 bsr asm_commander_page
flow_cargo_return:
 rts

; RC4 compact universe. Logical FRIN slot L>=1 is native record L-1.
; The planet remains in its full-width external block, but occupies FRIN0.
; All three per-ship blocks move together: INWK36, renderer272, cloud448.
.sect .data
.align 2
uni_state: .space 30
uni_plan: .space 30
uni_active: .data2 0
uni_copy_index: .data2 0
uni_removed: .data2 0
.sect .text
uni_allocate:
 movem.l d1-d7/a0-a6,-(sp)
 move.l d0,-(sp)
 move.l d0,-(sp)
 jsr _universe_cost
 addq.l #4,sp
 move.l d0,-(sp)
 move.l 4(sp),-(sp)
 pea uni_state
 jsr _universe_add
 lea 16(sp),sp
 tst.l d0
 bmi uni_allocate_done
 subq.w #1,d0
uni_allocate_done:
 movem.l (sp)+,d1-d7/a0-a6
 rts
uni_spawn_allocate:
 lea _models,a0
 move.w asm_spawn_kind,d0
 lsl.w #2,d0
 move.l 0(a0,d0.w),a0
 moveq #0,d0
 move.w 28(a0),d0
 bsr uni_allocate
 tst.l d0
 bmi uni_spawn_full
 move.w d0,d1
 mulu.w #36,d1
 lea asm_vectors,a2
 adda.l d1,a2
 move.w d0,d1
 mulu.w #272,d1
 lea asm_ships,a3
 adda.l d1,a3
 mulu.w #448,d0
 lea asm_clouds,a6
 adda.l d0,a6
 bra uni_spawn_ready
uni_encounter_allocate:
 moveq #0,d0
 move.w (a2),d0
 bsr uni_allocate
 tst.l d0
 bmi encounter_record_next
 move.w d0,d1
 mulu.w #36,d1
 lea asm_vectors,a4
 adda.l d1,a4
 move.w d0,d1
 mulu.w #272,d1
 lea asm_ships,a5
 adda.l d1,a5
 mulu.w #448,d0
 lea asm_clouds,a6
 adda.l d0,a6
 bra uni_encounter_ready
uni_encounter_plan:
 clr.l _encounter_pool
 tst.w uni_active
 beq uni_plan_done
 movem.l d0-d1/a0-a1,-(sp)
 lea uni_state,a0
 lea uni_plan,a1
 moveq #14,d0
uni_plan_copy:
 move.w (a0)+,(a1)+
 dbra d0,uni_plan_copy
 move.l #uni_plan,_encounter_pool
 ; Inventory includes exploding ships, like MANY (decremented at KILLSHP).
 clr.b asm_enc_params+1
 clr.b asm_enc_params+2
 moveq #2,d0
uni_inventory:
 cmp.w uni_state+14,d0
 bhs uni_inventory_done
 lea uni_state,a0
 move.b 0(a0,d0.w),d1
 cmp.b #9,d1
 bne uni_inventory_cop
 addq.b #1,asm_enc_params+1
uni_inventory_cop:
 cmp.b #2,d1
 bne uni_inventory_next
 addq.b #1,asm_enc_params+2
uni_inventory_next:
 addq.w #1,d0
 bra uni_inventory
uni_inventory_done:
 moveq #12,d0
 sub.w uni_state+14,d0
 move.b d0,asm_enc_params+7
 movem.l (sp)+,d0-d1/a0-a1
uni_plan_done:
 rts
uni_draw_entry:
 move.w asm_slot,d0
 addq.w #1,d0
 cmp.w uni_state+14,d0
 bhs uni_draw_finished
 cmp.w #1,d0
 bne uni_draw_present
 cmp.b #129,uni_state+1
 bne uni_draw_present
 ; MVEIT handles the slot1 placeholder as a full-width body, without AI.
 clr.l -(sp)
 pea asm_params
 pea asm_placeholder
 jsr _move_planet
 lea 12(sp),sp
 bra uni_draw_next
uni_draw_present:
 move.w asm_slot,d0
 mulu.w #272,d0
 lea asm_ships,a5
 adda.l d0,a5
 lea asm_vectors,a0
 move.w asm_slot,d0
 bra uni_slot_ready
uni_draw_complete:
 move.b 31(a4),d0
 and.w #160,d0
 cmp.w #160,d0
 bne uni_draw_next
 bsr uni_remove_current
 ; KS1 returns to MAL1 at the same slot: do not skip the shifted ship.
 bra asm_draw_loop
uni_draw_next:
 addq.w #1,asm_slot
 bra asm_draw_loop
uni_remove_current:
 movem.l d0-d7/a0-a6,-(sp)
 move.w asm_slot,uni_removed
 move.w asm_slot,d0
 cmp.b asm_player+2,d0
 bne uni_unlock_done
 move.b #255,asm_player+2
 clr.b asm_player+1
 moveq #5,d0
 bsr asm_message
uni_unlock_done:
 ; KILLSHP only aborts an equal player lock. It does NOT decrement MSTG
 ; for a later lock; retain that original behavior rather than fixing it.
 move.l a5,-(sp)
 pea 0x20000
 jsr _render_cache
 addq.l #8,sp
 move.l asm_cloud,a0
 moveq #0,d0
 move.w 56(a0),d0
 move.l d0,-(sp)
 pea 58(a0)
 pea 0x20000
 jsr _cloud_xor
 lea 12(sp),sp
 moveq #0,d0
 move.w uni_removed,d0
 addq.w #1,d0
 move.l d0,-(sp)
 pea uni_state
 jsr _universe_remove
 addq.l #8,sp
 tst.w uni_removed
 beq uni_remove_station
 move.w uni_removed,uni_copy_index
uni_shift_blocks:
 move.w uni_copy_index,d0
 addq.w #1,d0
 cmp.w uni_state+14,d0
 bhs uni_clear_tail
 move.w uni_copy_index,d0
 mulu.w #36,d0
 lea asm_vectors,a0
 adda.l d0,a0
 lea 36(a0),a1
 moveq #8,d0
uni_shift_inwk:
 move.l (a1)+,(a0)+
 dbra d0,uni_shift_inwk
 move.w uni_copy_index,d0
 mulu.w #272,d0
 lea asm_ships,a0
 adda.l d0,a0
 lea 272(a0),a1
 moveq #67,d0
uni_shift_cache:
 move.l (a1)+,(a0)+
 dbra d0,uni_shift_cache
 move.w uni_copy_index,d0
 mulu.w #448,d0
 lea asm_clouds,a0
 adda.l d0,a0
 lea 448(a0),a1
 moveq #111,d0
uni_shift_cloud:
 move.l (a1)+,(a0)+
 dbra d0,uni_shift_cloud
 addq.w #1,uni_copy_index
 bra uni_shift_blocks
uni_clear_tail:
 move.w uni_copy_index,d0
 mulu.w #36,d0
 lea asm_vectors,a0
 adda.l d0,a0
 moveq #8,d0
uni_clear_inwk:
 clr.l (a0)+
 dbra d0,uni_clear_inwk
 move.b #160,-5(a0)
 move.w uni_copy_index,d0
 mulu.w #272,d0
 lea asm_ships,a0
 adda.l d0,a0
 clr.w 12(a0)
 move.w #1,14(a0)
 move.w uni_copy_index,d0
 mulu.w #448,d0
 lea asm_clouds,a0
 adda.l d0,a0
 moveq #111,d0
uni_clear_cloud:
 clr.l (a0)+
 dbra d0,uni_clear_cloud
 ; KS2 scans the compacted list, remapping missiles, including those already
 ; processed this frame. AI=0 makes a missile drift instead of exploding.
 moveq #1,d7
 lea asm_vectors,a4
uni_targets:
 cmp.w uni_state+14,d7
 bhs uni_remove_done
 lea uni_state,a0
 cmp.b #8,0(a0,d7.w)
 bne uni_target_next
 moveq #0,d0
 move.w uni_removed,d0
 addq.w #1,d0
 move.l d0,-(sp)
 moveq #0,d0
 move.b 32(a4),d0
 move.l d0,-(sp)
 jsr _universe_missile_target
 addq.l #8,sp
 move.b d0,32(a4)
uni_target_next:
 lea 36(a4),a4
 addq.w #1,d7
 bra uni_targets
uni_remove_station:
 clr.l asm_station
 lea asm_placeholder,a0
 moveq #35,d0
uni_station_zero:
 clr.b 0(a0,d0.w)
 dbra d0,uni_station_zero
 move.b #6,asm_placeholder+5
 move.b #160,asm_vectors+31
 clr.w asm_ships+12
 clr.w asm_clouds+56
 ; KS4 returns before KS2: no missile remapping on placeholder replacement.
uni_remove_done:
 movem.l (sp)+,d0-d7/a0-a6
 rts

; Optional QL cheat interface, explicitly outside Electron gameplay rules.
.sect .data
.align 2
cheat_active: .data2 0
cheat_old: .data2 0
cheat_row: .data2 0
cheat_title: .ascii "CHEAT MENU - QL EXTRAS\0"
cheat_help: .ascii "1-6 APPLY    0/ESC CLOSE\0"
cheat_note: .ascii "CHANGES CAN BE SAVED NORMALLY\0"
cheat_applied: .ascii "APPLIED\0"
cheat_1: .ascii "1  ADD 1000 CREDITS\0"
cheat_2: .ascii "2  REFILL MISSILES TO FOUR\0"
cheat_3: .ascii "3  FIT DOCKING COMPUTER\0"
cheat_4: .ascii "4  REPLENISH ENERGY BOMB\0"
cheat_5: .ascii "5  FIT ECM\0"
cheat_6: .ascii "6  FIT GALACTIC HYPERDRIVE\0"
.align 2
cheat_lines: .data4 cheat_1,cheat_2,cheat_3,cheat_4,cheat_5,cheat_6
.sect .text
cheat_poll:
 tst.w cheat_active
 bne cheat_keys
 moveq #6,d0
 bsr asm_keyrow
 and.w #32,d0
 move.w cheat_old,d1
 eor.w d0,d1
 move.w d0,cheat_old
 and.w d0,d1
 beq cheat_idle
 move.w #1,cheat_active
 move.w #1,flow_held
 bsr cheat_paint
 bra cheat_consumed
cheat_keys:
 bsr flow_read_key
 cmp.w #48,d0
 beq cheat_close
 cmp.w #27,d0
 beq menu_escape
 cmp.w #49,d0
 blo cheat_consumed
 cmp.w #54,d0
 bhi cheat_consumed
 sub.w #49,d0
 add.w d0,d0
 lea cheat_actions,a0
 move.w 0(a0,d0.w),d0
 jsr 0(a0,d0.w)
 bsr cheat_paint
 lea cheat_applied,a4
 move.w #152,d6
 bsr asm_text
 bra cheat_consumed
cheat_close:
 clr.w cheat_active
 move.w #32,cheat_old
 move.w #1,flow_release_gate
 bsr asm_clear_view
 tst.w asm_nav
 bne nav_redraw
 tst.w asm_page
 beq cheat_restore_shop
 bsr asm_commander_page
 bra cheat_restore_done
cheat_restore_shop:
 tst.w asm_shop
 beq cheat_restore_dock
 bsr asm_shop_page
 bra cheat_restore_done
cheat_restore_dock:
 tst.w asm_docked
 beq cheat_restore_flight
 bsr asm_market_page
 bra cheat_restore_done
cheat_restore_flight:
 bsr asm_restore_view
cheat_restore_done:
 bsr asm_draw_dials
cheat_consumed:
 moveq #1,d0
 rts
cheat_idle:
 moveq #0,d0
 rts
cheat_paint:
 bsr asm_clear_view
 lea cheat_title,a4
 moveq #16,d6
 bsr asm_text
 clr.w cheat_row
cheat_paint_loop:
 move.w cheat_row,d0
 lsl.w #2,d0
 lea cheat_lines,a0
 move.l 0(a0,d0.w),a4
 move.w cheat_row,d6
 mulu.w #16,d6
 add.w #40,d6
 bsr asm_text
 addq.w #1,cheat_row
 cmp.w #6,cheat_row
 blo cheat_paint_loop
 lea cheat_help,a4
 move.w #168,d6
 bsr asm_text
 lea cheat_note,a4
 move.w #180,d6
 bsr asm_text
 rts
cheat_actions:
 .data2 cheat_cash-cheat_actions,cheat_missiles-cheat_actions,cheat_computer-cheat_actions,cheat_bomb-cheat_actions,cheat_ecm-cheat_actions,cheat_drive-cheat_actions
cheat_cash:
 add.l #10000,asm_commander
 bcc cheat_cash_done
 move.l #-1,asm_commander
cheat_cash_done:
 rts
cheat_missiles:
 move.b #4,asm_player
 rts
cheat_computer:
 move.b #255,asm_equipment+4
 rts
cheat_bomb:
 ; Do not replace the negative countdown while a bomb is already active.
 tst.b asm_equipment+2
 bmi cheat_bomb_done
 move.b #127,asm_equipment+2
cheat_bomb_done:
 rts
cheat_ecm:
 move.b #255,asm_equipment
 rts
cheat_drive:
 move.b #255,asm_travel+10
 rts

; Esc from any normal menu returns to the station bay or cockpit.
; Release gating prevents the held key reaching the outer exit/restart action.
menu_escape:
 clr.w cheat_active
 clr.w flow_state
 clr.w asm_nav
 clr.w asm_chart
 clr.w asm_local_chart
 clr.w asm_shop
 clr.w asm_page
 move.w #1,flow_release_gate
 move.w #1,flow_held
 bsr asm_clear_view
 tst.w asm_docked
 beq menu_escape_cockpit
 bsr asm_market_page
 bra menu_escape_done
menu_escape_cockpit:
 bsr asm_restore_view
menu_escape_done:
 bsr asm_draw_dials
 moveq #1,d0
 rts
