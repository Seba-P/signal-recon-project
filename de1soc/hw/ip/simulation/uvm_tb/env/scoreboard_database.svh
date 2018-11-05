
`ifndef _SCOREBOARD_DATABASE_SVH_
`define _SCOREBOARD_DATABASE_SVH_

class scoreboard_database #(avalon_st_inst_spec_t INST_SPEC) extends uvm_object;
  `uvm_object_param_utils(scoreboard_database #(INST_SPEC))

  logic [2*INST_SPEC.BUS_WIDTH-1:0] expected_limits[$];
  logic [  INST_SPEC.BUS_WIDTH-1:0] expected_value[$];
  logic [  INST_SPEC.BUS_WIDTH-1:0] received_value[$];

  int total_num;
  int errors_num;

  // Standard UVM Methods:
  extern function new(string name = "scoreboard_database");
endclass : scoreboard_database

function scoreboard_database::new(string name = "scoreboard_database");
  super.new(name);
endfunction : new

`endif // _SCOREBOARD_DATABASE_SVH_
