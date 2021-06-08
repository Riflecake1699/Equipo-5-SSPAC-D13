`timescale 1ps/1ps
module Procesador(
    input clk
);

wire [31:0]a;
wire [31:0]b;
wire [31:0]c;
wire [31:0]d;
wire [31:0]e;
wire [31:0]f;
wire [31:0]g;
wire [31:0]h;
wire [31:0]i;
wire [31:0]j;
wire [31:0]k;
wire [31:0]l;
wire [31:0]m;
wire [31:0]n;
wire [31:0]o;
wire [31:0]p;
wire [31:0]q;
wire [31:0]r;
wire [31:0]s;
wire [31:0]t;
wire [31:0]u;
wire [31:0]v;
wire [31:0]w;
wire [31:0]y;
wire [31:0]m1;
wire [31:0]m41;
wire [31:0]m40;
wire [31:0]mwd;
wire [2:0]C5;
wire [4:0]C9;
wire [4:0]C13;
wire [4:0]C14;
wire [4:0]C15;
wire [4:0]C16;
wire [4:0]C17;
wire [3:0]C10;
wire C11;
wire ZF;
wire BM;
wire [31:0]C12;
wire [1:0]WB;
wire [2:0]M;
wire [4:0]EX;
wire [1:0]WB1;
wire [2:0]M1;
wire [4:0]EX1;
wire [1:0]WB2;
wire [2:0]M2;
wire[1:0]WB3;


Mux2 ins0(.E1(m1), .E2(b), .sel(BM), .S(l)); //Antes del pc
PC ins1(.PCI(l), .clk(clk), .PCO(a));
Adder ins2(.E1(a), .E2(32'd4), .S(b));
bufer1 ins3(.EnAdd(b), .EnInsM(d), .clk(clk), .SalBuf(m), .SalInst(n));
InsMem ins4(.InsAd(a), .Ins(d));
UC ins5(.OP(n[31:26]), .RegDst(EX[2]), .Branch(M[2]), .MemRead(M[1]), .MemToReg(WB[0]), .ALUOp(EX[3:1]), .MemWrite(M[0]), .ALUSrc(EX[0]), .RegWrite(WB[1]));
bufer2 ins6(.EnBuf(m), .EnRd1(o), .EnRd2(p), .EnSX(q), .EnIns1(n[20:16]), .EnIns2(n[15:11]), .EnWB(WB), .EnM(M), .EnEX(EX), .clk(clk), .SalAdd(r), .SalAdd1(s), .SalMux2(t), .SalAlu(u), .SalMux3(C13), .SalMux31(C14), .SalWB(WB1), .SalM(M1), .SalEX(EX1));
Mux5bit ins7(.E1(C13), .E2(C14), .RegDst(EX[2]), .S(C9)); //Entre Bufer 2 y Bufer 3
BancReg ins8(.RegEn(WB3[1]), .RR1(n[25:21]), .RR2(n[20:16]), .WriteRegister(C17), .WriteData(mwd), .RD1(o), .RD2(p));
SignExt ins9(.E(n[15:0]), .S(q));
ShiftL ins10(.E(u), .S(h));
Adder ins11(.E1(r), .E2(h), .S(i));
ALUControl ins12(.Func(u[5:0]), .ALUOp(EX[3:1]), .sel(C10));
Mux ins13(.E1(u), .E2(t), .sel(EX[0]), .S(v)); //Entre Bufer 2 y Alu
ALU ins14(.OP1(s), .OP2(v), .sel(C10), .zf(C11), .Res(C12));
bufer3 ins15(.EnAdd(i), .EnAlRes(C12), .EnBu(t), .EnMux3(C9), .EnWB(WB1), .EnM(M1), .ZF(C11), .clk(clk), .SalMux1(m1), .SalDM(w), .SalDMW(y), .SalBu4(C16), .SalWB(WB2), .SalZF(ZF), .SalM(M2));
Mem ins16(.Address(w), .WriteData(y), .MemWrite(M2[0]), .MemRead(M2[1]), .ReadData(k));
AND ins17(.a(M2[2]), .b(ZF), .s(BM));
bufer4 ins18(.EnRD(k), .EnBuf3(w), .EnBf3(C16), .EnWB(WB2), .clk(clk), .SalMux4(m41), .SalMux40(m40), .SalWR(C17), .SalWB(WB3));
Mux ins19(.E1(m41), .E2(m40), .sel(WB3[0]), .S(mwd)); //Despues del bufer4
endmodule