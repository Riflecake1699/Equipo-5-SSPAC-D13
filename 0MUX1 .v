`timescale 1ns/1ns

module Mux_01(
    input [31:0]Me,
    input [31:0]Me1,
    input Me2,
    output reg Ms
);

always @*
case (Me2)
    0:
       Ms <= Me;
    1:
       Ms <= Me1 
endcase
endmodule
// multiplexor de 32 bits, y otro deve de ser de 5 bits, que esta localizado en entrada de 
//banco de registro


//