`timescale 1ps/1ps
module ALUControl(
    input [5:0]Func,
    input [2:0]ALUOp,
    output reg [3:0]sel
);

always @* begin
    case (ALUOp)
        3'b010: 
        begin
            case (Func)
            6'b100000: //ADD
            begin
                sel <= 4'b0010; 
            end 
            6'b100100: //AND
            begin
                sel <= 4'b0000;
            end
            6'b101010: //SLT
            begin
                sel <= 4'b0111;
            end
            6'b100010: //SUB
            begin
                sel <= 4'b0110;
            end
            6'b100101: //OR
            begin
                sel <= 4'b0001;
            end
            6'b000000:
            begin
                sel <= 4'b1000; //NOP
            end
            6'b000010:
            begin
                sel <= 4'0011;
            end
            endcase
        end    
    endcase
end
endmodule