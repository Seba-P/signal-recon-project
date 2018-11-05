
LIB_LINKS = -L work -L altera_common_sv_packages -L error_adapter_0 -L border -L avalon_st_adapter \
	        -L rsp_mux -L rsp_demux -L cmd_mux -L cmd_demux -L sysid_qsys_control_slave_burst_adapter -L router_002 \
	        -L router -L sysid_qsys_control_slave_agent -L hps_0_h2f_lw_axi_master_agent -L sysid_qsys_control_slave_translator \
	        -L sgdma_mm2st_descriptor_write_rsp_width_adapter -L sgdma_mm2st_descriptor_read_limiter -L router_006 -L router_004 \
	        -L hps_0_f2h_axi_slave_agent -L sgdma_mm2st_descriptor_read_agent -L sgdma_mm2st_descriptor_read_translator \
	        -L hps_io -L fpga_interfaces -L rst_controller -L mm_interconnect_1 -L mm_interconnect_0 -L sysid_qsys \
	        -L st2mm_data_adapter -L signal_buffer_ctrl -L signal_buffer -L sgdma_st2mm -L sgdma_mm2st -L sample2lvl_converter \
	        -L output_ctrl -L onchip_RAM -L mm2st_data_adapter -L limits_buffer_ctrl -L limits_buffer -L led_pio -L iteration_ctrl \
	        -L hps_0 -L hard_limiter_out_splitter -L hard_limiter -L fir_filter -L fir_fifo_in -L fir_driver -L dipsw_pio -L button_pio \
	        -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver \
	        -L cyclonev_pcie_hip_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L dut_rtl

libs: map_libs cyclonev_common altera_libs

