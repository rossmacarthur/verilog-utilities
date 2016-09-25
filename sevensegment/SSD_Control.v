module SSD_Control #(N = 4) (
  input clk,               // clock freq of about 750 Hz
  input rst,
  input [N*4-1:0] numbers, // list of 4 bit numbers to display
  output [N-1:0] displays, // the displays (active low)
  output [6:0] segments    // abcdefg segments (active low)
);

reg [6:0] abcdefg [N-1:0];
reg [$clog2(N)+1:0] count;

assign displays =  ~reset ? ~(1'b1 << count) : ~1'b0;
assign segments = abcdefg[count];

always @(posedge clk) count <= (count == N-1) ? 1'b0 : count + 1'b1;
 
generate
for (genvar i = 0; i < N; i = i+1) begin : decoder
  always @(*) begin
    case(numbers[i*4+3:i*4])
      4'h0 : abcdefg[i] <= 7'h01;
      4'h1 : abcdefg[i] <= 7'h4F;
      4'h2 : abcdefg[i] <= 7'h12;
      4'h3 : abcdefg[i] <= 7'h06;
      4'h4 : abcdefg[i] <= 7'h4C;
      4'h5 : abcdefg[i] <= 7'h24;
      4'h6 : abcdefg[i] <= 7'h20;
      4'h7 : abcdefg[i] <= 7'h0F;
      4'h8 : abcdefg[i] <= 7'h00;
      4'h9 : abcdefg[i] <= 7'h04;
      4'hA : abcdefg[i] <= 7'h08;
      4'hB : abcdefg[i] <= 7'h60;
      4'hC : abcdefg[i] <= 7'h31;
      4'hD : abcdefg[i] <= 7'h42;
      4'hE : abcdefg[i] <= 7'h30;
      4'hF : abcdefg[i] <= 7'h38;
    endcase
  end
end 
endgenerate

endmodule
