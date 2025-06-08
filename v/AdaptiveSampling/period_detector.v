// ============================
// Module: period_detector.v
// ============================
module period_detector (
    input wire clk,
    input wire reset,
    input wire [13:0] signal_in,
    output reg [31:0] period
);

    parameter THRESHOLD = 14'd8192;
    reg [31:0] counter = 0;
    reg [31:0] last_peak_time = 0;
    reg [31:0] current_time = 0;

    reg above_thresh = 0, prev_above_thresh = 0;

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            counter <= 0;
				period <= 0;
            prev_above_thresh <= 0;
            above_thresh <= 0;
        end else begin
            counter <= counter + 1;
            prev_above_thresh <= above_thresh;
				above_thresh <= (signal_in > THRESHOLD);

            if (!prev_above_thresh && above_thresh) begin
					 period <= counter;
                counter <= 0;
            end
        end
    end
endmodule

