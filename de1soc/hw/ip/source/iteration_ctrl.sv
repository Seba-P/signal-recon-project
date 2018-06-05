
module iteration_ctrl
#(
  parameter MAX_SAMPLES_IN_RAM  = 255,
  parameter ITER_NUM            = 1
)
(
  /* Common IF */
  input  wire        reset,                   //    reset.reset
  input  wire        clock,                   //    clock.clk
  /* Lvl generator IF */
  input  wire        lvl_gen_valid,           //  lvl_gen.new_signal
  output wire        lvl_gen_ready,           //         .new_signal_1
  /* Signal buffer controller IF */
  output wire [ 4:0] sigbuff_iter_num,        //  sigbuff.new_signal
  output wire        sigbuff_input_mux,       //         .new_signal_1
  output wire        sigbuff_input_enable,    //         .new_signal_2
  output wire        sigbuff_output_enable,   //         .new_signal_3
  input  wire        sigbuff_ready,           //         .new_signal_4
  output wire        sigbuff_init,            //         .new_signal_5
  /* Limits buffer controller IF */
  output wire        limbuff_input_enable,    //  limbuff.new_signal
  output wire        limbuff_output_enable,   //         .new_signal_1
  input  wire        limbuff_ready,           //         .new_signal_2
  output wire        limbuff_init,            //         .new_signal_3
  /* FIR driver IF */
  output wire        fir_input_mux,           //   fir_fe.new_signal
  output wire        fir_input_enable,        //         .new_signal_1
  input  wire        fir_ready,               //         .new_signal_2
  /* Hard limiter IF */
  output wire        limiter_input_enable,    //  limiter.new_signal
  input  wire        limiter_ready,           //         .new_signal_1
  /* Output controller IF */
  output wire        out_ctrl_output_enable,  // out_ctrl.new_signal
  input  wire        out_ctrl_ready           //         .new_signal_1
);

reg         lvl_gen_ready_r;
reg         sigbuff_input_mux_r;
reg         sigbuff_input_enable_r;
reg         sigbuff_output_enable_r;
reg         sigbuff_init_r;
reg         limbuff_input_enable_r;
reg         limbuff_output_enable_r;
reg         limbuff_output_enable_p1_r;
reg         limbuff_output_enable_p2_r;
reg         limbuff_init_r;
reg  [ 1:0] fir_input_mux_r;
reg         fir_input_enable_r;
reg         limiter_input_enable_r;
reg         limiter_input_enable_buff_r;
reg         out_ctrl_output_enable_r;
reg         out_ctrl_output_enable_buff_r;

reg  [ 7:0] iter_symbol_cnt_r;
// reg  [ 7:0] recv_symbol_cnt_r;
reg  [ 4:0] curr_iter_r;
reg  [ 4:0] iter_num_r;
reg         pipeline_prep_r; // prepare FIR pipeline for next iteration
wire        curr_iter_end;
wire        first_iter;
wire        last_iter;
wire        buffers_ready;
// wire        full_buffer;

assign lvl_gen_ready          = lvl_gen_ready_r & buffers_ready;
assign sigbuff_iter_num       = curr_iter_r;
assign sigbuff_input_mux      = sigbuff_input_mux_r;
assign sigbuff_input_enable   = sigbuff_input_enable_r;
assign sigbuff_output_enable  = sigbuff_output_enable_r;
assign sigbuff_init           = sigbuff_init_r;
assign limbuff_input_enable   = limbuff_input_enable_r;
assign limbuff_output_enable  = limbuff_output_enable_p2_r;
assign limbuff_init           = limbuff_init_r;
assign fir_input_mux          = fir_input_mux_r;
assign fir_input_enable       = fir_input_enable_r;
assign limiter_input_enable   = limiter_input_enable_r;
assign out_ctrl_output_enable = out_ctrl_output_enable_r;

/* Temporarily frozen iterations */
assign iter_num_r       = ITER_NUM;

