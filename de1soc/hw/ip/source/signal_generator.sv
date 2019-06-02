
module signal_generator
#(
  parameter MAX_LVLS_NUM = 32
)
(
  /* Common IF */
  input  wire                            reset,
  input  wire                            clock,
  /* Register file IF */
  input  wire [$clog2(MAX_LVLS_NUM)-1:0] params_lvls_num,
  input  wire [$clog2(MAX_LVLS_NUM)-1:0] params_init_lvl,
  input  wire                     [ 1:0] params_init_guess, // 00 -> zero guess, 01 -> piecewise constant,
                                                            // 10 -> piecewise linear, 11 -> reserved
  input  wire   [0:MAX_LVLS_NUM-1][15:0] params_lvls_values,
  /* Sample dispatcher IF */
  input  wire                            disp_cross_dir,  // 1 -> upward, 0 -> downward
  input  wire                     [14:0] disp_duration,
  input  wire                            disp_valid,
  output wire                            disp_ready,
  /* Buffer controllers IF */
  output wire                     [15:0] buff_value,
  output wire                     [31:0] buff_limits, // [31:16] -> upper limit, [15:0] -> lower limit
  output wire                            buff_valid,
  /* Iteration controller IF */
  output wire                            iter_valid,
  input  wire                            iter_ready
);

localparam int MAX_LVLS_NUM_BITS = $clog2(MAX_LVLS_NUM);

localparam bit LVL_UP   = 1'b1;
localparam bit LVL_DOWN = 1'b0;

localparam bit [1:0] INIT_GUESS_ZERO      = 2'b00;
localparam bit [1:0] INIT_GUESS_CONSTANT  = 2'b01;
localparam bit [1:0] INIT_GUESS_LINEAR    = 2'b10;
localparam bit [1:0] INIT_GUESS_RESERVED  = 2'b11;

reg                           disp_ready_r;
reg                    [15:0] buff_value_r;
reg                    [15:0] buff_value_del_r;
reg                    [31:0] buff_limits_r;
reg                    [31:0] buff_limits_del_r;
reg                           buff_valid_r;
reg                           buff_valid_del_r;
reg                           iter_valid_r;
reg                           iter_valid_del_r;

reg   [MAX_LVLS_NUM_BITS-1:0] lvls_num_r;
reg   [MAX_LVLS_NUM_BITS-1:0] init_lvl_r;
reg  [0:MAX_LVLS_NUM-1][15:0] lvls_values_r;
reg                    [ 1:0] init_guess_r;

reg   [MAX_LVLS_NUM_BITS-1:0] curr_lvl_r;
reg   [MAX_LVLS_NUM_BITS-1:0] next_lvl_r;
reg                           overflow_r;
reg                           underflow_r;

reg                    [15:0] lower_limit_r;
reg                    [15:0] upper_limit_r;
reg                    [15:0] lvls_distance_r;

reg                    [15:0] linear_step_r;
reg                    [ 1:0] half_step_dir_r;
reg                           curr_half_r;

reg                    [15:0] constant_guess_value_r;
reg                    [15:0] constant_guess_value_del_r;
reg                    [15:0] linear_guess_value_r;
reg                    [15:0] linear_guess_value_del_r;

reg                    [14:0] sample_duration_r;
reg                    [14:0] points_left_cnt_r;
wire                          sample_done;

assign disp_ready   = disp_ready_r;
assign buff_value   = buff_value_del_r;
assign buff_limits  = buff_limits_del_r;
assign buff_valid   = buff_valid_del_r;
assign iter_valid   = iter_valid_del_r;

