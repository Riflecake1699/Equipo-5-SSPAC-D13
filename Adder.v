`timescale 1ps/1ps
module Adder(
    input [31:0]E1,
    input [31:0]E2,
    output reg [31:0]S
);
always @* begin
    S <= E1 + E2;
end    
endmodule