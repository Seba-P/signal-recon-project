# TCL File Generated by Component Editor 17.1
# Sat Jul 14 15:02:00 CEST 2018
# DO NOT MODIFY


# 
# iteration_ctrl "iteration_ctrl" v1.0
#  2018.07.14.15:02:00
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module iteration_ctrl
# 
set_module_property DESCRIPTION ""
set_module_property NAME iteration_ctrl
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME iteration_ctrl
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL iteration_ctrl
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file iteration_ctrl.sv SYSTEM_VERILOG PATH ../source/iteration_ctrl.sv TOP_LEVEL_FILE
add_fileset_file delay.sv SYSTEM_VERILOG PATH ../source/delay.sv

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL iteration_ctrl
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file iteration_ctrl.sv SYSTEM_VERILOG PATH ../source/iteration_ctrl.sv MENTOR_SPECIFIC


# 
# parameters
# 
add_parameter FIR_TAPS_NUM INTEGER 255
set_parameter_property FIR_TAPS_NUM DEFAULT_VALUE 255
set_parameter_property FIR_TAPS_NUM DISPLAY_NAME FIR_TAPS_NUM
set_parameter_property FIR_TAPS_NUM TYPE INTEGER
set_parameter_property FIR_TAPS_NUM UNITS None
set_parameter_property FIR_TAPS_NUM ALLOWED_RANGES -2147483648:2147483647
set_parameter_property FIR_TAPS_NUM HDL_PARAMETER true
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
# connection point sigbuff
# 
add_interface sigbuff conduit end
set_interface_property sigbuff associatedClock clock
set_interface_property sigbuff associatedReset reset
set_interface_property sigbuff ENABLED true
set_interface_property sigbuff EXPORT_OF ""
set_interface_property sigbuff PORT_NAME_MAP ""
set_interface_property sigbuff CMSIS_SVD_VARIABLES ""
set_interface_property sigbuff SVD_ADDRESS_GROUP ""

add_interface_port sigbuff sigbuff_iter_state new_signal Output 2
add_interface_port sigbuff sigbuff_iter_num new_signal_1 Output 5
add_interface_port sigbuff sigbuff_symbol_num new_signal_2 Output 8
add_interface_port sigbuff sigbuff_section_id new_signal_3 Output 2
add_interface_port sigbuff sigbuff_init new_signal_4 Output 1
add_interface_port sigbuff sigbuff_input_mux new_signal_5 Output 1
add_interface_port sigbuff sigbuff_input_enable new_signal_6 Output 1
add_interface_port sigbuff sigbuff_output_enable new_signal_7 Output 1
add_interface_port sigbuff sigbuff_ready new_signal_8 Input 1


# 
# connection point limbuff
# 
add_interface limbuff conduit end
set_interface_property limbuff associatedClock clock
set_interface_property limbuff associatedReset reset
set_interface_property limbuff ENABLED true
set_interface_property limbuff EXPORT_OF ""
set_interface_property limbuff PORT_NAME_MAP ""
set_interface_property limbuff CMSIS_SVD_VARIABLES ""
set_interface_property limbuff SVD_ADDRESS_GROUP ""

add_interface_port limbuff limbuff_symbol_num new_signal Output 8
add_interface_port limbuff limbuff_section_id new_signal_1 Output 2
add_interface_port limbuff limbuff_init new_signal_2 Output 1
add_interface_port limbuff limbuff_input_enable new_signal_3 Output 1
add_interface_port limbuff limbuff_output_enable new_signal_4 Output 1
add_interface_port limbuff limbuff_ready new_signal_5 Input 1


# 
# connection point lvl_gen
# 
add_interface lvl_gen conduit end
set_interface_property lvl_gen associatedClock clock
set_interface_property lvl_gen associatedReset reset
set_interface_property lvl_gen ENABLED true
set_interface_property lvl_gen EXPORT_OF ""
set_interface_property lvl_gen PORT_NAME_MAP ""
set_interface_property lvl_gen CMSIS_SVD_VARIABLES ""
set_interface_property lvl_gen SVD_ADDRESS_GROUP ""

add_interface_port lvl_gen lvl_gen_init new_signal Output 1
add_interface_port lvl_gen lvl_gen_valid new_signal_1 Input 1
add_interface_port lvl_gen lvl_gen_ready new_signal_2 Output 1


# 
# connection point fir_driver
# 
add_interface fir_driver conduit end
set_interface_property fir_driver associatedClock clock
set_interface_property fir_driver associatedReset reset
set_interface_property fir_driver ENABLED true
set_interface_property fir_driver EXPORT_OF ""
set_interface_property fir_driver PORT_NAME_MAP ""
set_interface_property fir_driver CMSIS_SVD_VARIABLES ""
set_interface_property fir_driver SVD_ADDRESS_GROUP ""

add_interface_port fir_driver fir_input_mux new_signal Output 1
add_interface_port fir_driver fir_input_enable new_signal_1 Output 1
add_interface_port fir_driver fir_ready new_signal_2 Input 1
add_interface_port fir_driver fir_data_passed new_signal_3 Input 1


# 
# connection point limiter
# 
add_interface limiter conduit end
set_interface_property limiter associatedClock clock
set_interface_property limiter associatedReset reset
set_interface_property limiter ENABLED true
set_interface_property limiter EXPORT_OF ""
set_interface_property limiter PORT_NAME_MAP ""
set_interface_property limiter CMSIS_SVD_VARIABLES ""
set_interface_property limiter SVD_ADDRESS_GROUP ""

add_interface_port limiter limiter_input_enable new_signal Output 1
add_interface_port limiter limiter_ready new_signal_1 Input 1


# 
# connection point out_ctrl
# 
add_interface out_ctrl conduit end
set_interface_property out_ctrl associatedClock clock
set_interface_property out_ctrl associatedReset reset
set_interface_property out_ctrl ENABLED true
set_interface_property out_ctrl EXPORT_OF ""
set_interface_property out_ctrl PORT_NAME_MAP ""
set_interface_property out_ctrl CMSIS_SVD_VARIABLES ""
set_interface_property out_ctrl SVD_ADDRESS_GROUP ""

add_interface_port out_ctrl out_ctrl_output_enable new_signal Output 1
add_interface_port out_ctrl out_ctrl_ready new_signal_1 Input 1

