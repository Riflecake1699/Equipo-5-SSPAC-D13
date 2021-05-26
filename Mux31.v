`timescale 1ns/1ns

module Mux31(
    input [31:0]E,
    input [31:0]E1,
    input E2,
    output reg [31:0]Es
);

always @*
case (E2)
    0:
       Es = E;
    1:
       Es = E1;
endcase
endmodule

