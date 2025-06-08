module DET_SIGNAL  ( 

	input [13:0] PD_A,	  
	input [13:0] PD_B,
 
	output HAVE_A,
	output HAVE_B
 
	); 

	parameter TH  = 8192/5; 
 
	assign HAVE_A = (PD_A > TH) ? 1 : 0; 
	assign HAVE_B = (PD_B > TH) ? 1 : 0; 
		
endmodule 
	