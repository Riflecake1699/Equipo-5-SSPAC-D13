`timescale 1ns/1ns
module Mux(
    input [31:0]E1,
    input [31:0]E2,
    input sel,
    output reg [31:0]S
);
/*initial begin
    S<=31'd0;
end*/
always @* 
begin
    case (sel)
        0:
        begin
            S=E1;    
        end 
        1:
        begin
            S=E2;
        end
    endcase    
end
endmodule