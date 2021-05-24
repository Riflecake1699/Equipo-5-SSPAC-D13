`timescale 1ns/1ns

module ADDALU(
    input [31:0]EAALU,
    input [31:0]EAALU1, 
    output reg[31:0]SAALU 
);

always @*
begin
  SAALU = EAALU + EAALU1;
end

endmodule