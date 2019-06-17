
module register_file
#(
  parameter MAX_LVLS_NUM  = 32,
  parameter LVLS_NUM_BITS = 5,
  parameter MAX_ITER_NUM  = 1,
  parameter ITER_NUM_BITS = 1
)
(
  /* Common IF */
  input  wire              reset,             //   reset.reset
  input  wire              clock,             //   clock.clk
  /* CSR IF */
  input  wire       [ 7:0] csr_address,       //     csr.address
  input  wire       [ 3:0] csr_byteenable,    //        .byteenable
  input  wire              csr_read,          //        .read
  output wire       [31:0] csr_readdata,      //        .readdata
  output wire       [ 1:0] csr_response,      //        .response
  input  wire              csr_write,         //        .write
  input  wire       [31:0] csr_writedata,     //        .writedata
  output wire              csr_waitrequest,   //        .waitrequest
  /* STATUS register IF */
  input  wire              status_busy,       //  status.busy
  input  wire              status_ready,      //        .ready
  input  wire              status_error,      //        .error
  input  wire              status_fifo_err,   //        .fifo_err
  /* CONTROL register IF */
  output wire              control_run,       // control.run
  output wire              control_halt,      //        .halt
  output wire              control_flush,     //        .flush
  output wire              control_init,      //        .init
  /* PARAMS register IF */
  output wire       [ 4:0] params_lvls_num,   //  params.lvls_num
  output wire       [ 4:0] params_init_lvl,   //        .init_lvl
  output wire       [ 3:0] params_iter_num,   //        .iter_num
  output wire       [ 1:0] params_init_guess, //        .init_guess
  /* LVL_VAL registers IF */
  output wire [0:31][15:0] lvl_val_lvl_xx     // lvl_val.lvl_xx
);

import register_file_defs_pkg::*;

reg               csr_read_r;
reg        [31:0] csr_readdata_r;
reg        [ 1:0] csr_response_r;
// reg               csr_waitrequest_r;

csr_reg_block_t   csr_reg_block;

reg               control_run_pulse_r;
reg               control_run_pulse_d1_r;
reg               control_halt_pulse_r;
reg               control_halt_pulse_d1_r;
reg               control_flush_pulse_r;
reg               control_flush_pulse_d1_r;
reg               control_init_pulse_r;
reg               control_init_pulse_d1_r;

assign csr_readdata       = csr_readdata_r;
assign csr_response       = csr_response_r;
// assign csr_waitrequest    = csr_waitrequest_r;
assign csr_waitrequest    = csr_read & ~csr_read_r;

