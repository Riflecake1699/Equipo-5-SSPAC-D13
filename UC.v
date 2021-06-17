`timescale 1ns/1ns
module UC(
    input [5:0]OP,
    output reg RegDst,
    output reg Branch,
    output reg MemRead,
    output reg MemToReg,
    output reg [2:0]ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg jump
);

always @* begin
    case(OP)        //Instrucciones de tipo I
        6'b000100: //beq
        begin
            RegDst <= 1'bx;
            ALUSrc <= 1'b0;
            MemToReg <= 1'bx;
            RegWrite <= 1'b0;
            MemWrite <= 1'b0;
            MemRead <= 1'b0;
            Branch <= 1'b1;
            ALUOp <= 3'b001;
            jump <= 1'b0; 
        end
        6'b101011: //Sw
        begin
            RegDst <= 1'bx;
            ALUSrc <= 1'b1;
            MemToReg <= 1'bx;
            RegWrite <= 1'b0;
            MemWrite <= 1'b1;
            MemRead <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 3'b000; //
            jump <= 1'b0;
        end
        6'b100011:  //lw
        begin
            RegDst <= 1'b0;
            ALUSrc <= 1'b1;
            MemToReg <= 1'b1;
            RegWrite <= 1'b1;
            MemWrite <= 1'b0;
            MemRead <= 1'b1;
            Branch <= 1'b0;
            ALUOp <= 3'b000; //
            jump <= 1'b0;
        end
        6'b001000:  //ADDI
        begin
            RegDst <= 1'b0;
            ALUSrc <= 1'b1;
            MemToReg <= 1'b0;
            RegWrite <= 1'b1;
            MemWrite <= 1'b0;
            MemRead <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 3'b000; 
            jump <= 1'b0;
        end
        6'b001101:  //ORI
        begin
            RegDst <= 1'b0;
            ALUSrc <= 1'b1;
            MemToReg <= 1'b0;
            RegWrite <= 1'b1;
            MemWrite <= 1'b0;
            MemRead <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 3'b011;
            jump <= 1'b0; 
        end
        6'b001010:  //SLTI
        begin
            RegDst <= 1'b0;
            ALUSrc <= 1'b1;
            MemToReg <= 1'b0;
            RegWrite <= 1'b1;
            MemWrite <= 1'b0;
            MemRead <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 3'b100;
            jump <= 1'b0;
        end
        6'b001100:  //ANDI
        begin
            RegDst <= 1'b0;
            ALUSrc <= 1'b1;
            MemToReg <= 1'b0;
            RegWrite <= 1'b1;
            MemWrite <= 1'b0;
            MemRead <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 3'b010; 
            jump <= 1'b0;
        end

        6'b000000:      //intruccciones de tipo R
        begin
            RegDst <= 1'b1;
            ALUSrc <= 1'b0;
            MemToReg <= 1'b0;
            RegWrite <= 1'b1;
            MemWrite <= 1'b0;
            MemRead <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 3'b101;
            jump <= 1'b0; 
        end
        6'b011100: //Mul
        begin
            RegDst <= 1'b1;
            ALUSrc <= 1'b0;
            MemToReg <= 1'b0;
            RegWrite <= 1'b1;
            MemWrite <= 1'b0;
            MemRead <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 3'b101;
            jump <= 1'b0; 
        end
        6'b000010: //Instruccion J
        begin
            RegDst <= 1'b0;
            ALUSrc <= 1'b0;
            MemToReg <= 1'b0;
            RegWrite <= 1'b0;
            MemWrite <= 1'b0;
            MemRead <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= 3'b000; 
            jump <= 1'b1; 
        end
        endcase
end    
endmodule