module clock_gen
(
	output logic clock,
	output logic reset
);

initial
begin
	clock = 1'b0;
	reset = 1'b1;

	#100 reset = 1'b0;
end

initial 
	forever
		#5 clock = ~clock;

endmodule // clock_gen

module sample2lvl_converter_tb;

/* Common IF */
logic        reset;
logic        clock;
/* SGDMA IF */
logic [15:0] in_data;
logic        in_ready;
logic        in_valid;
/* CSR IF */
logic        csr_address;
logic        csr_read;
logic [31:0] csr_readdata;
logic        csr_waitrequest;
logic        csr_write;
logic [31:0] csr_writedata;
logic [ 3:0] csr_byteenable;
logic        csr_chipselect;
/* FIR IF */
logic [15:0] fir_data;
logic        fir_ready;
logic        fir_valid;
/* Sample buffer IF */
logic [ 8:0] ram_sample_address;
logic        ram_sample_chipselect;
logic        ram_sample_read;
logic        ram_sample_write;
logic [15:0] ram_sample_readdata;
logic [15:0] ram_sample_writedata;
logic [ 1:0] ram_sample_byteenable;
logic        ram_sample_waitrequest;
/* Limits buffer IF */
logic [ 9:0] ram_limits_address;
logic        ram_limits_chipselect;
logic        ram_limits_read;
logic        ram_limits_write;
logic [31:0] ram_limits_readdata;
logic [31:0] ram_limits_writedata;
logic [ 3:0] ram_limits_byteenable;
logic        ram_limits_waitrequest;

localparam MAX_SAMPLES_IN_RAM 	= 255;
localparam LVLS_NUM 			= 20;
localparam LVL_RESET_VALUE 	 	= 9;
localparam ITER_NUM 	 		= 4;

clock_gen clk_rst_gen
(
	.clock 	(clock),
	.reset 	(reset)
);

sample2lvl_converter
#(
	.MAX_SAMPLES_IN_RAM	(MAX_SAMPLES_IN_RAM),
	.LVLS_NUM			(LVLS_NUM),
	.LVL_RESET_VALUE	(LVL_RESET_VALUE),
	.ITER_NUM			(ITER_NUM)
) DUT
(
	/* Common IF */
	.reset 		(reset),
	.clk 		(clock),
	/* SGDMA IF */
	.in_data 	(in_data),
	.in_ready 	(in_ready),
	.in_valid 	(in_valid),
	/* CSR IF */
	.csr_address 		(csr_address),
	.csr_read 			(csr_read),
	.csr_readdata 		(csr_readdata),
	.csr_waitrequest	(csr_waitrequest),
	.csr_write 			(csr_write),
	.csr_writedata 		(csr_writedata),
	.csr_byteenable 	(csr_byteenable),
	.csr_chipselect 	(csr_chipselect),
	/* FIR IF */
	.fir_data 		(fir_data),
	.fir_ready 		(fir_ready),
	.fir_valid 		(fir_valid),
	/* Sample buffer IF */
	.ram_sample_address 	(ram_sample_address),
	.ram_sample_chipselect 	(ram_sample_chipselect),
	.ram_sample_read 		(ram_sample_read),
	.ram_sample_write 		(ram_sample_write),
	.ram_sample_readdata 	(ram_sample_readdata),
	.ram_sample_writedata 	(ram_sample_writedata),
	.ram_sample_byteenable 	(ram_sample_byteenable),
	.ram_sample_waitrequest (ram_sample_waitrequest),
	/* Limits buffer IF */
	.ram_limits_address 	(ram_limits_address),
	.ram_limits_chipselect 	(ram_limits_chipselect),
	.ram_limits_read 		(ram_limits_read),
	.ram_limits_write 		(ram_limits_write),
	.ram_limits_readdata 	(ram_limits_readdata),
	.ram_limits_writedata 	(ram_limits_writedata),
	.ram_limits_byteenable 	(ram_limits_byteenable),
	.ram_limits_waitrequest (ram_limits_waitrequest)
);