map_libs:
# mkdir -p _work
	vlib                                                ./_work/work/
	vmap work                                           ./_work/work/
	vlib                                                ./_work/altera_ver/
	vmap altera_ver                                     ./_work/altera_ver/
	vlib                                                ./_work/lpm_ver/
	vmap lpm_ver                                        ./_work/lpm_ver/
	vlib                                                ./_work/sgate_ver/
	vmap sgate_ver                                      ./_work/sgate_ver/
	vlib                                                ./_work/altera_mf_ver/
	vmap altera_mf_ver                                  ./_work/altera_mf_ver/
	vlib                                                ./_work/altera_lnsim_ver/
	vmap altera_lnsim_ver                               ./_work/altera_lnsim_ver/
	vlib                                                ./_work/cyclonev_ver/
	vmap cyclonev_ver                                   ./_work/cyclonev_ver/
	vlib                                                ./_work/cyclonev_hssi_ver/
	vmap cyclonev_hssi_ver                              ./_work/cyclonev_hssi_ver/
	vlib                                                ./_work/cyclonev_pcie_hip_ver/
	vmap cyclonev_pcie_hip_ver                          ./_work/cyclonev_pcie_hip_ver/
	vlib                                                ./_work/altera/
	vmap altera                                         ./_work/altera/
	vlib                                                ./_work/lpm/
	vmap lpm                                            ./_work/lpm/
	vlib                                                ./_work/sgate/
	vmap sgate                                          ./_work/sgate/
	vlib                                                ./_work/altera_mf/
	vmap altera_mf                                      ./_work/altera_mf/
	vlib                                                ./_work/altera_lnsim/
	vmap altera_lnsim                                   ./_work/altera_lnsim/
	vlib                                                ./_work/cyclonev/
	vmap cyclonev                                       ./_work/cyclonev/
	vlib                                                ./_work/altera_common_sv_packages/
	vmap altera_common_sv_packages                      ./_work/altera_common_sv_packages/
	vlib                                                ./_work/error_adapter_0/
	vmap error_adapter_0                                ./_work/error_adapter_0/
	vlib                                                ./_work/border/
	vmap border                                         ./_work/border/
	vlib                                                ./_work/avalon_st_adapter/
	vmap avalon_st_adapter                              ./_work/avalon_st_adapter/
	vlib                                                ./_work/rsp_mux/
	vmap rsp_mux                                        ./_work/rsp_mux/
	vlib                                                ./_work/rsp_demux/
	vmap rsp_demux                                      ./_work/rsp_demux/
	vlib                                                ./_work/cmd_mux/
	vmap cmd_mux                                        ./_work/cmd_mux/
	vlib                                                ./_work/cmd_demux/
	vmap cmd_demux                                      ./_work/cmd_demux/
	vlib                                                ./_work/sysid_qsys_control_slave_burst_adapter/
	vmap sysid_qsys_control_slave_burst_adapter         ./_work/sysid_qsys_control_slave_burst_adapter/
	vlib                                                ./_work/router_002/
	vmap router_002                                     ./_work/router_002/
	vlib                                                ./_work/router/
	vmap router                                         ./_work/router/
	vlib                                                ./_work/sysid_qsys_control_slave_agent/
	vmap sysid_qsys_control_slave_agent                 ./_work/sysid_qsys_control_slave_agent/
	vlib                                                ./_work/hps_0_h2f_lw_axi_master_agent/
	vmap hps_0_h2f_lw_axi_master_agent                  ./_work/hps_0_h2f_lw_axi_master_agent/
	vlib                                                ./_work/sysid_qsys_control_slave_translator/
	vmap sysid_qsys_control_slave_translator            ./_work/sysid_qsys_control_slave_translator/
	vlib                                                ./_work/sgdma_mm2st_descriptor_write_rsp_width_adapter/
	vmap sgdma_mm2st_descriptor_write_rsp_width_adapter ./_work/sgdma_mm2st_descriptor_write_rsp_width_adapter/
	vlib                                                ./_work/sgdma_mm2st_descriptor_read_limiter/
	vmap sgdma_mm2st_descriptor_read_limiter            ./_work/sgdma_mm2st_descriptor_read_limiter/
	vlib                                                ./_work/router_006/
	vmap router_006                                     ./_work/router_006/
	vlib                                                ./_work/router_004/
	vmap router_004                                     ./_work/router_004/
	vlib                                                ./_work/hps_0_f2h_axi_slave_agent/
	vmap hps_0_f2h_axi_slave_agent                      ./_work/hps_0_f2h_axi_slave_agent/
	vlib                                                ./_work/sgdma_mm2st_descriptor_read_agent/
	vmap sgdma_mm2st_descriptor_read_agent              ./_work/sgdma_mm2st_descriptor_read_agent/
	vlib                                                ./_work/sgdma_mm2st_descriptor_read_translator/
	vmap sgdma_mm2st_descriptor_read_translator         ./_work/sgdma_mm2st_descriptor_read_translator/
	vlib                                                ./_work/hps_io/
	vmap hps_io                                         ./_work/hps_io/
	vlib                                                ./_work/fpga_interfaces/
	vmap fpga_interfaces                                ./_work/fpga_interfaces/
	vlib                                                ./_work/rst_controller/
	vmap rst_controller                                 ./_work/rst_controller/
	vlib                                                ./_work/mm_interconnect_1/
	vmap mm_interconnect_1                              ./_work/mm_interconnect_1/
	vlib                                                ./_work/mm_interconnect_0/
	vmap mm_interconnect_0                              ./_work/mm_interconnect_0/
	vlib                                                ./_work/sysid_qsys/
	vmap sysid_qsys                                     ./_work/sysid_qsys/
	vlib                                                ./_work/st2mm_data_adapter/
	vmap st2mm_data_adapter                             ./_work/st2mm_data_adapter/
	vlib                                                ./_work/signal_buffer_ctrl/
	vmap signal_buffer_ctrl                             ./_work/signal_buffer_ctrl/
	vlib                                                ./_work/signal_buffer/
	vmap signal_buffer                                  ./_work/signal_buffer/
	vlib                                                ./_work/sgdma_st2mm/
	vmap sgdma_st2mm                                    ./_work/sgdma_st2mm/
	vlib                                                ./_work/sgdma_mm2st/
	vmap sgdma_mm2st                                    ./_work/sgdma_mm2st/
	vlib                                                ./_work/sample2lvl_converter/
	vmap sample2lvl_converter                           ./_work/sample2lvl_converter/
	vlib                                                ./_work/output_ctrl/
	vmap output_ctrl                                    ./_work/output_ctrl/
	vlib                                                ./_work/onchip_RAM/
	vmap onchip_RAM                                     ./_work/onchip_RAM/
	vlib                                                ./_work/mm2st_data_adapter/
	vmap mm2st_data_adapter                             ./_work/mm2st_data_adapter/
	vlib                                                ./_work/limits_buffer_ctrl/
	vmap limits_buffer_ctrl                             ./_work/limits_buffer_ctrl/
	vlib                                                ./_work/limits_buffer/
	vmap limits_buffer                                  ./_work/limits_buffer/
	vlib                                                ./_work/led_pio/
	vmap led_pio                                        ./_work/led_pio/
	vlib                                                ./_work/iteration_ctrl/
	vmap iteration_ctrl                                 ./_work/iteration_ctrl/
	vlib                                                ./_work/hps_0/
	vmap hps_0                                          ./_work/hps_0/
	vlib                                                ./_work/hard_limiter_out_splitter/
	vmap hard_limiter_out_splitter                      ./_work/hard_limiter_out_splitter/
	vlib                                                ./_work/hard_limiter/
	vmap hard_limiter                                   ./_work/hard_limiter/
	vlib                                                ./_work/fir_filter/
	vmap fir_filter                                     ./_work/fir_filter/
	vlib                                                ./_work/fir_fifo_in/
	vmap fir_fifo_in                                    ./_work/fir_fifo_in/
	vlib                                                ./_work/fir_driver/
	vmap fir_driver                                     ./_work/fir_driver/
	vlib                                                ./_work/dipsw_pio/
	vmap dipsw_pio                                      ./_work/dipsw_pio/
	vlib                                                ./_work/button_pio/
	vmap button_pio                                     ./_work/button_pio/
	vlib                                                ./_work/dut_rtl/
	vmap dut_rtl                                        ./_work/dut_rtl/
	vlib                                                ./_work/dut_tb/
	vmap dut_tb                                         ./_work/dut_tb/
	vlib                                                ./_work/uvm_pkg/
	vmap uvm_pkg                                        ./_work/uvm_pkg/

