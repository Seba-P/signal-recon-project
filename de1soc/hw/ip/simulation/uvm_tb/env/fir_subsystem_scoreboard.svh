
`ifndef _FIR_SUBSYSTEM_SCOREBOARD_SVH_
`define _FIR_SUBSYSTEM_SCOREBOARD_SVH_

// typedef struct
// {
//   logic [ST2MM.INS] expected_data[$];
//   logic [ST2MM.INS] received_data[$];
// } scoreboard_database;

`uvm_analysis_imp_decl(_mm2st)
`uvm_analysis_imp_decl(_st2mm)

class fir_subsystem_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fir_subsystem_scoreboard)

  // uvm_analysis_imp_mm2st #(mm2st_seq_item, fir_subsystem_scoreboard) m_mm2st_ap;
  uvm_analysis_imp_mm2st #(avalon_st_seq_item #(avalon_st_inst_specs[MM2ST]), fir_subsystem_scoreboard) m_mm2st_ap;
  // uvm_analysis_imp_st2mm #(st2mm_seq_item, fir_subsystem_scoreboard) m_st2mm_ap;
  uvm_analysis_imp_st2mm #(avalon_st_seq_item #(avalon_st_inst_specs[ST2MM]), fir_subsystem_scoreboard) m_st2mm_ap;

  scoreboard_database #(avalon_st_inst_specs[ST2MM])  database;
  bit [$bits(LVLS_NUM-1)-1:0]                         curr_lvl;
  bit [$bits(LVLS_NUM-1)-1:0]                         next_lvl;
  bit [avalon_st_inst_specs[ST2MM].BUS_WIDTH-1:0]     upper_limit;
  bit [avalon_st_inst_specs[ST2MM].BUS_WIDTH-1:0]     lower_limit;

  // Standard UVM Methods:
  extern function new(string name = "fir_subsystem_scoreboard", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);

  // Custom methods:
  // extern function void write_mm2st(mm2st_seq_item item);
  extern function void write_mm2st(avalon_st_seq_item #(avalon_st_inst_specs[MM2ST]) item);
  // extern function void write_st2mm(st2mm_seq_item item);
  extern function void write_st2mm(avalon_st_seq_item #(avalon_st_inst_specs[ST2MM]) item);
  // extern task verify_lvls(); // TODO:
endclass : fir_subsystem_scoreboard

function fir_subsystem_scoreboard::new(string name = "fir_subsystem_scoreboard", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void fir_subsystem_scoreboard::build_phase(uvm_phase phase);
  m_mm2st_ap  = new("m_mm2st_ap", this);
  m_st2mm_ap  = new("m_st2mm_ap", this);

  database    = scoreboard_database#(avalon_st_inst_specs[ST2MM])::type_id::create("database");
  curr_lvl    = LVL_RESET_VALUE;
  next_lvl    = LVL_RESET_VALUE;
  upper_limit = lvls_values[LVL_RESET_VALUE+1];
  lower_limit = lvls_values[LVL_RESET_VALUE];

  `uvm_info("SCOREBOARD", $sformatf("Scoreboard initial settings:\n    Current/next level = %0d/%0d;\n    Upper/lower limit  = %04h/%04h",
                                      curr_lvl, next_lvl, upper_limit, lower_limit), UVM_HIGH)
endfunction : build_phase

// function void fir_subsystem_scoreboard::write_mm2st(mm2st_seq_item item);
function void fir_subsystem_scoreboard::write_mm2st(avalon_st_seq_item #(avalon_st_inst_specs[MM2ST]) item);
  avalon_st_seq_item #(avalon_st_inst_specs[MM2ST]) cloned_item;
  lvl_cross_sample_t          sample;
  bit overflow;
  bit overflow_d1;
  bit underflow;
  bit underflow_d1;
  int i;

  `uvm_info("SCOREBOARD", $sformatf("Received mm2st_seq_item: %s", item.convert2string()), UVM_HIGH)

  if (!$cast(cloned_item, item.clone()))
      `uvm_fatal("clone", "Clone of sequence item failed.")

  if (cloned_item.burst_len != cloned_item.data.size())
      `uvm_error("write_mm2st", $sformatf("Burst length mismatch (burst_len = %0d, data.size() = %0d)!",
                                            cloned_item.burst_len, cloned_item.data.size()))

  overflow  = 0;
  underflow = 0;

  /* Store initial lvls */
  repeat ($ceil(FIR_TAPS_NUM/2.0) * ITER_NUM)
  begin
    database.expected_upper_limit.push_back(upper_limit);
    database.expected_lower_limit.push_back(lower_limit);
    // database.expected_value.push_back(...); TODO:
  
    `uvm_info("SCOREBOARD", $sformatf("Pushing initial %0d limits to database (radix hex): %04h/%04h (lvls %s)",
                                        $ceil(FIR_TAPS_NUM/2.0) * ITER_NUM, upper_limit, lower_limit,
                                        $sformatf("%0d/%0d", next_lvl+1, next_lvl)),
                                      UVM_HIGH)
  end

  while (cloned_item.data.size())
  begin
    sample = lvl_cross_sample_t'(cloned_item.data.pop_front());

    `uvm_info("SCOREBOARD", $sformatf("Received mm2st sample: %s::%0d", sample.lvl_cross_dir.name(), sample.timestamp), UVM_LOW)

    overflow_d1   = overflow;
    overflow      = (next_lvl >= LVLS_NUM-2 && sample.lvl_cross_dir == LVL_UP);
    underflow_d1  = underflow;
    underflow     = (next_lvl == 0 && sample.lvl_cross_dir == LVL_DOWN);
    curr_lvl      = next_lvl;

    if (sample.lvl_cross_dir == LVL_UP)
    begin
      if (!overflow_d1)
        next_lvl += !underflow_d1;

      upper_limit = overflow ? 16'h7FFF : lvls_values[next_lvl+1];
      lower_limit = lvls_values[next_lvl];
    end
    else
    begin
      if (!underflow)
        next_lvl -= 1;

      upper_limit = lvls_values[next_lvl+!underflow];
      lower_limit = underflow ? 16'h8000 : lvls_values[next_lvl];
    end

    for (i = 0; i < sample.timestamp; i++)
    begin
      database.expected_upper_limit.push_back(upper_limit);
      database.expected_lower_limit.push_back(lower_limit);
      // database.expected_value.push_back(...); TODO:

      `uvm_info("SCOREBOARD", $sformatf("Pushing expected limits to database (radix hex): %04h/%04h (lvls %s)",
                                          upper_limit, lower_limit,
                                          overflow ?
                                            $sformatf(">max/%0d", LVLS_NUM-1) :
                                              underflow ?
                                                $sformatf("%0d/<min", 0) : $sformatf("%0d/%0d", next_lvl+1, next_lvl)),
                                        UVM_HIGH)
    end
  end
endfunction : write_mm2st

// function void fir_subsystem_scoreboard::write_st2mm(st2mm_seq_item item);
function void fir_subsystem_scoreboard::write_st2mm(avalon_st_seq_item #(avalon_st_inst_specs[ST2MM]) item);
  avalon_st_seq_item #(avalon_st_inst_specs[ST2MM]) cloned_item;
  logic [avalon_st_inst_specs[ST2MM].BUS_WIDTH-1:0] received_value;

  `uvm_info("SCOREBOARD", $sformatf("Received st2mm_seq_item: %s", item.convert2string()), UVM_HIGH)

  if (!$cast(cloned_item, item.clone()))
      `uvm_fatal("clone", "Clone of sequence item failed.")

  if (cloned_item.burst_len != cloned_item.data.size())
      `uvm_error("write_st2mm", $sformatf("Burst length mismatch (burst_len = %0d, data.size() = %0d)!",
                                            cloned_item.burst_len, cloned_item.data.size()))

  while (cloned_item.data.size())
  begin
    received_value = cloned_item.data.pop_front();
    database.received_value.push_back(received_value);

    `uvm_info("SCOREBOARD", $sformatf("Pushing received value to database (radix hex): %04h", received_value), UVM_HIGH)
  end
endfunction : write_st2mm

`endif // _FIR_SUBSYSTEM_SCOREBOARD_SVH_
