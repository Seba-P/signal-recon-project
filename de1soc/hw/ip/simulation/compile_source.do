# set QSYS_SIMDIR "./../../soc_system/simulation"
# source $QSYS_SIMDIR/mentor/msim_setup_modified.tcl

# com_src
# vlog -sv -work work ./../source/fir_subsystem_top.sv
# vlog -sv -work work ./../source/fir_subsystem_top_tb.sv

vlog -sv -work work ./../source/sample_dispatcher.sv
vlog -sv -work work ./../source/lvl_generator.sv
vlog -sv -work work ./../source/sample2lvl_converter.sv
vlog -sv -work work ./../source/iteration_ctrl.sv
vlog -sv -work work ./../source/limits_buffer_ctrl.sv
vlog -sv -work work ./../source/signal_buffer_ctrl.sv
vlog -sv -work work ./../source/fir_driver.sv
vlog -sv -work work ./../source/hard_limiter.sv
vlog -sv -work work ./../source/output_ctrl.sv

vlog -sv -work work ./../source/fir_subsystem_top.sv
vlog -sv -work work ./../source/fir_subsystem_top_tb.sv
