
package tb_params_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import register_file_defs_pkg::*;
  import avalon_mm_agent_pkg::*;
  import avalon_st_agent_pkg::*;
  import common_share_pkg::*;

  // HACK: This has to be declared here, because the 'register_model_pkg' is not compiled yet
  typedef struct
  {
    string        reg_model_name;
    string        hdl_path_root;
    uvm_path_e    default_path;
    uvm_verbosity verbosity;
  } register_model_params_t;

  typedef enum bit [1:0]
  {
    CSR,
    AVALON_MM_AGENTS_NUM
  } avalon_mm_agent_e;

  typedef enum bit [1:0]
  {
    POCS_IN,
    POCS_OUT,
    AVALON_ST_AGENTS_NUM
  } avalon_st_agent_e;

  parameter avalon_mm_inst_spec_t avalon_mm_inst_specs[AVALON_MM_AGENTS_NUM] =
  '{
    '{
      /*addr_width*/  32,
      /*data_width*/  32,
      /*vif_modport*/ MODPORT_MASTER
    }
  };

  parameter avalon_mm_agent_params_t avalon_mm_agent_params[AVALON_MM_AGENTS_NUM] =
  '{
    '{
      /*addr_width*/  32,
      /*data_width*/  32,
      /*vif_modport*/ MODPORT_MASTER,
      /*agent_name*/  "CSR",
      /*is_active*/   UVM_ACTIVE,
      /*verbosity*/   UVM_LOW,
      /*vif_name*/    "csr_if"
    }
  };

  parameter avalon_st_inst_spec_t avalon_st_inst_specs[AVALON_ST_AGENTS_NUM] =
  '{
    '{
      /*bus_width*/   16,
      /*vif_modport*/ MODPORT_SOURCE
    },
    '{
      /*bus_width*/   16,
      /*vif_modport*/ MODPORT_SINK
    }
  };

  parameter avalon_st_agent_params_t avalon_st_agent_params[AVALON_ST_AGENTS_NUM] =
  '{
    '{
      /*bus_width*/   16,
      /*vif_modport*/ MODPORT_SOURCE,
      /*agent_name*/  "POCS_IN",
      /*is_active*/   UVM_ACTIVE,
      /*verbosity*/   UVM_LOW,
      /*vif_name*/    "pocs_in_if"
    },
    '{
      /*bus_width*/   16,
      /*vif_modport*/ MODPORT_SINK,
      /*agent_name*/  "POCS_OUT",
      /*is_active*/   UVM_ACTIVE,
      /*verbosity*/   UVM_LOW,
      /*vif_name*/    "pocs_out_if"
    }
  };

  parameter register_model_params_t register_model_params =
  '{
    /*reg_model_name*/  "REG_MODEL",
    /*hdl_path_root*/   "dut_top.DUT.DUT.register_file.csr_reg_block",
    /*default_path*/    UVM_FRONTDOOR,
    /*verbosity*/       UVM_MEDIUM
  };

  typedef avalon_mm_sequencer #(avalon_mm_inst_specs[CSR])      csr_sequencer;
  typedef avalon_st_sequencer #(avalon_st_inst_specs[POCS_IN])  pocs_in_sequencer;
  typedef avalon_st_sequencer #(avalon_st_inst_specs[POCS_OUT]) pocs_out_sequencer;

  `include "csr_seq_item.svh"
  `include "pocs_in_seq_item.svh"
  `include "pocs_out_seq_item.svh"

endpackage : tb_params_pkg
