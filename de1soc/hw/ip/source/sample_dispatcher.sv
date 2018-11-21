
module sample_dispatcher
(
  /* Common IF */
  input  wire        reset,
  input  wire        clock,
  /* SGDMA IF */
  input  wire [15:0] in_data,
  output wire        in_ready,
  input  wire        in_valid,
  /* Lvl generator IF */
  output wire        lvl_gen_cross_dir,   // 1 -> upward, 0 -> downward
  output wire        lvl_gen_new_sample,
  output wire        lvl_gen_valid,
  /* Iteration controler IF */
  input  wire        iter_ready
);

wire       next_sample;
reg        in_ready_r;
reg        lvl_gen_cross_dir_r;
reg        lvl_gen_new_sample_r;
reg        lvl_gen_valid_r;
reg [14:0] lvl_duration_cnt_r;

assign in_ready           = in_ready_r;
assign lvl_gen_cross_dir  = lvl_gen_cross_dir_r;
assign lvl_gen_new_sample = lvl_gen_new_sample_r;
assign lvl_gen_valid      = lvl_gen_valid_r;

assign next_sample = (lvl_duration_cnt_r == 'd0);

always_ff @(posedge clock)
begin
  if(reset)
  begin
    in_ready_r              <= '0;
    lvl_gen_cross_dir_r     <= '0;
    lvl_gen_new_sample_r    <= '0;
    lvl_gen_valid_r         <= '0;
    lvl_duration_cnt_r      <= '0;
  end
  else
  begin
    if(next_sample & in_valid)
    begin
      in_ready_r            <= 'd1;
      lvl_gen_new_sample_r  <= 'd1;
      lvl_gen_cross_dir_r   <= in_data[15];
      lvl_duration_cnt_r    <= in_data[14:0];
      lvl_gen_valid_r       <= 'd1;
    end
    else
    begin
      in_ready_r            <= 'd0;
      lvl_gen_new_sample_r  <= 'd0;
      lvl_gen_valid_r       <= lvl_duration_cnt_r > 'd1;

      if(iter_ready)
      begin
        lvl_duration_cnt_r  <= next_sample ? lvl_duration_cnt_r : lvl_duration_cnt_r - 'd1;
      end
    end
  end
end

endmodule