assign control_run        = control_run_pulse_r & ~control_run_pulse_d1_r;
assign control_halt       = control_halt_pulse_r & ~control_halt_pulse_d1_r;
assign control_flush      = control_flush_pulse_r & ~control_flush_pulse_d1_r;
assign control_init       = control_init_pulse_r & ~control_init_pulse_d1_r;
assign params_lvls_num    = csr_reg_block.params.lvls_num;
assign params_init_lvl    = csr_reg_block.params.init_lvl;
assign params_iter_num    = csr_reg_block.params.iter_num;
assign params_init_guess  = csr_reg_block.params.init_guess;
assign lvl_val_lvl_xx[ 0] = csr_reg_block.lvl_val_00_01.lvl_val_00;
assign lvl_val_lvl_xx[ 1] = csr_reg_block.lvl_val_00_01.lvl_val_01;
assign lvl_val_lvl_xx[ 2] = csr_reg_block.lvl_val_02_03.lvl_val_02;
assign lvl_val_lvl_xx[ 3] = csr_reg_block.lvl_val_02_03.lvl_val_03;
assign lvl_val_lvl_xx[ 4] = csr_reg_block.lvl_val_04_05.lvl_val_04;
assign lvl_val_lvl_xx[ 5] = csr_reg_block.lvl_val_04_05.lvl_val_05;
assign lvl_val_lvl_xx[ 6] = csr_reg_block.lvl_val_06_07.lvl_val_06;
assign lvl_val_lvl_xx[ 7] = csr_reg_block.lvl_val_06_07.lvl_val_07;
assign lvl_val_lvl_xx[ 8] = csr_reg_block.lvl_val_08_09.lvl_val_08;
assign lvl_val_lvl_xx[ 9] = csr_reg_block.lvl_val_08_09.lvl_val_09;
assign lvl_val_lvl_xx[10] = csr_reg_block.lvl_val_10_11.lvl_val_10;
assign lvl_val_lvl_xx[11] = csr_reg_block.lvl_val_10_11.lvl_val_11;
assign lvl_val_lvl_xx[12] = csr_reg_block.lvl_val_12_13.lvl_val_12;
assign lvl_val_lvl_xx[13] = csr_reg_block.lvl_val_12_13.lvl_val_13;
assign lvl_val_lvl_xx[14] = csr_reg_block.lvl_val_14_15.lvl_val_14;
assign lvl_val_lvl_xx[15] = csr_reg_block.lvl_val_14_15.lvl_val_15;
assign lvl_val_lvl_xx[16] = csr_reg_block.lvl_val_16_17.lvl_val_16;
assign lvl_val_lvl_xx[17] = csr_reg_block.lvl_val_16_17.lvl_val_17;
assign lvl_val_lvl_xx[18] = csr_reg_block.lvl_val_18_19.lvl_val_18;
assign lvl_val_lvl_xx[19] = csr_reg_block.lvl_val_18_19.lvl_val_19;
assign lvl_val_lvl_xx[20] = csr_reg_block.lvl_val_20_21.lvl_val_20;
assign lvl_val_lvl_xx[21] = csr_reg_block.lvl_val_20_21.lvl_val_21;
assign lvl_val_lvl_xx[22] = csr_reg_block.lvl_val_22_23.lvl_val_22;
assign lvl_val_lvl_xx[23] = csr_reg_block.lvl_val_22_23.lvl_val_23;
assign lvl_val_lvl_xx[24] = csr_reg_block.lvl_val_24_25.lvl_val_24;
assign lvl_val_lvl_xx[25] = csr_reg_block.lvl_val_24_25.lvl_val_25;
assign lvl_val_lvl_xx[26] = csr_reg_block.lvl_val_26_27.lvl_val_26;
assign lvl_val_lvl_xx[27] = csr_reg_block.lvl_val_26_27.lvl_val_27;
assign lvl_val_lvl_xx[28] = csr_reg_block.lvl_val_28_29.lvl_val_28;
assign lvl_val_lvl_xx[29] = csr_reg_block.lvl_val_28_29.lvl_val_29;
assign lvl_val_lvl_xx[30] = csr_reg_block.lvl_val_30_31.lvl_val_30;
assign lvl_val_lvl_xx[31] = csr_reg_block.lvl_val_30_31.lvl_val_31;

always_ff @(posedge clock)
begin
  csr_read_r <= csr_read;
end

