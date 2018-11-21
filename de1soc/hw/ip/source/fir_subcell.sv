
module fir_subcell
#(
  parameter FIR_TAPS_NUM    = 63,
  parameter SUBCELL_NUM     = 0
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

reg         init_stage_0_r;
reg         init_stage_1_r;
reg         init_stage_2_r;
reg         init_stage_3_r;
reg         init_stage_4_r;
reg         init_stage_done_r;

reg         valid_signal_fifo_r;
reg         valid_signal_limiter_r;
reg  [15:0] fir_data_limiter_r;
reg         fir_valid_limiter_r;
reg         fir_out_valid_r;

wire [15:0] fir_in_data;
wire        fir_in_valid;
wire  [1:0] fir_in_error;
wire        fir_in_ready;
wire [15:0] fir_out_data;
wire        fir_out_valid;
wire  [1:0] fir_out_error;
wire        fir_out_ready;
wire        fifo_rdreq;
wire [31:0] fifo_in_data;
wire        fifo_wrreq;
wire [31:0] fifo_out_data;
wire        fifo_empty;
wire        fifo_full;
wire [ 7:0] fifo_fill_count;
wire        limiter_ready;

assign fir_in_data      = in_signal_data;
assign fir_in_valid     = in_signal_valid & iter_input_enable;
assign fir_in_error     = 'd0; // not used
assign in_signal_ready  = fir_in_ready;

assign fifo_in_data = in_limits_data;
assign fifo_rdreq   = valid_signal_fifo_r & fir_out_valid /*fir_out_valid_r*/ | init_stage_4_r;
assign fifo_wrreq   = iter_new_limits /*& in_limits_valid*/ | init_stage_2_r;

assign iter_ready   = limiter_ready & init_stage_done_r;

always_ff @(posedge clock)
begin
  fir_out_valid_r <= fir_out_valid;
end

always_ff @(posedge clock)
begin
  if(reset)
  begin
    init_stage_0_r    <= 'd1;
    init_stage_1_r    <= 'd0;
    init_stage_2_r    <= 'd0;
    init_stage_3_r    <= 'd0;
    init_stage_4_r    <= 'd0;
    init_stage_done_r <= 'd0;
  end
  else
  begin
    init_stage_0_r    <= 'd0;
    init_stage_1_r    <= init_stage_0_r;
    init_stage_2_r    <= init_stage_1_r;
    init_stage_3_r    <= init_stage_2_r;
    init_stage_4_r    <= init_stage_3_r;
    init_stage_done_r <= init_stage_done_r | init_stage_4_r;
  end
end

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
    `DELAY_GEN(6)  // 6
    // `DELAY_GEN(7)  // 6
  else if(SUBCELL_NUM == 1)
    `DELAY_GEN(15) // 15
    // `DELAY_GEN(16) // 15
  else if(SUBCELL_NUM == 2)
    `DELAY_GEN(24) // 24
    // `DELAY_GEN(25) // 24
  else if(SUBCELL_NUM == 3)
    `DELAY_GEN(33) // 33
    // `DELAY_GEN(34) // 33
  else if(SUBCELL_NUM == 4)
    `DELAY_GEN(42) // 42
    // `DELAY_GEN(43) // 42
  else if(SUBCELL_NUM == 5)
    `DELAY_GEN(51) // 51
    // `DELAY_GEN(52) // 51
endgenerate

delay
#(
  .DELAY     (1),
  .WIDTH     ($bits({ valid_signal_fifo_r, fir_out_data, fir_out_valid })),
  .RESET     (1),
  .RESET_VAL ('0),
  .RAMSTYLE  ("logic")
)
delay_limiter_input
(
  .clock    (clock),
  .reset    (reset),
  .in_data  ({ valid_signal_fifo_r, fir_out_data, fir_out_valid }),
  .out_data ({ valid_signal_limiter_r, fir_data_limiter_r, fir_valid_limiter_r })
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

hard_limiter hard_limiter
(
  .reset              (reset | iter_init),
  .clock              (clock),
  .limbuff_data       (fifo_out_data),
  .limbuff_valid      (1'd1), // not used
  .iter_valid_signal  (valid_signal_limiter_r),
  .iter_output_enable (iter_output_enable), // delay?
  .iter_ready         (limiter_ready),
  .fir_data           (fir_data_limiter_r),
  .fir_valid          (fir_valid_limiter_r),
  .fir_error          (), // not used
  .fir_ready          (fir_out_ready),
  .out_data           (out_signal_data),
  .out_valid          (out_signal_valid),
  .out_ready          (out_signal_ready)
);

endmodule
