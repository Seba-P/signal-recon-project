
module limits_buffer_ctrl
#(
  parameter MAX_SAMPLES_IN_RAM = 255
)
(
  /* Common IF */
  input  wire        reset,                     //   reset.reset
  input  wire        clock,                     //   clock.clk
  /* Lvl generator IF */
  input  wire [31:0] lvl_gen_data,              // lvl_gen.data
  input  wire        lvl_gen_valid,             //        .valid
  /* Iteration controller IF */
  input  wire        iter_input_enable,         //    iter.new_signal
  input  wire        iter_output_enable,        //        .new_signal_1
  /* Hard limiter IF */
  output wire [31:0] limiter_data,              // limiter.data
  output wire        limiter_valid,             //        .valid
  /* Limits buffer IF */
  /* PORT A */
  output wire [ 7:0] ram_limits_address_a,      //  port_a.address
  output wire        ram_limits_chipselect_a,   //        .chipselect
  output wire        ram_limits_read_a,         //        .read
  input  wire [31:0] ram_limits_readdata_a,     //        .readdata
  output wire        ram_limits_write_a,        //        .write
  output wire [31:0] ram_limits_writedata_a,    //        .writedata
  output wire [ 3:0] ram_limits_byteenable_a,   //        .byteenable
  input  wire        ram_limits_waitrequest_a,  //        .waitrequest
  /* PORT B */
  output wire [ 7:0] ram_limits_address_b,      //  port_b.address
  output wire        ram_limits_chipselect_b,   //        .chipselect
  output wire        ram_limits_read_b,         //        .read
  input  wire [31:0] ram_limits_readdata_b,     //        .readdata
  output wire        ram_limits_write_b,        //        .write
  output wire [31:0] ram_limits_writedata_b,    //        .writedata
  output wire [ 3:0] ram_limits_byteenable_b,   //        .byteenable
  input  wire        ram_limits_waitrequest_b   //        .waitrequest
);

reg  [31:0] limiter_data_r;
// reg  [31:0] limiter_data_p1_r;
reg         limiter_valid_r;
// reg         limiter_valid_p1_r;

reg  [ 7:0] ram_limits_address_a_r;
reg  [ 7:0] ram_limits_address_a_p1_r;
reg         ram_limits_chipselect_a_r;
reg         ram_limits_write_a_r;
reg         ram_limits_write_a_p1_r;
reg  [31:0] ram_limits_writedata_a_r;
reg  [31:0] ram_limits_writedata_a_p1_r;
reg  [ 3:0] ram_limits_byteenable_a_r;

reg  [ 7:0] ram_limits_address_b_r;
reg  [ 7:0] ram_limits_address_b_p1_r;
reg         ram_limits_chipselect_b_r;
reg         ram_limits_read_b_r;
reg  [ 3:0] ram_limits_byteenable_b_r;

reg  [ 7:0] symbol_cnt_a_r;
reg  [ 7:0] symbol_cnt_b_r;
wire        full_buffer;
wire        buffer_end;

assign limiter_data             = limiter_data_r;
assign limiter_valid            = limiter_valid_r;
// assign limiter_data             = ram_limits_waitrequest_b ? limiter_data_p1_r : limiter_data_r;
// assign limiter_valid            = ram_limits_waitrequest_b ? limiter_valid_p1_r : limiter_valid_r;

assign ram_limits_address_a     = ram_limits_waitrequest_a ? ram_limits_address_a_r : ram_limits_address_a_p1_r;
assign ram_limits_chipselect_a  = ram_limits_chipselect_a_r;
assign ram_limits_read_a        = '0;
assign ram_limits_write_a       = ram_limits_waitrequest_a ? ram_limits_write_a_r : ram_limits_write_a_p1_r;
assign ram_limits_writedata_a   = ram_limits_waitrequest_a ? ram_limits_writedata_a_r : ram_limits_writedata_a_p1_r;
assign ram_limits_byteenable_a  = ram_limits_byteenable_a_r;

assign ram_limits_address_b     = ram_limits_waitrequest_b ? ram_limits_address_b_r : ram_limits_address_b_p1_r;
assign ram_limits_chipselect_b  = ram_limits_chipselect_b_r;
assign ram_limits_read_b        = ram_limits_read_b_r;
assign ram_limits_write_b       = '0;
assign ram_limits_writedata_b   = '0;
assign ram_limits_byteenable_b  = ram_limits_byteenable_b_r;

assign full_buffer  = (symbol_cnt_a_r == MAX_SAMPLES_IN_RAM - 'd1);
assign buffer_end   = (symbol_cnt_b_r == MAX_SAMPLES_IN_RAM - 'd1);

/* Input controler */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    ram_limits_address_a_r      <= '0;
    ram_limits_address_a_p1_r   <= '0;
    ram_limits_chipselect_a_r   <= '0;
    ram_limits_write_a_r        <= '0;
    ram_limits_write_a_p1_r     <= '0;
    ram_limits_writedata_a_r    <= '0;
    ram_limits_writedata_a_p1_r <= '0;
    ram_limits_byteenable_a_r   <= '0;

    symbol_cnt_a_r              <= '0;
  end
  else
  begin
    // ram_limits_address_a_r    <= '{ symbol_cnt_a_r, 2'b00 }; // is address unit in bytes?
    ram_limits_address_a_r      <= symbol_cnt_a_r; // address unit is in words!
    ram_limits_address_a_p1_r   <= ram_limits_address_a_r;
    ram_limits_chipselect_a_r   <= 'd1;
    ram_limits_write_a_r        <= iter_input_enable & lvl_gen_valid;
    ram_limits_write_a_p1_r     <= ram_limits_write_a_r;
    ram_limits_writedata_a_r    <= lvl_gen_data;
    ram_limits_writedata_a_p1_r <= ram_limits_writedata_a_r;
    ram_limits_byteenable_a_r   <= '1;

    symbol_cnt_a_r              <= full_buffer ? 'd0 : symbol_cnt_a_r + 8'(iter_input_enable & lvl_gen_valid & ~ram_limits_waitrequest_a); // ?
  end
end

/* Output controler */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    limiter_data_r              <= '0;
    limiter_valid_r             <= '0;

    ram_limits_address_b_r      <= '0;
    ram_limits_address_b_p1_r   <= '0;
    ram_limits_chipselect_b_r   <= '0;
    ram_limits_read_b_r         <= '0;
    ram_limits_byteenable_b_r   <= '0;

    symbol_cnt_b_r              <= '0;
  end
  else
  begin // TODO: check pipeline delays + waitrequest influence
    // limiter_data_p1_r           <= ram_limits_readdata_b;
    // limiter_data_r              <= limiter_data_p1_r;
    limiter_data_r            <= ram_limits_readdata_b;
    limiter_valid_r           <= iter_output_enable & ~ram_limits_waitrequest_b; // make sure the valid pulse is long enough (iteration ctrl)

    // ram_limits_address_b_r    <= '{ symbol_cnt_b_r, 2'b00 }; // is address unit in bytes?
    ram_limits_address_b_r    <= symbol_cnt_b_r; // address unit is in words!
    ram_limits_address_b_p1_r <= ram_limits_address_b_r; // address unit is in words!
    ram_limits_read_b_r       <= 'd1;
    ram_limits_chipselect_b_r <= 'd1;
    ram_limits_byteenable_b_r <= '1;

    symbol_cnt_b_r            <= buffer_end ? 'd0 : symbol_cnt_b_r + 8'(iter_output_enable & ~ram_limits_waitrequest_b); // ?
  end
end

endmodule
