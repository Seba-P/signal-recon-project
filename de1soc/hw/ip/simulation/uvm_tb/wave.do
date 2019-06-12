
onerror {resume}
quietly WaveActivateNextPane {} 0
radix -hexadecimal

add wave -noupdate -expand -group TB sim:/dut_top/reset
add wave -noupdate -expand -group TB sim:/dut_top/clock
add wave -noupdate -group TB -expand -group CSR_IF sim:/dut_top/m_dut_if/csr_address
add wave -noupdate -group TB -expand -group CSR_IF sim:/dut_top/m_dut_if/csr_byteenable
add wave -noupdate -group TB -expand -group CSR_IF sim:/dut_top/m_dut_if/csr_read
add wave -noupdate -group TB -expand -group CSR_IF sim:/dut_top/m_dut_if/csr_readdata
add wave -noupdate -group TB -expand -group CSR_IF sim:/dut_top/m_dut_if/csr_response
add wave -noupdate -group TB -expand -group CSR_IF sim:/dut_top/m_dut_if/csr_write
add wave -noupdate -group TB -expand -group CSR_IF sim:/dut_top/m_dut_if/csr_writedata
add wave -noupdate -group TB -expand -group CSR_IF sim:/dut_top/m_dut_if/csr_waitrequest
add wave -noupdate -group TB -expand -group MM2ST_IF sim:/dut_top/mm2st_if/data
add wave -noupdate -group TB -expand -group MM2ST_IF sim:/dut_top/mm2st_if/valid
add wave -noupdate -group TB -expand -group MM2ST_IF sim:/dut_top/mm2st_if/ready
add wave -noupdate -group TB -expand -group ST2MM_IF sim:/dut_top/st2mm_if/data
add wave -noupdate -group TB -expand -group ST2MM_IF sim:/dut_top/st2mm_if/valid
add wave -noupdate -group TB -expand -group ST2MM_IF sim:/dut_top/st2mm_if/ready

add wave -noupdate -group REGISTER_FILE sim:/dut_top/DUT/DUT/register_file/reset
add wave -noupdate -group REGISTER_FILE sim:/dut_top/DUT/DUT/register_file/clock
add wave -noupdate -group REGISTER_FILE -expand -group CSR_IF sim:/dut_top/DUT/DUT/register_file/csr_address
add wave -noupdate -group REGISTER_FILE -expand -group CSR_IF sim:/dut_top/DUT/DUT/register_file/csr_byteenable
add wave -noupdate -group REGISTER_FILE -expand -group CSR_IF sim:/dut_top/DUT/DUT/register_file/csr_read
add wave -noupdate -group REGISTER_FILE -expand -group CSR_IF sim:/dut_top/DUT/DUT/register_file/csr_readdata
add wave -noupdate -group REGISTER_FILE -expand -group CSR_IF sim:/dut_top/DUT/DUT/register_file/csr_response
add wave -noupdate -group REGISTER_FILE -expand -group CSR_IF sim:/dut_top/DUT/DUT/register_file/csr_write
add wave -noupdate -group REGISTER_FILE -expand -group CSR_IF sim:/dut_top/DUT/DUT/register_file/csr_writedata
add wave -noupdate -group REGISTER_FILE -expand -group CSR_IF sim:/dut_top/DUT/DUT/register_file/csr_waitrequest
add wave -noupdate -group REGISTER_FILE -group REG_STATUS_IF sim:/dut_top/DUT/DUT/register_file/reg_status_busy
add wave -noupdate -group REGISTER_FILE -group REG_STATUS_IF sim:/dut_top/DUT/DUT/register_file/reg_status_ready
add wave -noupdate -group REGISTER_FILE -group REG_STATUS_IF sim:/dut_top/DUT/DUT/register_file/reg_status_error
add wave -noupdate -group REGISTER_FILE -group REG_STATUS_IF sim:/dut_top/DUT/DUT/register_file/reg_status_fifo_err
add wave -noupdate -group REGISTER_FILE -group REG_CONTROL_IF sim:/dut_top/DUT/DUT/register_file/reg_control_run
add wave -noupdate -group REGISTER_FILE -group REG_CONTROL_IF sim:/dut_top/DUT/DUT/register_file/reg_control_halt
add wave -noupdate -group REGISTER_FILE -group REG_CONTROL_IF sim:/dut_top/DUT/DUT/register_file/reg_control_flush
add wave -noupdate -group REGISTER_FILE -group REG_CONTROL_IF sim:/dut_top/DUT/DUT/register_file/reg_control_init
add wave -noupdate -group REGISTER_FILE -group REG_PARAMS_IF sim:/dut_top/DUT/DUT/register_file/reg_params_lvls_num
add wave -noupdate -group REGISTER_FILE -group REG_PARAMS_IF sim:/dut_top/DUT/DUT/register_file/reg_params_init_lvl
add wave -noupdate -group REGISTER_FILE -group REG_PARAMS_IF sim:/dut_top/DUT/DUT/register_file/reg_params_iter_num
add wave -noupdate -group REGISTER_FILE -group REG_PARAMS_IF sim:/dut_top/DUT/DUT/register_file/reg_lvl_val_xx_yy
add wave -noupdate -group REGISTER_FILE -expand -group __INTERNALS__ -expand sim:/dut_top/DUT/DUT/register_file/csr_reg_block

