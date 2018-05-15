
module fir_front_end
#(

)
(
  /* Common IF */
  input  wire        reset,
  input  wire        clock,
  /* Input data IF */
  input  wire [15:0] in_lvl_gen_value,
  input  wire      in_lvl_gen_valid,
  input  wire [15:0] in_ram_data_value,
  input  wire      in_ram_data_valid,
  input  wire [15:0] in_fir_out_value,
  input  wire      in_fir_out_valid,
  output wire      in_fir_out_ready,
  /* FIR IF */
  // TODO:
  output wire [15:0] fir_data,
  output wire      fir_valid,
  input  wire      fir_ready,
  /* Iteration controler IF */
  input  wire [ 1:0] iter_input_mux, // 2 -> RAM content, 1 -> lvl generator output, 0 -> FIR output
  input  wire      iter_input_enable
);

always_ff @(posedge clock)
begin
  if(reset)
  begin

  end
  else
  begin

  end
end

endmodule
