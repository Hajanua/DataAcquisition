module ADC_HIGH_SPEED(

	//ADC-A//
	input [13:0] ADA_D,
	input ADA_DCO,
	input ADA_OR,
	output ADA_CLK_P,
   output ADA_CLK_N,
	output ADA_OE,
	
	//ADC-B//
	input [13:0] ADB_D,
	input ADB_DCO,
	input ADB_OR,
	output ADB_CLK_P,
   output ADB_CLK_N,
	output ADB_OE,
	
	//ADC -> FPGA//
	inout AD_SCLK,
	inout AD_SDIO,
	output ADA_SPI_CS,
	output ADB_SPI_CS,
	
	//FPGA CLOCK
	input FPGA_CLK,
	
	//LED FPGA
	output [1:0] LED,
	
	//KEY
	input [1:0] KEY,
	
	//SWITCH
	input [2:0] SWITCH
	
);	

	//=======================================================
	//  REG/WIRE declarations
	//=======================================================
	wire RESET_N;
	wire SYS_CLK;
	wire PLL_LOCKED;
	wire [13:0]	A2DA_DATA;
	wire [13:0]	A2DB_DATA;
	wire HAVE_A;
	wire HAVE_B;
	wire TIME_OUT ; 

	
	wire [13:0] DATA_OUT_A;
	wire [13:0] DATA_OUT_B;
	wire DATA_VALID;
	wire [13:0] BUFFER_A [0:1023];
	wire [13:0] BUFFER_B [0:1023];
   wire BUFFER_READY_A;
	wire BUFFER_READY_B;
	
	wire [13:0] sampled_data_A;
	wire [13:0] sampled_data_B;

	wire [6:0] perscale_value;
	
	reg [9:0] read_index;
	always @(posedge SYS_CLK) begin
		if (!RESET_N) 
			read_index <= 0;
		else if (BUFFER_READY_A) 
			read_index <= read_index + 1;
	end

	//=======================================================
	//  Structural coding
	//=======================================================

	//--DEBUNCE
	FTR disp(
	
		.CLK(SYS_CLK), 
		.DI (&KEY)
	
	); 

	//--LED
	assign LED[0] = HAVE_A; // ---- HAVE SIGNAL : 1 
	assign LED[1] = HAVE_B; // ---- HAVE SIGNAL : 1 

	//--RESET
	assign RESET_N	= &KEY;

	//---assign for ADC control signal
	assign AD_SCLK	= 1;			// (DFS)Data Format Select
	assign AD_SDIO	= 0;		   // (DCS)Duty Cycle Stabilizer Select
	assign ADA_OE = 1'b0;		// enable ADA output
	assign ADA_SPI_CS	= 1'b1;	// disable ADA_SPI_CS (CSB)
	assign ADB_OE = 1'b0;		// enable ADB output
	assign ADB_SPI_CS	= 1'b1;	// disable ADB_SPI_CS (CSB)

	//---ADC CLOCK ---
	assign ADA_CLK_P =  SYS_CLK;
	assign ADA_CLK_N = ~SYS_CLK;
	assign ADB_CLK_P =  SYS_CLK;
	assign ADB_CLK_N = ~SYS_CLK;

	//---PLL  100MHZ 
	PLL pll_inst(
	
		.refclk (FPGA_CLK), 
		.rst (~RESET_N),     
		.outclk_0 (SYS_CLK)
	
	);
		
	//---analog to digital converter capture and sync Channel
	TWO_CH_SYNC tw (
	
		.SYS_CLK (SYS_CLK), 
		.RESET_N (RESET_N),
		.ADA_DCO (ADA_DCO),  	//ADC-A input CLOCK
		.ADB_DCO (ADB_DCO),  	//ADC-B input CLOCK
		.ADA_D (ADA_D),  			//ADC-A input DATA
		.ADB_D (ADB_D),  			//ADC-B input DATA
		.A2DA_DATA (A2DA_DATA),	//Sync ADC-A DATA
		.A2DB_DATA (A2DB_DATA) 	//Sync ADC-B DATA
		
	);

	//---TO do Full wave rectifier / Detect Have Signal
	READ_DET adr (
	
		.RESET_N (RESET_N),
		.CLK_P (SYS_CLK), 
		.SADA_D (A2DA_DATA), //---- ADC-A  input
		.SADB_D (A2DB_DATA), //---- ADC-B  input
		.HAVE_A (HAVE_A), 	//---- HAVE SIGNAL =1
		.HAVE_B (HAVE_B), 	//---- HAVE SIGNAL =1
		.PD_A (),           	//-----Full wave rectifier from ADC-A
		.PD_B ()            	//-----Full wave rectifier from ADC-B
		
	);
	
	mode_prescaler mode_ps (
		.SYS_CLK (SYS_CLK),
		.RESET_N (RESET_N),
		.SWITCH (SWITCH[2:0]),
		.prescaler_value (prescaler_value)
	);
	
	//---Prescaller
	PRESCALER_OUTPUT prescaler (
		.SYS_CLK (SYS_CLK),
		.RESET_N (RESET_N),
		.DATA_IN_A (A2DA_DATA),
		.DATA_IN_B (A2DB_DATA),
		.prescaler_value (prescaler_value),
		.DATA_OUT_A (DATA_OUT_A),
		.DATA_OUT_B (DATA_OUT_B),
		.DATA_VALID (DATA_VALID)
	);
	
	//adaptive
	top_adaptive_acquisition adaptive (
		.SYS_CLK (SYS_CLK),
		.RESET_N (RESET_N),
		.ADC_DATA_A (A2DA_DATA),
		.ADC_DATA_B (A2DB_DATA),
		.read_index(read_index),                 
		.sampled_data_A(sampled_data_A),         
		.sampled_data_B(sampled_data_B),         
		.buffer_ready_A(buffer_ready_A),
		.buffer_ready_B(buffer_ready_B)
	
		);

endmodule