add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER sim:/dut_top/DUT/DUT/sample2signal_converter/reset
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER sim:/dut_top/DUT/DUT/sample2signal_converter/clock
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group PARAMS_IF sim:/dut_top/DUT/DUT/sample2signal_converter/params_lvls_num
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group PARAMS_IF sim:/dut_top/DUT/DUT/sample2signal_converter/params_init_lvl
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group PARAMS_IF sim:/dut_top/DUT/DUT/sample2signal_converter/params_init_guess
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group PARAMS_IF sim:/dut_top/DUT/DUT/sample2signal_converter/params_lvls_values
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -expand -group IN_IF sim:/dut_top/DUT/DUT/sample2signal_converter/in_data
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -expand -group IN_IF sim:/dut_top/DUT/DUT/sample2signal_converter/in_valid
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -expand -group IN_IF sim:/dut_top/DUT/DUT/sample2signal_converter/in_ready
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -expand -group ITER_IF sim:/dut_top/DUT/DUT/sample2signal_converter/iter_init
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -expand -group ITER_IF sim:/dut_top/DUT/DUT/sample2signal_converter/iter_valid
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -expand -group ITER_IF sim:/dut_top/DUT/DUT/sample2signal_converter/iter_ready
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -expand -group OUT_SIGNAL_IF sim:/dut_top/DUT/DUT/sample2signal_converter/out_signal_data
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -expand -group OUT_SIGNAL_IF sim:/dut_top/DUT/DUT/sample2signal_converter/out_signal_valid
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -expand -group OUT_LIMITS_IF sim:/dut_top/DUT/DUT/sample2signal_converter/out_limits_data
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -expand -group OUT_LIMITS_IF sim:/dut_top/DUT/DUT/sample2signal_converter/out_limits_valid
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/new_sample
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/sample_done
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/sample_duration_r
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/points_left_cnt_r
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/curr_half_r
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/curr_lvl_r
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/next_lvl_r
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/overflow_r
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/underflow_r
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/upper_limit_r
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/lower_limit_r
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/constant_guess_value_r
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/constant_guess_value_del_r
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/linear_guess_value_r
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/linear_guess_value_del_r
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/linear_step_r
add wave -noupdate -group SAMPLE2SIGNAL_CONVERTER -group __INTERNALS__ sim:/dut_top/DUT/DUT/sample2signal_converter/signal_generator/half_step_dir_r

