
module lvl_generator
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
  input  wire   [0:MAX_LVLS_NUM-1][15:0] params_lvls_values,
  /* Sample dispatcher IF */
  input  wire                            disp_cross_dir,   // 1 -> upward, 0 -> downward
  input  wire                            disp_new_sample,
  input  wire                            disp_valid,
  /* Buffer controlers IF */
  output wire                     [15:0] buff_value,
  output wire                     [31:0] buff_limits,   // [31:16] -> upper limit, [15:0] -> lower limit
  output wire                            buff_valid
);

localparam MAX_LVLS_NUM_BITS = $clog2(MAX_LVLS_NUM);

localparam LVL_UP   = 1'b1;
localparam LVL_DOWN = 1'b0;

reg                    [15:0] buff_value_r;
reg                    [31:0] buff_limits_r;
reg                           buff_valid_r;
reg                           buff_valid_d1_r;
reg                           buff_valid_d2_r;
reg                           buff_valid_d3_r;

reg   [MAX_LVLS_NUM_BITS-1:0] lvls_num_r;
reg   [MAX_LVLS_NUM_BITS-1:0] init_lvl_r;
reg  [0:MAX_LVLS_NUM-1][15:0] lvls_values_r;

reg   [MAX_LVLS_NUM_BITS-1:0] curr_lvl_r;
reg   [MAX_LVLS_NUM_BITS-1:0] next_lvl_r;
reg                    [15:0] lvls_step_r;
reg                    [15:0] lvl_value_r;
reg                    [15:0] lower_limit_r;
reg                    [15:0] upper_limit_r;
reg                           overflow_r;
reg                           underflow_r;

assign buff_value   = buff_value_r;
assign buff_limits  = buff_limits_r;
assign buff_valid   = buff_valid_d2_r;

always_ff @(posedge clock)
begin
  lvls_num_r  <= params_lvls_num;
  init_lvl_r  <= params_init_lvl;
end

genvar LVL;
generate
  for (LVL = 0; LVL < MAX_LVLS_NUM; LVL++)
  begin : _FOR_LVLS_VALUES
    always_ff @(posedge clock)
      lvls_values_r[LVL] <= params_lvls_values[LVL];
  end
endgenerate

always_ff @(posedge clock)
begin
  if (reset)
  begin
    curr_lvl_r    <= init_lvl_r;
    next_lvl_r    <= init_lvl_r;
    lower_limit_r <= lvls_values_r[init_lvl_r];
    upper_limit_r <= lvls_values_r[init_lvl_r+1];
    overflow_r    <= '0;
    underflow_r   <= '0;
    lvls_step_r   <= '0;
    lvl_value_r   <= '0;
  end
  else
  begin
    if (disp_valid & disp_new_sample)
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

      lower_limit_r  <= underflow_r ? 'h8000 : lvls_values_r[next_lvl_r];
      upper_limit_r  <= overflow_r ? 'h7FFF : lvls_values_r[next_lvl_r+!underflow_r];
    end

    lvls_step_r <= upper_limit_r - lower_limit_r;
  end
end

always_ff @(posedge clock)
begin
  if (reset)
  begin
    buff_value_r    <= '0;
    buff_limits_r   <= '0;
    buff_valid_r    <= '0;
    buff_valid_d1_r <= '0;
    buff_valid_d2_r <= '0;
    buff_valid_d3_r <= '0;
  end
  else
  begin
    buff_value_r    <= lower_limit_r + (lvls_step_r >>> 1'b1);
    buff_limits_r   <= { upper_limit_r, lower_limit_r };
    buff_valid_r    <= disp_valid;
    buff_valid_d1_r <= buff_valid_r;
    buff_valid_d2_r <= buff_valid_d1_r;
    buff_valid_d3_r <= buff_valid_d2_r;
  end
end

endmodule
