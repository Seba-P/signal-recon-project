
onerror {resume}
quietly WaveActivateNextPane {} 0
radix -hexadecimal

add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/reset_n
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/clock
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/sample
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/curr_lvl
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/curr_iter
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/total_duration
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/mm2st_data
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/mm2st_valid
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/mm2st_ready
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/st2mm_data
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/st2mm_valid
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/st2mm_ready

add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/reset
add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/clock
add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/in_data
add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/in_valid
add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/in_ready
add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/iter_valid
add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/iter_ready
add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/out_lvl_data
add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/out_lvl_valid
add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/out_limits_data
add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/out_limits_valid
#add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/sample_dispatcher_inst/next_sample
#add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/sample_dispatcher_inst/lvl_duration_cnt_r
#add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/lvl_generator_inst/curr_lvl_r

add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/reset
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/clock
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/lvl_gen_data
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/lvl_gen_valid
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/limiter_data
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/limiter_valid
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/limiter_ready
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/iter_iter_num
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/iter_symbol_num
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/iter_init
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/iter_input_mux
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/iter_input_enable
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/iter_output_enable
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/iter_ready
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/fir_driver_data
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/fir_driver_valid
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/fir_driver_ready
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_address_a
#add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_chipselect_a
#add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_read_a
#add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_readdata_a
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_write_a
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_writedata_a
#add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_byteenable_a
# add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_waitrequest_a
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/iter_num_r
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/pipeline_init_r
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/symbol_cnt_r
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/buffer_end
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_address_b
#add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_chipselect_b
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_read_b
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_readdata_b
#add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_write_b
#add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_writedata_b
#add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_byteenable_b
# add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/ram_signal_waitrequest_b
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/symbol_cnt_int_r
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/intbuff_end
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/intbuff_wren_r
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/intbuff_data_r
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/intbuff_wraddress_r
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/intbuff_rdaddress_r
add wave -noupdate -group SIGNAL_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/signal_buffer_ctrl/intbuff_q

add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/reset
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/clock
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/lvl_gen_data
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/lvl_gen_valid
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/iter_symbol_num
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/iter_init
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/iter_input_enable
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/iter_output_enable
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/iter_ready
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/limiter_data
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/limiter_valid
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_address_a
#add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_chipselect_a
#add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_read_a
#add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_readdata_a
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_write_a
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_writedata_a
#add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_byteenable_a
# add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_waitrequest_a
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/iter_num_r
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/pipeline_init_r
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/symbol_cnt_r
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/buffer_end
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/fir_taps_half
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/fir_taps_head_r
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/fir_taps_tail_r
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ping_pong_a_r
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ping_pong_b_r
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_address_b
#add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_chipselect_b
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_read_b
add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_readdata_b
#add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_write_b
#add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_writedata_b
#add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_byteenable_b
# add wave -noupdate -group LIMITS_BUFFER_CTRL sim:/fir_subsystem_top_tb/DUT/limits_buffer_ctrl/ram_limits_waitrequest_b

add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/reset
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/clock
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/lvl_gen_init
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/lvl_gen_valid
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/lvl_gen_ready
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/sigbuff_iter_num
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/sigbuff_symbol_num
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/sigbuff_init
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/sigbuff_input_mux
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/sigbuff_input_enable
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/sigbuff_output_enable
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/sigbuff_ready
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/limbuff_symbol_num
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/limbuff_init
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/limbuff_input_enable
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/limbuff_output_enable
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/limbuff_ready
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/fir_input_mux
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/fir_input_enable
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/fir_ready
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/fir_data_passed
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/limiter_input_enable
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/limiter_ready
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/out_ctrl_output_enable
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/out_ctrl_ready
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/state_r
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/iter_symbol_cnt_r
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/iter_symbol_inc_r
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/fir_taps_half
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/fir_taps_head_r
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/fir_taps_tail_r
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/curr_iter_r
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/curr_iter_end
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/pipeline_prep_r
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/buffs_prep_r
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/buffers_ready
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/first_iter
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/last_iter

add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/reset
add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/clock
add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/lvl_gen_data
add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/lvl_gen_valid
add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/sigbuff_data
add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/sigbuff_valid
add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/sigbuff_ready
add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/iter_input_mux
add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/iter_input_enable
add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/iter_ready
add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/iter_data_passed
add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/fir_data
add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/fir_valid
add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/fir_error
add wave -noupdate -group FIR_DRIVER sim:/fir_subsystem_top_tb/DUT/fir_driver/fir_ready

add wave -noupdate -group HARD_LIMITER sim:/fir_subsystem_top_tb/DUT/hard_limiter/reset
add wave -noupdate -group HARD_LIMITER sim:/fir_subsystem_top_tb/DUT/hard_limiter/clock
add wave -noupdate -group HARD_LIMITER sim:/fir_subsystem_top_tb/DUT/hard_limiter/limbuff_data
add wave -noupdate -group HARD_LIMITER sim:/fir_subsystem_top_tb/DUT/hard_limiter/limbuff_valid
add wave -noupdate -group HARD_LIMITER sim:/fir_subsystem_top_tb/DUT/hard_limiter/iter_input_enable
add wave -noupdate -group HARD_LIMITER sim:/fir_subsystem_top_tb/DUT/hard_limiter/iter_ready
add wave -noupdate -group HARD_LIMITER sim:/fir_subsystem_top_tb/DUT/hard_limiter/fir_data
add wave -noupdate -group HARD_LIMITER sim:/fir_subsystem_top_tb/DUT/hard_limiter/fir_valid
add wave -noupdate -group HARD_LIMITER sim:/fir_subsystem_top_tb/DUT/hard_limiter/fir_error
add wave -noupdate -group HARD_LIMITER sim:/fir_subsystem_top_tb/DUT/hard_limiter/fir_ready
add wave -noupdate -group HARD_LIMITER sim:/fir_subsystem_top_tb/DUT/hard_limiter/out_data
add wave -noupdate -group HARD_LIMITER sim:/fir_subsystem_top_tb/DUT/hard_limiter/out_valid
add wave -noupdate -group HARD_LIMITER sim:/fir_subsystem_top_tb/DUT/hard_limiter/out_ready
add wave -noupdate -group HARD_LIMITER sim:/fir_subsystem_top_tb/DUT/hard_limiter/signal_case

add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/reset
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/clock
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/limiter_data
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/limiter_valid
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/limiter_ready
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/iter_output_enable
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/iter_ready
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/out_data
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/out_valid
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/out_ready

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
# WaveRestoreZoom {0 ns} {20000 ns}
