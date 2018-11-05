
package test_seqs_pkg;

  import uvm_pkg::*;
	`include "uvm_macros.svh"

  import common_share_pkg::*;
  import tb_params_pkg::*;
  import avalon_st_agent_pkg::*;

	`include "mm2st_seq_item.svh"
	`include "st2mm_seq_item.svh"
	`include "base_mm2st_seq.svh"
	`include "base_st2mm_seq.svh"

	`include "mm2st_lvls_sweep_seq.svh"
	`include "st2mm_lvls_sweep_seq.svh"

endpackage : test_seqs_pkg
