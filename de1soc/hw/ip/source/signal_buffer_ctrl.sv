
module signal_buffer_ctrl
#(
  parameter MAX_SAMPLES_IN_RAM  = 255,
  parameter ITER_NUM            = 1
)
(
  /* Common IF */
  input  wire        reset,                     //      reset.reset
  input  wire        clock,                     //      clock.clk
  /* Lvl generator IF */
  input  wire [15:0] lvl_gen_data,              //    lvl_gen.data
  input  wire        lvl_gen_valid,             //           .valid
  /* Hard limiter IF */
  input  wire [15:0] limiter_data,              //    limiter.data
  input  wire        limiter_valid,             //           .valid
  output wire        limiter_ready,             //           .ready
  /* Iteration controller IF */
  input  wire [ 4:0] iter_iter_num,             //       iter.new_signal
  input  wire        iter_input_mux,            //           .new_signal_1
  input  wire        iter_input_enable,         //           .new_signal_2
  input  wire        iter_output_enable,        //           .new_signal_3
  /* FIR driver IF */
  output wire [15:0] fir_driver_data,           // fir_driver.data
  output wire        fir_driver_valid,          //           .valid
  /* Signal buffer IF */
  /* PORT A */
  output wire [12:0] ram_signal_address_a,      //     port_a.address
  output wire        ram_signal_chipselect_a,   //           .chipselect
  output wire        ram_signal_read_a,         //           .read
  input  wire [15:0] ram_signal_readdata_a,     //           .readdata
  output wire        ram_signal_write_a,        //           .write
  output wire [15:0] ram_signal_writedata_a,    //           .writedata
  output wire [ 1:0] ram_signal_byteenable_a,   //           .byteenable
  input  wire        ram_signal_waitrequest_a,  //           .waitrequest
  /* PORT B */
  output wire [12:0] ram_signal_address_b,      //     port_b.address
  output wire        ram_signal_chipselect_b,   //           .chipselect
  output wire        ram_signal_read_b,         //           .read
  input  wire [15:0] ram_signal_readdata_b,     //           .readdata
  output wire        ram_signal_write_b,        //           .write
  output wire [15:0] ram_signal_writedata_b,    //           .writedata
  output wire [ 1:0] ram_signal_byteenable_b,   //           .byteenable
  input  wire        ram_signal_waitrequest_b   //           .waitrequest
);


reg         limiter_ready_r;

reg  [15:0] fir_driver_data_r;
reg         fir_driver_valid_r;

reg  [12:0] ram_signal_address_a_r;
reg  [12:0] ram_signal_address_a_p1_r;
reg         ram_signal_chipselect_a_r;
reg         ram_signal_write_a_r;
reg         ram_signal_write_a_p1_r;
reg  [31:0] ram_signal_writedata_a_r;
reg  [31:0] ram_signal_writedata_a_p1_r;
reg  [ 3:0] ram_signal_byteenable_a_r;

reg  [12:0] ram_signal_address_b_r;
reg  [12:0] ram_signal_address_b_p1_r;
reg         ram_signal_chipselect_b_r;
reg         ram_signal_read_b_r;
reg  [ 3:0] ram_signal_byteenable_b_r;

reg  [ 7:0] symbol_cnt_a_r;
reg  [ 7:0] symbol_cnt_b_r;
wire        full_buffer;
wire        buffer_end;

assign limiter_ready            = limiter_ready_r;

assign fir_driver_data          = fir_driver_data_r;
assign fir_driver_valid         = fir_driver_valid_r;

assign ram_signal_address_a     = ram_signal_waitrequest_a ? ram_signal_address_a_r : ram_signal_address_a_p1_r;
assign ram_signal_chipselect_a  = ram_signal_chipselect_a_r;
assign ram_signal_read_a        = '0;
assign ram_signal_write_a       = ram_signal_waitrequest_a ? ram_signal_write_a_r : ram_signal_write_a_p1_r;
assign ram_signal_writedata_a   = ram_signal_waitrequest_a ? ram_signal_writedata_a_r : ram_signal_writedata_a_p1_r;
assign ram_signal_byteenable_a  = ram_signal_byteenable_a_r;

