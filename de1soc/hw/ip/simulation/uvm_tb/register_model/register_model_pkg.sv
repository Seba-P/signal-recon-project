
package register_model_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import register_file_defs_pkg::*;
  import avalon_mm_agent_pkg::*;
  import common_share_pkg::*;
  import tb_params_pkg::*;

  typedef struct
  {
    string        reg_model_name;
    string        hdl_path_root;
    uvm_path_e    default_path;
    uvm_verbosity verbosity;
  } register_model_params_t;

  `include "status_reg.svh"
  `include "control_reg.svh"
  `include "params_reg.svh"
  `include "lvl_val_xx_yy_reg.svh"

  `include "csr_reg_block.svh"
  `include "csr_reg_block_adapter.svh"
  `include "csr_reg_block_config.svh"

  typedef uvm_reg_predictor #(avalon_mm_seq_item #(avalon_mm_inst_specs[CSR])) csr_reg_block_predictor;

  `include "register_model_config.svh"
  `include "register_model.svh"

endpackage : register_model_pkg
