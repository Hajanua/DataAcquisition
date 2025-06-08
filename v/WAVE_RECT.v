module WAVE_RECT (
 
	input CLK_100, 
	input RESET_N, 
	input [13:0] A_D,
  
	output reg 	[13:0] P_D

	); 
 
	always @ (negedge RESET_N or posedge CLK_100) begin
		if (!RESET_N) begin 
			P_D <= 0 ; 
		end 
	
		else begin 
			if (A_D[13]) 
				P_D <= 0 - A_D; 
			else 
				P_D <= A_D;
		end
	end 

endmodule 