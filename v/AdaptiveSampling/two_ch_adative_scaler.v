module two_ch_adaptive_scaler (
	
	input wire [31:0] period_A,
	input wire [31:0] period_B,
	
	output wire [9:0] sample_target_A,
	output wire [9:0] sample_target_B
	
	);
	
	adaptive_scaler scale_A (
	
		.period(period_A),
		.sample_target(sample_target_A)
		
		);
		
	adaptive_scaler scale_B (
	
		.period(period_B),
		.sample_target(sample_target_B)
		
		);
	
endmodule	
		