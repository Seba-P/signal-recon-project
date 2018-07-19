
module iteration_ctrl
#(
  parameter FIR_TAPS_NUM        = 63,
  parameter MAX_SAMPLES_IN_RAM  = 63,
  parameter ITER_NUM            = 1
)
(
  /* Common IF */
  input  wire                       reset,                  //      reset.reset
  input  wire                       clock,                  //      clock.clk
  /* Sample2lvl converter IF */
  output wire                       sample2lvl_init,        // sample2lvl.new_signal
  input  wire                       sample2lvl_valid,       //           .new_signal_1
  output wire                       sample2lvl_ready,       //           .new_signal_2
  /* FIR subcells IF */
  output wire        [ITER_NUM-1:0] subcells_init,          //   subcells.new_signal
  output wire        [ITER_NUM-1:0] subcells_new_limits,    //           .new_signal_1
  output wire        [ITER_NUM-1:0] subcells_valid_signal,  //           .new_signal_2
  output wire        [ITER_NUM-1:0] subcells_input_enable,  //           .new_signal_3
  output wire        [ITER_NUM-1:0] subcells_output_enable, //           .new_signal_4
  input  wire        [ITER_NUM-1:0] subcells_ready,         //           .new_signal_5
  /* Output controller IF */
  output wire                       outctrl_enable,         //    outctrl.new_signal
  output wire [$bits(ITER_NUM)-1:0] outctrl_iter_num,       //           .new_signal_1
  input  wire                       outctrl_ready           //           .new_signal_2
);

localparam [$bits(FIR_TAPS_NUM)-1:0] FIR_FILTER_DELAY   = 'd6;
localparam [$bits(FIR_TAPS_NUM)-1:0] LIMITS_FIFO_DELAY  = 'd1;
localparam [$bits(FIR_TAPS_NUM)-1:0] HARD_LIMITER_DELAY = 'd3; // ?

reg                        sample2lvl_init_r;
reg                        sample2lvl_valid_r;
reg                        sample2lvl_ready_r;
reg         [ITER_NUM-1:0] subcells_init_r;
reg         [ITER_NUM-1:0] subcells_new_limits_r;
reg         [ITER_NUM-1:0] subcells_valid_signal_r;
reg         [ITER_NUM-1:0] subcells_input_enable_r;
reg         [ITER_NUM-1:0] subcells_output_enable_r;
reg         [ITER_NUM-1:0] subcells_ready_r;
reg                        outctrl_enable_r;
reg  [$bits(ITER_NUM)-1:0] outctrl_iter_num_r;
reg                        outctrl_ready_r;

reg                [$bits(FIR_TAPS_NUM)-1:0] fir_taps_num_r;
reg          [$bits(MAX_SAMPLES_IN_RAM)-1:0] max_samples_in_ram_r;
reg                    [$bits(ITER_NUM)-1:0] iter_num_r;

reg                [$bits(FIR_TAPS_NUM)-1:0] fir_taps_head_r;
reg                [$bits(FIR_TAPS_NUM)-1:0] fir_taps_tail_r;

reg                           [ITER_NUM-0:0] iter_start_r;
reg  [ITER_NUM-0:0][$bits(FIR_TAPS_NUM)-1:0] iter_symbol_cnt_r;
reg                           [ITER_NUM-0:0] iter_symbol_inc_r;
reg                           [ITER_NUM-0:0] iter_valid_signal_r;
reg                           [ITER_NUM-0:0] iter_valid_signal_del_r;
wire                          [ITER_NUM-0:0] valid_signal;
wire                                         pipeline_stall;

assign sample2lvl_init        = sample2lvl_init_r;
assign sample2lvl_ready       = sample2lvl_ready_r;
assign subcells_init          = subcells_init_r;
assign subcells_new_limits    = { ITER_NUM{ !pipeline_stall & sample2lvl_valid } };
// assign subcells_valid_signal  = iter_valid_signal_r[ITER_NUM:1];
assign subcells_valid_signal  = iter_valid_signal_del_r[ITER_NUM:1];

assign subcells_input_enable  = subcells_input_enable_r;
assign subcells_output_enable = subcells_output_enable_r;
assign outctrl_enable         = outctrl_enable_r;
assign outctrl_iter_num       = outctrl_iter_num_r;

