module Driver (
  input CLK_100M,
  output HS,
  output VS,
  output [11:0] RGB
);

// Basic setup
wire CLK_VGA; // need 65.0 MHz clock for 1024 x 768 VGA
wire display;
wire [10:0] countX;
wire [9:0] countY;
reg [11:0] pixel;
assign display = countX < 1024 && countY < 768;
assign RGB = display ? pixel : 12'h000; // set pixel only when in display area

// Display a nicely colored spectrum
wire [2:0] spectrum;
wire [3:0] shade;
assign spectrum = countY[9:7];
assign shade = countY[6:3];
always @(posedge CLK_VGA)
  case(spectrum)
    3'b000  : pixel <=  {  4'hF, shade,  4'h0 };
    3'b001  : pixel <= ~{ shade,  4'h0,  4'hF };
    3'b010  : pixel <=  {  4'h0,  4'hF, shade };
    3'b011  : pixel <= ~{  4'hF, shade,  4'h0 };
    3'b100  : pixel <=  { shade,  4'h0,  4'hF };
    3'b101  : pixel <= ~{  4'h0,  4'hF, shade };
    default : pixel <= 12'hFFF;
  endcase

// Connect up modules
Clock_Generator Clock_G (
  .CLK_IN1  ( CLK_100M ), // input
//.CLK_OUT1 (          ), // output
  .CLK_OUT2 ( CLK_VGA  )  // output
);

VGA_Control VGA_C (
  .clk    ( CLK_VGA ), // input 
//.rst    (         ), // input
  .HS     ( HS      ), // output
  .VS     ( VS      ), // output
  .countX ( countX  ), // output [10:0]
  .countY ( countY  )  // output [9:0]
);

endmodule
