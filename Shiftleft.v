`timescale 1ns/1ns

module Sleft(
    input [31:0]e1,
    output reg [31:0]s1
);

initial 
begin
     s1 =  e1 << 2;   
end
endmodule