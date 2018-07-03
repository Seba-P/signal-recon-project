# TCL File Generated by Component Editor 17.1
# Sun Jul 01 10:54:54 CEST 2018
# DO NOT MODIFY


# 
# signal_buffer_ctrl "signal_buffer_ctrl" v1.0
#  2018.07.01.10:54:54
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module signal_buffer_ctrl
# 
set_module_property DESCRIPTION ""
set_module_property NAME signal_buffer_ctrl
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME signal_buffer_ctrl
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL signal_buffer_ctrl
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file signal_buffer_ctrl.sv SYSTEM_VERILOG PATH ../source/signal_buffer_ctrl.sv TOP_LEVEL_FILE
add_fileset_file delay.sv SYSTEM_VERILOG PATH ../source/delay.sv

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL signal_buffer_ctrl
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file signal_buffer_ctrl.sv SYSTEM_VERILOG PATH ../source/signal_buffer_ctrl.sv MENTOR_SPECIFIC


# 
# parameters
# 
add_parameter MAX_SAMPLES_IN_RAM INTEGER 255
set_parameter_property MAX_SAMPLES_IN_RAM DEFAULT_VALUE 255
set_parameter_property MAX_SAMPLES_IN_RAM DISPLAY_NAME MAX_SAMPLES_IN_RAM
set_parameter_property MAX_SAMPLES_IN_RAM TYPE INTEGER
set_parameter_property MAX_SAMPLES_IN_RAM UNITS None
set_parameter_property MAX_SAMPLES_IN_RAM ALLOWED_RANGES -2147483648:2147483647
set_parameter_property MAX_SAMPLES_IN_RAM HDL_PARAMETER true
add_parameter ITER_NUM INTEGER 1
set_parameter_property ITER_NUM DEFAULT_VALUE 1
set_parameter_property ITER_NUM DISPLAY_NAME ITER_NUM
set_parameter_property ITER_NUM TYPE INTEGER
set_parameter_property ITER_NUM UNITS None
set_parameter_property ITER_NUM ALLOWED_RANGES -2147483648:2147483647
set_parameter_property ITER_NUM HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clock clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1


# 
# connection point lvl_gen
# 
add_interface lvl_gen avalon_streaming end
set_interface_property lvl_gen associatedClock clock
set_interface_property lvl_gen associatedReset reset
set_interface_property lvl_gen dataBitsPerSymbol 16
set_interface_property lvl_gen errorDescriptor ""
set_interface_property lvl_gen firstSymbolInHighOrderBits true
set_interface_property lvl_gen maxChannel 0
set_interface_property lvl_gen readyLatency 0
set_interface_property lvl_gen ENABLED true
set_interface_property lvl_gen EXPORT_OF ""
set_interface_property lvl_gen PORT_NAME_MAP ""
set_interface_property lvl_gen CMSIS_SVD_VARIABLES ""
set_interface_property lvl_gen SVD_ADDRESS_GROUP ""

add_interface_port lvl_gen lvl_gen_data data Input 16
add_interface_port lvl_gen lvl_gen_valid valid Input 1


# 
# connection point limiter
# 
add_interface limiter avalon_streaming end
set_interface_property limiter associatedClock clock
set_interface_property limiter associatedReset reset
set_interface_property limiter dataBitsPerSymbol 16
set_interface_property limiter errorDescriptor ""
set_interface_property limiter firstSymbolInHighOrderBits true
set_interface_property limiter maxChannel 0
set_interface_property limiter readyLatency 0
set_interface_property limiter ENABLED true
set_interface_property limiter EXPORT_OF ""
set_interface_property limiter PORT_NAME_MAP ""
set_interface_property limiter CMSIS_SVD_VARIABLES ""
set_interface_property limiter SVD_ADDRESS_GROUP ""

add_interface_port limiter limiter_data data Input 16
add_interface_port limiter limiter_valid valid Input 1
add_interface_port limiter limiter_ready ready Output 1


# 
# connection point iter
# 
add_interface iter conduit end
set_interface_property iter associatedClock clock
set_interface_property iter associatedReset reset
set_interface_property iter ENABLED true
set_interface_property iter EXPORT_OF ""
set_interface_property iter PORT_NAME_MAP ""
set_interface_property iter CMSIS_SVD_VARIABLES ""
set_interface_property iter SVD_ADDRESS_GROUP ""

add_interface_port iter iter_iter_num new_signal Input 5
add_interface_port iter iter_symbol_num new_signal_1 Input 8
add_interface_port iter iter_init new_signal_2 Input 1
add_interface_port iter iter_input_mux new_signal_3 Input 1
add_interface_port iter iter_input_enable new_signal_4 Input 1
add_interface_port iter iter_output_enable new_signal_5 Input 1
add_interface_port iter iter_ready new_signal_6 Output 1


