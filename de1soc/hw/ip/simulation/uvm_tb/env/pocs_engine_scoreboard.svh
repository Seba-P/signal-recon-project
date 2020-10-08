
`ifndef _POCS_ENGINE_SCOREBOARD_SVH_
`define _POCS_ENGINE_SCOREBOARD_SVH_

`uvm_analysis_imp_decl(_pocs_in)
`uvm_analysis_imp_decl(_pocs_out)

class pocs_engine_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(pocs_engine_scoreboard)

  // uvm_analysis_imp_pocs_in #(pocs_in_seq_item, pocs_engine_scoreboard) m_pocs_in_ap;
  uvm_analysis_imp_pocs_in #(avalon_st_seq_item #(avalon_st_inst_specs[POCS_IN]), pocs_engine_scoreboard) m_pocs_in_ap;
  // uvm_analysis_imp_pocs_out #(pocs_out_seq_item, pocs_engine_scoreboard) m_pocs_out_ap;
  uvm_analysis_imp_pocs_out #(avalon_st_seq_item #(avalon_st_inst_specs[POCS_OUT]), pocs_engine_scoreboard) m_pocs_out_ap;

  csr_reg_block_config  m_csr_config;
  bit                   is_active;

  scoreboard_database #(avalon_st_inst_specs[POCS_OUT]) m_database;
  bit [$bits(MAX_LVLS_NUM-1)-1:0]                       curr_lvl;
  bit [$bits(MAX_LVLS_NUM-1)-1:0]                       next_lvl;

  bit [15:0] m_lvls_values[MAX_LVLS_NUM];
  int m_init_lvl    = DEFAULT_INIT_LVL;
  int m_lvls_num    = DEFAULT_LVLS_NUM;
  int m_iter_num    = DEFAULT_ITER_NUM;
  int m_init_guess  = DEFAULT_INIT_GUESS;

  semaphore pocs_in_data_count_sem;
  semaphore pocs_in_queue_lock_sem;
  semaphore pocs_out_data_count_sem;
  semaphore pocs_out_queue_lock_sem;

  int expected_count;
  int received_count;

  // Standard UVM Methods:
  extern function       new(string name = "pocs_engine_scoreboard", uvm_component parent = null);
  extern function void  build_phase(uvm_phase phase);
  extern task           main_phase(uvm_phase phase);

  // Custom methods:
  // extern function void  write_pocs_in(pocs_in_seq_item item);
  extern function void  write_pocs_in(avalon_st_seq_item #(avalon_st_inst_specs[POCS_IN]) item);
  // extern function void  write_pocs_out(pocs_out_seq_item item);
  extern function void  write_pocs_out(avalon_st_seq_item #(avalon_st_inst_specs[POCS_OUT]) item);
  extern task           csr_supervisor();
  extern task           dataflow_supervisor();
  extern task           verify_limits();
endclass : pocs_engine_scoreboard

function pocs_engine_scoreboard::new(string name = "pocs_engine_scoreboard", uvm_component parent = null);
  super.new(name, parent);

  pocs_in_data_count_sem  = new(0);
  pocs_in_queue_lock_sem  = new(1);
  pocs_out_data_count_sem = new(0);
  pocs_out_queue_lock_sem = new(1);
endfunction : new

function void pocs_engine_scoreboard::build_phase(uvm_phase phase);
  if (!uvm_config_db#(csr_reg_block_config)::get(this, "", "m_csr_config", m_csr_config))
    `uvm_fatal("CONFIG", "Cannot get() 'm_csr_config' from uvm_config_db. Have you set() it?")

  m_pocs_in_ap  = new("m_pocs_in_ap", this);
  m_pocs_out_ap = new("m_pocs_out_ap", this);
  m_database    = scoreboard_database#(avalon_st_inst_specs[POCS_OUT])::type_id::create("m_database", this);

  is_active       = 0;
  expected_count  = 0;
  received_count  = 0;
endfunction : build_phase

task pocs_engine_scoreboard::main_phase(uvm_phase phase);
  m_init_lvl    = m_csr_config.m_csr_reg_block.params.init_lvl;
  m_lvls_num    = m_csr_config.m_csr_reg_block.params.lvls_num;
  m_iter_num    = m_csr_config.m_csr_reg_block.params.iter_num;
  m_init_guess  = m_csr_config.m_csr_reg_block.params.init_guess;
  m_lvls_values[ 0] = m_csr_config.m_csr_reg_block.lvl_val_00_01.lvl_val_00;
  m_lvls_values[ 1] = m_csr_config.m_csr_reg_block.lvl_val_00_01.lvl_val_01;
  m_lvls_values[ 2] = m_csr_config.m_csr_reg_block.lvl_val_02_03.lvl_val_02;
  m_lvls_values[ 3] = m_csr_config.m_csr_reg_block.lvl_val_02_03.lvl_val_03;
  m_lvls_values[ 4] = m_csr_config.m_csr_reg_block.lvl_val_04_05.lvl_val_04;
  m_lvls_values[ 5] = m_csr_config.m_csr_reg_block.lvl_val_04_05.lvl_val_05;
  m_lvls_values[ 6] = m_csr_config.m_csr_reg_block.lvl_val_06_07.lvl_val_06;
  m_lvls_values[ 7] = m_csr_config.m_csr_reg_block.lvl_val_06_07.lvl_val_07;
  m_lvls_values[ 8] = m_csr_config.m_csr_reg_block.lvl_val_08_09.lvl_val_08;
  m_lvls_values[ 9] = m_csr_config.m_csr_reg_block.lvl_val_08_09.lvl_val_09;
  m_lvls_values[10] = m_csr_config.m_csr_reg_block.lvl_val_10_11.lvl_val_10;
  m_lvls_values[11] = m_csr_config.m_csr_reg_block.lvl_val_10_11.lvl_val_11;
  m_lvls_values[12] = m_csr_config.m_csr_reg_block.lvl_val_12_13.lvl_val_12;
  m_lvls_values[13] = m_csr_config.m_csr_reg_block.lvl_val_12_13.lvl_val_13;
  m_lvls_values[14] = m_csr_config.m_csr_reg_block.lvl_val_14_15.lvl_val_14;
  m_lvls_values[15] = m_csr_config.m_csr_reg_block.lvl_val_14_15.lvl_val_15;
  m_lvls_values[16] = m_csr_config.m_csr_reg_block.lvl_val_16_17.lvl_val_16;
  m_lvls_values[17] = m_csr_config.m_csr_reg_block.lvl_val_16_17.lvl_val_17;
  m_lvls_values[18] = m_csr_config.m_csr_reg_block.lvl_val_18_19.lvl_val_18;
  m_lvls_values[19] = m_csr_config.m_csr_reg_block.lvl_val_18_19.lvl_val_19;
  m_lvls_values[20] = m_csr_config.m_csr_reg_block.lvl_val_20_21.lvl_val_20;
  m_lvls_values[21] = m_csr_config.m_csr_reg_block.lvl_val_20_21.lvl_val_21;
  m_lvls_values[22] = m_csr_config.m_csr_reg_block.lvl_val_22_23.lvl_val_22;
  m_lvls_values[23] = m_csr_config.m_csr_reg_block.lvl_val_22_23.lvl_val_23;
  m_lvls_values[24] = m_csr_config.m_csr_reg_block.lvl_val_24_25.lvl_val_24;
  m_lvls_values[25] = m_csr_config.m_csr_reg_block.lvl_val_24_25.lvl_val_25;
  m_lvls_values[26] = m_csr_config.m_csr_reg_block.lvl_val_26_27.lvl_val_26;
  m_lvls_values[27] = m_csr_config.m_csr_reg_block.lvl_val_26_27.lvl_val_27;
  m_lvls_values[28] = m_csr_config.m_csr_reg_block.lvl_val_28_29.lvl_val_28;
  m_lvls_values[29] = m_csr_config.m_csr_reg_block.lvl_val_28_29.lvl_val_29;
  m_lvls_values[30] = m_csr_config.m_csr_reg_block.lvl_val_30_31.lvl_val_30;
  m_lvls_values[31] = m_csr_config.m_csr_reg_block.lvl_val_30_31.lvl_val_31;

  curr_lvl  = m_init_lvl;
  next_lvl  = m_init_lvl;

  `uvm_info("SCOREBOARD", $sformatf("Scoreboard initial settings:\n    Current level      = %0d;\n    Upper/lower limit  = %04h/%04h",
                                      curr_lvl, m_lvls_values[m_init_lvl+1], m_lvls_values[m_init_lvl]), UVM_HIGH)

  fork
    csr_supervisor();
    dataflow_supervisor();
    verify_limits();
  join
endtask : main_phase

// function void pocs_engine_scoreboard::write_pocs_in(pocs_in_seq_item item);
function void pocs_engine_scoreboard::write_pocs_in(avalon_st_seq_item #(avalon_st_inst_specs[POCS_IN]) item);
  avalon_st_seq_item #(avalon_st_inst_specs[POCS_IN]) cloned_item;
  bit [avalon_st_inst_specs[POCS_OUT].BUS_WIDTH-1:0]  upper_limit;
  bit [avalon_st_inst_specs[POCS_OUT].BUS_WIDTH-1:0]  lower_limit;
  lvl_cross_sample_t sample;
  bit overflow_curr, overflow_next;
  bit underflow_curr, underflow_next;
  int i;

  `uvm_info("SCOREBOARD", $sformatf("Received pocs_in_seq_item: %s", item.convert2string()), UVM_HIGH)

  if (!$cast(cloned_item, item.clone()))
      `uvm_fatal("clone", "Clone of 'item' object failed.")

  if (cloned_item.burst_len != cloned_item.data.size())
      `uvm_error("write_pocs_in", $sformatf("Burst length mismatch (burst_len = %0d, data.size() = %0d)!",
                                            cloned_item.burst_len, cloned_item.data.size()))

  while (cloned_item.data.size())
  begin
    sample = lvl_cross_sample_t'(cloned_item.data.pop_front());

    `uvm_info("SCOREBOARD", $sformatf("Received pocs_in sample: %s::%0d", sample.lvl_cross_dir.name(), sample.timestamp), UVM_LOW)

    curr_lvl        = next_lvl;
    overflow_curr   = overflow_next;
    underflow_curr  = underflow_next;

    overflow_next   = (curr_lvl >= m_lvls_num-2 && sample.lvl_cross_dir == LVL_UP);
    underflow_next  = (curr_lvl == 0 && sample.lvl_cross_dir == LVL_DOWN);

    if (sample.lvl_cross_dir == LVL_UP)
    begin
      if (!overflow_curr)
        next_lvl += !underflow_curr;
    end
    else
    begin
      if (!underflow_next)
        next_lvl -= 1;
    end

    upper_limit = overflow_curr ? 16'h7FFF : m_lvls_values[curr_lvl+!underflow_curr];
    lower_limit = underflow_curr ? 16'h8000 : m_lvls_values[curr_lvl];

    for (i = 0; i < sample.timestamp; i++)
    begin
      m_database.store_expected_limits({ upper_limit, lower_limit });
      // m_database.expected_value.push_back(...); TODO:

      `uvm_info("SCOREBOARD", $sformatf("Pushing expected limits to database (radix hex): %04h/%04h (lvls %s)",
                                          upper_limit, lower_limit,
                                          overflow_curr ?
                                            $sformatf(">max/%0d", m_lvls_num-1) :
                                              underflow_curr ?
                                                $sformatf("%0d/<min", 0) : $sformatf("%0d/%0d", curr_lvl+1, curr_lvl)),
                                        UVM_HIGH)
    end

    expected_count += sample.timestamp;
  end
endfunction : write_pocs_in

// function void pocs_engine_scoreboard::write_pocs_out(pocs_out_seq_item item);
function void pocs_engine_scoreboard::write_pocs_out(avalon_st_seq_item #(avalon_st_inst_specs[POCS_OUT]) item);
  avalon_st_seq_item #(avalon_st_inst_specs[POCS_OUT])  cloned_item;
  logic [avalon_st_inst_specs[POCS_OUT].BUS_WIDTH-1:0]  received_value;
  int burst_len;
  int value_num;

  `uvm_info("SCOREBOARD", $sformatf("Received pocs_out_seq_item: %s", item.convert2string()), UVM_HIGH)

  if (!$cast(cloned_item, item.clone()))
      `uvm_fatal("clone", "Clone of 'item' object failed.")

  if (cloned_item.burst_len != cloned_item.data.size())
      `uvm_error("write_pocs_out", $sformatf("Burst length mismatch (burst_len = %0d, data.size() = %0d)!",
                                            cloned_item.burst_len, cloned_item.data.size()))

  burst_len = cloned_item.data.size();
  value_num = received_count;

  while (cloned_item.data.size())
  begin
    received_value = cloned_item.data.pop_front();
    m_database.store_received_value(received_value);

    `uvm_info("SCOREBOARD", $sformatf("Pushing received value #%0d to database (radix hex): %04h", value_num, received_value), UVM_HIGH)
    value_num++;
  end

  received_count += burst_len;
endfunction : write_pocs_out


task pocs_engine_scoreboard::csr_supervisor();
  fork
    CHECK_RUN : begin
      // run_pulse.wait_ptrigger();
    end

    CHECK_HALT : begin

    end

    CHECK_FLUSH : begin

    end

    CHECK_INIT : begin

    end
  join
endtask : csr_supervisor

task pocs_engine_scoreboard::dataflow_supervisor();
  int received_count_old;
  int expected_count_old;
  int received_count_diff;
  int expected_count_diff;

  received_count_old = 0;
  expected_count_old = 0;

  forever
  begin
    #1; // TODO: replace with @(posedge dut.clock);

    // if (!is_active)
      // wait (is_active == 1);

    if (received_count != received_count_old)
    begin
      received_count_diff = received_count - received_count_old + (received_count < received_count_old) * 2**32;
      received_count_old  = received_count;

      pocs_out_data_count_sem.put(received_count_diff);
    end

    if (expected_count != expected_count_old)
    begin
      expected_count_diff = expected_count - expected_count_old + (expected_count < expected_count_old) * 2**32;
      expected_count_old  = expected_count;

      pocs_in_data_count_sem.put(expected_count_diff);
    end
  end
endtask : dataflow_supervisor

task pocs_engine_scoreboard::verify_limits();
  bit   [2*avalon_st_inst_specs[POCS_OUT].BUS_WIDTH-1:0]  expected_limits;
  logic [  avalon_st_inst_specs[POCS_OUT].BUS_WIDTH-1:0]  upper_limit;
  logic [  avalon_st_inst_specs[POCS_OUT].BUS_WIDTH-1:0]  lower_limit;
  logic [  avalon_st_inst_specs[POCS_OUT].BUS_WIDTH-1:0]  received_value;
  int initial_limits_count;

  /* Store initial lvls */
  upper_limit = m_lvls_values[m_init_lvl+1];
  lower_limit = m_lvls_values[m_init_lvl];

  // initial_limits_count = $ceil(FIR_TAPS_NUM/2.0) * m_iter_num;
  initial_limits_count = $floor(FIR_TAPS_NUM/2.0) * m_iter_num;

  pocs_in_queue_lock_sem.get(1);
  repeat (initial_limits_count)
  begin
    m_database.store_expected_limits({ upper_limit, lower_limit });
    // m_database.store_expected_value(...); TODO:
  
    `uvm_info("SCOREBOARD", $sformatf("Pushing initial %0d limits to database (radix hex): %04h/%04h (lvls %s)",
                                        initial_limits_count, upper_limit, lower_limit,
                                        $sformatf("%0d/%0d", m_init_lvl+1, m_init_lvl)),
                                      UVM_HIGH)
  end
  pocs_in_queue_lock_sem.put(1);
  pocs_in_data_count_sem.put(initial_limits_count);

  forever
  begin
    #1; // TODO: replace with @(posedge dut.clock);

    /* Wait for expected limits */
    pocs_in_data_count_sem.get(1);

    pocs_in_queue_lock_sem.get(1);
    expected_limits = m_database.load_expected_limits();
    pocs_in_queue_lock_sem.put(1);

    upper_limit = expected_limits[2*avalon_st_inst_specs[POCS_OUT].BUS_WIDTH-1:avalon_st_inst_specs[POCS_OUT].BUS_WIDTH];
    lower_limit = expected_limits[avalon_st_inst_specs[POCS_OUT].BUS_WIDTH-1:0];

    /* Wait for received data */
    pocs_out_data_count_sem.get(1);

    pocs_out_queue_lock_sem.get(1);
    received_value = m_database.load_received_value();
    pocs_out_queue_lock_sem.put(1);

    /* Compare results */
    if ($signed(received_value) > $signed(upper_limit))
    begin
      `uvm_error("SCOREBOARD", $sformatf("Received value #%0d (%04h) is above upper limit (%04h)!",
                                            m_database.total_num, received_value, upper_limit))
      m_database.errors_num++;
    end
    else if ($signed(received_value) < $signed(lower_limit))
    begin
      `uvm_error("SCOREBOARD", $sformatf("Received value #%0d (%04h) is below lower limit (%04h)!",
                                            m_database.total_num, received_value, lower_limit))
      m_database.errors_num++;
    end
    else
    begin
      `uvm_info("SCOREBOARD", $sformatf("Received value #%0d (%04h) is inbound (%04h/%04h)",
                                            m_database.total_num, received_value, upper_limit, lower_limit), UVM_HIGH)
    end

    m_database.total_num++;
  end
endtask : verify_limits

`endif // _POCS_ENGINE_SCOREBOARD_SVH_
