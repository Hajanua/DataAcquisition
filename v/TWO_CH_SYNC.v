module TWO_CH_SYNC (
 
	input ADA_DCO, 
	input ADB_DCO, 
	input SYS_CLK, 
	input RESET_N,
	input [13:0] ADA_D,
	input [13:0] ADB_D,
 
	output [13:0] A2DA_DATA,
	output [13:0] A2DB_DATA
 
	); 
 
//---analog to digital converter capture and sync Channel A
	SYNC_DATA cha (

		.AD_DCO  (ADA_DCO), 
		.SYS_CLK (SYS_CLK), 
		.RESET_N (RESET_N),
		.DATA    (ADA_D), 
		.DATA1   (A2DA_DATA)
  
	);

//---analog to digital converter capture and syncChannel B
	SYNC_DATA chb (

		.AD_DCO  (ADB_DCO), 
		.SYS_CLK (SYS_CLK), 
		.RESET_N (RESET_N),
		.DATA    (ADB_D), 
		.DATA1   (A2DB_DATA)
  
	);

endmodule 