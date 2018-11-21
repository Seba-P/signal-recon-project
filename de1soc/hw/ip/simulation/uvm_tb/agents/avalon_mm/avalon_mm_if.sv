
import common_share_pkg::*;
import avalon_mm_agent_pkg::*;

interface avalon_mm_if
#(
  parameter avalon_mm_inst_spec_t INST_SPEC
)
(
  input reset,
  input clock
);
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  logic [INST_SPEC.ADDR_WIDTH-1:0] address;
  logic                     [ 3:0] byteenable;
  // logic                           debugaccess;         -> not supported
  logic                            read;
  logic [INST_SPEC.DATA_WIDTH-1:0] readdata;
  logic                     [ 1:0] response;
  logic                            write;
  logic [INST_SPEC.DATA_WIDTH-1:0] writedata;
  // logic                           lock;                -> not supported
  // logic                           waitrequest;         -> not supported
  // logic                           readdatavalid;       -> not supported
  // logic                           writeresponsevalid;  -> not supported
  // logic                   [ 10:0] burstcount;          -> not supported
  // logic                           beginbursttransfer;  -> not supported


  avalon_mm_footprint_if footprint_if
  (
    .reset(reset),
    .clock(clock)
  );

generate
  if (INST_SPEC.VIF_MODPORT == MODPORT_MASTER)
  begin
    assign footprint_if.address     = address;
    assign footprint_if.byteenable  = byteenable;
    assign footprint_if.read        = read;
    assign readdata                 = footprint_if.readdata;
    assign response                 = footprint_if.response;
    assign footprint_if.write       = write;
    assign footprint_if.writedata   = writedata;
  end
  else
  begin
    assign address                = footprint_if.address;
    assign byteenable             = footprint_if.byteenable;
    assign read                   = footprint_if.read;
    assign footprint_if.readdata  = readdata;
    assign footprint_if.response  = response;
    assign write                  = footprint_if.write;
    assign writedata              = footprint_if.writedata;
  end
endgenerate

 /*****************
  * DRIVER METHODS *
  *****************/
  function void clear_bus();
    if (INST_SPEC.VIF_MODPORT == MODPORT_MASTER)
    begin
      address     <= '0;
      byteenable  <= '0;
      read        <= '0;
      write       <= '0;
      writedata   <= '0;
    end
    else
    begin
      readdata    <= '0;
      response    <= '0;
    end
  endfunction : clear_bus

  task wait_for_reset();
    if (!reset)
      @(posedge reset);
    // @(negedge reset);
  endtask : wait_for_reset

  task write_data(uvm_object rhs);
    avalon_mm_seq_item #(INST_SPEC) seq;
    bit [INST_SPEC.DATA_WIDTH-1:0]  data_queue[$];

    if (!$cast(seq, rhs))
      `uvm_fatal("write_data", "Cast of rhs object failed.")

    if (seq.burst_len != seq.data.size())
      `uvm_error("write_data", $sformatf("Burst length mismatch (burst_len = %0d, data.size() = %0d)!", seq.burst_len, seq.data.size()))

    data_queue = { seq.data };

    while (data_queue.size())
    begin
      @(posedge clock);
      @(negedge clock);

      data  <= data_queue.pop_front();
      valid <= 'd1;

      if (ready !== 'd1)
        @(posedge ready);

      `uvm_info("write_data", $sformatf("data = 0x%0h", data), UVM_DEBUG)
    end

    @(posedge clock);
    valid <= 'd0;
  endtask : write_data

  task read_data(uvm_object rhs);
    avalon_mm_seq_item #(INST_SPEC) seq;

    if (!$cast(seq, rhs))
      `uvm_fatal("read_data", "Cast of rhs object failed.")

    @(posedge clock);
    ready <= 'd1;

    while (seq.data.size() < seq.burst_len)
    begin
      @(posedge clock);
      @(negedge clock);

      if (valid !== 'd1)
        @(posedge valid);

      `uvm_info("read_data", $sformatf("data = 0x%0h", data), UVM_DEBUG)
      seq.data.push_back(data);
    end

    @(posedge clock);
    ready <= 'd0;
  endtask : read_data

  /******************
  * MONITOR METHODS *
  ******************/
  task get_transaction(uvm_object rhs);
    avalon_mm_seq_item #(INST_SPEC) item;

    if (!$cast(item, rhs))
      `uvm_fatal("get_transaction", "Cast of rhs object failed.")

    fork
      READ_REQ:
      begin
        if (read !== 'd1)
          @(posedge read);

        seq.operation = READ_OP;
      end

      WRITE_REQ:
      begin
        if (write !== 'd1)
          @(posedge write);

        seq.operation = WRITE_OP;
      end
    join_any

    case (seq.operation)
      READ_OP:
      begin
        // TODO: handle read op
        while (read === 'd1)
        begin
        end
      end

      WRITE_OP:
      begin
        // TODO: handle write op
      end
    endcase

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

endinterface : avalon_mm_if
