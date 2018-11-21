
module register_file
#(
  parameter LVLS_NUM        = 20,
  parameter LVL_RESET_VALUE = 9,
  parameter ITER_NUM        = 1
)
(
  /* Common IF */
  input  wire              reset,               // reset.reset
  input  wire              clock,               // clock.clk
  /* CSR IF */
  input  wire       [ 7:0] csr_address,         //   csr.address
  input  wire       [ 3:0] csr_byteenable,      //      .byteenable
  input  wire              csr_read,            //      .read
  output wire       [31:0] csr_readdata,        //      .readdata
  output wire       [ 1:0] csr_response,        //      .response
  input  wire              csr_write,           //      .write
  input  wire       [31:0] csr_writedata,       //      .writedata
  output wire              csr_waitrequest,     //      .waitrequest
  /* Parameters IF */
  output wire       [ 4:0] reg_lvls_num,        //   reg.lvls_num
  output wire       [ 4:0] reg_lvl_reset_value, //      .lvl_reset_value
  output wire [0:31][15:0] reg_lvls_values,     //      .lvls_values
  output wire       [ 3:0] reg_iter_num         //      .iter_num
);

reg               csr_read_r;
reg        [15:0] csr_readdata_r;
reg        [ 1:0] csr_response_r;
reg               csr_waitrequest_r;
reg        [ 4:0] reg_lvls_num_r;
reg        [ 4:0] reg_lvl_reset_value_r;
// reg  [15:0] reg_lvls_values_r[32];
reg  [0:31][15:0] reg_lvls_values_r;
reg        [ 3:0] reg_iter_num_r;

assign csr_readdata         = csr_readdata_r;
// assign csr_waitrequest      = csr_waitrequest_r;
assign csr_response         = csr_response_r;
assign csr_waitrequest      = csr_read & ~csr_read_r;
assign reg_lvls_num         = reg_lvls_num_r;
assign reg_lvl_reset_value  = reg_lvl_reset_value_r;
assign reg_lvls_values      = reg_lvls_values_r;

// genvar LVL;
// generate
//   for (LVL = 0; LVL < 32; LVL++)
//   begin : LVL_VAL_REG
//     assign reg_lvls_values[LVL] = reg_lvls_values_r[LVL];
//   end
// endgenerate

assign reg_iter_num         = reg_iter_num_r;

always_ff @(posedge clock)
begin
  csr_read_r <= csr_read;
end

assign csr_readdata_r         = 'd0;
assign csr_response_r         = 'd0;
assign csr_waitrequest_r      = 'd0;
assign reg_lvls_num_r         = LVLS_NUM;
assign reg_lvl_reset_value_r  = LVL_RESET_VALUE;

/* Temporarily frozen levels */
assign reg_lvls_values_r      = 
'{
  16'h8666, 16'h9333, 16'h9FFF, 16'hACCC,
  16'hB999, 16'hC666, 16'hD333, 16'hE000,
  16'hECCC, 16'hF999, 16'h0666, 16'h1333,
  16'h2000, 16'h2CCC, 16'h3999, 16'h4666,
  16'h5333, 16'h6000, 16'h6CCC, 16'h7999,
  /* UNUSED BELOW */
  16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF,
  16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF,
  16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF 
};

assign reg_iter_num_r         = ITER_NUM;

endmodule
