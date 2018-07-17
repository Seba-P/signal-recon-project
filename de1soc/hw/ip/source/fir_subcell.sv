
module fir_subcell
#(
  parameter FIR_TAPS_NUM        = 63,
  parameter MAX_SAMPLES_IN_RAM  = 63,
  parameter LVLS_NUM            = 20,
  parameter LVL_RESET_VALUE     = 9,
  parameter ITER_NUM            = 1,
  parameter USE_COMB_LOGIC      = 0
)
(
  /* Common IF */
  input  wire        reset,               //      reset.reset
  input  wire        clock,               //      clock.clk
  /* Iteration controller IF */
  input  wire        iter_init,           //       iter.new_signal
  input  wire        iter_new_limits,     //           .new_signal_1
  input  wire        iter_valid_signal,   //           .new_signal_2
  input  wire        iter_input_enable,   //           .new_signal_3
  input  wire        iter_output_enable,  //           .new_signal_4
  output wire        iter_ready,          //           .new_signal_5
  /* Sample2lvl converter IF */
  input  wire [31:0] in_limits_data,      //  in_limits.data
  input  wire        in_limits_valid      //           .valid
  /* Input stage IF */
  input  wire [15:0] in_signal_data,      //  in_signal.data
  input  wire        in_signal_valid,     //           .valid
  output wire        in_signal_ready,     //           .ready
  /* Output stage IF */
  output wire [15:0] out_signal_data,     // out_signal.data
  output wire        out_signal_valid,    //           .valid
  input  wire        out_signal_ready     //           .ready
);

reg         iter_new_limits_r;
reg         iter_valid_signal_r;
reg         iter_input_enable_r;
reg         iter_output_enable_r;
reg         iter_ready_r;
reg  [31:0] in_limits_data_r;
reg         in_limits_valid_r;
reg  [15:0] in_signal_data_r;
reg         in_signal_valid_r;
reg         in_signal_ready_r;
reg  [15:0] out_signal_data_r;
reg         out_signal_valid_r;
reg         out_signal_ready_r;

wire        fir_out_valid;
wire [15:0] fir_out_data;
wire        fir_out_ready;
wire  [1:0] fir_out_error;
wire        fifo_rdreq;
wire [31:0] fifo_in_data;
wire        fifo_wrreq;
wire [31:0] fifo_out_data;
wire        fifo_empty;
wire        fifo_full;
wire [ 7:0] fifo_fill_count;

assign fir_in_data  = in_signal_data;
assign fir_in_valid = in_signal_valid & iter_input_enable;
assign fir_in_error = 'd0; // not used
assign fir_in_ready = in_signal_ready;

soc_system_fir_filter fir_filter
(
  .reset_n          (~(reset | iter_init)),
  .clk              (clock),
  .ast_sink_data    (fir_in_data),
  .ast_sink_valid   (fir_in_valid),
  .ast_sink_error   (fir_in_error),
  .ast_sink_ready   (fir_in_ready),
  .ast_source_data  (fir_out_data),
  .ast_source_valid (fir_out_valid),
  .ast_source_error (fir_out_error),
  .ast_source_ready (fir_out_ready)
);

limits_fifo limits_buffer
(
  .clock  (clock),
  .sclr   (reset | iter_init),
  .data   (fifo_in_data),
  .rdreq  (fifo_rdreq),
  .wrreq  (fifo_wrreq),
  .empty  (fifo_empty),
  .full   (fifo_full),
  .q      (fifo_out_data),
  .usedw  (fifo_fill_count)
);

hard_limiter
#(
  .USE_COMB_LOGIC (USE_COMB_LOGIC)
)
hard_limiter
(
  .reset              (reset | iter_init),
  .clock              (),
  .limbuff_data       (),
  .limbuff_valid      (),
  .iter_output_enable (),
  .iter_ready         (),
  .fir_data           (),
  .fir_valid          (),
  .fir_error          (),
  .fir_ready          (),
  .out_data           (),
  .out_valid          (),
  .out_ready          ()
);

endmodule
