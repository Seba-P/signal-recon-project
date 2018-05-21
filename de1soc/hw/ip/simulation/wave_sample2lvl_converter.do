
onerror {resume}
quietly WaveActivateNextPane {} 0
radix -hexadecimal

add wave -noupdate -expand -group TB sim:/sample2lvl_converter_tb/reset
add wave -noupdate -expand -group TB sim:/sample2lvl_converter_tb/clock
add wave -noupdate -expand -group TB sim:/sample2lvl_converter_tb/sample
add wave -noupdate -expand -group TB sim:/sample2lvl_converter_tb/curr_lvl
add wave -noupdate -expand -group DUT_EXT_IN sim:/sample2lvl_converter_tb/DUT/in_data
add wave -noupdate -expand -group DUT_EXT_IN sim:/sample2lvl_converter_tb/DUT/in_valid
add wave -noupdate -expand -group DUT_EXT_IN sim:/sample2lvl_converter_tb/DUT/in_ready
add wave -noupdate -expand -group DUT_INT sim:/sample2lvl_converter_tb/DUT/lvl_gen_cross_dir
add wave -noupdate -expand -group DUT_INT sim:/sample2lvl_converter_tb/DUT/lvl_gen_new_sample
add wave -noupdate -expand -group DUT_INT sim:/sample2lvl_converter_tb/DUT/lvl_gen_valid
add wave -noupdate -expand -group DUT_EXT_OUT sim:/sample2lvl_converter_tb/DUT/out_value
add wave -noupdate -expand -group DUT_EXT_OUT sim:/sample2lvl_converter_tb/DUT/out_limits
add wave -noupdate -expand -group DUT_EXT_OUT sim:/sample2lvl_converter_tb/DUT/out_valid
add wave -noupdate -expand -group SAMPLE_DISPATCHER sim:/sample2lvl_converter_tb/DUT/sample_dispatcher_inst/next_sample
add wave -noupdate -expand -group SAMPLE_DISPATCHER sim:/sample2lvl_converter_tb/DUT/sample_dispatcher_inst/lvl_duration_cnt_r
add wave -noupdate -expand -group LVL_GENERATOR sim:/sample2lvl_converter_tb/DUT/lvl_generator_inst/curr_lvl_r


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
WaveRestoreZoom {0 ns} {100 ns}
