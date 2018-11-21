
module sample2lvl_converter
#(
  parameter LVLS_NUM        = 20,
  parameter LVL_RESET_VALUE = 9
)
(
  /* Common IF */
  input  wire              reset,               //      reset.reset
  input  wire              clock,               //      clock.clk
  /* Register file IF */
  input  wire       [ 4:0] reg_lvls_num,        //        reg.lvls_num
  input  wire       [ 4:0] reg_lvl_reset_value, //           .lvl_reset_value
  input  wire [0:31][15:0] reg_lvls_values,     //           .lvls_values
  /* SGDMA IF */
  input  wire       [15:0] in_data,             //         in.data
  input  wire              in_valid,            //           .valid
  output wire              in_ready,            //           .ready
  /* Iteration controller IF */
  input  wire              iter_init,           //       iter.new_signal
  output wire              iter_valid,          //           .new_signal_1
  input  wire              iter_ready,          //           .new_signal_2
  /* Output lvl IF */
  output wire       [15:0] out_lvl_data,        //    out_lvl.data
  output wire              out_lvl_valid,       //           .valid
  /* Output limits IF */
  output wire       [31:0] out_limits_data,     // out_limits.data
  output wire              out_limits_valid     //           .valid
);

wire lvl_gen_cross_dir;
wire lvl_gen_new_sample;
wire lvl_gen_valid;
wire out_valid;

assign iter_valid       = out_valid;
assign out_lvl_valid    = out_valid;
assign out_limits_valid = out_valid;

sample_dispatcher sample_dispatcher
(
  /* Common IF */
  .reset              (reset | iter_init),
  .clock              (clock),
  /* SGDMA IF */
  .in_data            (in_data),
  .in_ready           (in_ready),
  .in_valid           (in_valid),
  /* Lvl generator IF */
  .lvl_gen_cross_dir  (lvl_gen_cross_dir),
  .lvl_gen_new_sample (lvl_gen_new_sample),
  .lvl_gen_valid      (lvl_gen_valid),
  /* Iteration controler IF */
  .iter_ready         (iter_ready)
);

lvl_generator
#(
  .LVLS_NUM         (LVLS_NUM),
  .LVL_RESET_VALUE  (LVL_RESET_VALUE)
)
lvl_generator
(
  /* Common IF */
  .reset            (reset | iter_init),
  .clock            (clock),
  /* Sample dispatcher IF */
  .disp_cross_dir   (lvl_gen_cross_dir),
  .disp_new_sample  (lvl_gen_new_sample),
  .disp_valid       (lvl_gen_valid),
  /* Buffer controlers IF */
  .buff_value       (out_lvl_data),
  .buff_limits      (out_limits_data),
  .buff_valid       (out_valid)
);

endmodule
