`timescale 1ps/1ps
module AND(
    input a,
    input b,
    output reg s
);

always @* begin
    s <= a & b;
end  
endmodule