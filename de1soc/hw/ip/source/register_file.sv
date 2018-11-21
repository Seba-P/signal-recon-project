
module register_file
#(
  parameter LVLS_NUM        = 20,
  parameter LVL_RESET_VALUE = 9,
  parameter ITER_NUM        = 1
)
(
  /* Common IF */
  input  wire              reset,               // reset.reset
  input  wire              clock,               // clock.clk
  /* CSR IF */
  input  wire       [ 7:0] csr_address,         //   csr.address
  input  wire       [ 3:0] csr_byteenable,      //      .byteenable
  input  wire              csr_read,            //      .read
  output wire       [31:0] csr_readdata,        //      .readdata
  output wire       [ 1:0] csr_response,        //      .response
  input  wire              csr_write,           //      .write
  input  wire       [31:0] csr_writedata,       //      .writedata
  output wire              csr_waitrequest,     //      .waitrequest
  /* Parameters IF */
  output wire       [ 4:0] reg_lvls_num,        //   reg.lvls_num
  output wire       [ 4:0] reg_lvl_reset_value, //      .lvl_reset_value
  output wire [0:31][15:0] reg_lvls_values,     //      .lvls_values
  output wire       [ 3:0] reg_iter_num         //      .iter_num
);

import register_file_defs_pkg::*;

reg               csr_read_r;
reg        [15:0] csr_readdata_r;
reg        [ 1:0] csr_response_r;
// reg               csr_waitrequest_r;

// reg        [ 4:0] reg_lvls_num_r;
// reg        [ 4:0] reg_lvl_reset_value_r;
// reg  [0:31][15:0] reg_lvls_values_r;
// reg        [ 3:0] reg_iter_num_r;

csr_reg_block_t csr_reg_block;

assign csr_readdata         = csr_readdata_r;
assign csr_response         = csr_response_r;
// assign csr_waitrequest      = csr_waitrequest_r;
assign csr_waitrequest      = csr_read & ~csr_read_r;

// assign reg_lvls_num         = reg_lvls_num_r;
// assign reg_lvl_reset_value  = reg_lvl_reset_value_r;
// assign reg_lvls_values      = reg_lvls_values_r;
// assign reg_iter_num         = reg_iter_num_r;

assign reg_lvls_num         = csr_reg_block.params.lvls_num;
assign reg_lvl_reset_value  = csr_reg_block.params.init_lvl;
assign reg_iter_num         = csr_reg_block.params.iter_num;
assign reg_lvls_values[ 0]  = csr_reg_block.lvl_val_00_01.lvl_val_00;
assign reg_lvls_values[ 1]  = csr_reg_block.lvl_val_00_01.lvl_val_01;
assign reg_lvls_values[ 2]  = csr_reg_block.lvl_val_02_03.lvl_val_02;
assign reg_lvls_values[ 3]  = csr_reg_block.lvl_val_02_03.lvl_val_03;
assign reg_lvls_values[ 4]  = csr_reg_block.lvl_val_04_05.lvl_val_04;
assign reg_lvls_values[ 5]  = csr_reg_block.lvl_val_04_05.lvl_val_05;
assign reg_lvls_values[ 6]  = csr_reg_block.lvl_val_06_07.lvl_val_06;
assign reg_lvls_values[ 7]  = csr_reg_block.lvl_val_06_07.lvl_val_07;
assign reg_lvls_values[ 8]  = csr_reg_block.lvl_val_08_09.lvl_val_08;
assign reg_lvls_values[ 9]  = csr_reg_block.lvl_val_08_09.lvl_val_09;
assign reg_lvls_values[10]  = csr_reg_block.lvl_val_10_11.lvl_val_10;
assign reg_lvls_values[11]  = csr_reg_block.lvl_val_10_11.lvl_val_11;
assign reg_lvls_values[12]  = csr_reg_block.lvl_val_12_13.lvl_val_12;
assign reg_lvls_values[13]  = csr_reg_block.lvl_val_12_13.lvl_val_13;
assign reg_lvls_values[14]  = csr_reg_block.lvl_val_14_15.lvl_val_14;
assign reg_lvls_values[15]  = csr_reg_block.lvl_val_14_15.lvl_val_15;
assign reg_lvls_values[16]  = csr_reg_block.lvl_val_16_17.lvl_val_16;
assign reg_lvls_values[17]  = csr_reg_block.lvl_val_16_17.lvl_val_17;
assign reg_lvls_values[18]  = csr_reg_block.lvl_val_18_19.lvl_val_18;
assign reg_lvls_values[19]  = csr_reg_block.lvl_val_18_19.lvl_val_19;
assign reg_lvls_values[20]  = csr_reg_block.lvl_val_20_21.lvl_val_20;
assign reg_lvls_values[21]  = csr_reg_block.lvl_val_20_21.lvl_val_21;
assign reg_lvls_values[22]  = csr_reg_block.lvl_val_22_23.lvl_val_22;
assign reg_lvls_values[23]  = csr_reg_block.lvl_val_22_23.lvl_val_23;
assign reg_lvls_values[24]  = csr_reg_block.lvl_val_24_25.lvl_val_24;
assign reg_lvls_values[25]  = csr_reg_block.lvl_val_24_25.lvl_val_25;
assign reg_lvls_values[26]  = csr_reg_block.lvl_val_26_27.lvl_val_26;
assign reg_lvls_values[27]  = csr_reg_block.lvl_val_26_27.lvl_val_27;
assign reg_lvls_values[28]  = csr_reg_block.lvl_val_28_29.lvl_val_28;
assign reg_lvls_values[29]  = csr_reg_block.lvl_val_28_29.lvl_val_29;
assign reg_lvls_values[30]  = csr_reg_block.lvl_val_30_31.lvl_val_30;
assign reg_lvls_values[31]  = csr_reg_block.lvl_val_30_31.lvl_val_31;

