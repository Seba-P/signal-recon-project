
module limits_buffer_ctrl
#(
  parameter FIR_TAPS_NUM        = 255,
  parameter MAX_SAMPLES_IN_RAM  = 255,
  parameter ITER_NUM            = 1
)
(
  /* Common IF */
  input  wire        reset,                     //   reset.reset
  input  wire        clock,                     //   clock.clk
  /* Lvl generator IF */
  input  wire [31:0] lvl_gen_data,              // lvl_gen.data
  input  wire        lvl_gen_valid,             //        .valid
  /* Iteration controller IF */
  input  wire [ 7:0] iter_symbol_num,           //    iter.new_signal
  input  wire [ 1:0] iter_section_id,           //        .new_signal_1
  input  wire        iter_init,                 //        .new_signal_2
  input  wire        iter_input_enable,         //        .new_signal_3
  input  wire        iter_output_enable,        //        .new_signal_4
  output wire        iter_ready,                //        .new_signal_5
  /* Hard limiter IF */
  output wire [31:0] limiter_data,              // limiter.data
  output wire        limiter_valid,             //        .valid
  /* Limits buffer IF */
  /* PORT A */
  output wire [ 8:0] ram_limits_address_a,      //  port_a.address
  output wire        ram_limits_chipselect_a,   //        .chipselect
  output wire        ram_limits_read_a,         //        .read
  input  wire [31:0] ram_limits_readdata_a,     //        .readdata
  output wire        ram_limits_write_a,        //        .write
  output wire [31:0] ram_limits_writedata_a,    //        .writedata
  output wire [ 3:0] ram_limits_byteenable_a,   //        .byteenable
  input  wire        ram_limits_waitrequest_a,  //        .waitrequest
  /* PORT B */
  output wire [ 8:0] ram_limits_address_b,      //  port_b.address
  output wire        ram_limits_chipselect_b,   //        .chipselect
  output wire        ram_limits_read_b,         //        .read
  input  wire [31:0] ram_limits_readdata_b,     //        .readdata
  output wire        ram_limits_write_b,        //        .write
  output wire [31:0] ram_limits_writedata_b,    //        .writedata
  output wire [ 3:0] ram_limits_byteenable_b,   //        .byteenable
  input  wire        ram_limits_waitrequest_b   //        .waitrequest
);

typedef enum reg [1:0]
{
  FIRST_SECTION   = 2'd0,
  SECOND_SECTION  = 2'd1,
  MIDDLE_SECTION  = 2'd2,
  LAST_SECTION    = 2'd3
} SECTION_ID_T;


SECTION_ID_T section_id;
SECTION_ID_T section_id_del_r[5];
reg  [31:0] lvl_gen_data_r;
reg  [31:0] lvl_gen_data_del_r[5];
reg         lvl_gen_valid_r;
reg         lvl_gen_valid_del_r[5];
reg  [31:0] limiter_data_r;
reg  [31:0] limiter_data_del_r[5];
reg         limiter_valid_r;
reg         limiter_valid_del_r[5];
reg         iter_ready_r;
reg         iter_ready_del_r[5];
reg  [ 8:0] ram_limits_address_a_r;
reg  [ 8:0] ram_limits_address_a_del_r[5];
reg         ram_limits_chipselect_a_r;
reg         ram_limits_write_a_r;
reg         ram_limits_write_a_del_r[5];
reg  [31:0] ram_limits_writedata_a_r;
reg  [31:0] ram_limits_writedata_a_del_r[5];
reg  [ 3:0] ram_limits_byteenable_a_r;
reg  [ 8:0] ram_limits_address_b_r;
reg  [ 8:0] ram_limits_address_b_del_r[5];
reg         ram_limits_chipselect_b_r;
reg         ram_limits_read_b_r;
reg         ram_limits_read_b_del_r[5];
reg  [31:0] ram_limits_readdata_b_r;
reg  [31:0] ram_limits_readdata_b_del_r[5];
reg  [ 3:0] ram_limits_byteenable_b_r;

reg  [ 7:0] fir_taps_num_r;
reg  [ 7:0] max_samples_in_ram_r;
reg  [ 4:0] iter_num_r;

reg  [31:0] reset_values_r;
reg  [ 7:0] fir_taps_head_r;
reg  [ 7:0] fir_taps_tail_r;
reg  [ 7:0] symbol_cnt_r;
reg  [ 7:0] symbol_cnt_del_r[5];
reg  [ 5:0] curr_iter_r; // 1 extra bit
reg  [ 5:0] curr_iter_del_r[5]; // 1 extra bit
reg         ping_pong_a_r;
reg         ping_pong_a_del_r[5];
reg         ping_pong_b_r;
reg         ping_pong_b_del_r[5];
reg         pipeline_init_r;
reg         pipeline_init_del_r[5];
reg         buffer_end_r;
wire        buffer_end;
wire        iter_end;
wire        fir_taps_half;

