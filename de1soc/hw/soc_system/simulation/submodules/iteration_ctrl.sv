
module iteration_ctrl
#(
  parameter MAX_SAMPLES_IN_RAM  = 255,
  parameter ITER_NUM            = 1
)
(
  /* Common IF */
  input  wire       reset,                  //    reset.reset
  input  wire       clock,                  //    clock.clk
  /* Lvl generator IF */
  input  wire       lvl_gen_valid,          //  lvl_gen.new_signal
  output wire       lvl_gen_ready,          //         .new_signal_1
  /* Signal buffer controller IF */
  output wire [4:0] sigbuff_iter_num,       //  sigbuff.new_signal
  output wire       sigbuff_input_mux,      //         .new_signal_1
  output wire       sigbuff_input_enable,   //         .new_signal_2
  output wire       sigbuff_output_enable,  //         .new_signal_3
  /* Limits buffer controller IF */
  output wire       limbuff_input_enable,   //  limbuff.new_signal
  output wire       limbuff_output_enable,  //         .new_signal_1
  /* FIR driver IF */
  output wire       fir_input_mux,          //   fir_fe.new_signal
  output wire       fir_input_enable,       //         .new_signal_1
  /* Hard limiter IF */
  output wire       limiter_input_enable,   //  limiter.new_signal
  /* Output controller IF */
  output wire       out_ctrl_output_enable  // out_ctrl.new_signal
);

reg         lvl_gen_ready_r;

reg         sigbuff_input_mux_r;
reg         sigbuff_input_enable_r;
reg         sigbuff_output_enable_r;

reg         limbuff_input_enable_r;
reg         limbuff_output_enable_r;

reg  [ 1:0] fir_input_mux_r;
reg         fir_input_enable_r;

reg  [ 7:0] iter_symbol_cnt_r;
// reg  [ 7:0] recv_symbol_cnt_r;
reg  [ 4:0] curr_iter_r;
reg  [ 4:0] iter_num_r;
reg         pipeline_prep_r; // prepare FIR pipeline for next iteration
wire        curr_iter_end;
wire        first_iter;
wire        last_iter;
// wire        full_buffer;

assign lvl_gen_ready          = lvl_gen_ready_r;
assign sigbuff_iter_num       = curr_iter_r;
assign sigbuff_input_mux      = sigbuff_input_mux_r;
assign sigbuff_input_enable   = sigbuff_input_enable_r;
assign sigbuff_output_enable  = sigbuff_output_enable_r;
assign limbuff_input_enable   = limbuff_input_enable_r;
assign limbuff_output_enable  = limbuff_output_enable_r;
assign fir_input_mux          = fir_input_mux_r;
// assign fir_input_enable   = fir_input_enable_r;

/* Temporarily frozen iterations */
assign iter_num_r       = ITER_NUM;

assign curr_iter_end    = (iter_symbol_cnt_r == MAX_SAMPLES_IN_RAM - 'd1);
// assign full_buffer      = (recv_symbol_cnt_r == MAX_SAMPLES_IN_RAM - 'd1);
assign first_iter       = (curr_iter_r == 'd0);
assign last_iter        = (curr_iter_r == iter_num_r - 'd1);

assign fir_input_enable = 1'b1; // ???

always_ff @(posedge clock)
begin
  if(reset)
  begin
    lvl_gen_ready_r         <= '0;
    sigbuff_input_mux_r     <= '0;
    sigbuff_input_enable_r  <= '0;
    sigbuff_output_enable_r <= '0;
    limbuff_input_enable_r  <= '0;
    limbuff_output_enable_r <= '0;
    fir_input_mux_r         <= '0;
    fir_input_enable_r      <= '0;
    iter_symbol_cnt_r       <= '0;
    curr_iter_r             <= '0;
    pipeline_prep_r         <= '0; // ?
  end
  else
  begin
    // if(lvl_gen_valid)
    // begin
    //   // recv_symbol_cnt_r <= full_buffer ? recv_symbol_cnt_r : recv_symbol_cnt_r + 'd1;
    //   recv_symbol_cnt_r <= recv_symbol_cnt_r + 8'(~full_buffer);
    // end
    // recv_symbol_cnt_r   <= first_iter ? recv_symbol_cnt_r + lvl_gen_valid : 
    //                   (last_iter & curr_iter_end ? 'd0 : recv_symbol_cnt_r);

    if(curr_iter_end)
    begin
      // recv_symbol_cnt_r   <= last_iter ? 'd0 : recv_symbol_cnt_r;
      iter_symbol_cnt_r <= 'd0;

      if(pipeline_prep_r)
      begin
        fir_input_mux_r <= 'd0;
      end
      else
      begin
        fir_input_mux_r <= 'd1;
        curr_iter_r     <= last_iter ? 'd0 : curr_iter_r + 'd1;
      end

      sigbuff_input_mux_r <= ~first_iter;
      pipeline_prep_r     <= ~pipeline_prep_r;
      // sigbuff_output_enable <=
      // fir_input_mux_r   <= first_iter ? 'd0 : 'd1; // without bypass for now
    end
    else
    begin
      // recv_symbol_cnt_r   <= first_iter ? recv_symbol_cnt_r + lvl_gen_valid : recv_symbol_cnt_r;
      iter_symbol_cnt_r   <= first_iter ? iter_symbol_cnt_r + (lvl_gen_valid | pipeline_prep_r) :
                                          iter_symbol_cnt_r + 'd1;

    end

    lvl_gen_ready_r         <= first_iter && (iter_symbol_cnt_r < MAX_SAMPLES_IN_RAM - 'd2) ? 1'b1 : 1'b0;

    sigbuff_input_enable_r  <= ~last_iter; // ???
    limbuff_input_enable_r  <= first_iter/* & ~full_buffer*/;

    // curr_iter_r     <= ~full_buffer ? iter_num_r : curr_iter_r - 8'(curr_iter_end & ~(curr_iter_r==0));
    // iter_symbol_cnt_r   <= curr_iter_end ? 'd0 : iter_symbol_cnt_r + 8'(iter_symbol_cnt_r < recv_symbol_cnt_r);
  end
end

endmodule
