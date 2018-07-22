
onerror {resume}
quietly WaveActivateNextPane {} 0
radix -hexadecimal

add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/reset_n
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/clock
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/sample
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/curr_lvl
add wave -noupdate -expand -group TB sim:/fir_subsystem_top_tb/duration
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
# add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/sample_dispatcher/next_sample
# add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/sample_dispatcher/lvl_duration_cnt_r
# add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/lvl_generator/curr_lvl_r
# add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/lvl_generator/next_lvl_r
# add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/lvl_generator/curr_upper_limit_r
# add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/lvl_generator/next_upper_limit_r
# add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/lvl_generator/curr_lower_limit_r
# add wave -noupdate -group SAMPLE2LVL_CONVERTER sim:/fir_subsystem_top_tb/DUT/sample2lvl_converter/lvl_generator/next_lower_limit_r

add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/reset
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/clock
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/sample2lvl_init
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/sample2lvl_valid
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/sample2lvl_ready
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/subcells_init
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/subcells_new_limits
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/subcells_valid_signal
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/subcells_input_enable
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/subcells_output_enable
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/subcells_ready
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/outctrl_enable
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/outctrl_iter_num
add wave -noupdate -group ITERATION_CTRL sim:/fir_subsystem_top_tb/DUT/iteration_ctrl/outctrl_ready

add wave -noupdate -group FIR_SUBCELL_0 {sim:/fir_subsystem_top_tb/DUT/_FOR_ITER[0]/fir_subcell/*}
add wave -noupdate -group FIR_SUBCELL_0_FIR {sim:/fir_subsystem_top_tb/DUT/_FOR_ITER[0]/fir_subcell/fir_filter/*}
add wave -noupdate -group FIR_SUBCELL_0_FIFO {sim:/fir_subsystem_top_tb/DUT/_FOR_ITER[0]/fir_subcell/limits_fifo/*}
add wave -noupdate -group FIR_SUBCELL_0_HL {sim:/fir_subsystem_top_tb/DUT/_FOR_ITER[0]/fir_subcell/hard_limiter/*}

# add wave -noupdate -group FIR_SUBCELL_1 {sim:/fir_subsystem_top_tb/DUT/_FOR_ITER[1]/fir_subcell/*}
# add wave -noupdate -group FIR_SUBCELL_1_FIR {sim:/fir_subsystem_top_tb/DUT/_FOR_ITER[1]/fir_subcell/fir_filter/*}
# add wave -noupdate -group FIR_SUBCELL_1_FIFO {sim:/fir_subsystem_top_tb/DUT/_FOR_ITER[1]/fir_subcell/limits_fifo/*}
# add wave -noupdate -group FIR_SUBCELL_1_HL {sim:/fir_subsystem_top_tb/DUT/_FOR_ITER[1]/fir_subcell/hard_limiter/*}

# add wave -noupdate -group FIR_SUBCELL_2 {sim:/fir_subsystem_top_tb/DUT/_FOR_ITER[2]/fir_subcell/*}
# add wave -noupdate -group FIR_SUBCELL_2_FIR {sim:/fir_subsystem_top_tb/DUT/_FOR_ITER[2]/fir_subcell/fir_filter/*}
# add wave -noupdate -group FIR_SUBCELL_2_FIFO {sim:/fir_subsystem_top_tb/DUT/_FOR_ITER[2]/fir_subcell/limits_fifo/*}
# add wave -noupdate -group FIR_SUBCELL_2_HL {sim:/fir_subsystem_top_tb/DUT/_FOR_ITER[2]/fir_subcell/hard_limiter/*}

add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/reset
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/clock
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/iter_enable
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/iter_iter_num
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/iter_ready
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/in_data
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/in_valid
add wave -noupdate -group OUTPUT_CTRL sim:/fir_subsystem_top_tb/DUT/output_ctrl/in_ready
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
