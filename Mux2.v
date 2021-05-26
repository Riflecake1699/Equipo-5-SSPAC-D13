`timescale 1ps/1ps
module Mux2(
    input [31:0]E1,
    input [31:0]E2,
    input sel,
    output reg [31:0]S
);
initial begin
    S <= 32'd0;
end
always @* 
begin
    case (sel)
        1:
        begin
            S<=E1;    
        end 
        0:
        begin
            S<=E2;
        end
    endcase    
end
endmodule