
module limits_buffer
(
  /* Common IF */
  input  wire        reset,               //  reset.reset
  input  wire        clock,               //  clock.clk
  /* PORT A */
  input  wire [ 7:0] port_a_address,      // port_a.address
  input  wire        port_a_chipselect,   //       .chipselect
  input  wire        port_a_read,         //       .read
  output wire [31:0] port_a_readdata,     //       .readdata
  input  wire        port_a_write,        //       .write
  input  wire [31:0] port_a_writedata,    //       .writedata
  input  wire [ 3:0] port_a_byteenable,   //       .byteenable
  output wire        port_a_waitrequest,  //       .waitrequest
  /* PORT B */
  input  wire [ 7:0] port_b_address,      // port_b.address
  input  wire        port_b_chipselect,   //       .chipselect
  input  wire        port_b_read,         //       .read
  output wire [31:0] port_b_readdata,     //       .readdata
  input  wire        port_b_write,        //       .write
  input  wire [31:0] port_b_writedata,    //       .writedata
  input  wire [ 3:0] port_b_byteenable,   //       .byteenable
  output wire        port_b_waitrequest   //       .waitrequest
);

reg  [31:0] port_b_readdata_r;

assign port_b_readdata      = port_b_readdata_r;
assign port_a_waitrequest   = '0; // wait request feature not used
assign port_b_waitrequest   = '0; // wait request feature not used

limits_buffer_alt limits_buffer_alt_inst
(
  .clock      (clock),
  .wren       (port_a_write),
  .wraddress  (port_a_address),
  .data       (port_a_writedata),
  .rden       (port_b_read),
  .rdaddress  (port_b_address),
  .q          (port_b_readdata_r)
);

endmodule // limits_buffer
