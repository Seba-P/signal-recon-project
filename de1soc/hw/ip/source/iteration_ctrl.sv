
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

typedef enum reg [1:0]
{
  INIT_BUFFS    = 2'd0,
  NEW_DATA      = 2'd1,
  PREPARE_FIR   = 2'd2,
  PROCESS_ITER  = 2'd3
} PIPELINE_STATE_T;

PIPELINE_STATE_T state_r;
reg         lvl_gen_ready_r;
reg         sigbuff_input_mux_r;
reg         sigbuff_input_enable_r;
reg         sigbuff_output_enable_r;
reg         sigbuff_output_enable_p1_r;
reg         sigbuff_output_enable_p2_r;
reg         sigbuff_init_r;
reg         limbuff_input_enable_r;
reg         limbuff_output_enable_r;
reg         limbuff_output_enable_p1_r;
reg         limbuff_output_enable_p2_r;
reg         limbuff_init_r;
reg  [ 1:0] fir_input_mux_r;
reg         fir_input_enable_r;
reg         limiter_input_enable_r;
reg         limiter_input_enable_p1_r;
reg         limiter_input_enable_p2_r;
reg         limiter_input_enable_p3_r;
reg         out_ctrl_output_enable_r;
reg         out_ctrl_output_enable_p1_r;
reg         out_ctrl_output_enable_p2_r;
reg         out_ctrl_output_enable_p3_r;
reg         out_ctrl_output_enable_p4_r;

reg  [ 7:0] iter_symbol_cnt_r;
reg         iter_symbol_inc_r;
// reg  [ 7:0] recv_symbol_cnt_r;
reg  [ 4:0] curr_iter_r;
reg  [ 4:0] iter_num_r;
reg         pipeline_prep_r; // prepare FIR pipeline for next iteration
reg         buffs_prep_r; // prepare buffers after init
wire        curr_iter_end;
wire        first_iter;
wire        last_iter;
wire        buffers_ready;
// wire        full_buffer;

assign lvl_gen_ready          = lvl_gen_ready_r & buffers_ready;
assign sigbuff_iter_num       = curr_iter_r;
assign sigbuff_input_mux      = sigbuff_input_mux_r;
assign sigbuff_input_enable   = sigbuff_input_enable_r;
assign sigbuff_output_enable  = sigbuff_output_enable_p2_r;
assign sigbuff_init           = sigbuff_init_r;
assign limbuff_input_enable   = limbuff_input_enable_r;
assign limbuff_output_enable  = limbuff_output_enable_p2_r;
assign limbuff_init           = limbuff_init_r;
assign fir_input_mux          = fir_input_mux_r;
assign fir_input_enable       = fir_input_enable_r;
assign limiter_input_enable   = limiter_input_enable_p3_r;
assign out_ctrl_output_enable = out_ctrl_output_enable_p4_r;

/* Temporarily frozen iterations */
assign iter_num_r       = ITER_NUM;

