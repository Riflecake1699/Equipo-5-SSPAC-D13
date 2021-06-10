`timescale 1ns/1ns
module Adder(
    input [31:0]E1,
    input [31:0]E2,
    output reg [31:0]S
);
assign S = E1 + E2;
/*always @* begin
    S <= E1 + E2;
end  */
endmodule