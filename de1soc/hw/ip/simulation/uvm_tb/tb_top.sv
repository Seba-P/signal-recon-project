
module tb_top();

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  import common_share_pkg::*;
  import register_file_defs_pkg::*;
  import tb_params_pkg::*;
  import avalon_mm_agent_pkg::*;
  import avalon_st_agent_pkg::*;
  import tests_pkg::*;

  initial
  begin
    uvm_config_db#(virtual avalon_mm_if #(avalon_mm_inst_specs[CSR]))::set(null, "uvm_test_top", "csr_if", dut_top.csr_if);
    uvm_config_db#(virtual avalon_st_if #(avalon_st_inst_specs[POCS_IN]))::set(null, "uvm_test_top", "pocs_in_if", dut_top.pocs_in_if);
    uvm_config_db#(virtual avalon_st_if #(avalon_st_inst_specs[POCS_OUT]))::set(null, "uvm_test_top", "pocs_out_if", dut_top.pocs_out_if);

    run_test();
  end

endmodule : tb_top
