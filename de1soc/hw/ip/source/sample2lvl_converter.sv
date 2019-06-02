
module sample2lvl_converter
#(
  parameter MAX_LVLS_NUM = 32
)
(
  /* Common IF */
  input  wire                            reset,               //      reset.reset
  input  wire                            clock,               //      clock.clk
  /* Parameters IF */
  input  wire [$clog2(MAX_LVLS_NUM)-1:0] params_lvls_num,     //     params.lvls_num
  input  wire [$clog2(MAX_LVLS_NUM)-1:0] params_init_lvl,     //           .init_lvl
  input  wire                     [ 1:0] params_init_guess,   //           .init_guess
  input  wire   [0:MAX_LVLS_NUM-1][15:0] params_lvls_values,  //           .lvls_values
  /* SGDMA IF */
  input  wire                     [15:0] in_data,             //         in.data
  input  wire                            in_valid,            //           .valid
  output wire                            in_ready,            //           .ready
  /* Iteration controller IF */
  input  wire                            iter_init,           //       iter.new_signal
  output wire                            iter_valid,          //           .new_signal_1
  input  wire                            iter_ready,          //           .new_signal_2
  /* Output signal IF */
  output wire                     [15:0] out_signal_data,     // out_signal.data
  output wire                            out_signal_valid,    //           .valid
  /* Output limits IF */
  output wire                     [31:0] out_limits_data,     // out_limits.data
  output wire                            out_limits_valid     //           .valid
);

localparam MAX_LVLS_NUM_BITS = $clog2(MAX_LVLS_NUM);

wire        sig_gen_cross_dir;
wire [14:0] sig_gen_duration;
wire        sig_gen_valid;
wire        sig_gen_ready;
wire        out_valid;

assign iter_valid       = out_valid;
assign out_signal_valid = out_valid;
assign out_limits_valid = out_valid;

sample_dispatcher sample_dispatcher
(
  /* Common IF */
  .reset              (reset | iter_init),
  .clock              (clock),
  /* SGDMA IF */
  .in_data            (in_data),
  .in_valid           (in_valid),
  .in_ready           (in_ready),
  /* Signal generator IF */
  .sig_gen_cross_dir  (sig_gen_cross_dir),
  .sig_gen_duration   (sig_gen_duration),
  .sig_gen_valid      (sig_gen_valid),
  .sig_gen_ready      (sig_gen_ready)
);

signal_generator
#(
  .MAX_LVLS_NUM (MAX_LVLS_NUM)
)
signal_generator
(
  /* Common IF */
  .reset              (reset | iter_init),
  .clock              (clock),
  /* Register file IF */
  .params_lvls_num    (params_lvls_num),
  .params_init_lvl    (params_init_lvl),
  .params_init_guess  (params_init_guess),
  .params_lvls_values (params_lvls_values),
  /* Sample dispatcher IF */
  .disp_cross_dir     (sig_gen_cross_dir),
  .disp_duration      (sig_gen_duration),
  .disp_valid         (sig_gen_valid),
  .disp_ready         (sig_gen_ready),
  /* Buffer controllers IF */
  .buff_value         (out_signal_data),
  .buff_limits        (out_limits_data),
  .buff_valid         (out_valid),
  /* Iteration controller IF */
  .iter_valid         (iter_valid),
  .iter_ready         (iter_ready)
);

endmodule