cyclonev_common:
	vlog     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/altera_primitives.v                     -work altera_ver
	vlog     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/220model.v                              -work lpm_ver
	vlog     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/sgate.v                                 -work sgate_ver
	vlog     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/altera_mf.v                             -work altera_mf_ver
	vlog -sv $(QUARTUS_INSTALL_DIR)/eda/sim_lib/altera_lnsim.sv                         -work altera_lnsim_ver
	vlog     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v          -work cyclonev_ver
	vlog     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/mentor/cyclonev_hmi_atoms_ncrypt.v      -work cyclonev_ver
	vlog     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/cyclonev_atoms.v                        -work cyclonev_ver
	vlog     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/mentor/cyclonev_hssi_atoms_ncrypt.v     -work cyclonev_hssi_ver
	vlog     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/cyclonev_hssi_atoms.v                   -work cyclonev_hssi_ver
	vlog     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/mentor/cyclonev_pcie_hip_atoms_ncrypt.v -work cyclonev_pcie_hip_ver
	vlog     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/cyclonev_pcie_hip_atoms.v               -work cyclonev_pcie_hip_ver
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/altera_syn_attributes.vhd               -work altera
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/altera_standard_functions.vhd           -work altera
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/alt_dspbuilder_package.vhd              -work altera
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/altera_europa_support_lib.vhd           -work altera
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/altera_primitives_components.vhd        -work altera
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/altera_primitives.vhd                   -work altera
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/220pack.vhd                             -work lpm
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/220model.vhd                            -work lpm
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/sgate_pack.vhd                          -work sgate
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/sgate.vhd                               -work sgate
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/altera_mf_components.vhd                -work altera_mf
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/altera_mf.vhd                           -work altera_mf
	vlog -sv $(QUARTUS_INSTALL_DIR)/eda/sim_lib/mentor/altera_lnsim_for_vhdl.sv         -work altera_lnsim
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/altera_lnsim_components.vhd             -work altera_lnsim
	vlog     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v          -work cyclonev
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/cyclonev_atoms.vhd                      -work cyclonev
	vcom     $(QUARTUS_INSTALL_DIR)/eda/sim_lib/cyclonev_components.vhd                 -work cyclonev

