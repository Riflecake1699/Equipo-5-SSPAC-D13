`timescale 1ns/1ns

module Mux_01(
    input [31:0]Me,
    input [31:0]Me1,
    input Me2,
    output reg[31:0]Ms
);

always @*
case (Me2)
    0:
       Ms <= Me;
    1:
       Ms <= Me1;
endcase
endmodule
