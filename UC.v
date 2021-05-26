`timescale 1ps/1ps
module UC(
    input [5:0]OP,
    output reg RegDst,
    output reg Branch,
    output reg MemRead,
    output reg MemToReg,
    output reg [2:0]ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
);

always @* begin
    case(OP)
        6'b000100: //beq
        begin
                         //RegDst <= 1'b0;
             ALUSrc = 1'b0;
                         //Memtoreg <= 1'b0;
             RegWrite = 1'b0;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             Branch = 1'b1;
             ALUOp = 3'b010; //
        end
        6'b100011: //Sw
        begin
                           //RegDst <= 1'b0;
             ALUSrc = 1'b1;
                          //Memtoreg <= 1'b0;
             RegWrite = 1'b0;
             MemWrite = 1'b1;
             MemRead = 1'b0;
             Branch = 1'b0;
             ALUOp = 3'b010; //
        end
        6'b101011:  //lw
        begin
             RegDst = 1'b0;
             ALUSrc = 1'b1;
             MemToReg = 1'b1;
             RegWrite = 1'b1;
             MemWrite = 1'b0;
             MemRead = 1'b1;
             Branch = 1'b0;
             ALUOp = 3'b010; //
        end
        6'b000000:
        begin
             RegDst = 1'b1;
             ALUSrc = 1'b0;
             MemToReg = 1'b0;
             RegWrite = 1'b1;
             MemWrite = 1'b0;
             MemRead = 1'b0;
             Branch = 1'b0;
             ALUOp = 3'b010; //intruccciones de tipo R
        end
        6'b011100:
        begin
            RegDst = 1'b1;
            ALUSrc = 1'b0;
            MemToReg = 1'b0;
            RegWrite = 1'b1;
            MemWrite = 1'b0;
            MemRead = 1'b0;
            Branch = 1'b0;
            ALUOp = 3'b010; 
        end
    
        endcase

end    
endmodule