//switch mode prescaler

module mode_prescaler (

	input wire [2:0] SWITCH,	
	input SYS_CLK,
	input RESET_N,
	
	output reg [6:0] prescaler_value
	
	);
	
	always @ (posedge SYS_CLK or negedge RESET_N) begin
		if (!RESET_N)
			prescaler_value = 7'd1;
		else begin
			case (SWITCH)
				3'b000: prescaler_value = 5; 	//50x prescaler
				3'b001: prescaler_value = 10;	//10x prescaler
				3'b010: prescaler_value = 15;	//25x prescaler
				3'b011: prescaler_value = 20;	//20x prescaler
				3'b100: prescaler_value = 25;	//25x prescaler
				3'b101: prescaler_value = 50;	//50x prescaler
				3'b110: prescaler_value = 75;	//75x prescaler
				3'b111: prescaler_value = 100;	//100x prescaler
			endcase
		end
	end
	
endmodule