
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

 /*****************
  * DRIVER METHODS *
  *****************/
  function void clear_bus();
    if (INST_SPEC.VIF_MODPORT == MODPORT_SOURCE)
    begin
      data            <= '0;
      error           <= '0;
      valid           <= '0;
      start_of_packet <= '0;
      end_of_packet   <= '0;
    end
    else
    begin
      ready           <= '0;
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
      @(posedge clock);
      @(negedge clock);

      data  <= data_queue.pop_front();
      valid <= 'd1;

      if (ready !== 'd1)
        @(posedge ready);

      `uvm_info("push_data", $sformatf("data = 0x%0h", data), UVM_DEBUG)
    end

    @(posedge clock);
    valid <= 'd0;
  endtask : push_data

  task pull_data(uvm_object rhs);
    avalon_st_seq_item #(INST_SPEC) seq;

    if (!$cast(seq, rhs))
      `uvm_fatal("pull_data", "Cast of 'rhs' object failed.")

    @(posedge clock);
    ready <= 'd1;

    while (seq.data.size() < seq.burst_len)
    begin
      @(posedge clock);
      @(negedge clock);

      if (valid !== 'd1)
        @(posedge valid);

      `uvm_info("pull_data", $sformatf("data = 0x%0h", data), UVM_DEBUG)
      seq.data.push_back(data);
    end

    @(posedge clock);
    ready <= 'd0;
  endtask : pull_data

  /******************
  * MONITOR METHODS *
  ******************/
  task get_transaction(uvm_object rhs);
    avalon_st_seq_item #(INST_SPEC) item;

    if (!$cast(item, rhs))
      `uvm_fatal("get_transaction", "Cast of 'rhs' object failed.")

    if (valid !== 'd1)
      @(posedge valid);

    while (valid === 'd1)
    begin
      if (ready === 'd1)
      begin
        item.data.push_back(data);
        item.burst_len++;
      end

      @(posedge clock);
      @(negedge clock);
    end
  endtask : get_transaction

endinterface : avalon_st_if
