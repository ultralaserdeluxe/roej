onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /roej_tb/clk
add wave -noupdate -format Logic /roej_tb/rst
add wave -noupdate -format Logic /roej_tb/tb_running
add wave -noupdate -format Logic /roej_tb/roej_out/clk
add wave -noupdate -format Logic /roej_tb/roej_out/rst
add wave -noupdate -format Literal /roej_tb/roej_out/vgared
add wave -noupdate -format Literal /roej_tb/roej_out/vgagreen
add wave -noupdate -format Literal /roej_tb/roej_out/vgablue
add wave -noupdate -format Logic /roej_tb/roej_out/hsync
add wave -noupdate -format Logic /roej_tb/roej_out/vsync
add wave -noupdate -format Literal /roej_tb/roej_out/adr_bus_connect
add wave -noupdate -expand -group {New Group} -format Literal /roej_tb/roej_out/data_bus_out_connect
add wave -noupdate -expand -group {New Group} -format Literal /roej_tb/roej_out/data_bus_in_connect
add wave -noupdate -expand -group {New Group} -format Literal /roej_tb/roej_out/mem_address
add wave -noupdate -expand -group {New Group} -format Logic /roej_tb/roej_out/write_enable_gpu
add wave -noupdate -expand -group {New Group} -format Literal /roej_tb/roej_out/gpu_address
add wave -noupdate -expand -group {New Group} -format Logic /roej_tb/roej_out/write_enable_mem
add wave -noupdate -expand -group {New Group} -format Literal -radix unsigned /roej_tb/roej_out/cpu_comp/adr/reg_value
add wave -noupdate -expand -group {New Group} -format Literal -radix unsigned /roej_tb/roej_out/cpu_comp/pc/reg_value
add wave -noupdate -expand -group {New Group} -format Literal -radix unsigned /roej_tb/roej_out/cpu_comp/xr/reg_value
add wave -noupdate -expand -group {New Group} -format Literal -radix unsigned /roej_tb/roej_out/cpu_comp/sp/reg_value
add wave -noupdate -expand -group {New Group} -format Literal /roej_tb/roej_out/cpu_comp/dr/reg_value
add wave -noupdate -expand -group {New Group} -format Literal /roej_tb/roej_out/cpu_comp/tr/reg_value
add wave -noupdate -expand -group {New Group} -format Literal /roej_tb/roej_out/cpu_comp/ar/reg_value
add wave -noupdate -expand -group {New Group} -format Literal /roej_tb/roej_out/cpu_comp/sr/reg_value
add wave -noupdate -expand -group {New Group} -format Literal -radix unsigned /roej_tb/roej_out/cpu_comp/mpc/reg_value
add wave -noupdate -expand -group {New Group} -format Literal /roej_tb/roej_out/cpu_comp/helpr/reg_value
add wave -noupdate -expand -group {New Group} -format Literal /roej_tb/roej_out/cpu_comp/ir/reg_value
add wave -noupdate -expand -group {New Group} -format Literal /roej_tb/roej_out/cpu_comp/mm/mm_out
add wave -noupdate -format Logic /roej_tb/roej_out/read_signal_connect
add wave -noupdate -format Logic /roej_tb/roej_out/write_signal_connect
add wave -noupdate -format Literal /roej_tb/roej_out/memory_connect
add wave -noupdate -format Literal /roej_tb/roej_out/sprite_x_pos
add wave -noupdate -format Literal /roej_tb/roej_out/sprite_y_pos
add wave -noupdate -format Literal /roej_tb/roej_out/prng_value
add wave -noupdate -format Literal /roej_tb/roej_out/single_value
add wave -noupdate -format Literal /roej_tb/roej_out/ten_value
add wave -noupdate -format Literal /roej_tb/roej_out/hundred_value
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/clk
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/rst
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/adr_bus
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/data_bus_out
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/data_bus_in
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/read_signal
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/write_signal
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_1
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/adr_conc
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_14
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_13
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_18
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_19
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_20
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_21
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_24
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_6
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_7
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/dr_load_connect
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_25
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_26
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_33
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_37
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_36
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/mpc_load_connect
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/mpc_reset
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_38
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_39
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_27
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/alu_logic_signal
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/ar_connect
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/sr_connect
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/ar_load
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_signal
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/bus_signal
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm_8
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/ir_out
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/k1_in_connect
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/k1_out_connect
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/k2_in_connect
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/k2_out_connect
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mpc_connect
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/pc_connect
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/pc_load_signal
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/dr_input
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/adr/clk
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/adr/rst
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/adr/load
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/adr/inc
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/adr/dec
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/adr/input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/adr/output
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/pc/clk
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/pc/rst
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/pc/load
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/pc/inc
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/pc/dec
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/pc/input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/pc/output
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/xr/clk
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/xr/rst
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/xr/load
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/xr/inc
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/xr/dec
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/xr/input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/xr/output
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/sp/clk
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/sp/rst
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/sp/load
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/sp/inc
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/sp/dec
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/sp/input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/sp/output
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/dr/clk
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/dr/rst
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/dr/load
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/dr/double_read_signal
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/dr/input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/dr/output
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/tr/clk
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/tr/rst
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/tr/load
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/tr/inc
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/tr/dec
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/tr/input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/tr/output
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/ar/clk
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/ar/rst
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/ar/load
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/ar/inc
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/ar/dec
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/ar/input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/ar/output
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/sr/clk
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/sr/rst
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/sr/load
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/sr/inc
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/sr/dec
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/sr/input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/sr/output
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/mpc/clk
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/mpc/rst
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/mpc/load
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/mpc/inc
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/mpc/dec
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mpc/input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mpc/output
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/helpr/clk
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/helpr/rst
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/helpr/load
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/helpr/inc
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/helpr/dec
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/helpr/input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/helpr/output
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/ir/clk
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/ir/rst
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/ir/load
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/ir/inc
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/ir/dec
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/ir/input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/ir/output
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/alu_comp/input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/alu_comp/ar_in
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/alu_comp/ar_out
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/alu_comp/alu_logic
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/alu_comp/subinput
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm/mpc_in
add wave -noupdate -format Logic /roej_tb/roej_out/cpu_comp/mm/clk
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/mm/micromem
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/k1_comp/k1_in
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/k1_comp/k1_out
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/k2_comp/k2_in
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/k2_comp/k2_out
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/k3_comp/mm_signal
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/k3_comp/input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/k3_comp/k3_out
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/k3_comp/sr_input
add wave -noupdate -format Literal /roej_tb/roej_out/cpu_comp/k3_comp/pc_input
add wave -noupdate -format Logic /roej_tb/roej_out/primmem_comp/clk
add wave -noupdate -format Literal /roej_tb/roej_out/primmem_comp/adr_bus
add wave -noupdate -format Literal /roej_tb/roej_out/primmem_comp/data_bus_in
add wave -noupdate -format Literal /roej_tb/roej_out/primmem_comp/data_bus_out
add wave -noupdate -format Logic /roej_tb/roej_out/primmem_comp/read_signal
add wave -noupdate -format Logic /roej_tb/roej_out/primmem_comp/write_signal
add wave -noupdate -format Literal /roej_tb/roej_out/primmem_comp/primmem
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/clk
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/rst
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/vgared
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/vgagreen
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/vgablue
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/hsync
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/vsync
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/address
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/data_in
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/w_enable
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_x_pos
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_y_pos
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/pixel_counter_value
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/pixel_clk
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/x_value
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/x_reset
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/x_enable
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/y_value
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/y_reset
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/y_enable
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/h_sync
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/v_sync
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/display_valid
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/mapmem_data_a_out
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/tilemem_data_out
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/tilemem_col
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/tilemem_row
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/tilemem_x
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/tilemem_y
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_rgb_out
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/pixel_counter/clk
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/pixel_counter/reset
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/pixel_counter/enable
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/pixel_counter/value
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/pixel_counter/count
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/x_counter/clk
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/x_counter/reset
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/x_counter/enable
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/x_counter/value
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/x_counter/count
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/y_counter/clk
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/y_counter/reset
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/y_counter/enable
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/y_counter/value
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/y_counter/count
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/map_memory/clk
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/map_memory/addr_a_row
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/map_memory/addr_a_col
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/map_memory/data_a_out
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/map_memory/address
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/map_memory/data_a_in
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/map_memory/w_enable
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/map_memory/mapmem
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/tile_memory/clk
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/tile_memory/row_base
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/tile_memory/row_offset
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/tile_memory/col_base
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/tile_memory/col_offset
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/tile_memory/data_out
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/tile_memory/tilemem
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/tile_memory/row
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/tile_memory/col
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/sprite_unit/clk
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/sprite_unit/pixel_clk
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/sprite_unit/rst
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_unit/pixel_x_pos
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_unit/pixel_y_pos
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_unit/rgb_in
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_unit/rgb_out
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_x_pos
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_y_pos
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_x_cnt
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_y_cnt
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/sprite_unit/display_x
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/sprite_unit/display_y
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/sprite_unit/display_sprite
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/sprite_unit/x_cnt_enable
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/sprite_unit/y_cnt_enable
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_unit/spritemem
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_rgb
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_x_counter/clk
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_x_counter/reset
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_x_counter/enable
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_x_counter/value
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_x_counter/count
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_y_counter/clk
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_y_counter/reset
add wave -noupdate -format Logic /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_y_counter/enable
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_y_counter/value
add wave -noupdate -format Literal /roej_tb/roej_out/gpu_comp/sprite_unit/sprite_y_counter/count
add wave -noupdate -format Logic /roej_tb/roej_out/prng_comp/clk
add wave -noupdate -format Logic /roej_tb/roej_out/prng_comp/rst
add wave -noupdate -format Literal /roej_tb/roej_out/prng_comp/value
add wave -noupdate -format Literal /roej_tb/roej_out/prng_comp/counter_value
add wave -noupdate -format Literal /roej_tb/roej_out/prng_comp/reg_value
add wave -noupdate -format Logic /roej_tb/roej_out/prng_comp/cnt/clk
add wave -noupdate -format Logic /roej_tb/roej_out/prng_comp/cnt/reset
add wave -noupdate -format Logic /roej_tb/roej_out/prng_comp/cnt/enable
add wave -noupdate -format Literal /roej_tb/roej_out/prng_comp/cnt/value
add wave -noupdate -format Literal /roej_tb/roej_out/prng_comp/cnt/count
add wave -noupdate -format Logic /roej_tb/roej_out/timer/clk
add wave -noupdate -format Logic /roej_tb/roej_out/timer/reset
add wave -noupdate -format Logic /roej_tb/roej_out/timer/enable
add wave -noupdate -format Literal /roej_tb/roej_out/timer/single_out
add wave -noupdate -format Literal /roej_tb/roej_out/timer/ten_out
add wave -noupdate -format Literal /roej_tb/roej_out/timer/hundred_out
add wave -noupdate -format Logic /roej_tb/roej_out/timer/single_reset
add wave -noupdate -format Logic /roej_tb/roej_out/timer/ten_reset
add wave -noupdate -format Logic /roej_tb/roej_out/timer/hundred_reset
add wave -noupdate -format Logic /roej_tb/roej_out/timer/clock_reset
add wave -noupdate -format Literal /roej_tb/roej_out/timer/clock_value
add wave -noupdate -format Literal /roej_tb/roej_out/timer/single_value
add wave -noupdate -format Literal /roej_tb/roej_out/timer/ten_value
add wave -noupdate -format Literal /roej_tb/roej_out/timer/hundred_value
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
configure wave -namecolwidth 346
configure wave -valuecolwidth 198
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {788 ns}
