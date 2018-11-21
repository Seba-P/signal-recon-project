
module dut_top();

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  import common_share_pkg::*;
  import tb_params_pkg::*;
  import avalon_st_agent_pkg::*;
  // import avalon_st_vip_pkg::*;
  import fir_subsystem_env_pkg::*;
  import tests_pkg::*;

  logic reset;
  logic clock;

  avalon_st_if #(avalon_st_inst_specs[MM2ST]) mm2st_if
  (
    .reset  (reset),
    .clock  (clock)
  );

  avalon_st_if #(avalon_st_inst_specs[ST2MM]) st2mm_if
  (
    .reset  (reset),
    .clock  (clock)
  );

  dut_if m_dut_if
  (
    .reset  (reset),
    .clock  (clock)
  );

  /* Disable for now */
  assign m_dut_if.csr_address           = '0;
  assign m_dut_if.csr_chipselect        = '0;
  assign m_dut_if.csr_read              = '0;
  assign m_dut_if.csr_write             = '0;
  assign m_dut_if.csr_writedata         = '0;

  assign m_dut_if.mm2st_data            = mm2st_if.footprint_if.data;
  assign m_dut_if.mm2st_valid           = mm2st_if.footprint_if.valid;
  assign mm2st_if.footprint_if.ready    = m_dut_if.mm2st_ready;
  assign st2mm_if.footprint_if.data     = m_dut_if.st2mm_data;
  assign st2mm_if.footprint_if.valid    = m_dut_if.st2mm_valid;
  assign m_dut_if.st2mm_ready           = st2mm_if.footprint_if.ready;

  dut_wrapper
  #(
    .FIR_TAPS_NUM       (FIR_TAPS_NUM),
    .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM),
    .LVLS_NUM           (LVLS_NUM),
    .LVL_RESET_VALUE    (LVL_RESET_VALUE),
    .ITER_NUM           (ITER_NUM)
  )
  DUT
  (
    .m_dut_if (m_dut_if)
  );

  initial
  begin
    clock = 1'b0;
    reset = 1'b1;

    #10 reset = 1'b0;
  end

  initial
    forever
        #0.5 clock = ~clock;

  initial
  begin
    uvm_config_db#(virtual avalon_st_if #(avalon_st_inst_specs[MM2ST]))::set(null, "uvm_test_top", "mm2st_if", mm2st_if);
    uvm_config_db#(virtual avalon_st_if #(avalon_st_inst_specs[ST2MM]))::set(null, "uvm_test_top", "st2mm_if", st2mm_if);

    run_test();
  end
endmodule
