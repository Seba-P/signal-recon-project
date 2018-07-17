
# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "fir_subsystem_top_tb"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../../soc_system/simulation"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "C:/intelfpga/17.1/quartus"
}

if ![info exists USER_DEFINED_COMPILE_OPTIONS] { 
  set USER_DEFINED_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_VHDL_COMPILE_OPTIONS] { 
  set USER_DEFINED_VHDL_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_VERILOG_COMPILE_OPTIONS] { 
  set USER_DEFINED_VERILOG_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_ELAB_OPTIONS] { 
  set USER_DEFINED_ELAB_OPTIONS ""
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/     
ensure_lib          ./libraries/work/
vmap       work     ./libraries/work/
vmap       work_lib ./libraries/work/
if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
  ensure_lib                       ./libraries/altera_ver/           
  vmap       altera_ver            ./libraries/altera_ver/           
  ensure_lib                       ./libraries/lpm_ver/              
  vmap       lpm_ver               ./libraries/lpm_ver/              
  ensure_lib                       ./libraries/sgate_ver/            
  vmap       sgate_ver             ./libraries/sgate_ver/            
  ensure_lib                       ./libraries/altera_mf_ver/        
  vmap       altera_mf_ver         ./libraries/altera_mf_ver/        
  ensure_lib                       ./libraries/altera_lnsim_ver/     
  vmap       altera_lnsim_ver      ./libraries/altera_lnsim_ver/     
  ensure_lib                       ./libraries/cyclonev_ver/         
  vmap       cyclonev_ver          ./libraries/cyclonev_ver/         
  ensure_lib                       ./libraries/cyclonev_hssi_ver/    
  vmap       cyclonev_hssi_ver     ./libraries/cyclonev_hssi_ver/    
  ensure_lib                       ./libraries/cyclonev_pcie_hip_ver/
  vmap       cyclonev_pcie_hip_ver ./libraries/cyclonev_pcie_hip_ver/
  ensure_lib                       ./libraries/altera/               
  vmap       altera                ./libraries/altera/               
  ensure_lib                       ./libraries/lpm/                  
  vmap       lpm                   ./libraries/lpm/                  
  ensure_lib                       ./libraries/sgate/                
  vmap       sgate                 ./libraries/sgate/                
  ensure_lib                       ./libraries/altera_mf/            
  vmap       altera_mf             ./libraries/altera_mf/            
  ensure_lib                       ./libraries/altera_lnsim/         
  vmap       altera_lnsim          ./libraries/altera_lnsim/         
  ensure_lib                       ./libraries/cyclonev/             
  vmap       cyclonev              ./libraries/cyclonev/             
}
ensure_lib                                                ./libraries/altera_common_sv_packages/                     
vmap       altera_common_sv_packages                      ./libraries/altera_common_sv_packages/                     
ensure_lib                                                ./libraries/error_adapter_0/                               
vmap       error_adapter_0                                ./libraries/error_adapter_0/                               
ensure_lib                                                ./libraries/border/                                        
vmap       border                                         ./libraries/border/                                        
ensure_lib                                                ./libraries/avalon_st_adapter/                             
vmap       avalon_st_adapter                              ./libraries/avalon_st_adapter/                             
ensure_lib                                                ./libraries/rsp_mux/                                       
vmap       rsp_mux                                        ./libraries/rsp_mux/                                       
ensure_lib                                                ./libraries/rsp_demux/                                     
vmap       rsp_demux                                      ./libraries/rsp_demux/                                     
ensure_lib                                                ./libraries/cmd_mux/                                       
vmap       cmd_mux                                        ./libraries/cmd_mux/                                       
ensure_lib                                                ./libraries/cmd_demux/                                     
vmap       cmd_demux                                      ./libraries/cmd_demux/                                     
ensure_lib                                                ./libraries/sysid_qsys_control_slave_burst_adapter/        
vmap       sysid_qsys_control_slave_burst_adapter         ./libraries/sysid_qsys_control_slave_burst_adapter/        
ensure_lib                                                ./libraries/router_002/                                    
vmap       router_002                                     ./libraries/router_002/                                    
ensure_lib                                                ./libraries/router/                                        
vmap       router                                         ./libraries/router/                                        
ensure_lib                                                ./libraries/sysid_qsys_control_slave_agent/                
vmap       sysid_qsys_control_slave_agent                 ./libraries/sysid_qsys_control_slave_agent/                
ensure_lib                                                ./libraries/hps_0_h2f_lw_axi_master_agent/                 
vmap       hps_0_h2f_lw_axi_master_agent                  ./libraries/hps_0_h2f_lw_axi_master_agent/                 
ensure_lib                                                ./libraries/sysid_qsys_control_slave_translator/           
vmap       sysid_qsys_control_slave_translator            ./libraries/sysid_qsys_control_slave_translator/           
ensure_lib                                                ./libraries/sgdma_mm2st_descriptor_write_rsp_width_adapter/
vmap       sgdma_mm2st_descriptor_write_rsp_width_adapter ./libraries/sgdma_mm2st_descriptor_write_rsp_width_adapter/
ensure_lib                                                ./libraries/sgdma_mm2st_descriptor_read_limiter/           
vmap       sgdma_mm2st_descriptor_read_limiter            ./libraries/sgdma_mm2st_descriptor_read_limiter/           
ensure_lib                                                ./libraries/router_006/                                    
vmap       router_006                                     ./libraries/router_006/                                    
ensure_lib                                                ./libraries/router_004/                                    
vmap       router_004                                     ./libraries/router_004/                                    
ensure_lib                                                ./libraries/hps_0_f2h_axi_slave_agent/                     
vmap       hps_0_f2h_axi_slave_agent                      ./libraries/hps_0_f2h_axi_slave_agent/                     
ensure_lib                                                ./libraries/sgdma_mm2st_descriptor_read_agent/             
vmap       sgdma_mm2st_descriptor_read_agent              ./libraries/sgdma_mm2st_descriptor_read_agent/             
ensure_lib                                                ./libraries/sgdma_mm2st_descriptor_read_translator/        
vmap       sgdma_mm2st_descriptor_read_translator         ./libraries/sgdma_mm2st_descriptor_read_translator/        
ensure_lib                                                ./libraries/hps_io/                                        
vmap       hps_io                                         ./libraries/hps_io/                                        
ensure_lib                                                ./libraries/fpga_interfaces/                               
vmap       fpga_interfaces                                ./libraries/fpga_interfaces/                               
ensure_lib                                                ./libraries/rst_controller/                                
vmap       rst_controller                                 ./libraries/rst_controller/                                
ensure_lib                                                ./libraries/mm_interconnect_1/                             
vmap       mm_interconnect_1                              ./libraries/mm_interconnect_1/                             
ensure_lib                                                ./libraries/mm_interconnect_0/                             
vmap       mm_interconnect_0                              ./libraries/mm_interconnect_0/                             
ensure_lib                                                ./libraries/sysid_qsys/                                    
vmap       sysid_qsys                                     ./libraries/sysid_qsys/                                    
ensure_lib                                                ./libraries/st2mm_data_adapter/                          
vmap       st2mm_data_adapter                             ./libraries/st2mm_data_adapter/                          
ensure_lib                                                ./libraries/signal_buffer_ctrl/                            
vmap       signal_buffer_ctrl                             ./libraries/signal_buffer_ctrl/                            
ensure_lib                                                ./libraries/signal_buffer/                                 
vmap       signal_buffer                                  ./libraries/signal_buffer/                                 
ensure_lib                                                ./libraries/sgdma_st2mm/                                   
vmap       sgdma_st2mm                                    ./libraries/sgdma_st2mm/                                   
ensure_lib                                                ./libraries/sgdma_mm2st/                                   
vmap       sgdma_mm2st                                    ./libraries/sgdma_mm2st/                                   
ensure_lib                                                ./libraries/sample2lvl_converter/                        
vmap       sample2lvl_converter                           ./libraries/sample2lvl_converter/                        
ensure_lib                                                ./libraries/output_ctrl/                                   
vmap       output_ctrl                                    ./libraries/output_ctrl/                                   
ensure_lib                                                ./libraries/onchip_RAM/                                    
vmap       onchip_RAM                                     ./libraries/onchip_RAM/                                    
ensure_lib                                                ./libraries/mm2st_data_adapter/                          
vmap       mm2st_data_adapter                             ./libraries/mm2st_data_adapter/                          
ensure_lib                                                ./libraries/limits_buffer_ctrl/                            
vmap       limits_buffer_ctrl                             ./libraries/limits_buffer_ctrl/                            
ensure_lib                                                ./libraries/limits_buffer/                                 
vmap       limits_buffer                                  ./libraries/limits_buffer/                                 
ensure_lib                                                ./libraries/led_pio/                                       
vmap       led_pio                                        ./libraries/led_pio/                                       
ensure_lib                                                ./libraries/iteration_ctrl/                                
vmap       iteration_ctrl                                 ./libraries/iteration_ctrl/                                
ensure_lib                                                ./libraries/hps_0/                                         
vmap       hps_0                                          ./libraries/hps_0/                                         
ensure_lib                                                ./libraries/hard_limiter_out_splitter/                     
vmap       hard_limiter_out_splitter                      ./libraries/hard_limiter_out_splitter/                     
ensure_lib                                                ./libraries/hard_limiter/                                  
vmap       hard_limiter                                   ./libraries/hard_limiter/                                  
ensure_lib                                                ./libraries/fir_filter/                                    
vmap       fir_filter                                     ./libraries/fir_filter/                                    
ensure_lib                                                ./libraries/fir_fifo_in/                                   
vmap       fir_fifo_in                                    ./libraries/fir_fifo_in/                                   
ensure_lib                                                ./libraries/fir_driver/                                    
vmap       fir_driver                                     ./libraries/fir_driver/                                    
ensure_lib                                                ./libraries/dipsw_pio/                                     
vmap       dipsw_pio                                      ./libraries/dipsw_pio/                                     
ensure_lib                                                ./libraries/button_pio/                                    
vmap       button_pio                                     ./libraries/button_pio/                                    

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                     -work altera_ver           
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                              -work lpm_ver              
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                 -work sgate_ver            
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                             -work altera_mf_ver        
    eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                         -work altera_lnsim_ver     
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                        -work cyclonev_ver         
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                   -work cyclonev_hssi_ver    
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"               -work cyclonev_pcie_hip_ver
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_syn_attributes.vhd"               -work altera               
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_standard_functions.vhd"           -work altera               
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/alt_dspbuilder_package.vhd"              -work altera               
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_europa_support_lib.vhd"           -work altera               
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives_components.vhd"        -work altera               
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.vhd"                   -work altera               
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/220pack.vhd"                             -work lpm                  
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.vhd"                            -work lpm                  
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate_pack.vhd"                          -work sgate                
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.vhd"                               -work sgate                
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf_components.vhd"                -work altera_mf            
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.vhd"                           -work altera_mf            
    eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/altera_lnsim_for_vhdl.sv"         -work altera_lnsim         
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim_components.vhd"             -work altera_lnsim         
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v"          -work cyclonev             
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.vhd"                      -work cyclonev             
    eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_components.vhd"                 -work cyclonev             
  }
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                                               -work altera_common_sv_packages                     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv"                                                                        -work altera_common_sv_packages                     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/avalon_mm_pkg.sv"                                                                               -work altera_common_sv_packages                     
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                                                    -work rst_controller                                
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                                                      -work rst_controller                                
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_splitter.sv"                                      -L altera_common_sv_packages -work hard_limiter_out_splitter                     
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                    -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                    -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                                 -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                   -L altera_common_sv_packages -work border                                        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                     -L altera_common_sv_packages -work border                                        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                     -L altera_common_sv_packages -work border                                        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                  -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                           -L altera_common_sv_packages -work sgdma_mm2st_descriptor_read_limiter           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_uncmpr.sv"                             -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                               -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                                -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                               -L altera_common_sv_packages -work sysid_qsys_control_slave_agent                
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_axi_master_ni.sv"                                    -L altera_common_sv_packages -work hps_0_h2f_lw_axi_master_agent                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_width_adapter.sv"                                    -L altera_common_sv_packages -work sgdma_mm2st_descriptor_write_rsp_width_adapter
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv"                                   -L altera_common_sv_packages -work sgdma_mm2st_descriptor_read_limiter           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                -L altera_common_sv_packages -work sgdma_mm2st_descriptor_read_translator        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/questa_mvc_svapi.svh"                                              -L altera_common_sv_packages -work fpga_interfaces                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/mgc_common_axi.sv"                                                 -L altera_common_sv_packages -work fpga_interfaces                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/mgc_axi_master.sv"                                                 -L altera_common_sv_packages -work fpga_interfaces                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/mgc_axi_slave.sv"                                                  -L altera_common_sv_packages -work fpga_interfaces                               
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QSYS_SIMDIR/submodules/dspba_library_package.vhd"                                                                      -work fir_filter                                    
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QSYS_SIMDIR/submodules/dspba_library.vhd"                                                                              -work fir_filter                                    
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QSYS_SIMDIR/submodules/auk_dspip_math_pkg_hpfir.vhd"                                                                   -work fir_filter                                    
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QSYS_SIMDIR/submodules/auk_dspip_lib_pkg_hpfir.vhd"                                                                    -work fir_filter                                    
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QSYS_SIMDIR/submodules/auk_dspip_avalon_streaming_controller_hpfir.vhd"                                                -work fir_filter                                    
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QSYS_SIMDIR/submodules/auk_dspip_avalon_streaming_sink_hpfir.vhd"                                                      -work fir_filter                                    
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QSYS_SIMDIR/submodules/auk_dspip_avalon_streaming_source_hpfir.vhd"                                                    -work fir_filter                                    
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QSYS_SIMDIR/submodules/auk_dspip_roundsat_hpfir.vhd"                                                                   -work fir_filter                                    
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QSYS_SIMDIR/submodules/soc_system_fir_filter_rtl_core.vhd"                                                             -work fir_filter                                    
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QSYS_SIMDIR/submodules/soc_system_fir_filter_ast.vhd"                                                                  -work fir_filter                                    
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QSYS_SIMDIR/submodules/soc_system_fir_filter.vhd"                                                                      -work fir_filter                                    
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS        "$QSYS_SIMDIR/submodules/soc_system_fir_filter_tb.vhd"                                                                   -work fir_filter                                    
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim -t ps $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS -L work -L work_lib -L altera_common_sv_packages -L error_adapter_0 -L border -L avalon_st_adapter -L rsp_mux -L rsp_demux -L cmd_mux -L cmd_demux -L sysid_qsys_control_slave_burst_adapter -L router_002 -L router -L sysid_qsys_control_slave_agent -L hps_0_h2f_lw_axi_master_agent -L sysid_qsys_control_slave_translator -L sgdma_mm2st_descriptor_write_rsp_width_adapter -L sgdma_mm2st_descriptor_read_limiter -L router_006 -L router_004 -L hps_0_f2h_axi_slave_agent -L sgdma_mm2st_descriptor_read_agent -L sgdma_mm2st_descriptor_read_translator -L hps_io -L fpga_interfaces -L rst_controller -L mm_interconnect_1 -L mm_interconnect_0 -L sysid_qsys -L st2mm_data_adapter -L signal_buffer_ctrl -L signal_buffer -L sgdma_st2mm -L sgdma_mm2st -L sample2lvl_converter -L output_ctrl -L onchip_RAM -L mm2st_data_adapter -L limits_buffer_ctrl -L limits_buffer -L led_pio -L iteration_ctrl -L hps_0 -L hard_limiter_out_splitter -L hard_limiter -L fir_filter -L fir_fifo_in -L fir_driver -L dipsw_pio -L button_pio -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev $TOP_LEVEL_NAME
}
