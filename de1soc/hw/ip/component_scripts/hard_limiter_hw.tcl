# TCL File Generated by Component Editor 17.1
# Fri May 18 16:07:01 CEST 2018
# DO NOT MODIFY


# 
# hard_limiter "hard_limiter" v1.0
#  2018.05.18.16:07:01
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module hard_limiter
# 
set_module_property DESCRIPTION ""
set_module_property NAME hard_limiter
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME hard_limiter
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL hard_limiter
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file hard_limiter.sv SYSTEM_VERILOG PATH ../source/hard_limiter.sv TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL hard_limiter
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file hard_limiter.sv SYSTEM_VERILOG PATH ../source/hard_limiter.sv MENTOR_SPECIFIC


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
# connection point limbuff
# 
add_interface limbuff avalon_streaming end
set_interface_property limbuff associatedClock clock
set_interface_property limbuff associatedReset reset
set_interface_property limbuff dataBitsPerSymbol 32
set_interface_property limbuff errorDescriptor ""
set_interface_property limbuff firstSymbolInHighOrderBits true
set_interface_property limbuff maxChannel 0
set_interface_property limbuff readyLatency 0
set_interface_property limbuff ENABLED true
set_interface_property limbuff EXPORT_OF ""
set_interface_property limbuff PORT_NAME_MAP ""
set_interface_property limbuff CMSIS_SVD_VARIABLES ""
set_interface_property limbuff SVD_ADDRESS_GROUP ""

add_interface_port limbuff limbuff_data data Input 32
add_interface_port limbuff limbuff_valid valid Input 1


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

add_interface_port iter iter_input_enable new_signal Input 1


# 
# connection point fir
# 
add_interface fir avalon_streaming end
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

add_interface_port fir fir_data data Input 16
add_interface_port fir fir_ready ready Output 1
add_interface_port fir fir_valid valid Input 1
add_interface_port fir fir_error error Input 2


# 
# connection point out
# 
add_interface out avalon_streaming start
set_interface_property out associatedClock clock
set_interface_property out associatedReset reset
set_interface_property out dataBitsPerSymbol 16
set_interface_property out errorDescriptor ""
set_interface_property out firstSymbolInHighOrderBits true
set_interface_property out maxChannel 0
set_interface_property out readyLatency 0
set_interface_property out ENABLED true
set_interface_property out EXPORT_OF ""
set_interface_property out PORT_NAME_MAP ""
set_interface_property out CMSIS_SVD_VARIABLES ""
set_interface_property out SVD_ADDRESS_GROUP ""

add_interface_port out out_data data Output 16
add_interface_port out out_valid valid Output 1
add_interface_port out out_ready ready Input 1
