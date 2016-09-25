module Driver (
  input CLK_100M, 
  input TXD, 
  input BTNC, 
  input SW15,
  input [7:0] SWs,
  output RXD,
  output [7:0] LDs
);

// Divide clocks to 16*62.5 kHz and 62.5 kHz
reg CLK_Receiver;
reg CLK_Transmitter;
reg [6:0] counterR;
reg [3:0] counterT;
always @(posedge CLK_100M) begin
  if (counterR == 99) begin
    counterR <= 0;
    CLK_Receiver <= 1;
    if (&counterT) CLK_Transmitter <= 1;
    else           CLK_Transmitter <= 0;
    counterT <= counterT + 1'b1;
  end else begin
    counterR <= counterR + 1'b1;
    CLK_Receiver <= 0;
  end
end

// Detect positive edge of button press
wire start;
wire BTNC_d;
reg  BTNC_d_pe;
assign start = ~BTNC_d_pe & BTNC_d;
always @(posedge CLK_Transmitter) BTNC_d_pe <= BTNC_d;

// Connect up modules
Debounce DebounceBTNC (
  .clk       ( CLK_100M ), // input
  .noisy     ( BTNC     ), // input
  .debounced ( BTNC_d   )  // output
);

UART_TX UART_T (
  .clk   ( CLK_Transmitter ), // input
  .start ( start           ), // input
  .data  ( SWs             ), // input [7:0]
//.busy  (                 ), // output
  .TX    ( RXD             )  // output
);

UART_RX UART_R (
  .clk    ( CLK_Receiver ), // input 
  .rst    ( SW15         ), // input
  .RX     ( TXD          ), // input
//.busy   (              ), // output
  .data   ( LDs          )  // output [7:0]
);

endmodule
