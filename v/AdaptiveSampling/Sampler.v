module sampler (
    input wire clk,
    input wire reset,
    input wire [9:0] sample_target,
    input wire [13:0] data_in,
    output reg [13:0] buffer,
    output reg done
);

    reg [9:0] sample_index;

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            sample_index <= 0;
            done <= 0;
        end else begin
            if (sample_index < sample_target) begin
                buffer[sample_index] <= data_in;
                sample_index <= sample_index + 1;
                done <= 0;
            end else begin
                done <= 1;
                sample_index <= 0;
            end
        end
    end
endmodule