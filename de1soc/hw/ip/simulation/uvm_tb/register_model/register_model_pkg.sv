
package register_model_pkg;

  import uvm_pkg::*;
	`include "uvm_macros.svh"

  import common_share_pkg::*;
  import register_file_defs_pkg::*;
  import tb_params_pkg::*;
  import avalon_mm_agent_pkg::*;
  import test_seqs_pkg::*;

  `include "status_reg.svh"
  `include "control_reg.svh"
  `include "params_reg.svh"
  `include "lvl_val_xx_yy_reg.svh"

  `include "csr_reg_block.svh"
  `include "csr_reg_block_adapter.svh"
  `include "csr_reg_block_config.svh"

endpackage : register_model_pkg
