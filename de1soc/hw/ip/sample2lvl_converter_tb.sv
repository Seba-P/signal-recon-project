`timescale 1ns/100ps

module clock_gen
(
  output logic clock,
  output logic reset
);

initial
begin
  clock = 1'b0;
  reset = 1'b1;

  #100 reset = 1'b0;
end

initial 
  forever
    #5 clock = ~clock;

endmodule // clock_gen

module sample2lvl_converter_tb;

/* Common IF */
logic        reset;
logic        clock;
/* SGDMA IF */
logic [15:0] in_data;
logic        in_ready;
logic        in_valid;
/* Output data IF */
logic [15:0] out_value;
logic [31:0] out_limits;
logic        out_valid;
logic        out_ready;

localparam MAX_SAMPLES_IN_RAM = 255;
localparam LVLS_NUM           = 20;
localparam LVL_RESET_VALUE    = 9;
localparam ITER_NUM           = 4;

clock_gen clk_rst_gen
(
  .clock (clock),
  .reset (reset)
);

sample2lvl_converter
#(
  .LVLS_NUM     (LVLS_NUM),
  .LVL_RESET_VALUE(LVL_RESET_VALUE)
)
DUT
(
  /* Common IF */
  .reset      (reset),
  .clock      (clock),
  /* SGDMA IF */
  .in_data    (in_data),
  .in_ready   (in_ready),
  .in_valid   (in_valid),
  /* Output data IF */
  .out_value  (out_value),
  .out_limits (out_limits),
  .out_valid  (out_valid),
  .out_ready  (out_ready)
);

typedef struct packed
{
  bit     lvl_cross_dir;
  bit [14:0]  timestamp;
} LVL_CROSS_SAMPLE_T;

LVL_CROSS_SAMPLE_T sample;
logic [15:0] recv_fir_data[MAX_SAMPLES_IN_RAM];
bit   [ 4:0] curr_lvl;
bit   [15:0] lvls_step;
bit   [15:0] expected_value;
bit   [31:0] expected_limits;
wire         not_max_lvl;
wire         not_min_lvl;
wire         upper_lvl_idx;
wire         lower_lvl_idx;

bit [0:31][15:0] lvls_values = 
{
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

assign not_max_lvl     = (curr_lvl != LVLS_NUM-1);
assign not_min_lvl     = (curr_lvl != '0);
assign upper_lvl_idx   = curr_lvl + not_max_lvl;
assign lower_lvl_idx   = curr_lvl - not_min_lvl;

task send_sample(LVL_CROSS_SAMPLE_T sample);
  int duration;

  curr_lvl        <= sample.lvl_cross_dir ? curr_lvl + (curr_lvl != LVLS_NUM-1) : curr_lvl - (curr_lvl != 0);
  lvls_step       <= sample.lvl_cross_dir ? lvls_values[curr_lvl+(curr_lvl != LVLS_NUM-1)] - lvls_values[curr_lvl] :
                                            lvls_values[curr_lvl] - lvls_values[curr_lvl-(curr_lvl != 0)];
  expected_value  <= lvls_values[curr_lvl] + (lvls_step>>>1);
  expected_limits <= sample.lvl_cross_dir ?
            { curr_lvl < LVLS_NUM-2 ? lvls_values[upper_lvl_idx+1] : 16'h7FFF, lvls_values[upper_lvl_idx] } :
            { lvls_values[curr_lvl], not_min_lvl ? lvls_values[lower_lvl_idx] : 16'h8000 };

  in_valid  = 'd1;
  in_data   = sample;

  if(!in_ready)
    @(posedge in_ready);

endtask : send_sample

task verify_output(LVL_CROSS_SAMPLE_T sample);
  localparam DELAY = 3;
  int duration;

  in_valid = 'd0;

  for(duration = 0; duration < DELAY; duration++)
  begin
    @(posedge clock);
  end

  for(duration = 0; duration < sample.timestamp; duration++)
  begin
    @(posedge clock);

    if(in_ready)
      $display("ERROR @%g(#%d): in_ready asserted!", $time, duration + DELAY);

    if(~out_valid)
      $display("ERROR @%g(#%d): out_valid deasserted!", $time, duration + DELAY);

    if(out_value != expected_value)
      $display("ERROR @%g(#%d): invalid output value (0x%0h/0x%0h)!", $time, duration + DELAY, out_value, expected_value);

    if(out_limits != expected_limits)
      $display("ERROR @%g(#%d): invalid output limits (0x%0h/0x%0h)!", $time, duration + DELAY, out_limits, expected_limits);
  end

endtask : verify_output

initial
begin
  in_data   = '0;
  in_valid  = '0;
  out_ready = '0;
end

initial
begin
  #150 curr_lvl = LVL_RESET_VALUE;
  out_ready     = 'd1;

  /* Verify lvls generation */
  repeat(LVLS_NUM/2+2)
  begin
    sample = '{ 1'b0, 15'd5 };
    send_sample(sample);
    verify_output(sample);
  end

  repeat(LVLS_NUM+1)
  begin
    sample = '{ 1'b1, 15'd5 };
    send_sample(sample);
    verify_output(sample);
  end

  /* Verify iterative processing */
  #  5 curr_lvl   = LVL_RESET_VALUE;
  # 20 reset      = 'd1;
  #100 reset      = 'd0;

  sample = '{ 1'b1, 15'd400 };
  send_sample(sample);

  sample = '{ 1'b1, 15'd40 };
  send_sample(sample);
  in_valid = 'd0;

  # 50 $stop;
end

endmodule // sample2lvl_converter_tb
