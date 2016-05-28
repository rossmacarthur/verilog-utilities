module Driver (
    input CLK_100M,
    output [7:0] displays,
    output [6:0] segments
);

// Something to display
wire [31:0] numbers;
assign numbers = { 4'h0, 4'h1, 4'h3, 4'h0, 4'h4, 4'h5, 4'h0, 4'hB }; //0x0130450B

// Divide clock to 763 Hz
reg CLK_SSD;
reg [16:0] counter;
always @(posedge CLK_100M) begin
    counter <= counter + 1'b1;
    CLK_SSD <= &counter ? 1'b1 : 1'b0;
end

// Connect up module
SSD_Control #(8) SSD_C(
    .clk      ( CLK_SSD  ), // input 
  //.reset    (          ), // input
    .numbers  ( numbers  ), // input [31:0]
    .displays ( displays ), // output [7:0]
    .segments ( segments )  // output [6:0]
);

endmodule
