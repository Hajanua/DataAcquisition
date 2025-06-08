module READ_DET (

	input RESET_N , 
	input CLK_P   , 
   input [13:0]SADA_D,
   input [13:0]SADB_D,
	  
   output [13:0]PD_A,
   output [13:0]PD_B,
   output HAVE_A ,
   output HAVE_B 
  
 ); 
 
	//--------signal detect	
	DET_SIGNAL ( 
		.HAVE_A (HAVE_A),
		.HAVE_B (HAVE_B),
		.PD_A (PD_A),	  
		.PD_B (PD_B)	 
     
	);
 
	//--CHA TWO' TO LINE
	WAVE_RECT chaa (
		  .CLK_100 (CLK_P), 
		  .RESET_N (RESET_N), 
		  .A_D (SADA_D),
		  .P_D (PD_A)	  
	);  
	 
	 //--CHB TWO' TO LINE
	WAVE_RECT chab (
		  .CLK_100 (CLK_P), 
		  .RESET_N (RESET_N), 
		  .A_D (SADB_D),
		  .P_D (PD_B)
	);  

endmodule 