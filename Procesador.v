`timescale 1ns/1ns
module Procesador(
    input clk
);

wire [31:0]C1; //Salida de PC
wire [31:0]C2; //Salida Adder a buffer IF/ID
wire [31:0]C3; //Instruccion a buffer IF/ID
wire [31:0]C4; //Adder Buffer IF/ID a ID/EX 
wire [31:0]C5; //Instruccion Buffer IF/ID
wire [31:0]C6; //Salida Sign/Ext a buffer ID/EX
wire [31:0]C7; //Salida a Adder que paso por buffer ID/EX
wire [31:0]C8; //Salida RD1 que paso por buffer ID/EX
wire [31:0]C9; //Salida RD2 que paso por buffer ID/EX
wire [31:0]C10; //Salida de sign/ext que paso por buffer ID/EX
wire [31:0]C11; //Salida shift a adder
wire [31:0]C12; //Salida adder a buffer EX/MEM
wire [31:0]C13; //Salida Mux que va a la ALU
wire [31:0]C14; //Salida ALU a buffer
wire [31:0]C15; //Segundo adder despues de pasar por buffer EX/MEM
wire [31:0]C16; //ALU despues de pasar por EX/MEM
wire [31:0]C17; //RD2 despues de pasar por EX/MEM
wire [31:0]C18; //Salida multiplexor a PC
wire [31:0]C19; //Read data a buffer MEM/WB
wire [31:0]C20; //Read data que paso por buffer
wire [31:0]C21; //Salida de ALU despues de salir de buffer MEM/WB
wire [31:0]C22; //Salida de Mux a lado de MEM/WB
wire [31:0]B1;
wire [31:0]B2;
wire [4:0]B3; //Salida de instruccion 20-16 que pasaron por buffer a mux5bits
wire [4:0]B4; //Salida de instruccion 15-11 que pasaron por buffer a mux5bits
wire [4:0]B5; //Salida Mux5bits a buffer EX/MEM
wire [4:0]B6; //Mux5bits despues de EX/MEM
wire [4:0]B7; //Mux5bits despues de MEM/WB
wire szf; //Zero flag ALU a Buffer
wire szf2; //Zero Flag despues EX/MEM
wire [3:0]selALU; //Salida de ALU control a ALU 
wire [1:0]WB;
wire [2:0]M;
wire [4:0]EX;
wire [1:0]WB1; //WB que paso por buffer ID/EX
wire [2:0]M1; //M que paso por buffer ID/EX
wire [4:0]EX1; //EX que paso por buffer ID/EX
wire [1:0]WB2; //WB que paso por buffer EX/MEM
wire [2:0]M2; //M que paso por buffer EX/MEM
wire [1:0]WB3; //WB que paso por buffer MEM/WB


PC ins0(
    .PCI(C18),
    .clk(clk),
    .PCO(C1)
);
Adder ins1(
    .E1(C1),
    .E2(32'd4),
    .S(C2)
);
InsMem ins2(
    .InsAd(C1),
    .Ins(C3)
);
buffer1 ins3(
    .Adder(C2),
    .Ins(C3),
    .clk(clk),
    .SalAdder(C4),
    .SalIns(C5)
);
UC ins4(
    .OP(C5[31:26]),
    .RegDst(EX[4]),
    .Branch(M[2]),
    .MemRead(M[1]),
    .MemToReg(WB[0]),
    .ALUOp(EX[3:1]),
    .MemWrite(M[0]),
    .ALUSrc(EX[0]),
    .RegWrite(WB[1])
);
BancReg ins5(
    .RegEn(WB3[1]),
    .RR1(C5[25:21]),
    .RR2(C5[20:16]),
    .WriteRegister(B7),
    .WriteData(C22),
    .RD1(B1),
    .RD2(B2)
);
SignExt ins6(
    .E(C5[15:0]),
    .S(C6)
);
buffer2 ins7(
    .EnBuf(C4),
    .EnRd1(B1),
    .EnRd2(B2),
    .EnSX(C6),
    .EnIns1(C5[20:16]),
    .EnIns2(C5[15:11]),
    .EnWB(WB),    
    .EnM(M),
    .EnEX(EX),
    .clk(clk),
    .SalAdd(C7),
    .SalAdd1(C8),
    .SalMux2(C9),
    .SalAlu(C10),
    .SalMux3(B3),
    .SalMux31(B4),
    .SalWB(WB1),
    .SalM(M1),
    .SalEX(EX1)    
);
ShiftL ins8(
    .E(C10),
    .S(C11)
);
Adder ins9(
    .E1(C7),
    .E2(C11),
    .S(C12)
);
Mux5bit ins10( //E1 -> 0 E2 -> 1
    .E1(B3),
    .E2(B4),
    .RegDst(EX1[4]),
    .S(B5)
);
Mux ins11( //E1 -> 0 E2 -> 1 
    .E1(C9),
    .E2(C10),
    .sel(EX1[0]),
    .S(C13)
);
ALUControl ins12(
    .Func(C10[5:0]),
    .ALUOp(EX1[3:1]),
    .sel(selALU)
);
ALU ins13(
    .OP1(C8),
    .OP2(C13),
    .sel(selALU),
    .zf(szf),
    .Res(C14)
);
buffer3 ins14(
    .Adder(C12),
    .ALU(C14),
    .RD2(C9),
    .Mux5bit(B5),
    .WB(WB1),
    .M(M1),
    .ZF(szf),
    .clk(clk),
    .sAdder(C15),
    .sALU(C16),
    .sZF(szf2),
    .sRD2(C17),
    .sMux5bit(B6),
    .sWB(WB2),
    .sM(M2)
);
Mux ins15( //E1 -> 0 E2 -> 1
    .E1(C2),
    .E2(C15),
    .sel(szf2 & M2[2]),
    .S(C18)
);
Mem ins16(
    .Address(C16),
    .WriteData(C17),
    .MemWrite(M2[0]),
    .MemRead(M2[1]),
    .ReadData(C19)
);
buffer4 ins17(
    .clk(clk),
    .RData(C19),
    .ALU(C16),
    .Mux5(B6),
    .WB(WB2),
    .sRData(C20),
    .sALU(C21),
    .sMux5(B7),
    .sWB(WB3)
);
Mux ins18( //E1 -> 0 E2 -> 1
    .E1(C21),
    .E2(C20),
    .sel(WB3[0]),
    .S(C22)
);
endmodule
