// SPI interface controller for the PmodDA4
// Author: Ross MacArthur (https://github.com/rossmacarthur)
// Description:
// - Using an FSM, continuously outputs the input value to the PmodDA4
// - Sets up PmodDA4 to use internal reference voltage
// - If the PmodDA4 cycled this module needs to be reset

module PmodDA4_Control (
  input clk,
  input rst,
  input [11:0] value, // 12-bit unsigned value to send to DAC
  output reg SYNC,    // SYNC: pin 1 on Pmod connector
  output DATA,        // DATA: pin 2 on Pmod connector
  output SCLK         // SCLK: pin 4 on Pmod connector 
);

localparam stIDLE = 3'd0,
           stINIT_irv = 3'd1,
           stTRAN_irv = 3'd2,
           stINIT = 3'd3,
           stTRAN = 3'd4;

wire [31:0] temp;
reg [2:0] state;
reg [4:0] index;

assign temp = ((state == stINIT_irv) || (state == stTRAN_irv)) ? {8'h8, 24'h1} : {12'h3F, value, 8'h0};
assign DATA = temp[index];
assign SCLK = clk;

always @(negedge clk) begin
  if (rst) begin
    state <= stIDLE;
    index <= 5'd31;
    SYNC <= 1'b0;
  end else begin
    case (state)
      stIDLE: begin
        state <= stINIT_irv;
        index <= 5'd31;
        SYNC <= 1'b1;
      end
      stINIT_irv: begin
        state <= stTRAN_irv;
        index <= 5'd31;
        SYNC <= 1'b0;
      end
      stTRAN_irv: begin
        state <= (index == 0) ? stINIT : stTRAN_irv;
        index <= index - 1'b1;
        SYNC <= (index == 0) ? 1'b1 : 1'b0;
      end
      stINIT: begin
        state <= stTRAN;
        index <= 5'd31;
        SYNC <= 1'b0;
      end
      stTRAN: begin
        state <= (index == 0) ? stINIT : stTRAN;
        index <= index - 1'b1;
        SYNC <= (index == 0) ? 1'b1 : 1'b0;
      end
      default: begin
        state <= stIDLE;
        index <= 5'd31;
        SYNC <= 1'b1;
      end 
    endcase
  end
end

endmodule