assign sample_done  = (points_left_cnt_r == 'd0);
assign new_sample   = (disp_valid & disp_ready);

always_ff @(posedge clock)
begin
  lvls_num_r    <= params_lvls_num;
  init_lvl_r    <= params_init_lvl;
  init_guess_r  <= params_init_guess;
end

genvar LVL;
generate
  for (LVL = 0; LVL < MAX_LVLS_NUM; LVL++)
  begin : _FOR_LVLS_VALUES
    always_ff @(posedge clock)
      lvls_values_r[LVL] <= params_lvls_values[LVL];
  end
endgenerate

/* Sample dispatcher & iteration controller IF */
always_ff @(posedge clock)
begin
  if (reset)
  begin
    disp_ready_r  <= '0;
    iter_valid_r  <= '0;
  end
  else
  begin
    if (sample_done)
    begin
      disp_ready_r  <= 'd1;
      iter_valid_r  <= 'd0;
    end
    else
    begin
      disp_ready_r  <= 'd0;
      iter_valid_r  <= 'd1;
    end
  end
end

/* Level duration & timing */
always_ff @(posedge clock)
begin
  if (reset)
  begin
    sample_duration_r <= '0;
    points_left_cnt_r <= '0;
    curr_half_r       <= '0;
  end
  else
  begin
    if (new_sample)
    begin
      sample_duration_r <= disp_duration;
      points_left_cnt_r <= disp_duration;
      curr_half_r       <= 'd0;
    end
    else
    begin
      if (iter_ready)
      begin
        points_left_cnt_r  <= sample_done ? points_left_cnt_r : points_left_cnt_r - 'd1;
      end

      curr_half_r <= (points_left_cnt_r <= (sample_duration_r >>> 1'b1));
    end
  end
end

/* Determine current & next levels */
always_ff @(posedge clock)
begin
  if (reset)
  begin
    curr_lvl_r      <= init_lvl_r;
    next_lvl_r      <= init_lvl_r;
    overflow_r      <= '0;
    underflow_r     <= '0;
  end
  else
  begin
    if (new_sample)
    begin
      curr_lvl_r <= next_lvl_r;

      if (disp_cross_dir == LVL_UP)
      begin
        if (!overflow_r)
          next_lvl_r <= next_lvl_r + !underflow_r;

        overflow_r  <= (next_lvl_r >= lvls_num_r - 'd2);
        underflow_r <= 'd0;
      end
      else
      begin
        if (next_lvl_r != 'd0)
          next_lvl_r <= next_lvl_r - 'd1;

        overflow_r  <= 'd0;
        underflow_r <= (next_lvl_r == 'd0);
      end
    end
  end
end

/* Determine signal limits */
always_ff @(posedge clock)
begin
  if (reset)
  begin
    lower_limit_r   <= lvls_values_r[init_lvl_r];
    upper_limit_r   <= lvls_values_r[init_lvl_r+1];
    lvls_distance_r <= '0;
  end
  else
  begin
    if (new_sample)
    begin
      lower_limit_r  <= underflow_r ? 'h8000 : lvls_values_r[next_lvl_r];
      upper_limit_r  <= overflow_r ? 'h7FFF : lvls_values_r[next_lvl_r+!underflow_r];
    end

    lvls_distance_r <= upper_limit_r - lower_limit_r;
  end
end

/* Piecewise-constant guess */
always_ff @(posedge clock)
begin
  if (reset)
  begin
    constant_guess_value_r <= 'd0;
  end
  else
  begin
    constant_guess_value_r <= lower_limit_r + (lvls_distance_r >>> 1'b1);
  end
end

delay
#(
  .DELAY     (2),
  .WIDTH     ($bits({ constant_guess_value_r })),
  .RESET     (1),
  .RESET_VAL ('0),
  .RAMSTYLE  ("logic")
)
delay_constant_guess_value
(
  .clock    (clock),
  .reset    (reset),
  .in_data  ({ constant_guess_value_r }),
  .out_data ({ constant_guess_value_del_r })
);

/* Piecewise-linear guess */
always_ff @(posedge clock)
begin
  if (reset)
  begin
    linear_guess_value_r  <= '0;
    linear_step_r         <= '0;
    half_step_dir_r       <= '0;
  end
  else
  begin
    //TODO:
    if (new_sample)
    begin
      half_step_dir_r <= 2'b00;
    end

    linear_guess_value_r <= 'd0;
  end
end

delay
#(
  .DELAY     (0),
  .WIDTH     ($bits({ linear_guess_value_r })),
  .RESET     (1),
  .RESET_VAL ('0),
  .RAMSTYLE  ("logic")
)
delay_linear_guess_value
(
  .clock    (clock),
  .reset    (reset),
  .in_data  ({ linear_guess_value_r }),
  .out_data ({ linear_guess_value_del_r })
);

always_ff @(posedge clock)
begin
  if (reset)
  begin
    buff_value_r    <= '0;
    buff_limits_r   <= '0;
    buff_valid_r    <= '0;
  end
  else
  begin
    unique case (init_guess_r)
      INIT_GUESS_ZERO:
      begin
        buff_value_r <= 'd0;
      end

      INIT_GUESS_CONSTANT:
      begin
        buff_value_r <= constant_guess_value_del_r;
      end

      INIT_GUESS_LINEAR:
      begin
        buff_value_r <= linear_guess_value_del_r;
      end

      INIT_GUESS_RESERVED:
      begin
        buff_value_r <= 'd0;
      end
    endcase

    buff_limits_r   <= { upper_limit_r, lower_limit_r };
    buff_valid_r    <= !sample_done & iter_ready;
  end
end

delay
#(
  .DELAY     (3),
  .WIDTH     ($bits({ buff_limits_r })),
  .RESET     (1),
  .RESET_VAL ('0),
  .RAMSTYLE  ("logic")
)
delay_buff_limits
(
  .clock    (clock),
  .reset    (reset),
  .in_data  ({ buff_limits_r }),
  .out_data ({ buff_limits_del_r })
);

delay
#(
  .DELAY     (0),
  .WIDTH     ($bits({ buff_value_r })),
  .RESET     (1),
  .RESET_VAL ('0),
  .RAMSTYLE  ("logic")
)
delay_buff_value
(
  .clock    (clock),
  .reset    (reset),
  .in_data  ({ buff_value_r }),
  .out_data ({ buff_value_del_r })
);

delay
#(
  .DELAY     (3),
  .WIDTH     ($bits({ buff_valid_r, iter_valid_r })),
  .RESET     (1),
  .RESET_VAL ('0),
  .RAMSTYLE  ("logic")
)
delay_buff_valid_iter_valid
(
  .clock    (clock),
  .reset    (reset),
  .in_data  ({ buff_valid_r, iter_valid_r }),
  .out_data ({ buff_valid_del_r, iter_valid_del_r })
);

endmodule