altera_libs: cyclonev_common
	vlog -sv $(QSYS_SIMDIR)/submodules/verbosity_pkg.sv                                                                            -work altera_common_sv_packages
	vlog -sv $(QSYS_SIMDIR)/submodules/avalon_utilities_pkg.sv                                                                     -work altera_common_sv_packages
	vlog -sv $(QSYS_SIMDIR)/submodules/avalon_mm_pkg.sv                                                                            -work altera_common_sv_packages
	vlog     $(QSYS_SIMDIR)/submodules/altera_reset_synchronizer.v                                                                 -work rst_controller
	vlog     $(QSYS_SIMDIR)/submodules/altera_reset_controller.v                                                                   -work rst_controller
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_incr_burst_converter.sv                                 -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_wrap_burst_converter.sv                                 -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_default_burst_converter.sv                              -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_avalon_interrupt_sink.sv                                -L altera_common_sv_packages -work border
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_avalon_clock_source.sv                                  -L altera_common_sv_packages -work border
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_avalon_reset_source.sv                                  -L altera_common_sv_packages -work border
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_avalon_st_pipeline_stage.sv                             -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_avalon_st_pipeline_base.v                               -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_avalon_sc_fifo.v                                        -L altera_common_sv_packages -work sgdma_mm2st_descriptor_read_limiter
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_merlin_burst_adapter_uncmpr.sv                          -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_merlin_burst_adapter_13_1.sv                            -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_merlin_burst_adapter_new.sv                             -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_merlin_address_alignment.sv                             -L altera_common_sv_packages -work sysid_qsys_control_slave_burst_adapter
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_merlin_burst_uncompressor.sv                            -L altera_common_sv_packages -work sysid_qsys_control_slave_agent
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_merlin_axi_master_ni.sv                                 -L altera_common_sv_packages -work hps_0_h2f_lw_axi_master_agent
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_merlin_width_adapter.sv                                 -L altera_common_sv_packages -work sgdma_mm2st_descriptor_write_rsp_width_adapter
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_merlin_reorder_memory.sv                                -L altera_common_sv_packages -work sgdma_mm2st_descriptor_read_limiter
	vlog -sv $(QSYS_SIMDIR)/submodules/altera_merlin_master_translator.sv                             -L altera_common_sv_packages -work sgdma_mm2st_descriptor_read_translator
	vlog -sv $(QSYS_SIMDIR)/submodules/questa_mvc_svapi.svh                                           -L altera_common_sv_packages -work fpga_interfaces
	vlog -sv $(QSYS_SIMDIR)/submodules/mgc_common_axi.sv                                              -L altera_common_sv_packages -work fpga_interfaces
	vlog -sv $(QSYS_SIMDIR)/submodules/mgc_axi_master.sv                                              -L altera_common_sv_packages -work fpga_interfaces
	vlog -sv $(QSYS_SIMDIR)/submodules/mgc_axi_slave.sv                                               -L altera_common_sv_packages -work fpga_interfaces
	vcom     $(RTL_DIR)/fir_filter_ip/fir_filter_sim/dspba_library_package.vhd                                                     -work fir_filter
	vcom     $(RTL_DIR)/fir_filter_ip/fir_filter_sim/dspba_library.vhd                                                             -work fir_filter
	vcom     $(RTL_DIR)/fir_filter_ip/fir_filter_sim/auk_dspip_math_pkg_hpfir.vhd                                                  -work fir_filter
	vcom     $(RTL_DIR)/fir_filter_ip/fir_filter_sim/auk_dspip_lib_pkg_hpfir.vhd                                                   -work fir_filter
	vcom     $(RTL_DIR)/fir_filter_ip/fir_filter_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd                               -work fir_filter
	vcom     $(RTL_DIR)/fir_filter_ip/fir_filter_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd                                     -work fir_filter
	vcom     $(RTL_DIR)/fir_filter_ip/fir_filter_sim/auk_dspip_avalon_streaming_source_hpfir.vhd                                   -work fir_filter
	vcom     $(RTL_DIR)/fir_filter_ip/fir_filter_sim/auk_dspip_roundsat_hpfir.vhd                                                  -work fir_filter
	vcom     $(RTL_DIR)/fir_filter_ip/fir_filter_sim/fir_filter_rtl_core.vhd                                                       -work fir_filter
	vcom     $(RTL_DIR)/fir_filter_ip/fir_filter_sim/fir_filter_ast.vhd                                                            -work fir_filter
	vcom     $(RTL_DIR)/fir_filter_ip/fir_filter_sim/fir_filter.vhd                                                                -work fir_filter
	vcom     $(RTL_DIR)/fir_filter_ip/fir_filter_sim/fir_filter_tb.vhd                                                             -work fir_filter