typedef struct packed
{
	bit 		lvl_cross_dir;
	bit [14:0]	timestamp;
} LVL_CROSS_SAMPLE_T;

LVL_CROSS_SAMPLE_T sample;
logic [4:0] curr_lvl;
int total_duration, iter, iter_sample;

logic [15:0] recv_fir_data[MAX_SAMPLES_IN_RAM];

bit [0:31][15:0] lvls_values = 
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

task send_sample(LVL_CROSS_SAMPLE_T sample);
	bit [15:0] lvls_step;
	bit [15:0] expected_value;
	int duration;

	curr_lvl = sample.lvl_cross_dir ? curr_lvl + (curr_lvl != LVLS_NUM-1) : curr_lvl - (curr_lvl != 0);
	lvls_step = sample.lvl_cross_dir ? 	lvls_values[curr_lvl+(curr_lvl != LVLS_NUM-1)] - lvls_values[curr_lvl] : 
										lvls_values[curr_lvl] - lvls_values[curr_lvl-(curr_lvl != 0)];
	expected_value = lvls_values[curr_lvl] + { lvls_step[15], lvls_step[15:1] };

	in_valid 	= 1'b1;
	in_data 	= sample;
	if(!in_ready)
		@(posedge in_ready);
	// test what happens when there is always a pending sample
	fir_ready = 1'b1;

	// duration 	= 0;
	for(duration = 0; duration < sample.timestamp; duration++)
	begin
		@(posedge clock);
		if(!fir_valid)
			@(posedge fir_valid);

		recv_fir_data[total_duration++%MAX_SAMPLES_IN_RAM] = fir_data;
		if(fir_data != expected_value)
			$display("Invalid output data (0x%x/0x%x) @ sample #%0d/%0d!", fir_data, expected_value, duration, total_duration-1);
		
		if((total_duration % MAX_SAMPLES_IN_RAM) == 0)
		begin
			while(iter)
			begin
				for(iter_sample = 0; iter_sample < MAX_SAMPLES_IN_RAM; iter_sample++)
				begin
					@(posedge clock);
					if(!fir_valid)
						@(posedge fir_valid);
					if(fir_data != recv_fir_data[iter_sample])
						$display("Invalid output data (0x%x/0x%x) @ sample #%0d(RAM))!", fir_data, expected_value, iter_sample);
				end
				iter--;
			end
		end
	end

endtask : send_sample

initial
begin
	in_data					= '0;
	in_valid				= '0;
	csr_address				= '0;
	csr_read				= '0;
	csr_write				= '0;
	csr_writedata			= '0;
	csr_byteenable			= '0;
	csr_chipselect			= '0;
	fir_ready				= '0;
	ram_sample_readdata		= '0;
	ram_sample_waitrequest	= '0;
	ram_limits_readdata		= '0;
	ram_limits_waitrequest  = '0;
end

always @(posedge clock)
	ram_sample_readdata = ram_sample_chipselect & ram_sample_read ? recv_fir_data[ram_sample_address[8:1]] : 16'hZZZZ;

initial
begin
	#150 curr_lvl 	= LVL_RESET_VALUE;
	total_duration	= 0;
	iter 			= ITER_NUM;
	iter_sample 	= 0;

	/* Verify lvls generation */
	repeat(LVLS_NUM/2+2)
	begin
		sample = {1'b0, 15'd5};
		send_sample(sample);
	end

	repeat(LVLS_NUM+1)
	begin
		sample = {1'b1, 15'd5};
		send_sample(sample);
	end

	/* Verify iterative processing */
	curr_lvl 		= LVL_RESET_VALUE;
	total_duration	= 0;
	iter 			= ITER_NUM;
	iter_sample 	= 0;

	# 20 reset 	= 1'b1;
	#100 reset 	= 1'b0;

	sample = {1'b1, 15'd400};
	send_sample(sample);

	sample = {1'b1, 15'd40};
	send_sample(sample);
	in_valid = 1'b0;

	# 50 $stop;
end

endmodule // sample2lvl_converter_tb
