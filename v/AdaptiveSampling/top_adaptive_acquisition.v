// ============================
// Top Module: top_adaptive_acquisition.v
// ============================

module top_adaptive_acquisition (
    input SYS_CLK,
    input RESET_N,
    input [13:0] ADC_DATA_A,
	 input [13:0] ADC_DATA_B,
//  output wire [13:0] BUFFER_A [0:1023],
//	 output wire [13:0] BUFFER_B [0:1023],
    output wire buffer_ready_A,
	 output wire buffer_ready_B,
	 
	 input wire [9:0] read_index,                    // Tambahan
    output wire [13:0] sampled_data_A,             // Tambahan
    output wire [13:0] sampled_data_B            // Tambahan
);
    wire [31:0] period;
    wire [9:0] sample_target;
	 
	 reg [13:0] BUFFER_A [0:1023];  // ✅ buffer jadi variabel internal
	 reg [13:0] BUFFER_B [0:1023];  // ✅ buffer jadi variabel internal

    two_ch_period_detector pd (
       .clk(SYS_CLK),
       .reset(RESET_N),
       .signal_in_A(ADC_DATA_A),
		 .signal_in_B(ADC_DATA_B),
       .period_A(period_A),
		 .period_B(period_B)
    );

    two_ch_adaptive_scaler scale (
       .period_A(period_A),
		 .period_B(period_B),
       .sample_target_A(sample_target_A),
		 .sample_target_B(sample_target_B)
		 );
	 

    two_ch_sampler samp (
		.clk(SYS_CLK),
		.reset(RESET_N),
		.sample_target_A(sample_target_A),
		.sample_target_B(sample_target_B),
		.data_in_A(ADC_DATA_A),
		.data_in_B(ADC_DATA_B),
		.done_A(buffer_ready_A),
		.done_B(buffer_ready_B),
		.read_index(read_index),
		.data_out_A(sampled_data_A),
		.data_out_B(sampled_data_B)
		);
endmodule
