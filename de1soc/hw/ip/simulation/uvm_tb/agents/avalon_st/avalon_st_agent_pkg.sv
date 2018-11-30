
package avalon_st_agent_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  typedef enum bit
  {
    MODPORT_SINK    = 0,
    MODPORT_SOURCE  = 1
  } modport_e;

  typedef struct
  {
    int                     bus_width;
    modport_e               vif_modport;
    string                  agent_name;
    uvm_active_passive_enum is_active;
    uvm_verbosity           verbosity;
    string                  vif_name;
  } avalon_st_agent_params_t;

  typedef struct
  {
    int       BUS_WIDTH;
    modport_e VIF_MODPORT;
  } avalon_st_inst_spec_t;

  `include "avalon_st_seq_item.svh"
  `include "avalon_st_seq.svh"
  `include "avalon_st_sequencer.svh"
  `include "avalon_st_agent_config.svh"
  `include "avalon_st_driver.svh"
  `include "avalon_st_monitor.svh"
  `include "avalon_st_agent.svh"

endpackage : avalon_st_agent_pkg
