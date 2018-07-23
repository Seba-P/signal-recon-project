`timescale 1ns/100ps

module clock_gen
(
  input  logic sim_end,
  output logic reset,
  output logic clock
);

initial
begin
  clock = 1'b0;
  reset = 1'b1;

  #100 reset = 1'b0;
end

initial
  do
    #5 clock = ~clock;
  while(!sim_end);

endmodule // clock_gen

module fir_subsystem_top_tb;

/* Common IF */
logic        sim_end;
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

localparam FIR_TAPS_NUM       = 63;
localparam MAX_SAMPLES_IN_RAM = 63;
localparam LVLS_NUM           = 20;
localparam LVL_RESET_VALUE    = 9;
localparam ITER_NUM           = 6;
localparam USE_COMB_LOGIC     = 0;

assign reset_n = ~reset;

clock_gen clk_rst_gen
(
  .sim_end  (sim_end),
  .reset    (reset),
  .clock    (clock)
);

fir_subsystem_top
#(
  .FIR_TAPS_NUM       (FIR_TAPS_NUM),
  .MAX_SAMPLES_IN_RAM (MAX_SAMPLES_IN_RAM),
  .LVLS_NUM           (LVLS_NUM),
  .LVL_RESET_VALUE    (LVL_RESET_VALUE),
  .ITER_NUM           (ITER_NUM),
  .USE_COMB_LOGIC     (USE_COMB_LOGIC)
)
DUT
(
  /* Common IF */
  .reset        (reset),
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
int          duration;
wire         not_max_lvl, not_min_lvl;
wire         upper_lvl_idx, lower_lvl_idx;
int          fd_in, fd_out;

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

localparam USE_TESTVECTOR = 1;

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
  mm2st_valid <= 'd0;
  @(posedge clock);

endtask : send_sample

task verify_output(LVL_CROSS_SAMPLE_T sample);
  localparam DELAY = 5;
  // static start_of_output;

  for(duration = 0; duration < sample.timestamp; duration++)
  begin
    // if(USE_TESTVECTOR)
    // begin
    //   wait(st2mm_valid == 'd1);
    //   $fwrite(fd_out, "0x%h\n", st2mm_data);
    //   // $fwrite(fd_out, "%u", st2mm_data);
    // end

    @(posedge clock);

    // if(mm2st_ready)
    //   $display("ERROR @%g(#%d): mm2st_ready asserted!", $time, duration + DELAY);

    // if(~st2mm_valid)
    //   $display("ERROR @%g(#%d): st2mm_valid deasserted!", $time, duration + DELAY);

    // if(st2mm_data != expected_value)
    //   $display("ERROR @%g(#%d): invalid output value (0x%0h/0x%0h)!", $time, duration + DELAY, st2mm_data, expected_value);
  end

endtask : verify_output

initial
begin
  sim_end     = '0;
  mm2st_data  = '0;
  mm2st_valid = '0;
  st2mm_ready = '0;
end

always @(posedge clock)
begin
  if(USE_TESTVECTOR)
  begin
    if(st2mm_valid)
      $fwrite(fd_out, "0x%h\n", st2mm_data);
      // $fwrite(fd_out, "%u", st2mm_data);
  end
end

initial
begin
  #150 curr_lvl = LVL_RESET_VALUE;
  st2mm_ready   = 'd1;

  /* Pipeline init after reset */
  repeat(MAX_SAMPLES_IN_RAM+5)
    @(posedge clock);

  if(USE_TESTVECTOR)
  begin
    fd_in   = $fopen("./samples.txt", "r");
    fd_out  = $fopen("./tb_output.txt", "w");
    // fd_out  = $fopen("./tb_output.txt", "wb");

    if(!fd_in || !fd_out)
    begin
      $display("ERROR: Unable to open I/O file!");
    end
    else
    begin
      /* Process samples */
      while(!$feof(fd_in))
      begin
        $fscanf(fd_in, "%h", sample);
        send_sample(sample);
        verify_output(sample);
      end

      /* Wait for delayed output */
      repeat(ITER_NUM*(FIR_TAPS_NUM-1))
      begin
        // wait(st2mm_valid == 'd1);
        @(posedge clock);
        @(posedge clock);
        @(posedge clock);
      end
    end

    $fclose(fd_in);
    $fclose(fd_out);
  end
  else
  begin
    /* Verify lvls generation */
    repeat(LVLS_NUM/2+2)
    begin
      sample = '{ 1'b0, 15'd10 };
      send_sample(sample);
      verify_output(sample);
    end

    repeat(LVLS_NUM+1)
    begin
      sample = '{ 1'b1, 15'd10 };
      send_sample(sample);
      verify_output(sample);
    end

    /* Verify iterative processing */
    #  5 curr_lvl   = LVL_RESET_VALUE;
    st2mm_ready     = 'd1;
    # 20 reset      = 'd1;
    #100 reset      = 'd0;

    /* Pipeline init after reset */
    repeat(MAX_SAMPLES_IN_RAM+5)
      @(posedge clock);

    sample = '{ 1'b1, 15'd600 };
    send_sample(sample);
    verify_output(sample);

    sample = '{ 1'b1, 15'd200 };
    send_sample(sample);
    verify_output(sample);
    mm2st_valid = 'd0;
  end

  # 50 sim_end = 'd1;
end

endmodule // fir_subsystem_top_tb