assign curr_iter_end    = (iter_symbol_cnt_r == MAX_SAMPLES_IN_RAM - 'd1);
// assign full_buffer      = (recv_symbol_cnt_r == MAX_SAMPLES_IN_RAM - 'd1);
assign first_iter       = (curr_iter_r == 'd0);
assign last_iter        = (curr_iter_r == iter_num_r - 'd1);
assign buffers_ready    = sigbuff_ready & limbuff_ready;

// assign fir_input_enable = 1'b1; // ???

/* Iteration control */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    sigbuff_init_r          <= '1;
    limbuff_init_r          <= '1;

    iter_symbol_cnt_r       <= '0;
    curr_iter_r             <= '0;
    pipeline_prep_r         <= '1; // ?
  end
  else
  begin
    sigbuff_init_r          <= 'd0;
    limbuff_init_r          <= 'd0;

    if(curr_iter_end)
    begin
      if(~pipeline_prep_r)
      begin
        curr_iter_r <= last_iter ? 'd0 : curr_iter_r + 'd1;
      end

      iter_symbol_cnt_r <= 'd0;
      pipeline_prep_r   <= ~pipeline_prep_r;
    end
    else
    begin
      iter_symbol_cnt_r <= first_iter ? iter_symbol_cnt_r + (lvl_gen_valid | pipeline_prep_r) :
                                        iter_symbol_cnt_r + 'd1;
    end
  end
end

/* Sample2lvl converter IF */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    lvl_gen_ready_r <= '0;
  end
  else
  begin
    lvl_gen_ready_r <= first_iter & ~pipeline_prep_r && (iter_symbol_cnt_r < MAX_SAMPLES_IN_RAM - 'd2) ? 1'b1 : 1'b0;
  end
end

/* Signal buffer controller IF */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    sigbuff_input_mux_r     <= '0;
    sigbuff_input_enable_r  <= '0;
    sigbuff_output_enable_r <= '0;
  end
  else
  begin
    if(curr_iter_end)
    begin
      sigbuff_input_mux_r     <= ~first_iter;
    end

    sigbuff_input_enable_r  <= first_iter | ~last_iter; // ???
    sigbuff_output_enable_r <= first_iter ? lvl_gen_valid | pipeline_prep_r : 'd1;
  end
end

/* Limits buffer controller IF */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    limbuff_input_enable_r      <= '0;
    limbuff_output_enable_r     <= '0;
    limbuff_output_enable_p1_r  <= '0;
    limbuff_output_enable_p2_r  <= '0;
  end
  else
  begin
    if(curr_iter_end)
    begin
      limbuff_input_enable_r  <= first_iter & pipeline_prep_r;
    end

    // limbuff_output_enable_r   <= (~first_iter | lvl_gen_valid) & ~pipeline_prep_r;
    limbuff_output_enable_r     <= (~first_iter | lvl_gen_valid) & ~pipeline_prep_r;
    limbuff_output_enable_p1_r  <= limbuff_output_enable_r;
    limbuff_output_enable_p2_r  <= limbuff_output_enable_p1_r;
  end
end

/* FIR driver IF */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    fir_input_mux_r     <= '0;
    fir_input_enable_r  <= '0;
  end
  else
  begin
    if(curr_iter_end)
    begin
      fir_input_mux_r   <= pipeline_prep_r;
    end
    
    fir_input_enable_r  <= 'd1;
  end
end

/* Hard limiter & output controller IF */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    limiter_input_enable_buff_r   <= '0;
    limiter_input_enable_r        <= '0;
    out_ctrl_output_enable_buff_r <= '0;
    out_ctrl_output_enable_r      <= '0;
  end
  else
  begin
    limiter_input_enable_r    <= ~pipeline_prep_r; // align with FIR output?
    // limiter_input_enable_buff_r   <= ~pipeline_prep_r; // align with FIR output?
    // limiter_input_enable_r        <= limiter_input_enable_buff_r;
    out_ctrl_output_enable_r  <= last_iter & ~pipeline_prep_r;
    // out_ctrl_output_enable_buff_r <= last_iter & ~pipeline_prep_r;
    // out_ctrl_output_enable_r      <= out_ctrl_output_enable_buff_r;
  end
end

endmodule
