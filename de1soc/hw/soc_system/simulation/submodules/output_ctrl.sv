
module output_ctrl
#(
  parameter USE_COMB_LOGIC = 0
)
(
  /* Common IF */
  input  wire        reset,               //   reset.reset
  input  wire        clock,               //   clock.clk
  /* Hard limiter IF */
  input  wire [15:0] limiter_data,        // limiter.data
  input  wire        limiter_valid,       //        .valid
  output wire        limiter_ready,       //        .ready
  /* Iteration controller IF */
  input  wire        iter_output_enable,  //    iter.new_signal
  /* Output IF */
  output wire [15:0] out_data,            //     out.data
  output wire        out_valid,           //        .valid
  input  wire        out_ready            //        .ready
);

generate
  if(USE_COMB_LOGIC == 0)
  begin
    reg  [15:0] out_data_r;
    reg         out_valid_r; // is next pipeline stage needed?

    assign limiter_ready  = ~reset & out_ready; // ?
    assign out_data       = out_data_r;
    assign out_valid      = out_valid_r;

    always_ff @(posedge clock)
    begin
      if(reset)
      begin
        out_data_r  <= '0;
        out_valid_r <= '0;
      end
      else
      begin
        out_data_r  <= limiter_data;
        out_valid_r <= limiter_valid & iter_output_enable;
      end
    end
  end
  else
  begin
    assign limiter_ready  = ~reset & out_ready; // ?
    assign out_data       = ~reset & limiter_data;
    assign out_valid      = ~reset & limiter_valid & iter_output_enable;

    /*
    reg         limiter_ready_r;
    reg  [15:0] out_data_r;
    reg         out_valid_r;

    assign limiter_ready  = limiter_ready_r;
    assign out_data       = out_data_r;
    assign out_valid      = out_valid_r;

    always_comb
    begin
      if(reset)
      begin
        limiter_ready_r  = '0; // ?
        out_data_r       = '0;
        out_valid_r      = '0;
      end
      else
      begin
        limiter_ready_r  = out_ready; // ?
        out_data_r       = limiter_data;
        out_valid_r      = limiter_valid & iter_output_enable;
      end
    end
    */
  end
endgenerate

endmodule
