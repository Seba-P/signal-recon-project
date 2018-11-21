
package avalon_mm_agent_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	typedef enum bit
  {
    MODPORT_SLAVE   = 0,
    MODPORT_MASTER  = 1
  } modport_e;

  typedef enum bit
  {
    READ_OP   = 0,
    WRITE_OP  = 1
  } operation_e;

  typedef struct
  {
  	int       addr_width;
  	int       data_width;
		modport_e vif_modport;
		string		agent_name;
		uvm_active_passive_enum is_active;
  	int       verbosity;
		string    vif_name;
  } avalon_mm_agent_params_t;

  typedef struct
  {
  	int       ADDR_WIDTH;
  	int       DATA_WIDTH;
		modport_e VIF_MODPORT;
  } avalon_mm_inst_spec_t;

	`include "avalon_mm_seq_item.svh"
	`include "avalon_mm_seq.svh"
	`include "avalon_mm_sequencer.svh"
	`include "avalon_mm_agent_config.svh"
	`include "avalon_mm_driver.svh"
	`include "avalon_mm_monitor.svh"
	`include "avalon_mm_agent.svh"

endpackage : avalon_mm_agent_pkg
