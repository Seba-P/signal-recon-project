
module lvl_generator
#(
  parameter LVLS_NUM        = 20,
  parameter LVL_RESET_VALUE = 9
)
(
  /* Common IF */
  input  wire              reset,
  input  wire              clock,
  /* Register file IF */
  input  wire       [ 4:0] reg_lvls_num,
  input  wire       [ 4:0] reg_lvl_reset_value,
  input  wire [0:31][15:0] reg_lvls_values,
  /* Sample dispatcher IF */
  input  wire              disp_cross_dir,   // 1 -> upward, 0 -> downward
  input  wire              disp_new_sample,
  input  wire              disp_valid,
  /* Buffer controlers IF */
  output wire       [15:0] buff_value,
  output wire       [31:0] buff_limits,   // [31:16] -> upper limit, [15:0] -> lower limit
  output wire              buff_valid
);

localparam LVL_UP   = 1'b1;
localparam LVL_DOWN = 1'b0;

reg [15:0] buff_value_r;
reg [31:0] buff_limits_r;
reg        buff_valid_r;
reg        buff_valid_d1_r;
reg        buff_valid_d2_r;
reg        buff_valid_d3_r;

reg  [ 4:0] lvls_num_r;
reg  [ 4:0] lvl_reset_value_r;

reg  [ 4:0] curr_lvl_r;
reg  [ 4:0] next_lvl_r;
reg  [15:0] lvls_step_r;
reg  [15:0] lvl_value_r;
reg  [15:0] lower_limit_r;
reg  [15:0] upper_limit_r;
reg  [0:31][15:0] lvls_values_r;
reg         overflow_r;
reg         underflow_r;

/* Temporarily frozen levels */
// assign lvls_values_r = 
// '{
//   16'h8666, 16'h9333, 16'h9FFF, 16'hACCC,
//   16'hB999, 16'hC666, 16'hD333, 16'hE000,
//   16'hECCC, 16'hF999, 16'h0666, 16'h1333,
//   16'h2000, 16'h2CCC, 16'h3999, 16'h4666,
//   16'h5333, 16'h6000, 16'h6CCC, 16'h7999,
//   /* UNUSED BELOW */
//   16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF,
//   16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF,
//   16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF 
// };

assign buff_value     = buff_value_r;
assign buff_limits    = buff_limits_r;
assign buff_valid     = buff_valid_d2_r;

// assign lvls_num_r         = LVLS_NUM;
// assign lvl_reset_value_r  = LVL_RESET_VALUE;

always_ff @(posedge clock)
begin
  lvls_num_r        <= reg_lvls_num;
  lvl_reset_value_r <= reg_lvl_reset_value;
end

genvar LVL;
generate
  for (LVL = 0; LVL < 32; LVL++)
  begin : _FOR_LVLS_VALUES
    always_ff @(posedge clock)
      lvls_values_r[LVL] <= reg_lvls_values[LVL];
  end
endgenerate

always_ff @(posedge clock)
begin
  if (reset)
  begin
    curr_lvl_r    <= lvl_reset_value_r;
    next_lvl_r    <= lvl_reset_value_r;
    lower_limit_r <= lvls_values_r[lvl_reset_value_r];
    upper_limit_r <= lvls_values_r[lvl_reset_value_r+1];
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

        overflow_r  <= (next_lvl_r >= LVLS_NUM - 'd2);
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
