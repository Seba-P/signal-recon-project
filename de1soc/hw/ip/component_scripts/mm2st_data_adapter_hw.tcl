# TCL File Generated by Component Editor 17.1
# Fri May 18 16:09:54 CEST 2018
# DO NOT MODIFY


# 
# mm2st_data_adapter "mm2st_data_adapter" v2.0
#  2018.05.18.16:09:54
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module mm2st_data_adapter
# 
set_module_property DESCRIPTION ""
set_module_property NAME mm2st_data_adapter
set_module_property VERSION 2.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME mm2st_data_adapter
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL mm2st_data_adapter
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file mm2st_data_adapter.sv SYSTEM_VERILOG PATH ../source/mm2st_data_adapter.sv TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL mm2st_data_adapter
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file mm2st_data_adapter.sv SYSTEM_VERILOG PATH ../source/mm2st_data_adapter.sv MENTOR_SPECIFIC


# 
# parameters
# 


# 
# display items
# 


# 
# connection point avalon_st_clk_source
# 
add_interface avalon_st_clk_source clock end
set_interface_property avalon_st_clk_source clockRate 0
set_interface_property avalon_st_clk_source ENABLED true
set_interface_property avalon_st_clk_source EXPORT_OF ""
set_interface_property avalon_st_clk_source PORT_NAME_MAP ""
set_interface_property avalon_st_clk_source CMSIS_SVD_VARIABLES ""
set_interface_property avalon_st_clk_source SVD_ADDRESS_GROUP ""

add_interface_port avalon_st_clk_source avalon_st_clk_source clk Input 1


# 
# connection point avalon_st_sink
# 
add_interface avalon_st_sink avalon_streaming end
set_interface_property avalon_st_sink associatedClock avalon_st_clk_sink
set_interface_property avalon_st_sink associatedReset avalon_st_reset
set_interface_property avalon_st_sink dataBitsPerSymbol 8
set_interface_property avalon_st_sink errorDescriptor ""
set_interface_property avalon_st_sink firstSymbolInHighOrderBits true
set_interface_property avalon_st_sink maxChannel 0
set_interface_property avalon_st_sink readyLatency 0
set_interface_property avalon_st_sink ENABLED true
set_interface_property avalon_st_sink EXPORT_OF ""
set_interface_property avalon_st_sink PORT_NAME_MAP ""
set_interface_property avalon_st_sink CMSIS_SVD_VARIABLES ""
set_interface_property avalon_st_sink SVD_ADDRESS_GROUP ""

add_interface_port avalon_st_sink avalon_st_sink_startofpacket startofpacket Input 1
add_interface_port avalon_st_sink avalon_st_sink_endofpacket endofpacket Input 1
add_interface_port avalon_st_sink avalon_st_sink_data data Input 16
add_interface_port avalon_st_sink avalon_st_sink_ready ready Output 1
add_interface_port avalon_st_sink avalon_st_sink_valid valid Input 1
add_interface_port avalon_st_sink avalon_st_sink_empty empty Input 1


# 
# connection point avalon_st_source
# 
add_interface avalon_st_source avalon_streaming start
set_interface_property avalon_st_source associatedClock avalon_st_clk_source
set_interface_property avalon_st_source associatedReset avalon_st_reset
set_interface_property avalon_st_source dataBitsPerSymbol 16
set_interface_property avalon_st_source errorDescriptor ""
set_interface_property avalon_st_source firstSymbolInHighOrderBits true
set_interface_property avalon_st_source maxChannel 0
set_interface_property avalon_st_source readyLatency 0
set_interface_property avalon_st_source ENABLED true
set_interface_property avalon_st_source EXPORT_OF ""
set_interface_property avalon_st_source PORT_NAME_MAP ""
set_interface_property avalon_st_source CMSIS_SVD_VARIABLES ""
set_interface_property avalon_st_source SVD_ADDRESS_GROUP ""

add_interface_port avalon_st_source avalon_st_source_data data Output 16
add_interface_port avalon_st_source avalon_st_source_valid valid Output 1
add_interface_port avalon_st_source avalon_st_source_ready ready Input 1


# 
# connection point avalon_st_clk_sink
# 
add_interface avalon_st_clk_sink clock end
set_interface_property avalon_st_clk_sink clockRate 0
set_interface_property avalon_st_clk_sink ENABLED true
set_interface_property avalon_st_clk_sink EXPORT_OF ""
set_interface_property avalon_st_clk_sink PORT_NAME_MAP ""
set_interface_property avalon_st_clk_sink CMSIS_SVD_VARIABLES ""
set_interface_property avalon_st_clk_sink SVD_ADDRESS_GROUP ""

add_interface_port avalon_st_clk_sink avalon_st_clk_sink clk Input 1


# 
# connection point avalon_st_reset
# 
add_interface avalon_st_reset reset end
set_interface_property avalon_st_reset associatedClock avalon_st_clk_sink
set_interface_property avalon_st_reset synchronousEdges DEASSERT
set_interface_property avalon_st_reset ENABLED true
set_interface_property avalon_st_reset EXPORT_OF ""
set_interface_property avalon_st_reset PORT_NAME_MAP ""
set_interface_property avalon_st_reset CMSIS_SVD_VARIABLES ""
set_interface_property avalon_st_reset SVD_ADDRESS_GROUP ""

add_interface_port avalon_st_reset avalon_st_reset reset Input 1
