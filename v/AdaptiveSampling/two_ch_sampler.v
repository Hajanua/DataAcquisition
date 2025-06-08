module two_ch_sampler (
	
	input wire clk,
	input wire reset,
	input wire [9:0] sample_target_A,
	input wire [9:0] sample_target_B,
   input wire [13:0] data_in_A,
	input wire [13:0] data_in_B,
	
	input wire [9:0] read_index,                      
   
	output wire [13:0] data_out_A,                    
   output wire [13:0] data_out_B,                    
	
   output wire done_A,
	output wire done_B
	
	);
	
	
	sampler samp_A (
    .clk(clk),                                 // GANTI
    .reset(reset),                             // GANTI
    .sample_target(sample_target_A),
    .data_in(data_in_A),                       // GANTI
    .done(done_A),
    .read_index(read_index),
    .data_out(data_out_A)
);

sampler samp_B (
    .clk(clk),
    .reset(reset),
    .sample_target(sample_target_B),
    .data_in(data_in_B),
    .done(done_B),
    .read_index(read_index),
    .data_out(data_out_B)
);
                         
		
endmodule