
module output_ctrl
#(
  parameter ITER_NUM = 1
)
(
  /* Common IF */
  input  wire                       reset,          // reset.reset
  input  wire                       clock,          // clock.clk
  /* Iteration controller IF */
  input  wire                       iter_enable,    //  iter.new_signal
  input  wire [$bits(ITER_NUM)-1:0] iter_iter_num,  //      .new_signal_1
  output wire                       iter_ready,     //      .new_signal_2
  /* FIR subcells IF */
  input  wire  [ITER_NUM-1:0][15:0] in_data,        //    in.data
  input  wire  [ITER_NUM-1:0]       in_valid,       //      .valid
  output wire  [ITER_NUM-1:0]       in_ready,       //      .ready
  /* SGDMA IF */
  output wire                [15:0] out_data,       //   out.data
  output wire                       out_valid,      //      .valid
  input  wire                       out_ready       //      .ready
);

reg  [15:0] out_data_r;
reg         out_valid_r; // is next pipeline stage needed?

assign iter_ready = out_ready;
assign in_ready   = { ITER_NUM{ out_ready & iter_enable } }; // ?
assign out_data   = out_data_r;
assign out_valid  = out_valid_r;

always_ff @(posedge clock)
begin
  if(reset)
  begin
    out_data_r  <= '0;
    out_valid_r <= '0;
  end
  else
  begin
    out_data_r  <= in_data[iter_iter_num];
    out_valid_r <= in_valid[iter_iter_num] & iter_enable;
  end
end

endmodule
