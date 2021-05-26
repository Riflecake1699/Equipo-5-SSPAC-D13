`timescale 1ps/1ps
module ShiftL(
    input [31:0]E,
    output reg [31:0]S
);
always @* begin
    S <= E<<2;
end    
endmodule