assign curr_iter_end    = (iter_symbol_cnt_r == MAX_SAMPLES_IN_RAM - 'd1);
// assign full_buffer      = (recv_symbol_cnt_r == MAX_SAMPLES_IN_RAM - 'd1);
assign first_iter       = (curr_iter_r == 'd0);
assign last_iter        = (curr_iter_r == iter_num_r - 'd1);
assign buffers_ready    = sigbuff_ready & limbuff_ready;

// assign fir_input_enable = 1'b1; // ???
assign iter_symbol_inc_r  = 'd1; // TODO: consider pipeline stall

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
    buffs_prep_r            <= '1; // ?
    state_r                 <= INIT_BUFFS;
  end
  else
  begin
    unique case(state_r)
      INIT_BUFFS:
      begin
        sigbuff_init_r  <= 'd0;
        limbuff_init_r  <= 'd0;

        if(buffers_ready)
        begin
          pipeline_prep_r <= 'd0;
          buffs_prep_r    <= 'd0;
          state_r         <= NEW_DATA;
        end
      end

      NEW_DATA:
      begin
        curr_iter_r <= 'd0;

        if(curr_iter_end)
        begin
          iter_symbol_cnt_r <= 'd0;
          state_r           <= PROCESS_ITER;
        end
        else
        begin
          iter_symbol_cnt_r <= iter_symbol_cnt_r + lvl_gen_valid;
        end
      end

      PREPARE_FIR:
      begin
        if(curr_iter_end)
        begin
          state_r           <= PROCESS_ITER;
          pipeline_prep_r   <= 'd0;
          iter_symbol_cnt_r <= 'd0;
        end
        else
        begin
          iter_symbol_cnt_r <= iter_symbol_cnt_r + iter_symbol_inc_r;
        end
      end

      PROCESS_ITER:
      begin
        if(curr_iter_end)
        begin
          if(last_iter)
          begin
            curr_iter_r     <= 'd0;
            state_r         <= NEW_DATA;
            pipeline_prep_r <= 'd0;
          end
          else
          begin
            curr_iter_r     <= curr_iter_r + 'd1;
            state_r         <= PREPARE_FIR;
            pipeline_prep_r <= 'd1;
          end

          iter_symbol_cnt_r <= 'd0;
        end
        else
        begin
          iter_symbol_cnt_r <= iter_symbol_cnt_r + iter_symbol_inc_r;
        end
      end
    endcase
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
    case(state_r)
      NEW_DATA:
        lvl_gen_ready_r <= iter_symbol_cnt_r < MAX_SAMPLES_IN_RAM - 'd2;
      default:
        lvl_gen_ready_r <= 'd0;
    endcase
  end
end

/* Signal buffer controller IF */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    sigbuff_input_mux_r         <= '0;
    sigbuff_input_enable_r      <= '0;
    sigbuff_output_enable_r     <= '0;
    sigbuff_output_enable_p1_r  <= '0;
    sigbuff_output_enable_p2_r  <= '0;
  end
  else
  begin
    unique case(state_r)
      INIT_BUFFS:
      begin
        sigbuff_input_mux_r     <= 'd0;
        sigbuff_input_enable_r  <= 'd0;
        sigbuff_output_enable_r <= 'd0;
      end

      NEW_DATA:
      begin
        sigbuff_input_mux_r     <= 'd0;
        sigbuff_input_enable_r  <= 'd1;
        sigbuff_output_enable_r <= lvl_gen_valid; // ?
      end

      PREPARE_FIR:
      begin
        sigbuff_input_mux_r     <= 'd1;
        sigbuff_input_enable_r  <= 'd0; // ?
        sigbuff_output_enable_r <= iter_symbol_inc_r; // ?
      end

      PROCESS_ITER:
      begin
        sigbuff_input_mux_r     <= 'd1;
        sigbuff_input_enable_r  <= last_iter ? 'd0 : iter_symbol_inc_r; // ?
        sigbuff_output_enable_r <= iter_symbol_inc_r; // ?
      end
    endcase
    // sigbuff_input_mux_r     <= (state_r == PREPARE_FIR) || (state_r == PROCESS_ITER);
    // sigbuff_input_enable_r  <= (state_r == NEW_DATA) || ((state_r == PROCESS_ITER) && (iter_symbol_inc_r & ~last_iter));
    // sigbuff_output_enable_r <= (state_r == NEW_DATA) ? lvl_gen_valid : 
    //                            (state_r == PREPARE_FIR) || (state_r == PROCESS_ITER) ? iter_symbol_inc_r : 'd0;

    sigbuff_output_enable_p1_r  <= sigbuff_output_enable_r;
    sigbuff_output_enable_p2_r  <= sigbuff_output_enable_p1_r;
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
    unique case(state_r)
      INIT_BUFFS:
      begin
        limbuff_input_enable_r  <= 'd0;
        limbuff_output_enable_r <= 'd0;
      end

      NEW_DATA:
      begin
        limbuff_input_enable_r  <= 'd1;
        limbuff_output_enable_r <= lvl_gen_valid; // ?
      end

      PREPARE_FIR:
      begin
        limbuff_input_enable_r  <= 'd0;
        limbuff_output_enable_r <= 'd0;
      end

      PROCESS_ITER:
      begin
        limbuff_input_enable_r  <= 'd0;
        limbuff_output_enable_r <= iter_symbol_inc_r; // ?
      end
    endcase
    // limbuff_input_enable_r  <= (state_r == NEW_DATA);
    // limbuff_output_enable_r <= (state_r == NEW_DATA) ? lvl_gen_valid : 
    //                            (state_r == PROCESS_ITER) ? iter_symbol_inc_r : 'd0;

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
    case(state_r)
      INIT_BUFFS:
      begin
        fir_input_mux_r     <= 'd0;
        fir_input_enable_r  <= 'd0;
      end

      NEW_DATA:
      begin
        fir_input_mux_r     <= 'd1;
        fir_input_enable_r  <= 'd1;
      end

      default:
      begin
        fir_input_mux_r     <= 'd0;
        fir_input_enable_r  <= 'd1;
      end
    endcase
    // fir_input_mux_r     <= state_r == NEW_DATA;
    // fir_input_enable_r  <= state_r != INIT_BUFFS;
  end
end

/* Hard limiter & output controller IF */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    limiter_input_enable_r      <= '0;
    limiter_input_enable_p1_r   <= '0;
    limiter_input_enable_p2_r   <= '0;
    out_ctrl_output_enable_r    <= '0;
    out_ctrl_output_enable_p1_r <= '0;
    out_ctrl_output_enable_p2_r <= '0;
    out_ctrl_output_enable_p3_r <= '0;
  end
  else
  begin
    case(state_r)
      PROCESS_ITER:
      begin
        limiter_input_enable_r    <= 'd1;
        out_ctrl_output_enable_r  <= last_iter;
      end

      default:
      begin
        limiter_input_enable_r    <= 'd0;
        out_ctrl_output_enable_r  <= 'd0;
      end
    endcase
    // limiter_input_enable_r    <= (state_r == PROCESS_ITER);
    // out_ctrl_output_enable_r  <= (state_r == PROCESS_ITER) & last_iter;

    limiter_input_enable_p1_r   <= limiter_input_enable_r;
    limiter_input_enable_p2_r   <= limiter_input_enable_p1_r;
    limiter_input_enable_p3_r   <= limiter_input_enable_p2_r;
    out_ctrl_output_enable_p1_r <= out_ctrl_output_enable_r;
    out_ctrl_output_enable_p2_r <= out_ctrl_output_enable_p1_r;
    out_ctrl_output_enable_p3_r <= out_ctrl_output_enable_p2_r;
    out_ctrl_output_enable_p4_r <= out_ctrl_output_enable_p3_r;
  end
end

endmodule
