
onerror {resume}
quietly WaveActivateNextPane {} 0
radix -hexadecimal

add wave -noupdate -expand -group TB sim:/sample2lvl_converter_tb/reset
add wave -noupdate -expand -group TB sim:/sample2lvl_converter_tb/clock
add wave -noupdate -expand -group TB sim:/sample2lvl_converter_tb/sample
add wave -noupdate -expand -group TB sim:/sample2lvl_converter_tb/curr_lvl
add wave -noupdate -expand -group SGDMA_IF sim:/sample2lvl_converter_tb/DUT/in_data
add wave -noupdate -expand -group SGDMA_IF sim:/sample2lvl_converter_tb/DUT/in_ready
add wave -noupdate -expand -group SGDMA_IF sim:/sample2lvl_converter_tb/DUT/in_valid
add wave -noupdate -expand -group FIR_IF sim:/sample2lvl_converter_tb/DUT/fir_data
add wave -noupdate -expand -group FIR_IF sim:/sample2lvl_converter_tb/DUT/fir_ready
add wave -noupdate -expand -group FIR_IF sim:/sample2lvl_converter_tb/DUT/fir_valid
add wave -noupdate -expand -group SAMPLE_RAM_IF sim:/sample2lvl_converter_tb/DUT/ram_sample_address
add wave -noupdate -expand -group SAMPLE_RAM_IF sim:/sample2lvl_converter_tb/DUT/ram_sample_chipselect
add wave -noupdate -expand -group SAMPLE_RAM_IF sim:/sample2lvl_converter_tb/DUT/ram_sample_read
add wave -noupdate -expand -group SAMPLE_RAM_IF sim:/sample2lvl_converter_tb/DUT/ram_sample_write
add wave -noupdate -expand -group SAMPLE_RAM_IF sim:/sample2lvl_converter_tb/DUT/ram_sample_readdata
add wave -noupdate -expand -group SAMPLE_RAM_IF sim:/sample2lvl_converter_tb/DUT/ram_sample_writedata
add wave -noupdate -expand -group SAMPLE_RAM_IF sim:/sample2lvl_converter_tb/DUT/ram_sample_byteenable
add wave -noupdate -expand -group LIMITS_RAM_IF sim:/sample2lvl_converter_tb/DUT/ram_limits_address
add wave -noupdate -expand -group LIMITS_RAM_IF sim:/sample2lvl_converter_tb/DUT/ram_limits_chipselect
add wave -noupdate -expand -group LIMITS_RAM_IF sim:/sample2lvl_converter_tb/DUT/ram_limits_write
add wave -noupdate -expand -group LIMITS_RAM_IF sim:/sample2lvl_converter_tb/DUT/ram_limits_writedata
add wave -noupdate -expand -group LIMITS_RAM_IF sim:/sample2lvl_converter_tb/DUT/ram_limits_byteenable
add wave -noupdate -expand -group DUT_INT sim:/sample2lvl_converter_tb/DUT/sample_buffer_fill_cnt_r
add wave -noupdate -expand -group DUT_INT sim:/sample2lvl_converter_tb/DUT/iter_sample_cnt_r
add wave -noupdate -expand -group DUT_INT sim:/sample2lvl_converter_tb/DUT/curr_lvl_r
add wave -noupdate -expand -group DUT_INT sim:/sample2lvl_converter_tb/DUT/curr_iter_r
add wave -noupdate -expand -group DUT_INT sim:/sample2lvl_converter_tb/DUT/curr_iter_end
add wave -noupdate -expand -group DUT_INT sim:/sample2lvl_converter_tb/DUT/sample_processed
add wave -noupdate -expand -group DUT_INT sim:/sample2lvl_converter_tb/DUT/use_ram_vector_r
add wave -noupdate -expand -group DUT_INT sim:/sample2lvl_converter_tb/DUT/load_fresh_vector
add wave -noupdate -expand -group DUT_INT sim:/sample2lvl_converter_tb/DUT/full_buffer
add wave -noupdate -expand -group DUT_INT sim:/sample2lvl_converter_tb/DUT/next_sample

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