always_ff @(posedge clock)
begin
  csr_read_r <= csr_read;
end

always_ff @(posedge clock)
begin
  if (reset)
  begin
    csr_readdata_r    <= '0;
    csr_response_r    <= '0;
    // csr_waitrequest_r <= '0;

    csr_reg_block     <= { 19{ 32'd0 } };
  end
  else
  begin
    if (csr_read)
    begin
      case (csr_address)
        // CSR_REG_BLOCK_STATUS_START:
        CSR_REG_BLOCK_STATUS_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.status);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_CONTROL_START:
        CSR_REG_BLOCK_CONTROL_OFFSET:
        begin
          // csr_readdata_r  <= 32'(csr_reg_block.status);
          csr_readdata_r  <= 'd0;
          csr_response_r  <= 'd2; // write-only register, issue SLAVEERR response
        end

        // CSR_REG_BLOCK_PARAMS_START:
        CSR_REG_BLOCK_PARAMS_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.params);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_00_01_START:
        CSR_REG_BLOCK_LVL_VAL_00_01_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_00_01);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_02_03_START:
        CSR_REG_BLOCK_LVL_VAL_02_03_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_02_03);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_04_05_START:
        CSR_REG_BLOCK_LVL_VAL_04_05_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_04_05);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_06_07_START:
        CSR_REG_BLOCK_LVL_VAL_06_07_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_06_07);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_08_09_START:
        CSR_REG_BLOCK_LVL_VAL_08_09_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_08_09);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_10_11_START:
        CSR_REG_BLOCK_LVL_VAL_10_11_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_10_11);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_12_13_START:
        CSR_REG_BLOCK_LVL_VAL_12_13_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_12_13);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_14_15_START:
        CSR_REG_BLOCK_LVL_VAL_14_15_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_14_15);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_16_17_START:
        CSR_REG_BLOCK_LVL_VAL_16_17_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_16_17);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_18_19_START:
        CSR_REG_BLOCK_LVL_VAL_18_19_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_18_19);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_20_21_START:
        CSR_REG_BLOCK_LVL_VAL_20_21_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_20_21);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_22_23_START:
        CSR_REG_BLOCK_LVL_VAL_22_23_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_22_23);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_24_25_START:
        CSR_REG_BLOCK_LVL_VAL_24_25_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_24_25);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_26_27_START:
        CSR_REG_BLOCK_LVL_VAL_26_27_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_26_27);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_28_29_START:
        CSR_REG_BLOCK_LVL_VAL_28_29_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_28_29);
          csr_response_r  <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_30_31_START:
        CSR_REG_BLOCK_LVL_VAL_30_31_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_30_31);
          csr_response_r  <= 'd0;
        end
      endcase
    end

    if (csr_write)
    begin
      case (csr_address)
        // CSR_REG_BLOCK_STATUS_START:
        CSR_REG_BLOCK_STATUS_OFFSET:
        begin
          // csr_reg_block.status        <= csr_writedata;
          csr_response_r              <= 'd2; // read-only register, issue SLAVEERR response
        end

        // CSR_REG_BLOCK_CONTROL_START:
        CSR_REG_BLOCK_CONTROL_OFFSET:
        begin
          csr_reg_block.control       <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_PARAMS_START:
        CSR_REG_BLOCK_PARAMS_OFFSET:
        begin
          csr_reg_block.params        <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_00_01_START:
        CSR_REG_BLOCK_LVL_VAL_00_01_OFFSET:
        begin
          csr_reg_block.lvl_val_00_01 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_02_03_START:
        CSR_REG_BLOCK_LVL_VAL_02_03_OFFSET:
        begin
          csr_reg_block.lvl_val_02_03 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_04_05_START:
        CSR_REG_BLOCK_LVL_VAL_04_05_OFFSET:
        begin
          csr_reg_block.lvl_val_04_05 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_06_07_START:
        CSR_REG_BLOCK_LVL_VAL_06_07_OFFSET:
        begin
          csr_reg_block.lvl_val_06_07 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_08_09_START:
        CSR_REG_BLOCK_LVL_VAL_08_09_OFFSET:
        begin
          csr_reg_block.lvl_val_08_09 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_10_11_START:
        CSR_REG_BLOCK_LVL_VAL_10_11_OFFSET:
        begin
          csr_reg_block.lvl_val_10_11 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_12_13_START:
        CSR_REG_BLOCK_LVL_VAL_12_13_OFFSET:
        begin
          csr_reg_block.lvl_val_12_13 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_14_15_START:
        CSR_REG_BLOCK_LVL_VAL_14_15_OFFSET:
        begin
          csr_reg_block.lvl_val_14_15 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_16_17_START:
        CSR_REG_BLOCK_LVL_VAL_16_17_OFFSET:
        begin
          csr_reg_block.lvl_val_16_17 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_18_19_START:
        CSR_REG_BLOCK_LVL_VAL_18_19_OFFSET:
        begin
          csr_reg_block.lvl_val_18_19 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_20_21_START:
        CSR_REG_BLOCK_LVL_VAL_20_21_OFFSET:
        begin
          csr_reg_block.lvl_val_20_21 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_22_23_START:
        CSR_REG_BLOCK_LVL_VAL_22_23_OFFSET:
        begin
          csr_reg_block.lvl_val_22_23 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_24_25_START:
        CSR_REG_BLOCK_LVL_VAL_24_25_OFFSET:
        begin
          csr_reg_block.lvl_val_24_25 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_26_27_START:
        CSR_REG_BLOCK_LVL_VAL_26_27_OFFSET:
        begin
          csr_reg_block.lvl_val_26_27 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_28_29_START:
        CSR_REG_BLOCK_LVL_VAL_28_29_OFFSET:
        begin
          csr_reg_block.lvl_val_28_29 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        // CSR_REG_BLOCK_LVL_VAL_30_31_START:
        CSR_REG_BLOCK_LVL_VAL_30_31_OFFSET:
        begin
          csr_reg_block.lvl_val_30_31 <= csr_writedata;
          csr_response_r              <= 'd0;
        end
      endcase
    end
  end
end

// assign csr_readdata_r         = 'd0;
// assign csr_response_r         = 'd0;
// assign csr_waitrequest_r      = 'd0;
// assign reg_lvls_num_r         = LVLS_NUM;
// assign reg_lvl_reset_value_r  = LVL_RESET_VALUE;

// /* Temporarily frozen levels */
// assign reg_lvls_values_r      = 
// '{
//   16'h8666, 16'h9333, 16'h9FFF, 16'hACCC,
//   16'hB999, 16'hC666, 16'hD333, 16'hE000,
//   16'hECCC, 16'hF999, 16'h0666, 16'h1333,
//   16'h2000, 16'h2CCC, 16'h3999, 16'h4666,
//   16'h5333, 16'h6000, 16'h6CCC, 16'h7999,
//   /* UNUSED BELOW */
//   16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF,
//   16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF,
//   16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF 
// };

// assign reg_iter_num_r         = ITER_NUM;

endmodule
