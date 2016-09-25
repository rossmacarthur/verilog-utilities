// 1024 x 768 VGA -- see http://tinyvga.com/vga-timing/1024x768@60Hz
module VGA_Control (
  input clk,                // pixel clock of 65 MHz
  input rst,
  output reg HS,            // horizontal sync
  output reg VS,            // vertical sync 
  output reg [10:0] countX, // current X position on screen
  output reg [9:0] countY   // current Y position on screen
);

always @(posedge clk) begin
  if(rst) begin
    countX <= 0;
    countY <= 0;
    HS <= 1; 
    VS <= 1;
  end else begin
    // Count higher than the display area so that it includes front porch,
    // back porch and sync pulse time
    if (countX == 1343) begin
      countX <= 0;
      if (countY == 805) countY <= 0;
      else countY <= countY + 1'b1;
    end else countX <= countX + 1'b1;
    // Pulse horizontal syncs
    if      (countX == 1047) HS <= 0; // start sync-pulse of 96
    else if (countX == 1143) HS <= 1; // end sync-pulse of 96
    // Pulse verticle syncs 
    if      (countY == 770) VS <= 0; // start sync-pulse of 2
    else if (countY == 772) VS <= 1; // end sync-pulse of 2
  end
end

endmodule