# 
# connection point port_a
# 
add_interface port_a avalon start
set_interface_property port_a addressUnits WORDS
set_interface_property port_a associatedClock clock
set_interface_property port_a associatedReset reset
set_interface_property port_a bitsPerSymbol 8
set_interface_property port_a burstOnBurstBoundariesOnly false
set_interface_property port_a burstcountUnits WORDS
set_interface_property port_a doStreamReads false
set_interface_property port_a doStreamWrites false
set_interface_property port_a holdTime 0
set_interface_property port_a linewrapBursts false
set_interface_property port_a maximumPendingReadTransactions 0
set_interface_property port_a maximumPendingWriteTransactions 0
set_interface_property port_a readLatency 0
set_interface_property port_a readWaitTime 1
set_interface_property port_a setupTime 0
set_interface_property port_a timingUnits Cycles
set_interface_property port_a writeWaitTime 0
set_interface_property port_a ENABLED true
set_interface_property port_a EXPORT_OF ""
set_interface_property port_a PORT_NAME_MAP ""
set_interface_property port_a CMSIS_SVD_VARIABLES ""
set_interface_property port_a SVD_ADDRESS_GROUP ""

add_interface_port port_a ram_signal_address_a address Output 13
add_interface_port port_a ram_signal_byteenable_a byteenable Output 2
add_interface_port port_a ram_signal_chipselect_a chipselect Output 1
add_interface_port port_a ram_signal_readdata_a readdata Input 16
add_interface_port port_a ram_signal_write_a write Output 1
add_interface_port port_a ram_signal_writedata_a writedata Output 16
add_interface_port port_a ram_signal_waitrequest_a waitrequest Input 1
add_interface_port port_a ram_signal_read_a read Output 1


# 
# connection point port_b
# 
add_interface port_b avalon start
set_interface_property port_b addressUnits WORDS
set_interface_property port_b associatedClock clock
set_interface_property port_b associatedReset reset
set_interface_property port_b bitsPerSymbol 8
set_interface_property port_b burstOnBurstBoundariesOnly false
set_interface_property port_b burstcountUnits WORDS
set_interface_property port_b doStreamReads false
set_interface_property port_b doStreamWrites false
set_interface_property port_b holdTime 0
set_interface_property port_b linewrapBursts false
set_interface_property port_b maximumPendingReadTransactions 0
set_interface_property port_b maximumPendingWriteTransactions 0
set_interface_property port_b readLatency 0
set_interface_property port_b readWaitTime 1
set_interface_property port_b setupTime 0
set_interface_property port_b timingUnits Cycles
set_interface_property port_b writeWaitTime 0
set_interface_property port_b ENABLED true
set_interface_property port_b EXPORT_OF ""
set_interface_property port_b PORT_NAME_MAP ""
set_interface_property port_b CMSIS_SVD_VARIABLES ""
set_interface_property port_b SVD_ADDRESS_GROUP ""

add_interface_port port_b ram_signal_address_b address Output 13
add_interface_port port_b ram_signal_byteenable_b byteenable Output 2
add_interface_port port_b ram_signal_chipselect_b chipselect Output 1
add_interface_port port_b ram_signal_readdata_b readdata Input 16
add_interface_port port_b ram_signal_write_b write Output 1
add_interface_port port_b ram_signal_writedata_b writedata Output 16
add_interface_port port_b ram_signal_waitrequest_b waitrequest Input 1
add_interface_port port_b ram_signal_read_b read Output 1


# 
# connection point fir_driver
# 
add_interface fir_driver avalon_streaming start
set_interface_property fir_driver associatedClock clock
set_interface_property fir_driver associatedReset reset
set_interface_property fir_driver dataBitsPerSymbol 16
set_interface_property fir_driver errorDescriptor ""
set_interface_property fir_driver firstSymbolInHighOrderBits true
set_interface_property fir_driver maxChannel 0
set_interface_property fir_driver readyLatency 0
set_interface_property fir_driver ENABLED true
set_interface_property fir_driver EXPORT_OF ""
set_interface_property fir_driver PORT_NAME_MAP ""
set_interface_property fir_driver CMSIS_SVD_VARIABLES ""
set_interface_property fir_driver SVD_ADDRESS_GROUP ""

add_interface_port fir_driver fir_driver_data data Output 16
add_interface_port fir_driver fir_driver_valid valid Output 1
add_interface_port fir_driver fir_driver_ready ready Input 1

