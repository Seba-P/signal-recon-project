
module sample2lvl_converter
#(
  parameter MAX_SAMPLES_IN_RAM  = 255,
  parameter LVLS_NUM            = 20,
  parameter LVL_RESET_VALUE     = 9,
  parameter ITER_NUM            = 1
)
(
  /* Common IF */
  input  wire        reset,                  //    reset.reset
  input  wire        clk,                    //    clock.clk
  /* SGDMA IF */
  input  wire [15:0] in_data,                //    in.data
  output wire        in_ready,               //         .ready
  input  wire        in_valid,               //         .valid
  /* CSR IF */
  input  wire        csr_address,            //    csr.address
  input  wire        csr_read,               //         .read
  output wire [31:0] csr_readdata,           //         .readdata
  output wire        csr_waitrequest,        //         .waitrequest
  input  wire        csr_write,              //         .write
  input  wire [31:0] csr_writedata,          //         .writedata
  input  wire [ 3:0] csr_byteenable,         //         .byteenable
  input  wire        csr_chipselect,         //         .chipselect
  /* FIR IF */
  output wire [15:0] fir_data,               //    fir.data
  input  wire        fir_ready,              //         .ready
  output wire        fir_valid,              //         .valid
  /* Sample buffer IF */
  output wire [ 8:0] ram_sample_address,     //    ram_sample.address
  output wire        ram_sample_chipselect,  //         .chipselect
  output wire        ram_sample_read,        //         .read
  output wire        ram_sample_write,       //         .write
  input  wire [15:0] ram_sample_readdata,    //         .readdata
  output wire [15:0] ram_sample_writedata,   //         .writedata
  output wire [ 1:0] ram_sample_byteenable,  //         .byteenable
  input  wire        ram_sample_waitrequest, //         .waitrequest
  /* Limits buffer IF */
  output wire [ 9:0] ram_limits_address,     //    ram_limits.address
  output wire        ram_limits_chipselect,  //         .chipselect
  output wire        ram_limits_read,        //         .read
  output wire        ram_limits_write,       //         .write
  input  wire [31:0] ram_limits_readdata,    //         .readdata
  output wire [31:0] ram_limits_writedata,   //         .writedata
  output wire [ 3:0] ram_limits_byteenable,  //         .byteenable
  input  wire        ram_limits_waitrequest  //         .waitrequest
);

/* Output regs */
reg         sample_recv_r;            //         .ready
reg  [31:0] csr_readdata_r;           //         .readdata
reg         csr_waitrequest_r;        //         .waitrequest
reg  [15:0] fir_data_r;               // fir.data
reg  [15:0] fir_data_buff_r;          // fir.data
reg         fir_valid_r;              //         .valid
reg         fir_valid_buff_r;         //         .valid
reg  [ 8:0] ram_sample_address_r;     // ram_sample.address
reg         ram_sample_chipselect_r;  //         .chipselect
reg         ram_sample_read_r;        //         .read
// reg  [15:0] ram_sample_readdata_r;    //         .writedata
reg         ram_sample_write_r;       //         .write
reg  [15:0] ram_sample_writedata_r;   //         .writedata
reg  [ 3:0] ram_sample_byteenable_r;  //         .byteenable
reg  [ 9:0] ram_limits_address_r;     // ram_limits.address
reg         ram_limits_chipselect_r;  //         .chipselect
reg         ram_limits_write_r;       //         .write
reg  [31:0] ram_limits_writedata_r;   //         .writedata
reg  [ 3:0] ram_limits_byteenable_r;  //         .byteenable

assign in_ready               = sample_recv_r;
assign csr_readdata           = csr_readdata_r;
assign csr_waitrequest        = csr_waitrequest_r;
assign fir_data               = fir_data_r;
assign fir_data_buff          = fir_data_buff_r;
assign fir_valid              = fir_valid_r;
assign fir_valid_buff         = fir_valid_buff_r;
assign ram_sample_address     = ram_sample_address_r;
assign ram_sample_chipselect  = ram_sample_chipselect_r;
assign ram_sample_read        = ram_sample_read_r;
// assign ram_sample_readdata     = ram_sample_readdata_r;
assign ram_sample_write       = ram_sample_write_r;
assign ram_sample_writedata   = ram_sample_writedata_r;
assign ram_sample_byteenable  = ram_sample_byteenable_r;
assign ram_limits_address     = ram_limits_address_r;
assign ram_limits_chipselect  = ram_limits_chipselect_r;
assign ram_limits_write       = ram_limits_write_r;
assign ram_limits_writedata   = ram_limits_writedata_r;
assign ram_limits_byteenable  = ram_limits_byteenable_r;

