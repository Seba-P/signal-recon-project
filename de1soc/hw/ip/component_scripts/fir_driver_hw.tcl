# TCL File Generated by Component Editor 17.1
# Mon Jun 04 11:33:46 CEST 2018
# DO NOT MODIFY


# 
# fir_driver "fir_driver" v1.0
#  2018.06.04.11:33:46
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module fir_driver
# 
set_module_property DESCRIPTION ""
set_module_property NAME fir_driver
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME fir_driver
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL fir_driver
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file fir_driver.sv SYSTEM_VERILOG PATH ../source/fir_driver.sv TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL fir_driver
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file fir_driver.sv SYSTEM_VERILOG PATH ../source/fir_driver.sv MENTOR_SPECIFIC


# 
# parameters
# 
add_parameter USE_COMB_LOGIC INTEGER 0
set_parameter_property USE_COMB_LOGIC DEFAULT_VALUE 0
set_parameter_property USE_COMB_LOGIC DISPLAY_NAME USE_COMB_LOGIC
set_parameter_property USE_COMB_LOGIC TYPE INTEGER
set_parameter_property USE_COMB_LOGIC UNITS None
set_parameter_property USE_COMB_LOGIC ALLOWED_RANGES -2147483648:2147483647
set_parameter_property USE_COMB_LOGIC HDL_PARAMETER true


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
# connection point sigbuff
# 
add_interface sigbuff avalon_streaming end
set_interface_property sigbuff associatedClock clock
set_interface_property sigbuff associatedReset reset
set_interface_property sigbuff dataBitsPerSymbol 16
set_interface_property sigbuff errorDescriptor ""
set_interface_property sigbuff firstSymbolInHighOrderBits true
set_interface_property sigbuff maxChannel 0
set_interface_property sigbuff readyLatency 0
set_interface_property sigbuff ENABLED true
set_interface_property sigbuff EXPORT_OF ""
set_interface_property sigbuff PORT_NAME_MAP ""
set_interface_property sigbuff CMSIS_SVD_VARIABLES ""
set_interface_property sigbuff SVD_ADDRESS_GROUP ""

add_interface_port sigbuff sigbuff_data data Input 16
add_interface_port sigbuff sigbuff_valid valid Input 1


# 
# connection point fir
# 
add_interface fir avalon_streaming start
set_interface_property fir associatedClock clock
set_interface_property fir associatedReset reset
set_interface_property fir dataBitsPerSymbol 16
set_interface_property fir errorDescriptor ""
set_interface_property fir firstSymbolInHighOrderBits true
set_interface_property fir maxChannel 0
set_interface_property fir readyLatency 0
set_interface_property fir ENABLED true
set_interface_property fir EXPORT_OF ""
set_interface_property fir PORT_NAME_MAP ""
set_interface_property fir CMSIS_SVD_VARIABLES ""
set_interface_property fir SVD_ADDRESS_GROUP ""

add_interface_port fir fir_data data Output 16
add_interface_port fir fir_valid valid Output 1
add_interface_port fir fir_ready ready Input 1
add_interface_port fir fir_error error Output 2


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

add_interface_port iter iter_input_mux new_signal Input 1
add_interface_port iter iter_input_enable new_signal_1 Input 1
add_interface_port iter iter_ready new_signal_2 Output 1

