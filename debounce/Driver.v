module Driver(
    input CLK_100M,
    input BTNC,
    output reg [3:0] LDs
);

wire BTNC_d;
always @(posedge BTNC_d) LDs <= LDs + 1'b1;

// Connect up module
Debounce DebounceBTNC (
    .clk       ( CLK_100M ), // input
    .noisy     ( BTNC     ), // input
    .debounced ( BTNC_d   )  // output
);

endmodule
