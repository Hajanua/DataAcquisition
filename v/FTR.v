module FTR (

	input CLK, 
	input DI, 
	
	output reg DO 
	
	);

	reg [31:0] T;
	
	always @(posedge CLK ) begin 
		T[31:0]  <= { T[30:0], DI } ;    
		if ( T[31:0]==32'hffffffff) 
			DO <=1;
		else if ( T[31:0]==0 ) 
			DO <=0;
	end 
 
endmodule 