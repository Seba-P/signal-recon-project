
module fir_driver
#(
  parameter USE_COMB_LOGIC = 0
)
(
  /* Common IF */
  input  wire        reset,             //   reset.reset
  input  wire        clock,             //   clock.clk
  /* Lvl generator IF */
  input  wire [15:0] lvl_gen_data,      // lvl_gen.data
  input  wire        lvl_gen_valid,     //        .valid
  /* Signal buffer controller IF */
  input  wire [15:0] sigbuff_data,      // sigbuff.data
  input  wire        sigbuff_valid,     //        .valid
  /* Iteration controller IF */
  input  wire        iter_input_mux,    //    iter.new_signal
  input  wire        iter_input_enable, //        .new_signal_1
  output wire        iter_ready,        //        .new_signal_2
  /* FIR filter IF */
  output wire [15:0] fir_data,          //     fir.data
  output wire        fir_valid,         //        .valid
  output wire [ 1:0] fir_error,         //        .error
  input  wire        fir_ready          //        .ready
);

generate
  if(USE_COMB_LOGIC == 0)
  begin
    reg  [15:0] fir_data_r;
    reg         fir_valid_r;

    assign iter_ready = fir_ready;
    assign fir_data   = fir_data_r;
    assign fir_valid  = fir_valid_r & iter_input_enable;
    assign fir_error  = '0; // not used

    always_ff @(posedge clock)
    begin
      if(reset)
      begin
        fir_data_r  <= '0;
        fir_valid_r <= '0;
      end
      else
      begin
        fir_data_r  <= iter_input_mux ? lvl_gen_data : sigbuff_data;
        fir_valid_r <= iter_input_mux ? lvl_gen_valid : sigbuff_valid;
      end
    end
  end
  else
  begin
    assign iter_ready = fir_ready;
    assign fir_data   = ~reset & (iter_input_mux ? lvl_gen_data : sigbuff_data);
    assign fir_valid  = ~reset & (iter_input_mux ? lvl_gen_valid : sigbuff_valid) & iter_input_enable;
    assign fir_error  = '0; // not used

    /*
    reg  [15:0] fir_data_r;
    reg         fir_valid_r;

    assign iter_ready = fir_ready;
    assign fir_data   = fir_data_r;
    assign fir_valid  = fir_valid_r;
    always_comb
    begin
      if(reset)
      begin
        fir_data_r  = '0;
        fir_valid_r = '0;
      end
      else
      begin
        fir_data_r  = iter_input_mux ? lvl_gen_data : sigbuff_data;
        fir_valid_r = (iter_input_mux ? lvl_gen_valid : sigbuff_valid) & iter_input_enable;
      end
    end
    */
  end
endgenerate

endmodule
