`timescale 1ns/1ns
module Procesador(
    input clk
);
wire [31:0]C1;      //Salida de Mux1 y entrada a PC.
wire [31:0]C2;      //Salida del PC y enetrada de Instruction Memory.     
wire [31:0]C3;      //Entrada de Mux1 en 0 y salida del Adder.
wire [31:0]C4;      //Salida de Instruction Memory y entrada a Bufer1.
wire [31:0]C5;      //Salida del Bufer1 y entrada de Bufer2.
wire [31:0]C6;      //Salida del Bufer1 y entrada para UC, BangRe, SignExt y Bufer2.
wire [31:0]C7;
wire [31:0]C8;
wire [31:0]C9;
wire [31:0]C10;
wire [31:0]C11;
wire [31:0]C12;
wire [31:0]C13;
wire [31:0]C14;
wire [31:0]C15;
wire [31:0]C16;
wire [31:0]C17;
wire [31:0]C18;     //Entrada de Mux1 en 1 y salida del Bufer 3.
wire [31:0]C19;
wire [31:0]C20;
wire [31:0]C21;
wire [31:0]C22;
wire [31:0]C23;
wire [31:0]C24;
wire ZF;
wire ZF1;
wire [3:0]sel;
wire [4:0]B1;
wire [4:0]B2;
wire [4:0]B3;
wire [4:0]B4;
wire [4:0]B5;
wire [1:0]WB;       //Salida del Bufer2 en WB.
wire [2:0]M;        //Salida del Bufer2 en M.
wire [4:0]EX;       //Salida del Bufer2 en EX.
wire [1:0]WB1;
wire [2:0]M1;
wire [4:0]EX1;
wire [1:0]WB2;
wire [2:0]M2;
wire [1:0]WB3;      //Salida del Bufer3 en WB.
wire PCSrc;         //Selector de Mux1 y salida de la AND.

Mux ins0(.E1(C18), .E2(C3), .sel(PCSrc), .S(C1)); //Antes del contador de programa
PC ins1(.PCI(C1), .clk(clk), .PCO(C2)); //Contador de programa
Adder ins2(.E1(C2), .E2(32'd04), .S(C3)); //Sumador arriba de insmem
InsMem ins3(.InsAd(C2), .Ins(C4));
buffer1 ins4(.Adder(C3), .Ins(C4), .clk(clk), .SalAdder(C5), .SalIns(C6));
UC ins5(.OP(C6[31:26]), .RegDst(EX[4]), .Branch(M[2]), .MemRead(M[1]), .MemToReg(WB[0]), .ALUOp(EX[3:1]), .MemWrite(M[0]), .ALUSrc(EX[0]), .RegWrite(WB[1]));
BancReg ins6(.RegEn(WB3[1]), .RR1(C6[25:21]), .RR2(C6[20:16]), .WriteRegister(B5), .WriteData(C24), .RD1(C7), .RD2(C8));
SignExt ins7(.E(C6[15:0]), .S(C9));
buffer2 ins8(.Adder(C5), .RD1(C7), .RD2(C8), .SignEx(C9), .Ins20(C6[20:16]), .Ins15(C6[15:11]), .EnWB(WB), .EnM(M), .EnEX(EX), .clk(clk), .sAdder(C10), .sRD1(C11), .sRD2(C12), .sSignEx(C13), .sIns20(B1), .sIns15(B2), .sWB(WB1), .sM(M1), .sEX(EX1));
ShiftL ins9(.E(C9), .S(C14));
Adder ins10(.E1(C10), .E2(C14), .S(C15));
Mux5bit ins11(.E1(B1), .E2(B2), .RegDst(EX[4]), .S(B3)); 
Mux ins12(.E1(C13), .E2(C12), .sel(EX[0]), .S(C16));
ALU ins13(.OP1(C11), .OP2(C16), .sel(sel), .zf(ZF), .Res(C17));
ALUControl ins14(.Func(C13[5:0]), .ALUOp(EX[3:1]), .sel(sel));
buffer3 ins15(.clk(clk), .Adder(C15), .ALU(C17), .zf(ZF), .RD2(C12), .WB(WB1), .M(M1), .Mux5(B3), .sAdder(C18), .sALU(C19), .szf(ZF1), .sRD2(C20), .sWB(WB2), .sM(M2), .sMux5(B4));
AND ins16(.a(ZF1), .b(M2[2]), .s(PCSrc));
Mem ins17(.Address(C19), .WriteData(C20), .MemWrite(M2[0]), .MemRead(M2[1]), .ReadData(C21));
buffer4 ins18(.clk(clk), .RData(C21), .ALU(C19), .Mux5(B4), .WB(WB2), .sRData(C22), .sALU(C23), .sMux5(B5), .sWB(WB3));
Mux ins19(.E1(C22), .E2(C23), .sel(WB3[0]), .S(C24)); //Despues del buffer4
endmodule