reg  [15:0] recv_sample_r;
reg  [ 8:0] sample_buffer_fill_cnt_r;  // 1 bit more for lazy overflow
reg  [ 8:0] iter_sample_cnt_r;         // 1 bit more for lazy overflow
reg  [ 7:0] iter_num_r;
reg  [ 7:0] curr_iter_r;
reg  [ 4:0] curr_lvl_r;
reg  [14:0] lvl_duration_cnt_r;
wire [15:0] lvls_step;
wire [15:0] lvl_value;
reg  [15:0] lvl_lower_limit_r;
reg  [15:0] lvl_upper_limit_r;
wire [ 4:0] upper_lvl_idx;
wire [ 4:0] lower_lvl_idx;
reg  [ 4:0] lvls_num_r;
reg  [0:31][15:0] lvls_values_r;
wire [14:0] lvl_cross_timestamp;
wire     		lvl_cross_dir;
wire     		not_max_lvl;
wire     		not_min_lvl;
wire     		full_buffer;
wire     		iter_end;
wire     		next_sample;
wire     		load_fresh_vector;
wire     		sample_processed;
reg      		use_ram_vector_r;

/* Temporarily frozen levels and iterations */
assign iter_num_r = 8'(ITER_NUM);
assign lvls_num_r = 5'(LVLS_NUM);

assign lvls_values_r = 
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