assign ram_signal_address_b     = ram_signal_waitrequest_b ? ram_signal_address_b_r : ram_signal_address_b_p1_r;
assign ram_signal_chipselect_b  = ram_signal_chipselect_b_r;
assign ram_signal_read_b        = ram_signal_read_b_r;
assign ram_signal_write_b       = '0;
assign ram_signal_writedata_b   = '0;
assign ram_signal_byteenable_b  = ram_signal_byteenable_b_r;

assign full_buffer  = (symbol_cnt_a_r == MAX_SAMPLES_IN_RAM - 'd1);
assign buffer_end   = (symbol_cnt_b_r == MAX_SAMPLES_IN_RAM - 'd1);

// TODO: 1cc buffer for lvl_gen_data to be written (let's make fir_driver read the content of the cell before it's overwritten)
/* Input controler */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    ram_signal_address_a_r      <= '0;
    ram_signal_address_a_p1_r   <= '0;
    ram_signal_chipselect_a_r   <= '0;
    ram_signal_write_a_r        <= '0;
    ram_signal_write_a_p1_r     <= '0;
    ram_signal_writedata_a_r    <= '0;
    ram_signal_writedata_a_p1_r <= '0;
    ram_signal_byteenable_a_r   <= '0;

    symbol_cnt_a_r              <= '0;
  end
  else
  begin
    // TODO: especially input_mux
    // ram_signal_address_a_r    <= '{ iter_iter_num, symbol_cnt_a_r, 1'b0 }; // is address unit in bytes? 
    ram_signal_address_a_r      <= { iter_iter_num[4:0], symbol_cnt_a_r[7:0] }; // address unit is in words! 
    ram_signal_address_a_p1_r   <= ram_signal_address_a_r; // address unit is in words! 
    ram_signal_chipselect_a_r   <= 'd1;
    ram_signal_write_a_r        <= iter_input_enable & lvl_gen_valid; // TODO
    ram_signal_write_a_p1_r     <= ram_signal_write_a_r;
    ram_signal_writedata_a_r    <= lvl_gen_data; // TODO
    ram_signal_writedata_a_p1_r <= ram_signal_writedata_a_r;
    ram_signal_byteenable_a_r   <= '1;

    symbol_cnt_a_r              <= full_buffer ? 'd0 : symbol_cnt_a_r + 8'(iter_input_enable & lvl_gen_valid & ~ram_signal_waitrequest_a); // ? // TODO
  end
end

/* Output controler */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    limiter_ready_r           <= '0;

    fir_driver_data_r         <= '0;
    fir_driver_valid_r        <= '0;

    ram_signal_address_b_r    <= '0;
    ram_signal_chipselect_b_r <= '0;
    ram_signal_read_b_r       <= '0;
    ram_signal_byteenable_b_r <= '0;

    symbol_cnt_b_r            <= '0;
  end
  else
  begin // TODO: check pipeline delays + waitrequest influence
    limiter_ready_r           <= 'd1;

    fir_driver_data_r         <= ram_signal_readdata_b;
    fir_driver_valid_r        <= iter_output_enable;
    // fir_driver_valid_buff_r       <= iter_output_enable;
    // fir_driver_valid_r            <= fir_driver_valid_buff_r;

    // ram_signal_address_b_r    <= '{ iter_iter_num, symbol_cnt_b_r, 1'b0 }; // is address unit in bytes?
    ram_signal_address_b_r    <= { iter_iter_num[4:0], symbol_cnt_b_r[7:0] }; // address unit is in words!
    ram_signal_read_b_r       <= 'd1;
    ram_signal_chipselect_b_r <= 'd1;
    ram_signal_byteenable_b_r <= '1;

    symbol_cnt_b_r            <= buffer_end ? 'd0 : symbol_cnt_b_r + 8'(iter_output_enable); // ?
  end
end

endmodule
