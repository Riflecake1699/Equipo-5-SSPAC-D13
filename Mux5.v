`timescale 1ns/1ns

module Mux5(
    input [4:0]e,
    input [4:0]e1,
    input e2,
    output reg[4:0]es
);

always @*
case (e2)
    0:
       es = e;
    1:
       es = e1;
endcase
endmodule
