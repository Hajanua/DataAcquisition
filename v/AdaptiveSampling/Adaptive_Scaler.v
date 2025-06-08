module adaptive_scaler (
    input wire [31:0] period,
    output reg [9:0] sample_target
);
    always @(*) begin
        if (period <= 20000)
            sample_target = 1000;
        else if (period >= 250000)
            sample_target = 200;
        else
            sample_target = 200 + ((period - 20000) * 800) / (250000 - 20000);
    end
endmodule