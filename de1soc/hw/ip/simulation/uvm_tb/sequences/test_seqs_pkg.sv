
package test_seqs_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import register_file_defs_pkg::*;
  import avalon_mm_agent_pkg::*;
  import avalon_st_agent_pkg::*;
  import common_share_pkg::*;
  import tb_params_pkg::*;
  import register_model_pkg::*;
  import pocs_engine_env_pkg::*;

  `include "base_csr_seq.svh"
  `include "base_pocs_in_seq.svh"
  `include "base_pocs_out_seq.svh"

  `include "csr_init_config_seq.svh"
  `include "pocs_in_lvls_sweep_seq.svh"
  `include "pocs_out_lvls_sweep_seq.svh"
  `include "pocs_in_vector_seq.svh"
  `include "pocs_out_vector_seq.svh"

endpackage : test_seqs_pkg
