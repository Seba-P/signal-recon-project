
import avalon_st_agent_pkg::*;

interface avalon_st_if
#(
  parameter avalon_st_inst_spec_t INST_SPEC
)
(
  input reset,
  input clock
);
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // logic                    [ 1:0] channel; -> not supported
  logic [INST_SPEC.BUS_WIDTH-1:0] data;
  logic                    [ 1:0] error;
  logic                           ready;
  logic                           valid;
  // logic                    [ 1:0] empty;   -> not supported
  logic                           start_of_packet;
  logic                           end_of_packet;

  avalon_st_footprint_if footprint_if
  (
    .reset(reset),
    .clock(clock)
  );

generate
  if(INST_SPEC.VIF_MODPORT == MODPORT_SOURCE)
  begin
    assign footprint_if.data[INST_SPEC.BUS_WIDTH-1:0] = data;
    assign footprint_if.error[1:0]                    = error;
    assign ready                                      = footprint_if.ready;
    assign footprint_if.valid                         = valid;
    assign footprint_if.start_of_packet               = start_of_packet;
    assign footprint_if.end_of_packet                 = end_of_packet;
  end
  else
  begin
    assign data               = footprint_if.data[INST_SPEC.BUS_WIDTH-1:0];
    assign error              = footprint_if.error[1:0];
    assign footprint_if.ready = ready;
    assign valid              = footprint_if.valid;
    assign start_of_packet    = footprint_if.start_of_packet;
    assign end_of_packet      = footprint_if.end_of_packet;
  end
endgenerate

  clocking avalon_st_source_cb @(posedge clock);
    // default input #0.1 output #0.1;
    default input #0 output #0;

    output  data;
    output  error;
    input   ready;
    output  valid;
    output  start_of_packet;
    output  end_of_packet;
  endclocking

  clocking avalon_st_sink_cb @(posedge clock);
    // default input #0.1 output #0.1;
    default input #0 output #0;

    input   data;
    input   error;
    output  ready;
    input   valid;
    input   start_of_packet;
    input   end_of_packet;
  endclocking

 /*****************
  * DRIVER METHODS *
  *****************/
  function void clear_bus();
    if (INST_SPEC.VIF_MODPORT == MODPORT_SOURCE)
    begin
      avalon_st_source_cb.data            <= '0;
      avalon_st_source_cb.error           <= '0;
      avalon_st_source_cb.valid           <= '0;
      avalon_st_source_cb.start_of_packet <= '0;
      avalon_st_source_cb.end_of_packet   <= '0;
    end
    else
    begin
      avalon_st_sink_cb.ready             <= '0;
    end
  endfunction : clear_bus

  task wait_for_reset();
    if (!reset)
      @(posedge reset);
    // @(negedge reset);
  endtask : wait_for_reset

  task push_data(uvm_object rhs);
    avalon_st_seq_item #(INST_SPEC) seq;
    bit [INST_SPEC.BUS_WIDTH-1:0]   data_queue[$];

    if (!$cast(seq, rhs))
      `uvm_fatal("push_data", "Cast of 'rhs' object failed.")

    if (seq.burst_len != seq.data.size())
      `uvm_error("push_data", $sformatf("Burst length mismatch (burst_len = %0d, data.size() = %0d)!", seq.burst_len, seq.data.size()))

    data_queue = { seq.data };

    while (data_queue.size())
    begin
      @(avalon_st_source_cb);

      avalon_st_source_cb.data  <= data_queue.pop_front();
      avalon_st_source_cb.valid <= 'd1;

      while (avalon_st_source_cb.ready !== 'd1)
        @(avalon_st_source_cb);

      `uvm_info("push_data", $sformatf("data = 0x%0h", avalon_st_source_cb.data), UVM_DEBUG)
    end

    @(avalon_st_source_cb);
    avalon_st_source_cb.valid <= 'd0;
  endtask : push_data

  task pull_data(uvm_object rhs);
    avalon_st_seq_item #(INST_SPEC) seq;

    if (!$cast(seq, rhs))
      `uvm_fatal("pull_data", "Cast of 'rhs' object failed.")

    @(avalon_st_sink_cb);
    avalon_st_sink_cb.ready <= 'd1;

    while (seq.data.size() < seq.burst_len)
    begin
      @(avalon_st_sink_cb);

      if (avalon_st_sink_cb.valid !== 'd1)
        @(posedge avalon_st_sink_cb.valid);

      `uvm_info("pull_data", $sformatf("data = 0x%0h", avalon_st_sink_cb.data), UVM_DEBUG)
      seq.data.push_back(data);
    end

    @(avalon_st_sink_cb);
    avalon_st_sink_cb.ready <= 'd0;
  endtask : pull_data

  /******************
  * MONITOR METHODS *
  ******************/
  task get_transaction(uvm_object rhs);
    avalon_st_seq_item #(INST_SPEC) item;

    if (!$cast(item, rhs))
      `uvm_fatal("get_transaction", "Cast of 'rhs' object failed.")

    if (avalon_st_sink_cb.valid !== 'd1)
        @(posedge avalon_st_sink_cb.valid);

      while (avalon_st_sink_cb.valid === 'd1)
      begin
        if (avalon_st_source_cb.ready === 'd1)
        begin
          item.data.push_back(avalon_st_sink_cb.data);
          item.burst_len++;
        end

        @(avalon_st_source_cb);
      end
  endtask : get_transaction

endinterface : avalon_st_if
