module two_ch_adaptive_scaler (
	
	input wire [31:0] period_A,
	input wire [31:0] period_B,
	
	output reg [9:0] sample_target_A,
	output reg [9:0] sample_target_B
	
	);
	
	adaptive_scaler scale_A (
	
		.periode(period_A),
		.sample_target(sample_target_A)
		
		);
		
	adaptive_scaler scale_B (
	
		.periode(period_B),
		.sample_target(sample_target_B)
		
		);
	
endmodule	
		