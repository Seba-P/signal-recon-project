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

module fir_subsystem_top_tb;

/* Common IF */
logic        reset;
logic        reset_n;
logic        clock;
  /* MM2ST IF */
logic [15:0] mm2st_data;
logic        mm2st_valid;
logic        mm2st_ready;
  /* ST2MM IF */
logic [15:0] st2mm_data;
logic        st2mm_valid;
logic        st2mm_ready;

localparam MAX_SAMPLES_IN_RAM = 255;
localparam LVLS_NUM           = 20;
localparam LVL_RESET_VALUE    = 9;
localparam ITER_NUM           = 1;
localparam USE_COMB_LOGIC     = 0;

assign reset_n = ~reset;

clock_gen clk_rst_gen
(
  .clock  (clock),
  .reset  (reset)
);

fir_subsystem_top
#(
  .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM),
  .LVLS_NUM           (LVLS_NUM),
  .LVL_RESET_VALUE    (LVL_RESET_VALUE),
  .ITER_NUM           (ITER_NUM),
  .USE_COMB_LOGIC     (USE_COMB_LOGIC)
)
DUT
(
  /* Common IF */
  .reset_n      (reset_n),
  .clock        (clock),
  /* MM2ST IF */
  .mm2st_data   (mm2st_data),
  .mm2st_valid  (mm2st_valid),
  .mm2st_ready  (mm2st_ready),
  /* ST2MM IF */
  .st2mm_data   (st2mm_data),
  .st2mm_valid  (st2mm_valid),
  .st2mm_ready  (st2mm_ready)
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
int          curr_iter, iter_sample;
int          duration, total_duration;
wire         not_max_lvl, not_min_lvl;
wire         upper_lvl_idx, lower_lvl_idx;

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
  curr_lvl        <= sample.lvl_cross_dir ? curr_lvl + (curr_lvl != LVLS_NUM-1) : curr_lvl - (curr_lvl != 0);
  lvls_step       <= sample.lvl_cross_dir ? lvls_values[curr_lvl+(curr_lvl != LVLS_NUM-1)] - lvls_values[curr_lvl] :
                                            lvls_values[curr_lvl] - lvls_values[curr_lvl-(curr_lvl != 0)];
  expected_value  <= lvls_values[curr_lvl] + (lvls_step>>>1);
  expected_limits <= sample.lvl_cross_dir ?
            { curr_lvl < LVLS_NUM-2 ? lvls_values[upper_lvl_idx+1] : 16'h7FFF, lvls_values[upper_lvl_idx] } :
            { lvls_values[curr_lvl], not_min_lvl ? lvls_values[lower_lvl_idx] : 16'h8000 };

  mm2st_valid  = 'd1;
  mm2st_data   = sample;

  if(!mm2st_ready)
    @(posedge mm2st_ready);
  mm2st_valid = 'd0;

endtask : send_sample

task verify_output(LVL_CROSS_SAMPLE_T sample);
  localparam DELAY = 5;

  for(duration = 0; duration < sample.timestamp; duration++)
  begin
    @(posedge clock);
    /*if(!st2mm_valid)
      @(posedge st2mm_valid);

    recv_fir_data[total_duration++%MAX_SAMPLES_IN_RAM] = st2mm_data;
    if(st2mm_data != expected_value)
      $display("Invalid output data (0x%x/0x%x) @ sample #%0d/%0d!", st2mm_data, expected_value, duration, total_duration-1);*/
    
    if((++total_duration % MAX_SAMPLES_IN_RAM) == 0)
    begin
      while(curr_iter < ITER_NUM)
      begin
        for(iter_sample = 0; iter_sample < MAX_SAMPLES_IN_RAM; iter_sample++)
        begin
          @(posedge clock);
          /*if(!st2mm_valid)
            @(posedge st2mm_valid);
          if(st2mm_data != recv_fir_data[iter_sample])
            $display("Invalid output data (0x%x/0x%x) @ sample #%0d(RAM))!", st2mm_data, expected_value, iter_sample);*/
        end
        curr_iter++;
      end
      curr_iter = 0;
    end
  end

  /*for(duration = 0; duration < sample.timestamp; duration++)
  begin
    @(posedge clock);

    if(mm2st_ready)
      $display("ERROR @%g(#%d): mm2st_ready asserted!", $time, duration + DELAY);

    if(~st2mm_valid)
      $display("ERROR @%g(#%d): st2mm_valid deasserted!", $time, duration + DELAY);

    if(st2mm_data != expected_value)
      $display("ERROR @%g(#%d): invalid output value (0x%0h/0x%0h)!", $time, duration + DELAY, st2mm_data, expected_value);
  end*/

endtask : verify_output

initial
begin
  mm2st_data   = '0;
  mm2st_valid  = '0;
  st2mm_ready  = '0;
end

initial
begin
  #150 curr_lvl = LVL_RESET_VALUE;
  curr_iter     = 0;
  st2mm_ready   = 'd1;

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
  curr_iter       = 0;
  total_duration  = 0;
  # 20 reset      = 'd1;
  #100 reset      = 'd0;

  sample = '{ 1'b1, 15'd400 };
  send_sample(sample);
  verify_output(sample);

  sample = '{ 1'b1, 15'd40 };
  send_sample(sample);
  verify_output(sample);
  mm2st_valid = 'd0;

  # 50 $stop;
end

endmodule // fir_subsystem_top_tb