add wave -noupdate -group ITERATION_CTRL sim:/dut_top/DUT/DUT/iteration_ctrl/reset
add wave -noupdate -group ITERATION_CTRL sim:/dut_top/DUT/DUT/iteration_ctrl/clock
add wave -noupdate -group ITERATION_CTRL -group REGFILE_IF sim:/dut_top/DUT/DUT/iteration_ctrl/regfile_busy
add wave -noupdate -group ITERATION_CTRL -group REGFILE_IF sim:/dut_top/DUT/DUT/iteration_ctrl/regfile_ready
add wave -noupdate -group ITERATION_CTRL -group REGFILE_IF sim:/dut_top/DUT/DUT/iteration_ctrl/regfile_error
add wave -noupdate -group ITERATION_CTRL -group REGFILE_IF sim:/dut_top/DUT/DUT/iteration_ctrl/regfile_fifo_err
add wave -noupdate -group ITERATION_CTRL -group REGFILE_IF sim:/dut_top/DUT/DUT/iteration_ctrl/regfile_run
add wave -noupdate -group ITERATION_CTRL -group REGFILE_IF sim:/dut_top/DUT/DUT/iteration_ctrl/regfile_halt
add wave -noupdate -group ITERATION_CTRL -group REGFILE_IF sim:/dut_top/DUT/DUT/iteration_ctrl/regfile_flush
add wave -noupdate -group ITERATION_CTRL -group REGFILE_IF sim:/dut_top/DUT/DUT/iteration_ctrl/regfile_init
add wave -noupdate -group ITERATION_CTRL -group REGFILE_IF sim:/dut_top/DUT/DUT/iteration_ctrl/regfile_iter_num
add wave -noupdate -group ITERATION_CTRL -expand -group sample2signal_IF sim:/dut_top/DUT/DUT/iteration_ctrl/sample2signal_init
add wave -noupdate -group ITERATION_CTRL -expand -group sample2signal_IF sim:/dut_top/DUT/DUT/iteration_ctrl/sample2signal_valid
add wave -noupdate -group ITERATION_CTRL -expand -group sample2signal_IF sim:/dut_top/DUT/DUT/iteration_ctrl/sample2signal_ready
add wave -noupdate -group ITERATION_CTRL -expand -group SUBCELLS_IF sim:/dut_top/DUT/DUT/iteration_ctrl/subcells_init
add wave -noupdate -group ITERATION_CTRL -expand -group SUBCELLS_IF sim:/dut_top/DUT/DUT/iteration_ctrl/subcells_new_limits
add wave -noupdate -group ITERATION_CTRL -expand -group SUBCELLS_IF sim:/dut_top/DUT/DUT/iteration_ctrl/subcells_valid_signal
add wave -noupdate -group ITERATION_CTRL -expand -group SUBCELLS_IF sim:/dut_top/DUT/DUT/iteration_ctrl/subcells_input_enable
add wave -noupdate -group ITERATION_CTRL -expand -group SUBCELLS_IF sim:/dut_top/DUT/DUT/iteration_ctrl/subcells_output_enable
add wave -noupdate -group ITERATION_CTRL -expand -group SUBCELLS_IF sim:/dut_top/DUT/DUT/iteration_ctrl/subcells_ready
add wave -noupdate -group ITERATION_CTRL -expand -group OUTCTRL_IF sim:/dut_top/DUT/DUT/iteration_ctrl/outctrl_enable
add wave -noupdate -group ITERATION_CTRL -expand -group OUTCTRL_IF sim:/dut_top/DUT/DUT/iteration_ctrl/outctrl_iter_num
add wave -noupdate -group ITERATION_CTRL -expand -group OUTCTRL_IF sim:/dut_top/DUT/DUT/iteration_ctrl/outctrl_ready
add wave -noupdate -group ITERATION_CTRL -group __INTERNALS__ sim:/dut_top/DUT/DUT/iteration_ctrl/iter_start_r
add wave -noupdate -group ITERATION_CTRL -group __INTERNALS__ sim:/dut_top/DUT/DUT/iteration_ctrl/iter_symbol_cnt_r
add wave -noupdate -group ITERATION_CTRL -group __INTERNALS__ sim:/dut_top/DUT/DUT/iteration_ctrl/iter_valid_signal_r
add wave -noupdate -group ITERATION_CTRL -group __INTERNALS__ sim:/dut_top/DUT/DUT/iteration_ctrl/pipeline_stall
add wave -noupdate -group ITERATION_CTRL -group __INTERNALS__ sim:/dut_top/DUT/DUT/iteration_ctrl/is_active_r

