//--- analog to digital converter capture and sync

module SYNC_DATA (

	input AD_DCO, 
	input SYS_CLK, 
	input RESET_N,
	input [13:0] DATA,
  
	output reg [13:0] DATA1

	); 

	reg [13:0] DATA_TEMP; 

	always @ (negedge RESET_N or posedge AD_DCO) 
		begin
			if (!RESET_N) begin
				DATA_TEMP	<= 14'd0;
			end
			else begin
				DATA_TEMP	<= DATA ;
			end
		end


//------temp tranform 
	always @ (negedge RESET_N or posedge SYS_CLK) 
		begin
			if (!RESET_N ) begin
				DATA1	<= 14'd0;
			end
			else begin
				DATA1	<= DATA_TEMP;
			end
		end

endmodule 