assign pipeline_stall       = !(&subcells_ready & outctrl_ready);

assign fir_taps_num_r       = FIR_TAPS_NUM;
assign max_samples_in_ram_r = MAX_SAMPLES_IN_RAM;
assign iter_num_r           = ITER_NUM;

always_ff @(posedge clock)
begin
  if(reset)
  begin
    // fir_taps_head_r <= '0;
    // fir_taps_tail_r <= '0;
  end
  else
  begin
    // fir_taps_num_r        <= FIR_TAPS_NUM;
    // max_samples_in_ram_r  <= MAX_SAMPLES_IN_RAM;
    // iter_num_r            <= ITER_NUM;

    fir_taps_head_r       <= fir_taps_num_r[$bits(FIR_TAPS_NUM)-1:1] + fir_taps_num_r[0];
    fir_taps_tail_r       <= fir_taps_num_r[$bits(FIR_TAPS_NUM)-1:1];
  end
end

/* Sample2lvl converter IF */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    sample2lvl_init_r   <= '1;
    sample2lvl_ready_r  <= '0;
  end
  else
  begin
    sample2lvl_ready_r  <= !pipeline_stall;
    sample2lvl_init_r   <= '0;
  end
end

genvar ITER;
generate
  assign iter_start_r[0]        = 'd1;
  assign iter_symbol_cnt_r[0]   = fir_taps_head_r;
  // assign iter_symbol_inc_r[0]   = 'd1;
  assign iter_valid_signal_r[0] = 'd1;
  assign valid_signal[0]        = 'd1;

  for(ITER = 0; ITER < ITER_NUM; ITER++)
  begin : _FOR_ITER
    assign valid_signal[ITER+1]       = iter_symbol_cnt_r[ITER+1] >= fir_taps_head_r - 'd1;

    /* Iteration control */
    always_ff @(posedge clock)
    begin
      if(reset)
      begin
        iter_start_r[ITER+1]        <= '0;
        iter_symbol_cnt_r[ITER+1]   <= '0;
        // iter_symbol_inc_r[ITER+1]   <= '0;
        iter_valid_signal_r[ITER+1] <= '0;
      end
      else
      begin
        // iter_start_r[ITER+1] <= iter_valid_signal_r[ITER];
        iter_start_r[ITER+1] <= valid_signal[ITER];

        if(iter_start_r[ITER+1])
        begin
          iter_symbol_cnt_r[ITER+1]   <= iter_symbol_cnt_r[ITER+1] + (!pipeline_stall & sample2lvl_valid & !valid_signal[ITER+1]);
          // iter_symbol_inc_r[ITER+1]   <= !pipeline_stall & sample2lvl_valid;
          iter_valid_signal_r[ITER+1] <= valid_signal[ITER+1];
        end
      end
    end

    /* FIR subcells IF */
    always_ff @(posedge clock)
    begin
      if(reset)
      begin
        subcells_init_r[ITER]           <= '1;
        subcells_input_enable_r[ITER]   <= '0;
        subcells_output_enable_r[ITER]  <= '0;
      end
      else
      begin
        subcells_init_r[ITER]           <= 'd0;
        subcells_input_enable_r[ITER]   <= 'd1;
        subcells_output_enable_r[ITER]  <= 'd1;
      end
    end

    delay
    #(
      .DELAY     (5*(ITER+1)+2*(ITER)),
      .WIDTH     (1),
      .RESET     (1),
      .RESET_VAL ('0),
      .RAMSTYLE  ("logic")
    )
    delay4_valid_signal
    (
      .clock    (clock),
      .reset    (reset),
      .in_data  (iter_valid_signal_r[ITER+1]),
      .out_data (iter_valid_signal_del_r[ITER+1])
    );
  end
endgenerate

/* Output controller IF */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    outctrl_enable_r    <= '0;
    outctrl_iter_num_r  <= '0;
  end
  else
  begin
    outctrl_enable_r    <= 'd1;//!pipeline_stall; // ?
    outctrl_iter_num_r  <= iter_num_r - 'd1;
  end
end

endmodule
