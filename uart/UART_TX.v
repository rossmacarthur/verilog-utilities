module UART_TX (
    input clk,        // baudrate
    input start,      // pulse line to transmit
    input [7:0] data, // data to transmit 
    output reg busy,  // high when transmitting
    output reg TX     // UART transmit line
);

wire [9:0] datafill;
reg  [3:0] index;
assign datafill = {1'b1, data[7:0], 1'b0};

always @(posedge clk) begin
    if (~busy & start) busy <= 1;
    if (busy) begin
        TX <= datafill[index];
        if (index < 9) 
            index <= index + 1'b1;
        else begin
            busy <= 0;
            index <= 0;
        end
    end else TX <= 1;
end

endmodule
