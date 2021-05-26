`timescale 1ps/1ps
module Mux5bit(
    input [4:0]E1,
    input [4:0]E2,
    input sel,
    output reg[4:0]S
);

always @* begin
    case (sel)
        0:
        begin
            S <= E1;
        end
        1:
        begin
            S <= E2;
        end
    endcase
end

endmodule