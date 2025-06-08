module two_ch_period_detector (

	input wire clk,
   input wire reset,
   input wire [13:0] signal_in_A,
	input wire [13:0] signal_in_B,
   
	output wire [31:0] period_A,
	output wire [31:0] period_B
	
	);
	
	period_detector pd_A (
    .clk(clk),                                 // GANTI
    .reset(reset),                             // GANTI
    .signal_in(signal_in_A),
    .period(period_A)
);

period_detector pd_B (
    .clk(clk),
    .reset(reset),
    .signal_in(signal_in_B),
    .period(period_B)
);

		
endmodule