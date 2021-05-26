`timescale 1ns/1ns

module DATAPATH(
    input Clk
);
//CABLES DE SALIDA DE MEMORIA DE INSTRUCCIONES
wire [31:0]c1;
//cables de salida de banco de registro 
wire [31:0]c2;
wire [31:0]c3;
//cables de salida de memoria de datos 
wire [31:0]c4;
//cables de salida de signected
wire [31:0]c5;
//cables de salida de ALU control
wire [2:0]c6;
//cables de salida de ALU
wire  c7;
wire [31:0]c8;
//cables de salida de pc
wire [31:0]c9;
//cables de salida de ADD 
wire [31:0]c10;
//cables de salida de ADD ALU
wire [31:0]c11;
//Cable de salida de AND
wire c12;
//cables de salida de unidad de control
wire c13;
wire c14;
wire c15;
wire c16;
wire c17;
wire c18;
wire [2:0]c19;
wire c20;
//cables de salida de multiplexor 1 0 [31:0]
wire [31:0]c21;
//cables de salida de multiplexor 0 1 [31:0]
wire  [31:0]c22;
//cables de salida de multiplexor 0 1 [31:0]    multiplexor 1
wire [31:0]c24;
//cables de salida de multiplexor 0 1 [31:0]    multiplexor 1
wire [4:0]c25;
//cable de salida de shifleft2 [31:0]
wire [31:0]c23;
//Memoria de instrucciones:0     ya esta conectado
MDI t(
    .address(c9),
    .Ins(c1)
);

//Banco de registro:1
BR y(
    .RA1(c1[25:21]),
    .RA2(c1[20:16]),
    .Di(c1[31:0]),
    .Dir(c25),  //multiplexor de [5:0]
    .Write(c20),
    .Dr1(c2),
    .Dr2(c3)
);
//Memoria de datos:2  ya esta conectado
Mem2 u(
    .Ewr(c17),
    .Dir(c8),
    .Din(c2),
    .Dout(c4)
);
// signected :3   ya esta conectado
signextend i(
    .Esix(c1[15:0]),
    .Ssix(c5)
);
//ALUcontrol :4     ya esta conectado
AC o(
    .Aop(c19),
    .func(c1[5:0]),
    .s(c6)
);
//ALU :5   ya esta conectado
ALU p(
    .a(c2),
    .b(c24),    //cable del multiplexor 
    .op2(c6),
    .s(c8),
    .Z(c7)
);
//PC:6           ya esta conectado
PC g(
    .pce(c22),
    .clk(Clk),
    .pcs(c9)
);
// ADD :7      ya esta conectado
ADD h(
    .EADD(c9),
    .Ecuatro(32'd4),
    .SADD(c10)
);
//ADD ALU: 8   ya esta conectado
 ADDALU j(  
    .EAALU(c10),
    .EAALU1(c23),
    .SAALU(c11)
);
//AND : 9   ya esta conectado
AND k(
    .AND(c14),
    .AND1(c7),
    .SAND(c12)
); 
//Unidad de control:10    ya esta conectado
UDC l(
    .RegDst(c13),
    .Branch(c14),
    .MemRead(c15),
    .Memtoreg(c16),
    .Memtowrite(c17),
    .ALUSrc(c18),
    .ALUop(c19),
    .Regwrite(c20),
    .op(c1[31:26])
);
// shifleft2 _11       ya esta conectado
Sleft b(
    .e1(c5),
    .s1(c23)
);
//multiplexor 01    ya esta conectado
MUX2 m(
    .roadc5(c4),
    .resc3(c8),
    .Mtoreg(c16),
    .sWritedata(c21)
);

//multiplexor [31:0]   ya esta conectado   conectado de pc
Mux_01 q(
    .Me(c10),
    .Me1(c11),
    .Me2(c12),
    .Ms(c22)
);
//multiplexor [31:0] multiplexor 1   cnectado de entrada ALU 
Mux31 a(
    .E(c3),
    .E1(c23),
    .E2(c18),
    .Es(c24)
);
//multiplexor [31:0] multiplexor 1    conectado entrada banco de registro
Mux5 n(
    .e(c1[20:16]),
    .e1(c1[15:11]),
    .e2(c13),
    .es(c25)
);


endmodule