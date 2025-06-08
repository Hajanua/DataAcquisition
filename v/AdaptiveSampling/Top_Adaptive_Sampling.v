// ============================
// Top Module: top_adaptive_acquisition.v
// ============================

module top_adaptive_acquisition (
    input SYS_CLK,
    input RESET_N,
    input [13:0] ADC_DATA,
    output wire [13:0] BUFFER [0:1023],
    output wire BUFFER_READY
);
    wire [31:0] period;
    wire [9:0] sample_target;

    period_detector pd (
        .clk(SYS_CLK),
        .reset(RESET_N),
        .signal_in(ADC_DATA),
        .period(period)
    );

    adaptive_scaler scale (
        .period(period),
        .sample_target(sample_target)
    );

    sampler samp (
        .clk(SYS_CLK),
        .reset(RESET_N),
        .sample_target(sample_target),
        .data_in(ADC_DATA),
        .buffer(BUFFER),
        .done(BUFFER_READY)
    );
endmodule
