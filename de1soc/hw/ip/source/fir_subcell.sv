
module fir_subcell
#(
  parameter FIR_TAPS_NUM        = 63,
  parameter MAX_SAMPLES_IN_RAM  = 63,
  parameter LVLS_NUM            = 20,
  parameter LVL_RESET_VALUE     = 9,
  parameter ITER_NUM            = 1,
  parameter SUBCELL_NUM         = 0,
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
  input  wire        in_limits_valid,     //           .valid
  /* Input stage IF */
  input  wire [15:0] in_signal_data,      //  in_signal.data
  input  wire        in_signal_valid,     //           .valid
  output wire        in_signal_ready,     //           .ready
  /* Output stage IF */
  output wire [15:0] out_signal_data,     // out_signal.data
  output wire        out_signal_valid,    //           .valid
  input  wire        out_signal_ready     //           .ready
);

localparam [$bits(FIR_TAPS_NUM)-1:0] FIR_FILTER_DELAY   = 'd6;
localparam [$bits(FIR_TAPS_NUM)-1:0] LIMITS_FIFO_DELAY  = 'd1;
localparam [$bits(FIR_TAPS_NUM)-1:0] HARD_LIMITER_DELAY = 'd3; // ?

reg         valid_signal_fifo_r;
reg         valid_signal_limiter_r;

wire        fir_in_valid;
wire [15:0] fir_in_data;
wire        fir_in_ready;
wire  [1:0] fir_in_error;
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

assign fir_in_data      = in_signal_data;
assign fir_in_valid     = in_signal_valid & iter_input_enable;
assign fir_in_error     = 'd0; // not used
assign in_signal_ready  = fir_in_ready;

assign fifo_in_data = in_limits_data;
assign fifo_rdreq   = valid_signal_fifo_r & fir_out_valid;
assign fifo_wrreq   = iter_new_limits /*& in_limits_valid*/;

`define DELAY_GEN(DEL) \
  delay \
  #( \
    .DELAY      (DEL), \
    .WIDTH      (1), \
    .RESET      (1), \
    .RESET_VAL  ('0), \
    .RAMSTYLE   ("logic") \
  ) \
  delay_valid_signal_fifo \
  ( \
    .clock    (clock), \
    .reset    (reset), \
    .in_data  (iter_valid_signal), \
    .out_data (valid_signal_fifo_r) \
  );

generate
  if(SUBCELL_NUM == 0)
    `DELAY_GEN(4)
  else if(SUBCELL_NUM == 1)
    // `DELAY_GEN(7)
    `DELAY_GEN(11)
  else if(SUBCELL_NUM == 2)
    `DELAY_GEN(18)
  else if(SUBCELL_NUM == 3)
    // `DELAY_GEN(25)
    `DELAY_GEN(23)
  else if(SUBCELL_NUM == 4)
    `DELAY_GEN(32)
  else if(SUBCELL_NUM == 5)
    `DELAY_GEN(39)
endgenerate

delay
#(
  .DELAY     (2),
  .WIDTH     (1),
  .RESET     (1),
  .RESET_VAL ('0),
  .RAMSTYLE  ("logic")
)
delay_valid_signal_limiter
(
  .clock    (clock),
  .reset    (reset),
  .in_data  (valid_signal_fifo_r),
  .out_data (valid_signal_limiter_r)
);

fir_filter fir_filter
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

// TODO: defparam
limits_fifo limits_fifo
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
  .clock              (clock),
  .limbuff_data       (fifo_out_data),
  .limbuff_valid      (1'd1), // not used
  .iter_valid_signal  (valid_signal_limiter_r),
  .iter_output_enable (iter_output_enable), // delay?
  .iter_ready         (iter_ready),
  .fir_data           (fir_out_data),
  .fir_valid          (fir_out_valid),
  .fir_error          (fir_out_error),
  .fir_ready          (fir_out_ready),
  .out_data           (out_signal_data),
  .out_valid          (out_signal_valid),
  .out_ready          (out_signal_ready)
);

endmodule