assign ram_limits_read     = 1'b0;
assign full_buffer         = (sample_buffer_fill_cnt_r == 9'(MAX_SAMPLES_IN_RAM));
assign empty_buffer        = (sample_buffer_fill_cnt_r == 9'd0);
assign curr_iter_end       = (iter_sample_cnt_r == 9'(MAX_SAMPLES_IN_RAM-1));
assign sample_processed    = (curr_iter_r == 9'd0 & full_buffer & ~curr_iter_end);
assign in_ready            = sample_recv_r;
assign lvl_cross_dir       = in_data[15];
assign lvl_cross_timestamp = in_data[14:0];
assign not_max_lvl         = (curr_lvl_r != lvls_num_r-5'd1);
assign not_min_lvl         = (curr_lvl_r != 0);
assign upper_lvl_idx       = curr_lvl_r + 5'(not_max_lvl);
assign lower_lvl_idx       = curr_lvl_r - 5'(not_min_lvl);
assign next_sample         = (lvl_duration_cnt_r == 15'd0);
assign load_fresh_vector   = ~next_sample & ~full_buffer;
assign lvls_step           = recv_sample_r[15] ?  lvls_values_r[upper_lvl_idx] - lvls_values_r[curr_lvl_r] :
                                                  lvls_values_r[curr_lvl_r] - lvls_values_r[lower_lvl_idx];
assign lvl_value           = lvls_values_r[curr_lvl_r] + (lvls_step>>>1'b1)/*{ lvls_step[15], lvls_step[15:1] }*/;

/* Sample dispatcher */
always_ff @(posedge clk)
begin
  if(reset)
  begin
    sample_recv_r       <= 1'b0;
    recv_sample_r       <= 16'd0;
    curr_lvl_r          <= 5'(LVL_RESET_VALUE);
    lvl_lower_limit_r   <= lvls_values_r[LVL_RESET_VALUE];
    lvl_upper_limit_r   <= lvls_values_r[LVL_RESET_VALUE+1];
    lvl_duration_cnt_r  <= 15'd0;
  end
  else
  begin
    sample_recv_r <= in_valid && next_sample;
    
    if(in_valid && next_sample)
    begin
      recv_sample_r       <= in_data;
      curr_lvl_r          <= lvl_cross_dir ? upper_lvl_idx : lower_lvl_idx;
      lvl_duration_cnt_r  <= lvl_cross_timestamp;
      lvl_lower_limit_r   <= lvl_cross_dir ? lvls_values_r[upper_lvl_idx] :
                          (not_min_lvl ? lvls_values_r[lower_lvl_idx] : 16'h8000);
      lvl_upper_limit_r   <= lvl_cross_dir ? (curr_lvl_r < lvls_num_r-5'd2 ? lvls_values_r[upper_lvl_idx+1] : 16'h7FFF) : 
                          lvls_values_r[curr_lvl_r];
    end

    if(load_fresh_vector)
    begin
      lvl_duration_cnt_r  <= lvl_duration_cnt_r - 15'd1;
    end
  end
end

/* Iteration CTRL */
always_ff @(posedge clk)
begin
  if(reset)
  begin
    curr_iter_r       <= iter_num_r;
    iter_sample_cnt_r <= 9'd0;
    use_ram_vector_r  <= 1'b0;
  end
  else
  begin
    if((fir_valid_buff_r) & fir_ready)
    begin
      curr_iter_r       <= ~full_buffer ? iter_num_r : curr_iter_r - 8'(curr_iter_end & ~(curr_iter_r==0));
      iter_sample_cnt_r <= curr_iter_end ? 9'd0 : iter_sample_cnt_r + 9'(iter_sample_cnt_r < sample_buffer_fill_cnt_r);
      use_ram_vector_r  <= sample_processed;
    end
  end
end

/* FIR IF */
always_ff @(posedge clk)
begin
  if(reset)
  begin
    fir_valid_r       <= 1'b0;
    fir_valid_buff_r  <= 1'b0;
    fir_data_r        <= 16'd0;
    fir_data_buff_r   <= 16'd0;
  end
  else
  begin
    if(load_fresh_vector | full_buffer)
    begin
      fir_valid_buff_r <= 1'b1;
      fir_data_buff_r  <= lvl_value;
    end
    else 
    begin
      fir_valid_buff_r <= 1'b0;
    end

    fir_valid_r <= fir_valid_buff_r; // are the buffers really necessary?
    fir_data_r  <= use_ram_vector_r ? ram_sample_readdata : fir_data_buff_r;
  end
end

/* Sample buffer IF */
always_ff @(posedge clk)
begin
  if(reset)
  begin
    // ram_sample_address_r    <= 9'd0;
    ram_sample_chipselect_r   <= 1'b0;
    ram_sample_read_r         <= 1'b0;
    ram_sample_write_r        <= 1'b0;
    // ram_sample_writedata_r    <= 16'd0;
    ram_sample_byteenable_r   <= 2'b00;
    sample_buffer_fill_cnt_r  <= 9'd0;// 9'h1FF;
  end
  else
  begin
    if(load_fresh_vector)
    begin
      ram_sample_address_r      <= { sample_buffer_fill_cnt_r[7:0], 1'b0 }; // is address unit in bytes? 
      ram_sample_chipselect_r   <= 1'b1;
      ram_sample_read_r         <= 1'b0;
      ram_sample_write_r        <= 1'b1;
      // ram_sample_writedata_r    <= lvl_value;
      ram_sample_writedata_r    <= lvl_value;
      ram_sample_byteenable_r   <= 2'b11;
    end
    else
    begin
      ram_sample_address_r    <= { iter_sample_cnt_r[7:0], 1'b0 }; // is address unit in bytes? 
      ram_sample_chipselect_r <= 1'b1;
      ram_sample_read_r       <= 1'b1;
      ram_sample_write_r      <= 1'b0;
      ram_sample_byteenable_r <= 2'b11;
    end

    sample_buffer_fill_cnt_r <= ((curr_iter_r == 0) & curr_iter_end) ? 9'd0 : sample_buffer_fill_cnt_r + 9'(load_fresh_vector);
  end
end

/* Limits buffer IF */
always_ff @(posedge clk)
begin
  if(reset)
  begin
    ram_limits_address_r    <= 9'd0;
    ram_limits_chipselect_r <= 1'b0;
    ram_limits_write_r      <= 1'b0;
    ram_limits_writedata_r  <= 16'd0;
    ram_limits_byteenable_r <= 2'b00;
  end
  else
  begin
    if(load_fresh_vector)
    begin
      ram_limits_address_r    <= { sample_buffer_fill_cnt_r[7:0], 2'b00 }; // is address unit in bytes? 
      ram_limits_chipselect_r <= 1'b1;
      ram_limits_write_r      <= 1'b1;
      ram_limits_writedata_r  <= { lvl_upper_limit_r, lvl_lower_limit_r };
      ram_limits_byteenable_r <= 4'b1111;
    end
  end
end

endmodule
