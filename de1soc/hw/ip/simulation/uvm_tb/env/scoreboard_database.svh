
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

  // Custom methods:
  extern function void store_expected_limits(logic [2*INST_SPEC.BUS_WIDTH-1:0] limits);
  extern function void store_expected_value(logic [INST_SPEC.BUS_WIDTH-1:0] value);
  extern function void store_received_value(logic [INST_SPEC.BUS_WIDTH-1:0] value);
  extern function logic [2*INST_SPEC.BUS_WIDTH-1:0] load_expected_limits();
  extern function logic [  INST_SPEC.BUS_WIDTH-1:0] load_expected_value();
  extern function logic [  INST_SPEC.BUS_WIDTH-1:0] load_received_value();
endclass : scoreboard_database

function scoreboard_database::new(string name = "scoreboard_database");
  super.new(name);
endfunction : new

function void scoreboard_database::store_expected_limits(logic [2*INST_SPEC.BUS_WIDTH-1:0] limits);
	expected_limits.push_back(limits);
endfunction : store_expected_limits

function void scoreboard_database::store_expected_value(logic [INST_SPEC.BUS_WIDTH-1:0] value);
	expected_value.push_back(value);
endfunction : store_expected_value

function void scoreboard_database::store_received_value(logic [INST_SPEC.BUS_WIDTH-1:0] value);
	received_value.push_back(value);
endfunction : store_received_value

function logic [2*INST_SPEC.BUS_WIDTH-1:0] scoreboard_database::load_expected_limits();
	return expected_limits.pop_front();
endfunction : load_expected_limits

function logic [  INST_SPEC.BUS_WIDTH-1:0] scoreboard_database::load_expected_value();
	return expected_value.pop_front();
endfunction : load_expected_value

function logic [  INST_SPEC.BUS_WIDTH-1:0] scoreboard_database::load_received_value();
	return received_value.pop_front();
endfunction : load_received_value

`endif // _SCOREBOARD_DATABASE_SVH_
