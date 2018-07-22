
module lvl_generator
#(
  parameter LVLS_NUM        = 20,
  parameter LVL_RESET_VALUE = 9
)
(
  /* Common IF */
  input  wire        reset,
  input  wire        clock,
  /* Sample dispatcher IF */
  input  wire        disp_cross_dir,   // 1 -> upward, 0 -> downward
  input  wire        disp_new_sample,
  input  wire        disp_valid,
  /* Buffer controlers IF */
  output wire [15:0] buff_value,
  output wire [31:0] buff_limits,   // [31:16] -> upper limit, [15:0] -> lower limit
  output wire        buff_valid
);

reg [15:0] buff_value_r;
reg [31:0] buff_limits_r;
reg        buff_valid_r;
reg        buff_valid_buff_r;

reg  [ 4:0] lvls_num_r;
reg  [ 4:0] lvl_reset_value_r;

reg  [ 4:0] curr_lvl_r;
reg  [ 4:0] next_lvl_r;
wire [15:0] lvls_step;
wire [15:0] lvl_value;
reg  [15:0] curr_lower_limit_r;
reg  [15:0] next_lower_limit_r;
reg  [15:0] curr_upper_limit_r;
reg  [15:0] next_upper_limit_r;
wire [ 4:0] upper_lvl_idx;
wire [ 4:0] lower_lvl_idx;
reg  [0:31][15:0] lvls_values_r;
wire        not_max_lvl;
wire        not_min_lvl;

/* Temporarily frozen levels */
assign lvls_values_r = 
'{
  16'h8666, 16'h9333, 16'h9FFF, 16'hACCC,
  16'hB999, 16'hC666, 16'hD333, 16'hE000,
  16'hECCC, 16'hF999, 16'h0666, 16'h1333,
  16'h2000, 16'h2CCC, 16'h3999, 16'h4666,
  16'h5333, 16'h6000, 16'h6CCC, 16'h7999,
  /* UNUSED BELOW */
  16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF,
  16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF,
  16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF 
};

assign buff_value     = buff_value_r;
assign buff_limits    = buff_limits_r;
assign buff_valid     = buff_valid_r;

assign not_max_lvl    = (next_lvl_r != lvls_num_r-'d1);
assign not_min_lvl    = (next_lvl_r != 'd0);
assign upper_lvl_idx  = next_lvl_r + not_max_lvl;
assign lower_lvl_idx  = next_lvl_r - not_min_lvl;
assign lvls_step      = disp_cross_dir ?  lvls_values_r[upper_lvl_idx] - lvls_values_r[next_lvl_r] :
                                          lvls_values_r[next_lvl_r] - lvls_values_r[lower_lvl_idx];
assign lvl_value      = lvls_values_r[curr_lvl_r] + (lvls_step>>>1'b1);

assign lvls_num_r         = LVLS_NUM;
assign lvl_reset_value_r  = LVL_RESET_VALUE;

always_ff @(posedge clock)
begin
  if(reset)
  begin
    buff_value_r        <= '0;
    buff_limits_r       <= '0;
    buff_valid_r        <= '0;
    buff_valid_buff_r   <= '0;

    curr_lvl_r          <= lvl_reset_value_r;
    next_lvl_r          <= lvl_reset_value_r;
    curr_lower_limit_r  <= lvls_values_r[lvl_reset_value_r];
    next_lower_limit_r  <= lvls_values_r[lvl_reset_value_r];
    curr_upper_limit_r  <= lvls_values_r[lvl_reset_value_r+1];
    next_upper_limit_r  <= lvls_values_r[lvl_reset_value_r+1];
  end
  else
  begin
    if(disp_valid & disp_new_sample)
    begin
      curr_lvl_r          <= next_lvl_r;
      curr_lower_limit_r  <= next_lower_limit_r;
      curr_upper_limit_r  <= next_upper_limit_r;

      next_lvl_r          <= disp_cross_dir ? upper_lvl_idx : lower_lvl_idx;
      next_lower_limit_r  <= disp_cross_dir ? lvls_values_r[upper_lvl_idx] :
                                              (not_min_lvl ? lvls_values_r[lower_lvl_idx] : 16'h8000);
      next_upper_limit_r  <= disp_cross_dir ? (next_lvl_r < lvls_num_r-'d2 ? lvls_values_r[upper_lvl_idx+1] : 16'h7FFF) :
                                              lvls_values_r[next_lvl_r];
    end

    buff_value_r      <= lvl_value;
    buff_limits_r     <= { curr_upper_limit_r, curr_lower_limit_r };
    buff_valid_buff_r <= disp_valid;
    buff_valid_r      <= buff_valid_buff_r;
  end
end

endmodule