always_ff @(posedge clock)
begin
  if (reset)
  begin
    control_run_pulse_r       <= '0;
    control_halt_pulse_r      <= '0;
    control_flush_pulse_r     <= '0;
    control_init_pulse_r      <= '0;

    control_run_pulse_d1_r    <= '0;
    control_halt_pulse_d1_r   <= '0;
    control_flush_pulse_d1_r  <= '0;
    control_init_pulse_d1_r   <= '0;
  end
  else
  begin
    control_run_pulse_r       <= (csr_write && (csr_address == CSR_REG_BLOCK_CONTROL_OFFSET) && (csr_writedata[CSR_CONTROL_RUN_OFFSET] == 'd1));
    control_halt_pulse_r      <= (csr_write && (csr_address == CSR_REG_BLOCK_CONTROL_OFFSET) && (csr_writedata[CSR_CONTROL_HALT_OFFSET] == 'd1));
    control_flush_pulse_r     <= (csr_write && (csr_address == CSR_REG_BLOCK_CONTROL_OFFSET) && (csr_writedata[CSR_CONTROL_FLUSH_OFFSET] == 'd1));
    control_init_pulse_r      <= (csr_write && (csr_address == CSR_REG_BLOCK_CONTROL_OFFSET) && (csr_writedata[CSR_CONTROL_INIT_OFFSET] == 'd1));
    
    control_run_pulse_d1_r    <= control_run_pulse_r;
    control_halt_pulse_d1_r   <= control_halt_pulse_r;
    control_flush_pulse_d1_r  <= control_flush_pulse_r;
    control_init_pulse_d1_r   <= control_init_pulse_r;
  end
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
        CSR_REG_BLOCK_STATUS_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.status);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_CONTROL_OFFSET:
        begin
          csr_readdata_r  <= 'd0;
          csr_response_r  <= 'd2; // write-only register, issue SLAVEERR response
        end

        CSR_REG_BLOCK_PARAMS_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.params);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_00_01_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_00_01);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_02_03_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_02_03);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_04_05_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_04_05);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_06_07_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_06_07);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_08_09_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_08_09);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_10_11_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_10_11);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_12_13_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_12_13);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_14_15_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_14_15);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_16_17_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_16_17);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_18_19_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_18_19);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_20_21_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_20_21);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_22_23_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_22_23);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_24_25_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_24_25);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_26_27_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_26_27);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_28_29_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_28_29);
          csr_response_r  <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_30_31_OFFSET:
        begin
          csr_readdata_r  <= 32'(csr_reg_block.lvl_val_30_31);
          csr_response_r  <= 'd0;
        end

        default:
        begin
          csr_readdata_r  <= 'd0;
          csr_response_r  <= 'd3; // invalid address, issue DECERR response
        end
      endcase
    end

    if (csr_write)
    begin
      case (csr_address)
        CSR_REG_BLOCK_STATUS_OFFSET:
        begin
          // csr_reg_block.status        <= csr_writedata;
          csr_response_r              <= 'd2; // read-only register, issue SLAVEERR response
        end

        CSR_REG_BLOCK_CONTROL_OFFSET:
        begin
          csr_reg_block.control       <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_PARAMS_OFFSET:
        begin
          csr_reg_block.params        <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_00_01_OFFSET:
        begin
          csr_reg_block.lvl_val_00_01 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_02_03_OFFSET:
        begin
          csr_reg_block.lvl_val_02_03 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_04_05_OFFSET:
        begin
          csr_reg_block.lvl_val_04_05 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_06_07_OFFSET:
        begin
          csr_reg_block.lvl_val_06_07 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_08_09_OFFSET:
        begin
          csr_reg_block.lvl_val_08_09 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_10_11_OFFSET:
        begin
          csr_reg_block.lvl_val_10_11 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_12_13_OFFSET:
        begin
          csr_reg_block.lvl_val_12_13 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_14_15_OFFSET:
        begin
          csr_reg_block.lvl_val_14_15 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_16_17_OFFSET:
        begin
          csr_reg_block.lvl_val_16_17 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_18_19_OFFSET:
        begin
          csr_reg_block.lvl_val_18_19 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_20_21_OFFSET:
        begin
          csr_reg_block.lvl_val_20_21 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_22_23_OFFSET:
        begin
          csr_reg_block.lvl_val_22_23 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_24_25_OFFSET:
        begin
          csr_reg_block.lvl_val_24_25 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_26_27_OFFSET:
        begin
          csr_reg_block.lvl_val_26_27 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_28_29_OFFSET:
        begin
          csr_reg_block.lvl_val_28_29 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        CSR_REG_BLOCK_LVL_VAL_30_31_OFFSET:
        begin
          csr_reg_block.lvl_val_30_31 <= csr_writedata;
          csr_response_r              <= 'd0;
        end

        default:
        begin
          csr_response_r  <= 'd3; // invalid address, issue DECERR response
        end
      endcase
    end
  end
end

endmodule
