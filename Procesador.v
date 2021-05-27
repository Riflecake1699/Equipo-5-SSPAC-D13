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
wire C1;
wire C2;
wire C3;
wire C4;
wire [2:0]C5;
wire C6;
wire C7;
wire C8;
wire [4:0]C9;
wire [3:0]C10;
wire C11;
wire [31:0]C12;

PC ins0(.PCI(c), .clk(clk), .PCO(a));
Adder ins1(.E1(a), .E2(32'd4), .S(b));
Mux2 ins2(.E1(i), .E2(b), .sel(C2&C11), .S(c));
InsMem ins3(.InsAd(a), .Ins(d));
UC ins4(.OP(d[31:26]), .RegDst(C1), .Branch(C2), .MemRead(C3), .MemToReg(C4), .ALUOp(C5), .MemWrite(C6), .ALUSrc(C7), .RegWrite(C8));
Mux5bit ins5(.E1(d[20:16]), .E2(d[15:11]), .sel(C1), .S(C9));
BancReg ins6(.RegEn(C8), .RR1(d[25:21]), .RR2(d[20:16]), .WriteRegister(C9), .WriteData(l), .RD1(e), .RD2(f));
SignExt ins7(.E(d[15:0]), .S(g));
ShiftL ins8(.E(g), .S(h));
Adder ins9(.E1(b), .E2(h), .S(i));
ALUControl ins10(.Func(d[5:0]), .ALUOp(C5), .sel(C10));
Mux ins11(.E1(g), .E2(f), .sel(C7), .S(j));
ALU ins12(.OP1(e), .OP2(j), .sel(C10), .zf(C11), .Res(C12));
Mem ins13(.Address(C12), .WriteData(f), .MemWrite(C6), .MemRead(C3), .ReadData(k));
Mux ins14(.E1(k), .E2(C12), .sel(C4), .S(l));
endmodule