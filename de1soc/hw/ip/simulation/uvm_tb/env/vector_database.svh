
`ifndef _VECTOR_DATABASE_SVH_
`define _VECTOR_DATABASE_SVH_

class vector_database #(avalon_st_inst_spec_t INST_SPEC) extends uvm_object;
  `uvm_object_param_utils(vector_database #(INST_SPEC))

  lvl_cross_sample_t              samples_vector[$];
  logic [INST_SPEC.BUS_WIDTH-1:0] signal_orig_vector[$];
  logic [INST_SPEC.BUS_WIDTH-1:0] signal_recon_vector[$];
  logic [31:0]                    config_vector[string];

  // Standard UVM Methods:
  extern function new(string name = "vector_database");
endclass : vector_database

function vector_database::new(string name = "vector_database");
  super.new(name);
endfunction : new

`endif // _VECTOR_DATABASE_SVH_
