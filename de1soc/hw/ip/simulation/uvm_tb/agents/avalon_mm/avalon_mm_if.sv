
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

  logic     [INST_SPEC.ADDR_WIDTH-1:0] address;
  logic [(INST_SPEC.DATA_WIDTH/8)-1:0] byteenable;
  // logic                              debugaccess;         -> not supported
  logic                                read;
  logic     [INST_SPEC.DATA_WIDTH-1:0] readdata;
  logic                         [ 1:0] response;
  logic                                write;
  logic     [INST_SPEC.DATA_WIDTH-1:0] writedata;
  // logic                                lock;                -> not supported
  logic                                waitrequest;
  // logic                                readdatavalid;       -> not supported
  // logic                                writeresponsevalid;  -> not supported
  // logic                        [ 10:0] burstcount;          -> not supported
  // logic                                beginbursttransfer;  -> not supported


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
    assign waitrequest              = footprint_if.waitrequest;
  end
  else
  begin
    assign address                  = footprint_if.address;
    assign byteenable               = footprint_if.byteenable;
    assign read                     = footprint_if.read;
    assign footprint_if.readdata    = readdata;
    assign footprint_if.response    = response;
    assign write                    = footprint_if.write;
    assign writedata                = footprint_if.writedata;
    assign footprint_if.waitrequest = waitrequest;
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
      waitrequest <= '0;
    end
  endfunction : clear_bus

  task wait_for_reset();
    if (!reset)
      @(posedge reset);
    // @(negedge reset);
  endtask : wait_for_reset

  /* Master's handle */
  task write_data(uvm_object rhs);
    avalon_mm_seq_item #(INST_SPEC) seq;
    bit     [INST_SPEC.ADDR_WIDTH-1:0] addr_queue[$];
    bit [(INST_SPEC.DATA_WIDTH/8)-1:0] byteen_queue[$];
    logic   [INST_SPEC.DATA_WIDTH-1:0] data_queue[$];

    if (!$cast(seq, rhs))
      `uvm_fatal("write_data", "Cast of 'rhs' object failed.")

    if (seq.burst_len != seq.data.size())
      `uvm_error("write_data", $sformatf("Burst length mismatch (burst_len = %0d, data.size() = %0d)!", seq.burst_len, seq.data.size()))

    addr_queue    = { seq.addr };
    byteen_queue  = { seq.byteen };
    data_queue    = { seq.data };

    while (data_queue.size())
    begin
      @(posedge clock);

      address     <= addr_queue.pop_front();
      write       <= 'd1;
      writedata   <= data_queue.pop_front();
      byteenable  <= byteen_queue.pop_front();

      // @(posedge clock);
      @(negedge clock);

      if (waitrequest === 'd1)
        @(negedge waitrequest);

      `uvm_info("write_data", $sformatf("writedata = 0x%0h", writedata), UVM_DEBUG)
      seq.resp.push_back(response); // write burst might get only 1 response
    end

    @(posedge clock);
    write <= 'd0;

    // TODO: response validation
  endtask : write_data

  /* Master's handle */
  task read_data(uvm_object rhs);
    avalon_mm_seq_item #(INST_SPEC) seq;
    bit     [INST_SPEC.ADDR_WIDTH-1:0] addr_queue[$];
    bit [(INST_SPEC.DATA_WIDTH/8)-1:0] byteen_queue[$];

    if (!$cast(seq, rhs))
      `uvm_fatal("read_data", "Cast of 'rhs' object failed.")

    addr_queue    = { seq.addr };
    byteen_queue  = { seq.byteen };

    while (seq.data.size() < seq.burst_len)
    begin
      @(posedge clock);

      address     <= addr_queue.pop_front();
      read        <= 'd1;
      byteenable  <= byteen_queue.pop_front();

      // @(posedge clock);
      @(negedge clock);

      if (waitrequest === 'd1)
        @(negedge waitrequest);
      
      `uvm_info("read_data", $sformatf("readdata = 0x%0h, response = 0x%0h", readdata, response), UVM_DEBUG)
      seq.data.push_back(readdata);
      seq.resp.push_back(response);
    end

    // @(negedge clock);
    @(posedge clock);
    read <= 'd0;
  endtask : read_data

  /******************
  * MONITOR METHODS *
  ******************/
  task get_transaction(uvm_object rhs);
    avalon_mm_seq_item #(INST_SPEC) item;

    if (!$cast(item, rhs))
      `uvm_fatal("get_transaction", "Cast of 'rhs' object failed.")

    fork
      READ_REQ:
      begin
        if (read !== 'd1)
          @(posedge read);

        item.operation = READ_OP;
      end

      WRITE_REQ:
      begin
        if (write !== 'd1)
          @(posedge write);

        item.operation = WRITE_OP;
      end
    join_any

    case (item.operation)
      READ_OP:
      begin
        while (read === 'd1)
        begin
          @(negedge clock);

          if (waitrequest !== 'd1 && read === 'd1)
          begin
            item.addr.push_back(address);
            item.byteen.push_back(byteenable);
            item.data.push_back(readdata);
            item.resp.push_back(response);
            item.burst_len++;
          end
        end
      end

      WRITE_OP:
      begin
        while (write === 'd1)
        begin
          @(negedge clock);

          if (waitrequest !== 'd1 && write === 'd1)
          begin
            item.addr.push_back(address);
            item.byteen.push_back(byteenable);
            item.data.push_back(writedata);
            item.resp.push_back(response); // write burst might get only 1 response
            item.burst_len++;
          end
        end
      end
    endcase
  endtask : get_transaction

endinterface : avalon_mm_if