add wave -noupdate -group POCS_SUBCELL_0 -expand -group FIR_FILTER {sim:/dut_top/DUT/DUT/_FOR_ITER[0]/pocs_subcell/fir_filter/*}
add wave -noupdate -group POCS_SUBCELL_0 -expand -group LIMITS_FIFO {sim:/dut_top/DUT/DUT/_FOR_ITER[0]/pocs_subcell/limits_fifo/*}
add wave -noupdate -group POCS_SUBCELL_0 -expand -group HARD_LIMITER {sim:/dut_top/DUT/DUT/_FOR_ITER[0]/pocs_subcell/hard_limiter/*}

add wave -noupdate -group POCS_SUBCELL_1 -expand -group FIR_FILTER {sim:/dut_top/DUT/DUT/_FOR_ITER[1]/pocs_subcell/fir_filter/*}
add wave -noupdate -group POCS_SUBCELL_1 -expand -group LIMITS_FIFO {sim:/dut_top/DUT/DUT/_FOR_ITER[1]/pocs_subcell/limits_fifo/*}
add wave -noupdate -group POCS_SUBCELL_1 -expand -group HARD_LIMITER {sim:/dut_top/DUT/DUT/_FOR_ITER[1]/pocs_subcell/hard_limiter/*}

add wave -noupdate -group POCS_SUBCELL_2 -expand -group FIR_FILTER {sim:/dut_top/DUT/DUT/_FOR_ITER[2]/pocs_subcell/fir_filter/*}
add wave -noupdate -group POCS_SUBCELL_2 -expand -group LIMITS_FIFO {sim:/dut_top/DUT/DUT/_FOR_ITER[2]/pocs_subcell/limits_fifo/*}
add wave -noupdate -group POCS_SUBCELL_2 -expand -group HARD_LIMITER {sim:/dut_top/DUT/DUT/_FOR_ITER[2]/pocs_subcell/hard_limiter/*}

add wave -noupdate -group POCS_SUBCELL_3 -expand -group FIR_FILTER {sim:/dut_top/DUT/DUT/_FOR_ITER[3]/pocs_subcell/fir_filter/*}
add wave -noupdate -group POCS_SUBCELL_3 -expand -group LIMITS_FIFO {sim:/dut_top/DUT/DUT/_FOR_ITER[3]/pocs_subcell/limits_fifo/*}
add wave -noupdate -group POCS_SUBCELL_3 -expand -group HARD_LIMITER {sim:/dut_top/DUT/DUT/_FOR_ITER[3]/pocs_subcell/hard_limiter/*}

add wave -noupdate -group POCS_SUBCELL_4 -expand -group FIR_FILTER {sim:/dut_top/DUT/DUT/_FOR_ITER[4]/pocs_subcell/fir_filter/*}
add wave -noupdate -group POCS_SUBCELL_4 -expand -group LIMITS_FIFO {sim:/dut_top/DUT/DUT/_FOR_ITER[4]/pocs_subcell/limits_fifo/*}
add wave -noupdate -group POCS_SUBCELL_4 -expand -group HARD_LIMITER {sim:/dut_top/DUT/DUT/_FOR_ITER[4]/pocs_subcell/hard_limiter/*}

add wave -noupdate -group POCS_SUBCELL_5 -expand -group FIR_FILTER {sim:/dut_top/DUT/DUT/_FOR_ITER[5]/pocs_subcell/fir_filter/*}
add wave -noupdate -group POCS_SUBCELL_5 -expand -group LIMITS_FIFO {sim:/dut_top/DUT/DUT/_FOR_ITER[5]/pocs_subcell/limits_fifo/*}
add wave -noupdate -group POCS_SUBCELL_5 -expand -group HARD_LIMITER {sim:/dut_top/DUT/DUT/_FOR_ITER[5]/pocs_subcell/hard_limiter/*}

add wave -noupdate -group OUTPUT_CTRL sim:/dut_top/DUT/DUT/output_ctrl/reset
add wave -noupdate -group OUTPUT_CTRL sim:/dut_top/DUT/DUT/output_ctrl/clock
add wave -noupdate -group OUTPUT_CTRL -expand -group ITER_IF sim:/dut_top/DUT/DUT/output_ctrl/iter_enable
add wave -noupdate -group OUTPUT_CTRL -expand -group ITER_IF sim:/dut_top/DUT/DUT/output_ctrl/iter_iter_num
add wave -noupdate -group OUTPUT_CTRL -expand -group ITER_IF sim:/dut_top/DUT/DUT/output_ctrl/iter_ready
add wave -noupdate -group OUTPUT_CTRL -expand -group IN_IF sim:/dut_top/DUT/DUT/output_ctrl/in_data
add wave -noupdate -group OUTPUT_CTRL -expand -group IN_IF sim:/dut_top/DUT/DUT/output_ctrl/in_valid
add wave -noupdate -group OUTPUT_CTRL -expand -group IN_IF sim:/dut_top/DUT/DUT/output_ctrl/in_ready
add wave -noupdate -group OUTPUT_CTRL -expand -group OUT_IF sim:/dut_top/DUT/DUT/output_ctrl/out_data
add wave -noupdate -group OUTPUT_CTRL -expand -group OUT_IF sim:/dut_top/DUT/DUT/output_ctrl/out_valid
add wave -noupdate -group OUTPUT_CTRL -expand -group OUT_IF sim:/dut_top/DUT/DUT/output_ctrl/out_ready

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
