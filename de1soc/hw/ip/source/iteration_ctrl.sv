
module iteration_ctrl
#(
  parameter FIR_TAPS_NUM        = 255,
  parameter MAX_SAMPLES_IN_RAM  = 255,
  parameter ITER_NUM            = 1
)
(
  /* Common IF */
  input  wire        reset,                   //    reset.reset
  input  wire        clock,                   //    clock.clk
  /* Lvl generator IF */
  output wire        lvl_gen_init,            //  lvl_gen.new_signal
  input  wire        lvl_gen_valid,           //         .new_signal_1
  output wire        lvl_gen_ready,           //         .new_signal_2
  /* Signal buffer controller IF */
  output wire [ 1:0] sigbuff_iter_state,      //  sigbuff.new_signal
  output wire [ 4:0] sigbuff_iter_num,        //         .new_signal_1
  output wire [ 7:0] sigbuff_symbol_num,      //         .new_signal_2
  output wire [ 1:0] sigbuff_section_id,      //         .new_signal_3
  output wire        sigbuff_init,            //         .new_signal_4
  output wire        sigbuff_input_mux,       //         .new_signal_5
  output wire        sigbuff_input_enable,    //         .new_signal_6
  output wire        sigbuff_output_enable,   //         .new_signal_7
  input  wire        sigbuff_ready,           //         .new_signal_8
  /* Limits buffer controller IF */
  output wire [ 7:0] limbuff_symbol_num,      //  limbuff.new_signal
  output wire [ 1:0] limbuff_section_id,      //         .new_signal_1
  output wire        limbuff_init,            //         .new_signal_2
  output wire        limbuff_input_enable,    //         .new_signal_3
  output wire        limbuff_output_enable,   //         .new_signal_4
  input  wire        limbuff_ready,           //         .new_signal_5
  /* FIR driver IF */
  output wire        fir_input_mux,           //   fir_fe.new_signal
  output wire        fir_input_enable,        //         .new_signal_1
  input  wire        fir_ready,               //         .new_signal_2
  input  wire        fir_data_passed,         //         .new_signal_3
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

typedef enum reg [1:0]
{
  FIRST_SECTION   = 2'd0,
  SECOND_SECTION  = 2'd1,
  MIDDLE_SECTION  = 2'd2,
  LAST_SECTION    = 2'd3
} SECTION_ID_T;

PIPELINE_STATE_T  state_r;
PIPELINE_STATE_T  state_del_r[5];
SECTION_ID_T      section_id_r;
SECTION_ID_T      section_id_del_r[5];
reg         lvl_gen_init_r;
reg         lvl_gen_init_del_r[5];
reg         lvl_gen_ready_r;
reg         lvl_gen_ready_del_r[5];
reg  [ 7:0] sigbuff_symbol_num_r;
reg  [ 7:0] sigbuff_symbol_num_del_r[5];
reg         sigbuff_init_r;
reg         sigbuff_init_del_r[5];
reg         sigbuff_input_mux_r;
reg         sigbuff_input_mux_del_r[5];
reg         sigbuff_input_enable_r;
reg         sigbuff_input_enable_del_r[5];
reg         sigbuff_output_enable_r;
reg         sigbuff_output_enable_del_r[5];
reg  [ 7:0] limbuff_symbol_num_r;
reg  [ 7:0] limbuff_symbol_num_del_r[5];
reg         limbuff_init_r;
reg         limbuff_init_del_r[5];
reg         limbuff_input_enable_r;
reg         limbuff_input_enable_del_r[5];
reg         limbuff_output_enable_r;
reg         limbuff_output_enable_del_r[5];
reg  [ 1:0] fir_input_mux_r;
reg  [ 1:0] fir_input_mux_del_r[5];
reg         fir_input_enable_r;
reg         fir_input_enable_del_r[5];
reg         limiter_input_enable_r;
reg         limiter_input_enable_del_r[5];
reg         out_ctrl_output_enable_r;
reg         out_ctrl_output_enable_del_r[5];

reg  [ 7:0] fir_taps_num_r;
reg  [ 7:0] max_samples_in_ram_r;
reg  [ 4:0] iter_num_r;

reg  [ 7:0] fir_taps_head_r;
reg  [ 7:0] fir_taps_tail_r;
reg  [ 7:0] iter_symbol_cnt_r;
reg  [ 7:0] iter_symbol_cnt_del_r[5];
reg         iter_symbol_inc_r;
reg         iter_symbol_inc_del_r[5];
reg  [ 4:0] curr_iter_r;
reg  [ 4:0] curr_iter_del_r[5];
reg         pipeline_prep_r; // prepare FIR pipeline for next iteration
reg         buffs_prep_r; // prepare buffers after init
reg         first_section_fix_r;
reg         curr_iter_end_r;
wire        curr_iter_end;
wire        first_iter;
wire        last_iter;
wire        buffers_ready;
wire        fir_taps_half;

assign lvl_gen_init           = lvl_gen_init_r;
assign lvl_gen_ready          = lvl_gen_ready_r & buffers_ready;
// assign sigbuff_iter_num       = curr_iter_r;
assign sigbuff_iter_state     = state_del_r[1];
assign sigbuff_iter_num       = curr_iter_del_r[1];
// assign sigbuff_symbol_num     = sigbuff_symbol_num_r;
assign sigbuff_symbol_num     = sigbuff_symbol_num_del_r[0];
// assign sigbuff_section_id     = section_id_r;
assign sigbuff_section_id     = section_id_del_r[1];
assign sigbuff_init           = sigbuff_init_r;
// assign sigbuff_input_mux      = sigbuff_input_mux_r;
assign sigbuff_input_mux      = sigbuff_input_mux_del_r[0];
// assign sigbuff_input_enable   = sigbuff_input_enable_r;
assign sigbuff_input_enable   = sigbuff_input_enable_del_r[0];
// assign sigbuff_output_enable  = (state_r == NEW_DATA) ? sigbuff_output_enable_p1_r : sigbuff_output_enable_p2_r;
assign sigbuff_output_enable  = sigbuff_output_enable_del_r[1];
// assign limbuff_symbol_num     = limbuff_symbol_num_r;
assign limbuff_symbol_num     = limbuff_symbol_num_del_r[0];
// assign limbuff_section_id     = section_id_r;
assign limbuff_section_id     = section_id_del_r[1];
assign limbuff_init           = limbuff_init_r;
assign limbuff_input_enable   = limbuff_input_enable_del_r[0];
assign limbuff_output_enable  = limbuff_output_enable_del_r[1];
assign fir_input_mux          = fir_input_mux_r;
assign fir_input_enable       = fir_input_enable_r;
assign limiter_input_enable   = limiter_input_enable_del_r[2];
assign out_ctrl_output_enable = out_ctrl_output_enable_del_r[4];

assign fir_taps_half    = (iter_symbol_cnt_r >= fir_taps_head_r - 'd1); // ?
assign curr_iter_end    = (iter_symbol_cnt_r == max_samples_in_ram_r - 'd1);
assign first_iter       = (curr_iter_r == 'd0);
assign last_iter        = (curr_iter_r == iter_num_r - 'd1);
assign buffers_ready    = sigbuff_ready & limbuff_ready;

// assign fir_input_enable = 1'b1; // ???
assign iter_symbol_inc_r  = 'd1; // TODO: consider pipeline stall

assign fir_taps_num_r       = FIR_TAPS_NUM;
assign max_samples_in_ram_r = MAX_SAMPLES_IN_RAM;
assign iter_num_r           = ITER_NUM;

/* FIR delay calculation */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    fir_taps_head_r <= '0;
    fir_taps_tail_r <= '0;
  end
  else
  begin
    fir_taps_head_r <= fir_taps_num_r[7:1] + fir_taps_num_r[0];
    fir_taps_tail_r <= fir_taps_num_r[7:1];
  end
end

// TODO: curr_iter_end is fragile and the state machine might not work when stall occurs
/* Iteration control */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    iter_symbol_cnt_r       <= '0;
    curr_iter_r             <= '0;
    curr_iter_end_r         <= '0;
    pipeline_prep_r         <= '1; // ?
    buffs_prep_r            <= '1; // ?
    state_r                 <= INIT_BUFFS;
    section_id_r            <= FIRST_SECTION;
    first_section_fix_r     <= '1;
  end
  else
  begin
    unique case(state_r)
      INIT_BUFFS:
      begin
        if(buffers_ready)
        begin
          pipeline_prep_r <= 'd0;
          buffs_prep_r    <= 'd0;
          state_r         <= NEW_DATA;
        end

        section_id_r        <= FIRST_SECTION;
        first_section_fix_r <= 'd1;
      end

      NEW_DATA:
      begin
        curr_iter_r <= 'd0;

        if(curr_iter_end)
        begin
          iter_symbol_cnt_r <= 'd0;

          if(section_id_r == FIRST_SECTION)
          begin
            state_r           <= NEW_DATA;
            section_id_r      <= SECOND_SECTION;
          end
          else if(section_id_r == SECOND_SECTION)
          begin
            state_r           <= PREPARE_FIR;
            section_id_r      <= FIRST_SECTION;
            // section_id_r      <= SECOND_SECTION;
          end
          else
          begin
            state_r           <= PROCESS_ITER;
            section_id_r      <= MIDDLE_SECTION;
          end
        end
        else
        begin
          iter_symbol_cnt_r <= iter_symbol_cnt_r + (lvl_gen_valid /*& lvl_gen_ready_r*/ & lvl_gen_ready_del_r[0] & lvl_gen_ready_del_r[1]); // TODO: not first section
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
          // if(...) -> do some nested if to block curr_iter overflow when stall occurs
            if(last_iter)
            begin
              curr_iter_r     <= 'd0;
              // state_r         <= NEW_DATA;
              state_r         <= section_id_r == FIRST_SECTION ? PREPARE_FIR : NEW_DATA;
              pipeline_prep_r <= 'd0;
              section_id_r    <= section_id_r == FIRST_SECTION ? SECOND_SECTION : MIDDLE_SECTION;
            end
            else
            begin  // pipeline stall might do serious shit around here
              if(first_section_fix_r)
              begin
                if(section_id_r == FIRST_SECTION)
                begin
                  curr_iter_r   <= curr_iter_r;
                  state_r       <= PROCESS_ITER;
                  section_id_r  <= SECOND_SECTION;
                end
                else
                begin
                  curr_iter_r   <= curr_iter_r + 'd1;
                  // state_r       <= PROCESS_ITER;
                  state_r       <= PREPARE_FIR;
                  section_id_r  <= FIRST_SECTION;
                end
              end
              else
              begin
                curr_iter_r   <= curr_iter_r + 'd1;
                state_r       <= PREPARE_FIR;
                section_id_r  <= section_id_r;
              end

              pipeline_prep_r <= 'd1;
            end

            iter_symbol_cnt_r   <= 'd0;
            first_section_fix_r <= first_section_fix_r & section_id_r == FIRST_SECTION;
        end
        else
        begin
          iter_symbol_cnt_r <= iter_symbol_cnt_r + iter_symbol_inc_r;
        end
      end
    endcase

    curr_iter_end_r <= curr_iter_end;
  end
end

/* Sample2lvl converter IF */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    lvl_gen_init_r      <= '1;
    lvl_gen_ready_r     <= '0;
  end
  else
  begin
    case(state_r)
      NEW_DATA:
        lvl_gen_ready_r <= iter_symbol_cnt_r < max_samples_in_ram_r - 'd3;
      default:
        lvl_gen_ready_r <= 'd0;
    endcase

    lvl_gen_init_r      <= '0;
  end
end

/* Signal buffer controller IF */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    sigbuff_symbol_num_r        <= '0;
    sigbuff_init_r              <= '1;
    sigbuff_input_mux_r         <= '0;
    sigbuff_input_enable_r      <= '0;
    sigbuff_output_enable_r     <= '0;
  end
  else
  begin
    unique case(state_r)
      INIT_BUFFS:
      begin
        sigbuff_symbol_num_r    <= 'd0;
        sigbuff_input_mux_r     <= 'd0;
        sigbuff_input_enable_r  <= 'd0;
        sigbuff_output_enable_r <= 'd0;
      end

      NEW_DATA:
      begin
        sigbuff_symbol_num_r    <= iter_symbol_cnt_r;
        sigbuff_input_mux_r     <= 'd0;
        sigbuff_input_enable_r  <= lvl_gen_valid;
        sigbuff_output_enable_r <= lvl_gen_valid; // ?
      end

      PREPARE_FIR:
      begin
        sigbuff_symbol_num_r    <= iter_symbol_cnt_r;
        sigbuff_input_mux_r     <= 'd1;
        sigbuff_input_enable_r  <= 'd0; // ?
        // sigbuff_input_enable_r  <= (section_id_r == FIRST_SECTION & first_iter & fir_taps_half) ? iter_symbol_inc_r : 'd0; // fix 1cc delay
        sigbuff_output_enable_r <= iter_symbol_inc_r; // ?
      end

      PROCESS_ITER:
      begin
        sigbuff_symbol_num_r    <= iter_symbol_cnt_r;
        sigbuff_input_mux_r     <= 'd1;
        sigbuff_input_enable_r  <= iter_symbol_inc_r; // ?
        sigbuff_output_enable_r <= iter_symbol_inc_r; // ?
      end
    endcase

    sigbuff_init_r              <= 'd0;
  end
end

/* Limits buffer controller IF */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    limbuff_symbol_num_r        <= '0;
    limbuff_init_r              <= '1;
    limbuff_input_enable_r      <= '0;
    limbuff_output_enable_r     <= '0;
  end
  else
  begin
    unique case(state_r)
      INIT_BUFFS:
      begin
        limbuff_symbol_num_r    <= 'd0;
        limbuff_input_enable_r  <= 'd0;
        limbuff_output_enable_r <= 'd0;
      end

      NEW_DATA:
      begin
        limbuff_symbol_num_r    <= iter_symbol_cnt_r;
        limbuff_input_enable_r  <= lvl_gen_valid;
        limbuff_output_enable_r <= lvl_gen_valid; // ?
      end

      PREPARE_FIR:
      begin
        limbuff_symbol_num_r    <= 'd0;
        limbuff_input_enable_r  <= 'd0;
        limbuff_output_enable_r <= 'd0;
      end

      PROCESS_ITER:
      begin
        limbuff_symbol_num_r    <= iter_symbol_cnt_r; // ?
        limbuff_input_enable_r  <= 'd0;
        limbuff_output_enable_r <= iter_symbol_inc_r; // ?
      end
    endcase

    limbuff_init_r              <= 'd0;
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
        // fir_input_mux_r     <= 'd1;
        fir_input_mux_r     <= 'd0; // disable direct lvl_gen_data streaming
        fir_input_enable_r  <= 'd1;
      end

      default:
      begin
        fir_input_mux_r     <= 'd0;
        fir_input_enable_r  <= 'd1;
      end
    endcase
  end
end

/* Hard limiter & output controller IF */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    limiter_input_enable_r      <= '0;
    out_ctrl_output_enable_r    <= '0;
  end
  else
  begin
    unique case(state_r)
      INIT_BUFFS:
      begin
        limiter_input_enable_r    <= 'd1;
        out_ctrl_output_enable_r  <= 'd0;
      end

      NEW_DATA:
      begin
        limiter_input_enable_r    <= 'd1;
        out_ctrl_output_enable_r  <= last_iter & /*!first_section_r*/ (section_id_r != FIRST_SECTION ) & fir_taps_half;
      end

      PREPARE_FIR:
      begin
        limiter_input_enable_r    <= 'd1;
        out_ctrl_output_enable_r  <= last_iter & /*!first_section_r*/ (section_id_r != FIRST_SECTION ) & fir_taps_half;
      end

      PROCESS_ITER:
      begin
        limiter_input_enable_r    <= 'd1;
        out_ctrl_output_enable_r  <= last_iter & !fir_taps_half;
      end
    endcase
  end
end

always_ff @(posedge clock)
begin
  if(reset)
  begin
    // state_del_r                   <= '0;
    // section_id_del_r              <= '0;
    // lvl_gen_init_del_r            <= '0;
    // lvl_gen_ready_del_r           <= '0;
    // sigbuff_symbol_num_del_r      <= '0;
    // sigbuff_init_del_r            <= '0;
    // sigbuff_input_mux_del_r       <= '0;
    // sigbuff_input_enable_del_r    <= '0;
    // sigbuff_output_enable_del_r   <= '0;
    // limbuff_symbol_num_del_r      <= '0;
    // limbuff_init_del_r            <= '0;
    // limbuff_input_enable_del_r    <= '0;
    // limbuff_output_enable_del_r   <= '0;
    // fir_input_mux_del_r           <= '0;
    // fir_input_enable_del_r        <= '0;
    // limiter_input_enable_del_r    <= '0;
    // out_ctrl_output_enable_del_r  <= '0;
    // iter_symbol_cnt_del_r         <= '0;
    // iter_symbol_inc_del_r         <= '0;
    // curr_iter_del_r               <= '0;
  end
  else
  begin
    state_del_r[0]                  <= state_r;
    section_id_del_r[0]             <= section_id_r;
    lvl_gen_init_del_r[0]           <= lvl_gen_init_r;
    lvl_gen_ready_del_r[0]          <= lvl_gen_ready_r;
    sigbuff_symbol_num_del_r[0]     <= sigbuff_symbol_num_r;
    sigbuff_init_del_r[0]           <= sigbuff_init_r;
    sigbuff_input_mux_del_r[0]      <= sigbuff_input_mux_r;
    sigbuff_input_enable_del_r[0]   <= sigbuff_input_enable_r;
    sigbuff_output_enable_del_r[0]  <= sigbuff_output_enable_r;
    limbuff_symbol_num_del_r[0]     <= limbuff_symbol_num_r;
    limbuff_init_del_r[0]           <= limbuff_init_r;
    limbuff_input_enable_del_r[0]   <= limbuff_input_enable_r;
    limbuff_output_enable_del_r[0]  <= limbuff_output_enable_r;
    fir_input_mux_del_r[0]          <= fir_input_mux_r;
    fir_input_enable_del_r[0]       <= fir_input_enable_r;
    limiter_input_enable_del_r[0]   <= limiter_input_enable_r;
    out_ctrl_output_enable_del_r[0] <= out_ctrl_output_enable_r;
    iter_symbol_cnt_del_r[0]        <= iter_symbol_cnt_r;
    iter_symbol_inc_del_r[0]        <= iter_symbol_inc_r;
    curr_iter_del_r[0]              <= curr_iter_r;

    for(int i = 1; i < 5; i++)
    begin
      state_del_r[i]                  <= state_del_r[i-1];
      section_id_del_r[i]             <= section_id_del_r[i-1];
      lvl_gen_init_del_r[i]           <= lvl_gen_init_del_r[i-1];
      lvl_gen_ready_del_r[i]          <= lvl_gen_ready_del_r[i-1];
      sigbuff_symbol_num_del_r[i]     <= sigbuff_symbol_num_del_r[i-1];
      sigbuff_init_del_r[i]           <= sigbuff_init_del_r[i-1];
      sigbuff_input_mux_del_r[i]      <= sigbuff_input_mux_del_r[i-1];
      sigbuff_input_enable_del_r[i]   <= sigbuff_input_enable_del_r[i-1];
      sigbuff_output_enable_del_r[i]  <= sigbuff_output_enable_del_r[i-1];
      limbuff_symbol_num_del_r[i]     <= limbuff_symbol_num_del_r[i-1];
      limbuff_init_del_r[i]           <= limbuff_init_del_r[i-1];
      limbuff_input_enable_del_r[i]   <= limbuff_input_enable_del_r[i-1];
      limbuff_output_enable_del_r[i]  <= limbuff_output_enable_del_r[i-1];
      fir_input_mux_del_r[i]          <= fir_input_mux_del_r[i-1];
      fir_input_enable_del_r[i]       <= fir_input_enable_del_r[i-1];
      limiter_input_enable_del_r[i]   <= limiter_input_enable_del_r[i-1];
      out_ctrl_output_enable_del_r[i] <= out_ctrl_output_enable_del_r[i-1];
      iter_symbol_cnt_del_r[i]        <= iter_symbol_cnt_del_r[i-1];
      iter_symbol_inc_del_r[i]        <= iter_symbol_inc_del_r[i-1];
      curr_iter_del_r[i]              <= curr_iter_del_r[i-1];
    end
  end
end

endmodule
