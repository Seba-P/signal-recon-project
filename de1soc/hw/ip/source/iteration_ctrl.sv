
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
  /* Register file IF */
  output wire                       regfile_busy,           //    regfile.busy
  output wire                       regfile_ready,          //           .ready
  output wire                       regfile_error,          //           .error
  output wire                       regfile_fifo_err,       //           .fifo_err
  input  wire                       regfile_run,            //           .run
  input  wire                       regfile_halt,           //           .halt
  input  wire                       regfile_flush,          //           .flush
  input  wire                       regfile_init,           //           .init
  input  wire                [ 3:0] regfile_iter_num,       //           .iter_num
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


reg                        regfile_busy_r;
reg                        regfile_ready_r;
reg                        regfile_error_r;
reg                        regfile_fifo_err_r;
reg                        regfile_run_r;
reg                        regfile_halt_r;
reg                        regfile_flush_r;
reg                        regfile_init_r;
reg                 [ 3:0] regfile_iter_num_r;
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
reg                        outctrl_enable_d1_r;
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
reg                                          is_active_r;

assign regfile_busy           = regfile_busy_r;
assign regfile_ready          = regfile_ready_r;
assign regfile_error          = regfile_error_r;
assign regfile_fifo_err       = regfile_fifo_err_r;
assign sample2lvl_init        = sample2lvl_init_r;
assign sample2lvl_ready       = sample2lvl_ready_r;
assign subcells_init          = subcells_init_r;
// assign subcells_new_limits    = { ITER_NUM{ !pipeline_stall & sample2lvl_valid } };
assign subcells_new_limits    = subcells_new_limits_r;
assign subcells_valid_signal  = iter_valid_signal_r[ITER_NUM:1];
assign subcells_input_enable  = subcells_input_enable_r;
assign subcells_output_enable = subcells_output_enable_r;
// assign outctrl_enable         = outctrl_enable_r;
assign outctrl_enable         = outctrl_enable_d1_r;
assign outctrl_iter_num       = outctrl_iter_num_r;

assign pipeline_stall       = !(&subcells_ready & outctrl_ready);

/* Internal parameters */
always_ff @(posedge clock)
begin
  if (reset)
  begin
    fir_taps_num_r        <= '0;
    max_samples_in_ram_r  <= '0;
    fir_taps_head_r       <= '0;
    fir_taps_tail_r       <= '0;
    is_active_r           <= '0;
  end
  else
  begin
    fir_taps_num_r        <= FIR_TAPS_NUM;
    max_samples_in_ram_r  <= MAX_SAMPLES_IN_RAM;

    fir_taps_head_r       <= fir_taps_num_r[$bits(FIR_TAPS_NUM)-1:1] + fir_taps_num_r[0];
    fir_taps_tail_r       <= fir_taps_num_r[$bits(FIR_TAPS_NUM)-1:1];

    if (regfile_run)
      is_active_r <= 'd1;
    else if (regfile_halt)
      is_active_r <= 'd0;
  end
end

/* Register file IF */
always_ff @(posedge clock)
begin
  if (reset)
  begin
    regfile_busy_r      <= '0;
    regfile_ready_r     <= '0;
    regfile_error_r     <= '0;
    regfile_fifo_err_r  <= '0;
    regfile_run_r       <= '0;
    regfile_halt_r      <= '0;
    regfile_flush_r     <= '0;
    regfile_init_r      <= '0;
    regfile_iter_num_r  <= '0;
  end
  else
  begin
    regfile_busy_r      <= sample2lvl_valid;
    regfile_ready_r     <= !sample2lvl_valid;
    regfile_error_r     <= 'd0;
    regfile_fifo_err_r  <= 'd0;
    regfile_run_r       <= regfile_run;
    regfile_halt_r      <= regfile_halt;
    regfile_flush_r     <= regfile_flush;
    regfile_init_r      <= regfile_init;
    regfile_iter_num_r  <= regfile_iter_num;
  end
end

/* Sample2lvl converter IF */
always_ff @(posedge clock)
begin
  if (reset)
  begin
    sample2lvl_init_r   <= '1;
    sample2lvl_ready_r  <= '0;
  end
  else
  begin
    // sample2lvl_init_r   <= '0;
    sample2lvl_init_r   <= regfile_init;
    // sample2lvl_ready_r  <= !pipeline_stall;
    sample2lvl_ready_r  <= !pipeline_stall && is_active_r;
  end
end

genvar ITER;
generate
  assign iter_start_r[0]        = 'd1;
  assign iter_symbol_cnt_r[0]   = fir_taps_head_r;
  assign iter_valid_signal_r[0] = 'd1;
  assign valid_signal[0]        = 'd1;

  for (ITER = 0; ITER < ITER_NUM; ITER++)
  begin : _FOR_ITER
    assign valid_signal[ITER+1] = iter_symbol_cnt_r[ITER+1] >= fir_taps_head_r - 'd1;

    /* Iteration control */
    always_ff @(posedge clock)
    begin
      if (reset)
      begin
        iter_start_r[ITER+1]        <= '0;
        iter_symbol_cnt_r[ITER+1]   <= '0;
        iter_valid_signal_r[ITER+1] <= '0;
      end
      else
      begin
        iter_start_r[ITER+1] <= valid_signal[ITER];

        if (/*iter_start_r[ITER+1]*/valid_signal[ITER])
        begin
          iter_symbol_cnt_r[ITER+1]   <= iter_symbol_cnt_r[ITER+1] + (!pipeline_stall & sample2lvl_valid & !valid_signal[ITER+1]);
          iter_valid_signal_r[ITER+1] <= valid_signal[ITER+1];
        end
      end
    end

    /* FIR subcells IF */
    always_ff @(posedge clock)
    begin
      if (reset)
      begin
        subcells_init_r[ITER]           <= '1;
        subcells_input_enable_r[ITER]   <= '0;
        subcells_output_enable_r[ITER]  <= '0;
        subcells_new_limits_r[ITER]     <= '0;
      end
      else
      begin
        // subcells_init_r[ITER]           <= 'd0;
        subcells_init_r[ITER]           <= regfile_init;
        subcells_input_enable_r[ITER]   <= 'd1;
        subcells_output_enable_r[ITER]  <= 'd1;
        subcells_new_limits_r[ITER]     <= !pipeline_stall & sample2lvl_valid;
      end
    end
  end
endgenerate

/* Output controller IF */
always_ff @(posedge clock)
begin
  if (reset)
  begin
    outctrl_enable_r    <= '0;
    outctrl_enable_d1_r <= '0;
    outctrl_iter_num_r  <= '0;
  end
  else
  begin
    outctrl_enable_r    <= 'd1;//!pipeline_stall; // ?
    outctrl_enable_d1_r <= outctrl_enable_r;
    outctrl_iter_num_r  <= regfile_iter_num_r - 'd1;
  end
end

endmodule
