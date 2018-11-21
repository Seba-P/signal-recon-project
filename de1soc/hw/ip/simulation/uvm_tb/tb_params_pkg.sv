
package tb_params_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import common_share_pkg::*;
  import avalon_mm_agent_pkg::*;
  import avalon_st_agent_pkg::*;

  typedef enum bit [1:0]
  {
    MM2ST,
    ST2MM,
    AVALON_ST_AGENTS_NUM
  } avalon_st_agent_e;

  typedef enum bit [1:0]
  {
    CSR,
    AVALON_MM_AGENTS_NUM
  } avalon_mm_agent_e;

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
      /*agent_name*/  "MM2ST",
      /*is_active*/   UVM_ACTIVE,
      /*verbosity*/   UVM_LOW,
      /*vif_name*/    "mm2st_if"
    },
    '{
      /*bus_width*/   16,
      /*vif_modport*/ MODPORT_SINK,
      /*agent_name*/  "ST2MM",
      /*is_active*/   UVM_ACTIVE,
      /*verbosity*/   UVM_LOW,
      /*vif_name*/    "st2mm_if"
    }
  };

endpackage : tb_params_pkg
