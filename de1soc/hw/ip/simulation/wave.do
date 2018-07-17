
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
