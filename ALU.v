`timescale 1ns/1ns
module ALU(
    input [31:0]OP1,
    input [31:0]OP2,
    input [3:0]sel,
    output reg zf,
    output reg [31:0]Res
);
always @* begin
    case (sel)
        4'b0000:
        begin
            Res <= OP1 & OP2;    
        end
        4'b0001:
        begin
            Res <= OP1 | OP2;
        end
        4'b0010:
        begin
            Res <= OP1 + OP2;
        end
        4'b0011:
        begin
            Res <= OP1*OP2;
        end
        4'b0100:
        begin
            Res <= OP1/OP2;
        end
        4'b0101:
        begin
            Res <= OP1^OP2;
        end
        4'b0110:
        begin
            Res <= OP1-OP2;
        end
        4'b0111:
        begin
            Res <= (OP1 < OP2)?1:0;
        end
        4'b1000:
        begin
            Res <= OP1 << 0; 
        end
        default:
        begin
            Res <= OP1 + OP2; 
        end 
    endcase
    zf <= (Res)?0:1;
end
endmodule