assign section_id               = SECTION_ID_T'(iter_section_id);
assign iter_ready               = iter_ready_r & ~ram_limits_waitrequest_b;
assign limiter_data             = limiter_data_r;
assign limiter_valid            = limiter_valid_del_r[1];

assign ram_limits_address_a     = ram_limits_address_a_r;
assign ram_limits_chipselect_a  = ram_limits_chipselect_a_r;
assign ram_limits_read_a        = '0;
assign ram_limits_write_a       = ram_limits_write_a_r;
assign ram_limits_writedata_a   = ram_limits_writedata_a_r;
assign ram_limits_byteenable_a  = ram_limits_byteenable_a_r;

assign ram_limits_address_b     = ram_limits_address_b_r;
assign ram_limits_chipselect_b  = ram_limits_chipselect_b_r;
assign ram_limits_read_b        = ram_limits_read_b_r;
assign ram_limits_write_b       = '0;
assign ram_limits_writedata_b   = '0;
assign ram_limits_byteenable_b  = ram_limits_byteenable_b_r;

assign buffer_end     = (symbol_cnt_r == max_samples_in_ram_r - 'd1);
assign fir_taps_half  = (iter_symbol_num >= fir_taps_head_r); // ?
assign iter_end       = (curr_iter_r == iter_num_r - 'd1);

assign fir_taps_num_r       = FIR_TAPS_NUM;
assign max_samples_in_ram_r = MAX_SAMPLES_IN_RAM;
assign iter_num_r           = ITER_NUM;

/* Iteration & symbol counter controller */
always_ff @(posedge clock)
begin
  if(reset | iter_init)
  begin
    lvl_gen_data_r      <= '0;
    lvl_gen_valid_r     <= '0;
    symbol_cnt_r        <= '0;
    curr_iter_r         <= '0;
    ping_pong_a_r       <= '0;
    ping_pong_b_r       <= '0;
    pipeline_init_r     <= '1;
    fir_taps_head_r     <= '0;
    fir_taps_tail_r     <= '0;
  end
  else
  begin
    if(pipeline_init_del_r[0])
    begin
      symbol_cnt_r <= buffer_end ? 'd0 : symbol_cnt_r + 8'(!ram_limits_waitrequest_a);

      if(symbol_cnt_r == 'd0 && !curr_iter_r[0])
      begin
        reset_values_r <= lvl_gen_data;
      end

      if(buffer_end)
      begin
        curr_iter_r     <= !curr_iter_r[0];
        pipeline_init_r <= !curr_iter_r[0];
        ping_pong_a_r   <= ~ping_pong_a_r;
      end
    end
    else
    begin
      if(ram_limits_write_a_r & ~buffer_end_r & buffer_end) // detect falling edge in case of pipeline stall
      begin
        ping_pong_a_r <= ~ping_pong_a_r;
        ping_pong_b_r <= ping_pong_a_r;
      end

      symbol_cnt_r  <= iter_symbol_num & { 8{ ~(pipeline_init_r | pipeline_init_del_r[0]) } };
    end

    lvl_gen_data_r      <= lvl_gen_data;
    lvl_gen_valid_r     <= lvl_gen_valid;

    fir_taps_head_r     <= fir_taps_num_r[7:1] + fir_taps_num_r[0];
    fir_taps_tail_r     <= fir_taps_num_r[7:1];
    buffer_end_r        <= buffer_end;
  end
end

/* Input controller */
always_ff @(posedge clock)
begin
  if(reset | iter_init)
  begin
    ram_limits_address_a_r      <= '0;
    ram_limits_chipselect_a_r   <= '0;
    ram_limits_write_a_r        <= '0;
    ram_limits_writedata_a_r    <= '0;
    ram_limits_byteenable_a_r   <= '0;
  end
  else
  begin

    if(pipeline_init_del_r[1])
    begin
      ram_limits_address_a_r    <= { ping_pong_a_del_r[0], symbol_cnt_del_r[0] };
      ram_limits_write_a_r      <= 'd1;

      if(pipeline_init_r)
        ram_limits_writedata_a_r  <= reset_values_r;
    end
    else
    begin
      ram_limits_address_a_r    <= { ping_pong_a_del_r[0], iter_symbol_num };
      ram_limits_write_a_r      <= iter_input_enable & lvl_gen_valid_del_r[0] & ~(pipeline_init_r | pipeline_init_del_r[0]);
      ram_limits_writedata_a_r  <= lvl_gen_data_del_r[0];
    end
    
    ram_limits_chipselect_a_r   <= 'd1;
    ram_limits_byteenable_a_r   <= '1;
  end
end

/* Output controller */
always_ff @(posedge clock)
begin
  if(reset)
  begin
    iter_ready_r                <= '0;
    limiter_data_r              <= '0;
    limiter_valid_r             <= '0;

    ram_limits_address_b_r      <= '0;
    ram_limits_chipselect_b_r   <= '0;
    ram_limits_read_b_r         <= '0;
    ram_limits_byteenable_b_r   <= '0;
  end
  else
  begin // TODO: check pipeline delays + waitrequest influence
    iter_ready_r              <= ~(pipeline_init_r | pipeline_init_del_r[0] | pipeline_init_del_r[1]);
    limiter_data_r            <= (section_id == FIRST_SECTION) & !fir_taps_half ? reset_values_r : ram_limits_readdata_b;
    limiter_valid_r           <= iter_output_enable & ~ram_limits_waitrequest_b; // make sure the valid pulse is long enough (iteration ctrl)

    if(fir_taps_half)
      ram_limits_address_b_r    <= { ping_pong_b_r & (section_id != FIRST_SECTION), iter_symbol_num - fir_taps_head_r };
    else
      ram_limits_address_b_r    <= { ~ping_pong_b_r & (section_id != FIRST_SECTION), iter_symbol_num + max_samples_in_ram_r - fir_taps_head_r };

    ram_limits_read_b_r       <= 'd1;
    ram_limits_readdata_b_r   <= ram_limits_readdata_b;
    ram_limits_chipselect_b_r <= 'd1;
    ram_limits_byteenable_b_r <= '1;
  end
end

always_ff @(posedge clock)
begin
  if(reset)
  begin
    // section_id_del_r              <= '0;
    // lvl_gen_data_del_r            <= '0;
    // lvl_gen_valid_del_r           <= '0;
    // limiter_data_del_r            <= '0;
    // limiter_valid_del_r           <= '0;
    // iter_ready_del_r              <= '0;
    // ram_limits_address_a_del_r    <= '0;
    // ram_limits_write_a_del_r      <= '0;
    // ram_limits_writedata_a_del_r  <= '0;
    // ram_limits_address_b_del_r    <= '0;
    // ram_limits_read_b_del_r       <= '0;
    // ram_limits_readdata_b_del_r   <= '0;
    // symbol_cnt_del_r              <= '0;
    // curr_iter_del_r               <= '0;
    // ping_pong_a_del_r             <= '0;
    // ping_pong_b_del_r             <= '0;
    // pipeline_init_del_r           <= '0;
  end
  else
  begin
    section_id_del_r[0]             <= section_id;
    lvl_gen_data_del_r[0]           <= lvl_gen_data_r;
    lvl_gen_valid_del_r[0]          <= lvl_gen_valid_r;
    limiter_data_del_r[0]           <= limiter_data_r;
    limiter_valid_del_r[0]          <= limiter_valid_r;
    iter_ready_del_r[0]             <= iter_ready_r;
    ram_limits_address_a_del_r[0]   <= ram_limits_address_a_r;
    ram_limits_write_a_del_r[0]     <= ram_limits_write_a_r;
    ram_limits_writedata_a_del_r[0] <= ram_limits_writedata_a_r;
    ram_limits_address_b_del_r[0]   <= ram_limits_address_b_r;
    ram_limits_read_b_del_r[0]      <= ram_limits_read_b_r;
    ram_limits_readdata_b_del_r[0]  <= ram_limits_readdata_b_r;
    symbol_cnt_del_r[0]             <= symbol_cnt_r;
    curr_iter_del_r[0]              <= curr_iter_r;
    ping_pong_a_del_r[0]            <= ping_pong_a_r;
    ping_pong_b_del_r[0]            <= ping_pong_b_r;
    pipeline_init_del_r[0]          <= pipeline_init_r;

    for(int i = 1; i < 4; i++)
    begin
      section_id_del_r[i]             <= section_id_del_r[i-1];
      lvl_gen_data_del_r[i]           <= lvl_gen_data_del_r[i-1];
      lvl_gen_valid_del_r[i]          <= lvl_gen_valid_del_r[i-1];
      limiter_data_del_r[i]           <= limiter_data_del_r[i-1];
      limiter_valid_del_r[i]          <= limiter_valid_del_r[i-1];
      iter_ready_del_r[i]             <= iter_ready_del_r[i-1];
      ram_limits_address_a_del_r[i]   <= ram_limits_address_a_del_r[i-1];
      ram_limits_write_a_del_r[i]     <= ram_limits_write_a_del_r[i-1];
      ram_limits_writedata_a_del_r[i] <= ram_limits_writedata_a_del_r[i-1];
      ram_limits_address_b_del_r[i]   <= ram_limits_address_b_del_r[i-1];
      ram_limits_read_b_del_r[i]      <= ram_limits_read_b_del_r[i-1];
      ram_limits_readdata_b_del_r[i]  <= ram_limits_readdata_b_del_r[i-1];
      symbol_cnt_del_r[i]             <= symbol_cnt_del_r[i-1];
      curr_iter_del_r[i]              <= curr_iter_del_r[i-1];
      ping_pong_a_del_r[i]            <= ping_pong_a_del_r[i-1];
      ping_pong_b_del_r[i]            <= ping_pong_b_del_r[i-1];
      pipeline_init_del_r[i]          <= pipeline_init_del_r[i-1];
    end
  end
end

endmodule
