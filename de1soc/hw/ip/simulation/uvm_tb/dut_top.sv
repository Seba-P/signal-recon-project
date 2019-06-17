
module dut_top();

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  import common_share_pkg::*;
  import register_file_defs_pkg::*;
  import tb_params_pkg::*;
  import avalon_mm_agent_pkg::*;
  import avalon_st_agent_pkg::*;
  import tests_pkg::*;

  logic reset;
  logic clock;
  logic icn_enable;

  avalon_mm_if #(avalon_mm_inst_specs[CSR]) csr_if
  (
    .reset  (reset),
    .clock  (clock)
  );

  avalon_st_if #(avalon_st_inst_specs[POCS_IN]) pocs_in_if
  (
    .reset  (reset),
    .clock  (clock)
  );

  avalon_st_if #(avalon_st_inst_specs[POCS_OUT]) pocs_out_if
  (
    .reset  (reset),
    .clock  (clock)
  );

  dut_if m_dut_if
  (
    .reset  (reset),
    .clock  (clock)
  );

  assign icn_enable = (csr_if.footprint_if.address >= CSR_REG_BLOCK_START) && (csr_if.footprint_if.address <= CSR_REG_BLOCK_END);

  assign m_dut_if.csr_address             = csr_if.footprint_if.address;
  assign m_dut_if.csr_byteenable          = csr_if.footprint_if.byteenable;
  assign m_dut_if.csr_read                = csr_if.footprint_if.read & icn_enable;
  assign csr_if.footprint_if.readdata     = m_dut_if.csr_readdata;
  assign csr_if.footprint_if.response     = m_dut_if.csr_response | { 2{ ~icn_enable } };
  assign m_dut_if.csr_write               = csr_if.footprint_if.write & icn_enable;
  assign m_dut_if.csr_writedata           = csr_if.footprint_if.writedata;
  assign csr_if.footprint_if.waitrequest  = m_dut_if.csr_waitrequest;

  assign m_dut_if.pocs_in_data            = pocs_in_if.footprint_if.data;
  assign m_dut_if.pocs_in_valid           = pocs_in_if.footprint_if.valid;
  assign pocs_in_if.footprint_if.ready    = m_dut_if.pocs_in_ready;

  assign pocs_out_if.footprint_if.data    = m_dut_if.pocs_out_data;
  assign pocs_out_if.footprint_if.valid   = m_dut_if.pocs_out_valid;
  assign m_dut_if.pocs_out_ready          = pocs_out_if.footprint_if.ready;

  dut_wrapper
  #(
    .FIR_TAPS_NUM       (FIR_TAPS_NUM),
    .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM),
    .MAX_LVLS_NUM       (MAX_LVLS_NUM),
    .MAX_ITER_NUM       (MAX_ITER_NUM)
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
    uvm_config_db#(virtual avalon_mm_if #(avalon_mm_inst_specs[CSR]))::set(null, "uvm_test_top", "csr_if", csr_if);
    uvm_config_db#(virtual avalon_st_if #(avalon_st_inst_specs[POCS_IN]))::set(null, "uvm_test_top", "pocs_in_if", pocs_in_if);
    uvm_config_db#(virtual avalon_st_if #(avalon_st_inst_specs[POCS_OUT]))::set(null, "uvm_test_top", "pocs_out_if", pocs_out_if);

    run_test();
  end

endmodule : dut_top
