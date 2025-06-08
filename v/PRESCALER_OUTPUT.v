module PRESCALER_OUTPUT(
   
	input wire SYS_CLK,           // Clock dari ADC
   input wire RESET_N,               // Reset
   input wire [13:0] DATA_IN_A, // Data dari ADC
	input wire [13:0] DATA_IN_B, // Data dari ADC
	input wire [6:0] prescaler_value,

	output reg [13:0] DATA_OUT_A,   // Data yang sudah diprescale
   output reg [13:0] DATA_OUT_B,   // Data yang sudah diprescale
   output reg DATA_VALID         // Flag bahwa data_out valid
	
	);
	
	reg [6:0] counter;

   always @ (posedge SYS_CLK or negedge RESET_N) begin
		if (!RESET_N) begin
			counter    <= 0;
         DATA_OUT_A <= 0;
			DATA_OUT_B <= 0;
         DATA_VALID <= 0;
		end 
		
		else begin
			if (counter == (prescaler_value - 1)) begin
				counter 	  <= 0;
				DATA_OUT_A <= DATA_IN_A;
				DATA_OUT_B <= DATA_IN_B;
				DATA_VALID <= 1;
         end 
			
			else begin
				counter <= counter + 1;
            DATA_VALID <= 0;
         end
		
		end
	
	end

endmodule
