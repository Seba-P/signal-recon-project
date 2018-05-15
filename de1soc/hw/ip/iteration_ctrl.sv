
module iteration_ctrl
#(

)
(
	/* Common IF */
	input  wire        reset,                  //    reset.reset
	input  wire        clock,                  //    clock.clk
	/* Lvl generator IF */
	input  wire 	   lvl_gen_valid,
	// output wire 	   lvl_gen_ready,
	/* Sample dispatcher IF */
	output wire 	   disp_ready,
	/* Buffer controlers IF */
	output wire 	   buff_input_mux, 	// 1 -> lvl generator output, 0 -> FIR output
	output wire 	   buff_signal_enable,
	output wire 	   buff_limits_enable,
	/* FIR front-end IF */
	output wire [ 1:0] fir_input_mux, 	// 1 -> lvl generator output, 0 -> FIR output
	output wire 	   fir_input_enable
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
