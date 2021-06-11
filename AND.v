`timescale 1ns/1ns
module AND(
    input a,
    input b,
    output reg s
);

assign s = a & b;
/*always @* begin
    s = a & b;
end*/  
endmodule