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
    output reg RegWrite
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
        end
        6'b100011: //Sw
        begin
             RegDst <= 1'bx;
             ALUSrc <= 1'b1;
             MemToReg <= 1'bx;
             RegWrite <= 1'b0;
             MemWrite <= 1'b1;
             MemRead <= 1'b0;
             Branch <= 1'b0;
             ALUOp <= 3'b000; //
        end
        6'b101011:  //lw
        begin
             RegDst <= 1'b0;
             ALUSrc <= 1'b1;
             MemToReg <= 1'b0;
             RegWrite <= 1'b1;
             MemWrite <= 1'b0;
             MemRead <= 1'b1;
             Branch <= 1'b0;
             ALUOp <= 3'b000; //
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
        end
        endcase
end    
endmodule

// `timescale 1ns/1ns 

// module UC(
//     input [5:0]OP,
//     output 
//     output reg[4:0]EX,
//     output reg[2:0]M,
//     output reg[1:0]WB
// );

// always @* begin
//     case(OP)    //Instrucciones de tipo I
//         6'b000100:     //BEQ
//         begin
//             EX[0] = 1'bx;           //RegDst 
//             EX[3:1] = 3'b001;         //ALUOp
//             EX[4] = 1'b0;           //ALUSrc
//             M[0] = 1'b1;            //Branch
//             M[1] = 1'b0;            //MemRead
//             M[2] = 1'b0;            //MemWrite
//             WB[0] = 1'b0;           //RegWrite
//             WB[1] = 1'bx;           //MemToReg
//         end
//          6'b100011:      //LW  
//         begin
//             EX[0] = 1'b0;   
//             EX[3:1] = 3'b000;
//             EX[4] = 1'b1;
//             M[0] = 1'b0;
//             M[1] = 1'b1;
//             M[2] = 1'b0;
//             WB[0] = 1'b1;
//             WB[1] = 1'b0;
//         end
//          6'b101011:     //SW
//         begin
//             EX[0] = 1'bx;   
//             EX[3:1] = 3'b000;
//             EX[4] = 1'b1;
//             M[0] = 1'b0;
//             M[1] = 1'b0;
//             M[2] = 1'b1;
//             WB[0] = 1'b1;
//             WB[1] = 1'bx;
//         end
//          6'b001000:     //ADDI
//         begin
//             EX[0] = 1'b0;   
//             EX[3:1] = 3'b000;
//             EX[4] = 1'b1;
//             M[0] = 1'b0;
//             M[1] = 1'b1;
//             M[2] = 1'b0;
//             WB[0] = 1'b1;
//             WB[1] = 1'b1;
//         end
//          6'b001010:     //SLTI
//         begin
//             EX[0] = 1'b0;   
//             EX[3:1] = 3'b100;
//             EX[4] = 1'b1;
//             M[0] = 1'b0;
//             M[1] = 1'b1;
//             M[2] = 1'b0;
//             WB[0] = 1'b1;
//             WB[1] = 1'b1;
//         end
//          6'b001100:     //ANDI
//         begin
//             EX[0] = 1'b0;   
//             EX[3:1] = 3'b010;
//             EX[4] = 1'b1;
//             M[0] = 1'b0;
//             M[1] = 1'b1;
//             M[2] = 1'b0;
//             WB[0] = 1'b1;
//             WB[1] = 1'b1;
//         end
//          6'b001101:     //ORI
//         begin
//             EX[0] = 1'b0;   
//             EX[3:1] = 3'b011;
//             EX[4] = 1'b1;
//             M[0] = 1'b0;
//             M[1] = 1'b1;
//             M[2] = 1'b0;
//             WB[0] = 1'b1;
//             WB[1] = 1'b1;
//         end
//          6'b000000:            //Instrucciones de tipo R
//         begin
//             EX[0] = 1'b1;   
//             EX[3:1] = 3'b101;
//             EX[4] = 1'b0;
//             M[0] = 1'b0;
//             M[1] = 1'b0;
//             M[2] = 1'b0;
//             WB[0] = 1'b1;
//             WB[1] = 1'b1;
//         end
//          6'bxxxxxx:     
//         begin
//             EX[0] = 1'bx;   
//             EX[3:1] = 3'bxxx;
//             EX[4] = 1'bx;
//             M[0] = 1'bx;
//             M[1] = 1'bx;
//             M[2] = 1'bx;
//             WB[0] = 1'bx;
//             WB[1] = 1'bx;
//         end
//     endcase
// end
// endmodule
