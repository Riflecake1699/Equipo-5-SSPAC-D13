/*`timescale 1ns/1ns
module Procesador(
    input CLK
);
wire [31:0]C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C20,C21,C22,C23,C24;
wire [4:0]B1,B2,B3,B4,B5,EX,EX1;
wire [3:0]sel;
wire [2:0]M,M1,M2;
wire [1:0]WB,WB1,WB2,WB3;
wire PCSrc, ZF, ZF1;

//Antes del contador de programa
Mux ins0(        
    .E1(C18),               //Salida de Sumador del Bufer3 y entrada del Mux0 en 1.
    .E2(C3),                //Salida del Sumador a la entrada del Mux0 en 0. 
    .sel(PCSrc),            //Salida de la AND a la entrada del Selec del Mux0.   
    .S(C1)                  //Salida del Mux0 a la entrada del PC.
); 
//Contador de programa
PC ins1(        
    .PCI(C1),               //Salida del Mux0 a la entrada del PC. 
    .clk(CLK),              //Se instancia del clk del PC al CLK del procesador.         
    .PCO(C2)                //Salida del PC, entra a la entrada 1 del Sumador y a su vez a la Memoria de Instrucciones.
); 
//Sumador arriba de insmem
Adder ins2(
    .E1(C2),                //Salida del PC, entra a la entrada 1 del Sumador y a su vez a la Memoria de Instrucciones.
    .E2(32'd4),             //Es la constante de 4.  
    .S(C3)                  //Salida del Sumador a la entrada del Mux0 en 0 y a la entrada del Buffer1.
); 
InsMem ins3(
    .InsAd(C2),             //Salida del PC, entra a la entrada 1 del Sumador y a su vez a la Memoria de Instrucciones.
    .Ins(C4)                //Salida de la Memoria de Instrucciones a la entrada del Buffer1.
);
buffer1 ins4(
    .Adder(C3),             //Salida del Sumador a la entrada del Mux0 en 0 y a la entrada del Buffer1.
    .Ins(C4),               //Salida de la Memoria de Instrucciones a la entrada del Buffer1.
    .clk(CLK),              //Se instancia del clk del PC al CLK del Buffer1. 
    .SalAdder(C5),          //Salida del Buffer1 a la entrada 1 del Buffer2.
    .SalIns(C6)             //Salida 2 del Buffer1 a la entrada de UC, BancoReg en Ent1, Ent2, [15:0]SingExt, [20:16]Buffer2 en entrada 6 y del [15:11]Entrada7 del Buffer2             
);
UC ins5(
    .OP(C6[31:26]),         //Salida 2 del Buffer1 a la entrada de UC, BancoReg en Ent1, Ent2, [15:0]SingExt, [20:16]Buffer2 en entrada 6 y del [15:11]Entrada7 del Buffer2 
    .RegDst(EX[4]),         //Salida de EX en el bit [4] para RegDst del Mux2 de 5 bits.
    .Branch(M),             //Salida de la UC a la entrada de M en el Buffer2.          
    .MemRead(M2[2]),        //Salida del Buffer3 en M a la MemRead de la Memoria.
    .MemToReg(WB[0]),       //Salida del MemToReg de la UC y entra al Buffer2. 
    .ALUOp(EX[3:1]),        //Salida de EX del bit [3:1] para el selector de ALU Control. 
    .MemWrite(M1),          //Salida de M del Buffer3 y entra al MemWrite de la Memoria.
    .ALUSrc(EX[0]),         //Salida de EX del bit [0] a la entrada del selector en el Mux1.
    .RegWrite(WB[1])        //Salida del RegWrite de la UC y entra al Buffer2. 
);
BancReg ins6(
    .RegEn(WB3[1]),         //Salida del WB [1] Para el RegWrite.(Banco de Registro) 
    .RR1(C6[25:21]),        //Salida 2 del Buffer1 a la entrada de UC, BancoReg en Ent1, Ent2, [15:0]SingExt, [20:16]Buffer2 en entrada 6 y del [15:11]Entrada7 del Buffer2  
    .RR2(C6[20:16]),        //Salida 2 del Buffer1 a la entrada de UC, BancoReg en Ent1, Ent2, [15:0]SingExt, [20:16]Buffer2 en entrada 6 y del [15:11]Entrada7 del Buffer2 
    .WriteRegister(B5),     //Salida 3 del Buffer4 a la entrada 3 del BancoReg.
    .WriteData(C24),        //Salida del Mux4 y entra en la entrada 4 del BancoReg.
    .RD1(C7),               //Salida 1 del BancoReg a la entrada 2 del Buffer2.
    .RD2(C8)                //Salida 2 del BancoReg a la entrada 3 del Buffer2.
);
SignExt ins7(
    .E(C6[15:0]),           //Salida 2 del Buffer1 a la entrada de UC, BancoReg en Ent1, Ent2, [15:0]SingExt, [20:16]Buffer2 en entrada 6 y del [15:11]Entrada7 del Buffer2 
    .S(C9));                //Salida del SignExt a la entrada 4 del Buffer2.
buffer2 ins8(
    .Adder(C5),             //Salida del Buffer1 a la entrada 1 del Buffer2. 
    .RD1(C7),               //Salida 1 del BancoReg a la entrada 2 del Buffer2. 
    .RD2(C8),               //Salida 2 del BancoReg a la entrada 3 del Buffer2.
    .SignEx(C9),            //Salida del SignExt a la entrada 4 del Buffer2.
    .Ins20(C6[20:16]),      //Salida 2 del Buffer1 a la entrada de UC, BancoReg en Ent1, Ent2, [15:0]SingExt, [20:16]Buffer2 en entrada 6 y del [15:11]Entrada7 del Buffer2  
    .Ins15(C6[15:11]),      //Salida 2 del Buffer1 a la entrada de UC, BancoReg en Ent1, Ent2, [15:0]SingExt, [20:16]Buffer2 en entrada 6 y del [15:11]Entrada7 del Buffer2  
    .EnWB(WB),              //Salida de la UC y entra en WB en el Buffer2. 
    .EnM(M1),               //Salida de M del Buffer3 y entra al MemWrite de la Memoria.
    .EnEX(EX),              //Salida de la UC a la entrada de EX en el Buffer2.
    .clk(CLK), 
    .sAdder(C10),           //Salida del Buffer2 a la entrada 1 del Sumador 2.
    .sRD1(C11),             //Salida 2 del Buffer2 a la entrada 1 de la ALU. 
    .sRD2(C12),             //Salida 3 del Buffer2 a la entrada del Mux1 en 0 y a la entrada 4 del Buffer3.  
    .sSignEx(C13),          //Salida del Buffer 2 a la entrada del Func de la AluControl y a la entrada 2 del Mux1 y a la entrada del Shift.
    .sIns20(B1),            //Salida 5 del Buffer2 a la entrada en 0 del Mux2.
    .sIns15(B2),            //Salida 6 del Buffer2 a la entrada en 1 del Mux2. 
    .sWB(WB1),              //Salida del Buffer2 en WB a la entrada en WB en del Buffer3. 
    .sM(M),                 //Salida de la UC a la entrada de M en el Buffer2.
    .sEX(EX1)               //Salida del Buffer2 en EX a la entrada en Selec del Mux2, entra en el Sel de AluC y en el selector de Mux1
);
ShiftL ins9(
    .E(C13),                 //Salida del Buffer 2 a la entrada del Func de la AluControl y a la entrada 2 del Mux1 y a la entrada del Shift.
    .S(C14)                  //Salida del Shift y entrada a la entrada 2 del Sumador 2.
);
Adder ins10(
    .E1(C10),               //Salida del Buffer2 a la entrada 1 del Sumador 2.
    .E2(C14),               //Salida del Shift y entrada a la entrada 2 del Sumador 2.
    .S(C15)                 //Salida del Sumador 2 a la entrada 1 del Buffer 3.
);
Mux5bit ins11(
    .E1(B1),                //Salida 5 del Buffer2 a la entrada en 0 del Mux2.
    .E2(B2),                //Salida 6 del Buffer2 a la entrada en 1 del Mux2. 
    .RegDst(EX1[4]),         //Salida de EX1 en el bit [4] para RegDst del Mux2 de 5 bits.
    .S(B3)                  //Salida del Mux2 a la entrada 5 del Buffer3.
); 
Mux ins12(
    .E1(C13),               //Salida del Buffer 2 a la entrada del Func de la AluControl y a la entrada 2 del Mux1 y a la entrada del Shift. 
    .E2(C12),               //Salida 3 del Buffer2 a la entrada del Mux1 en 0 y a la entrada 4 del Buffer3. 
    .sel(EX1[0]),            //Salida de EX en el bit [0] para el Sel del Mux1. 
    .S(C16)                 //Salida del Mux1 a la entrada 2 de la ALU.
);
ALU ins13(
    .OP1(C11),              //Salida 2 del Buffer2 a la entrada 1 de la ALU.
    .OP2(C16),              //Salida del Mux1 a la entrada 2 de la ALU.
    .sel(sel),              //Salida de la ALU Control al Selector de la ALU. 
    .zf(ZF),                //Salida del ZF a la entrada 2 del Buffer3. 
    .Res(C17)               //Salida de Res de la ALU a la entrada 3 del Buffer3.
);
ALUControl ins14(
    .Func(C13[5:0]),        //Salida del Buffer 2 a la entrada del Func de la AluControl y a la entrada 2 del Mux1 y a la entrada del Shift. 
    .ALUOp(EX1[3:1]),       //Salida de EX del bit [3:1] para el selector de ALU Control.
    .sel(sel)               //Salida de la ALU Control al Selector de la ALU. 
);
buffer3 ins15(
    .clk(CLK), 
    .Adder(C15),            //Salida del Sumador 2 a la entrada 1 del Buffer 3. 
    .ALU(C17),              //Salida de Res de la ALU a la entrada 3 del Buffer3. 
    .zf(ZF),                //Salida del ZF a la entrada 2 del Buffer3. 
    .RD2(C12),              //Salida 3 del Buffer2 a la entrada del Mux1 en 0 y a la entrada 4 del Buffer3.  
    .WB(WB1),               //Salida del Buffer2 en WB a la entrada en WB en del Buffer3.
    .M(M1),                 //Salida de M del Buffer3 y entra al MemWrite de la Memoria.
    .Mux5(B3),              //Salida del Mux2 a la entrada 5 del Buffer3. 
    .sAdder(C18),           //Salida de Sumador del Bufer3 y entrada del Mux en 1.
    .sALU(C19),             //Salida 2 del Buffer3 a la entrada 1 de la Memoria y a la entrada 2 del Buffer4. 
    .szf(ZF1),              //Salida del ZF en el Buffer3 a la entrada 2 de la AND.  
    .sRD2(C20),             //Salida 3 del Buffer3 a la entrada 2 de la Memoria. 
    .sWB(WB2),              //Salida WB del Buffer3 a la entrada WB del Buffer4. 
    .sM(M2),                //Salida del Buffer3 a la entrada 1 del AND, a la MemRead de la Memoria y la MemWrite de la Memoria.
    .sMux5(B4)              //Salida 3 del Buffer3 a la entrada 3 del Buffer4. 
);
AND ins16(
    .a(ZF1),              //Sale del bit [2] en el Buffer 3 en M y entra a la primera entrada de AND. 
    .b(M2[2]),                //Salida del ZF en el Buffer3 a la entrada 2 de la AND. 
    .s(PCSrc)               //Salida de la AND a la entrada del Selec del Mux0.
);                            
Mem ins17(
    .Address(C19),          //Salida 2 del Buffer3 a la entrada 1 de la Memoria y a la entrada 2 del Buffer4.
    .WriteData(C20),        //Salida 3 del Buffer3 a la entrada 2 de la Memoria. 
    .MemWrite(M2[0]),       //Sale del bit [0] en el Buffer 3 en M y entra en MemWrite de la memoria.
    .MemRead(M2[1]),        //Sale del bit [1] en el Buffer 3 en M y entra en MemRead de la Memoria. 
    .ReadData(C21)          //Salida de la Memoria a la entrada 1 del Buffer4.
);
buffer4 ins18(
    .clk(CLK), 
    .RData(C21),            //Salida de la Memoria a la entrada 1 del Buffer4. 
    .ALU(C19),              //Salida 2 del Buffer3 a la entrada 1 de la Memoria y a la entrada 2 del Buffer4. 
    .Mux5(B4),              //Salida 3 del Buffer3 a la entrada 3 del Buffer4. 
    .WB(WB2),               //Salida WB del Buffer3 a la entrada WB del Buffer4. 
    .sRData(C22),           //Salida 1 del Buffer4 a la entrada del Mux4 en 0.
    .sALU(C23),             //Salida 2 del Buffer4 a la entrada del Mux4 en 1.  
    .sMux5(B5),             //Salida 3 del Buffer4 a la entrada 3 del BancoReg.
    .sWB(WB3)               //Salida del WB [1] Para el RegWrite.(Banco de Registro)
);
//Despues del buffer4
Mux ins19(
    .E1(C23),               //Salida 2 del Buffer4 a la entrada del Mux4 en 1. 
    .E2(C22),               //Salida 1 del Buffer4 a la entrada del Mux4 en 0.
    .sel(WB3[0]),           //Salida del WB [0] para MemToReg del Mux4.
    .S(C24)                 //Salida del Mux4 y entra en la entrada 4 del BancoReg.
); 
endmodule

`timescale 1ns/1ns
module Procesador(
    input CLK
);
wire [31:0]C1;      //Salida de Mux1 y entrada a PC.
wire [31:0]C2;      //Salida del PC y enetrada de Instruction Memory.     
wire [31:0]C3;      //Entrada de Mux1 en 0 y salida del Adder.
wire [31:0]C4;      //Salida de Instruction Memory y entrada a Bufer1.
wire [31:0]C5;      //Salida del Bufer1 y entrada de Bufer2.
wire [31:0]C6;      //Salida del Bufer1 y entrada para UC, BangRe, SignExt y Bufer2.
wire [31:0]C7;      //Salida 1 del BancoReg a la entrada 2 del Buffer2.
wire [31:0]C8;       //Salida 2 del BancoReg a la entrada 3 del Buffer2.
wire [31:0]C9;      //Salida del SignExt a la entrada 4 del Buffer2.     
wire [31:0]C10;     //Salida del Buffer2 a la entrada 1 del Sumador 2.
wire [31:0]C11;      //Salida 2 del Buffer2 a la entrada 1 de la ALU.
wire [31:0]C12;     //Salida 3 del Buffer2 a la entrada del Mux1 en 0 y a la entrada 4 del Buffer3.
wire [31:0]C13;      //Salida del Buffer 2 a la entrada del Func de la AluControl y a la entrada 2 del Mux1 y a la entrada del Shift.
wire [31:0]C14;     //Salida del Shift y entrada a la entrada 2 del Sumador 2.
wire [31:0]C15;     //Salida del Sumador 2 a la entrada 1 del Buffer 3.
wire [31:0]C16;      //Salida del Mux1 a la entrada 2 de la ALU.
wire [31:0]C17;      //Salida de Res de la ALU a la entrada 3 del Buffer3.
wire [31:0]C18;     //Entrada de Mux1 en 1 y salida del Bufer 3.
wire [31:0]C19;     //Salida 2 del Buffer3 a la entrada 1 de la Memoria y a la entrada 2 del Buffer4.
wire [31:0]C20;     //Salida 3 del Buffer3 a la entrada 2 de la Memoria. 
wire [31:0]C21;      //Salida de la Memoria a la entrada 1 del Buffer4.
wire [31:0]C22;     //Salida 1 del Buffer4 a la entrada del Mux4 en 0.
wire [31:0]C23;     //Salida 2 del Buffer4 a la entrada del Mux4 en 1.
wire [31:0]C24;      //Salida del Mux4 y entra en la entrada 4 del BancoReg.
wire ZF;             //Salida del ZF a la entrada 2 del Buffer3.
wire ZF1;            //Salida del ZF en el Buffer3 a la entrada 2 de la AND.
wire [3:0]sel;       //Salida de la ALU Control al Selector de la ALU.
wire [4:0]B1;       //Salida 5 del Buffer2 a la entrada en 0 del Mux2.
wire [4:0]B2;       //Salida 6 del Buffer2 a la entrada en 1 del Mux2. 
wire [4:0]B3;       //Salida del Mux2 a la entrada 5 del Buffer3.
wire [4:0]B4;       //Salida 3 del Buffer3 a la entrada 3 del Buffer4.
wire [4:0]B5;       //Salida 3 del Buffer4 a la entrada 3 del BancoReg.
wire [1:0]WB;       //Salida del Bufer2 en WB.
wire [2:0]M;        //Salida del Bufer2 en M.
wire [4:0]EX;       //Salida del Bufer2 en EX.
wire [1:0]WB1;       //Salida del Buffer2 en WB a la entrada en WB en del Buffer3.
wire [2:0]M1;        //Salida de M del Buffer3 y entra al MemWrite de la Memoria.
wire [4:0]EX1;      //Salida del Buffer2 en EX a la entrada en Selec del Mux2, entra en el Sel de AluC y en el selector de Mux1
wire [1:0]WB2;      //Salida WB del Buffer3 a la entrada WB del Buffer4.
wire [2:0]M2;        //Salida del Buffer3 a la entrada 1 del AND, a la MemRead de la Memoria y la MemWrite de la Memoria.
wire [1:0]WB3;      //Salida del Bufer3 en WB.
wire PCSrc;         //Selector de Mux1 y salida de la AND.

Mux ins0(.E1(C18), .E2(C3), .sel(PCSrc), .S(C1)); //Antes del contador de programa
PC ins1(.PCI(C1), .clk(CLK), .PCO(C2)); //Contador de programa
Adder ins2(.E1(C2), .E2(32'd04), .S(C3)); //Sumador arriba de insmem
InsMem ins3(.InsAd(C2), .Ins(C4));
buffer1 ins4(.Adder(C3), .Ins(C4), .clk(CLK), .SalAdder(C5), .SalIns(C6));
UC ins5(.OP(C6[31:26]), .RegDst(EX[4]), .Branch(M[2]), .MemRead(M[1]), .MemToReg(WB[0]), .ALUOp(EX[3:1]), .MemWrite(M[0]), .ALUSrc(EX[0]), .RegWrite(WB[1]));
BancReg ins6(.RegEn(WB3[1]), .RR1(C6[25:21]), .RR2(C6[20:16]), .WriteRegister(B5), .WriteData(C24), .RD1(C7), .RD2(C8));
SignExt ins7(.E(C6[15:0]), .S(C9));
buffer2 ins8(.Adder(C5), .RD1(C7), .RD2(C8), .SignEx(C9), .Ins20(C6[20:16]), .Ins15(C6[15:11]), .EnWB(WB), .EnM(M), .EnEX(EX), .clk(CLK), .sAdder(C10), .sRD1(C11), .sRD2(C12), .sSignEx(C13), .sIns20(B1), .sIns15(B2), .sWB(WB1), .sM(M1), .sEX(EX1));
ShiftL ins9(.E(C9), .S(C14));
Adder ins10(.E1(C10), .E2(C14), .S(C15));
Mux5bit ins11(.E1(B1), .E2(B2), .RegDst(EX[4]), .S(B3)); 
Mux ins12(.E1(C13), .E2(C12), .sel(EX[0]), .S(C16));
ALU ins13(.OP1(C11), .OP2(C16), .sel(sel), .zf(ZF), .Res(C17));
ALUControl ins14(.Func(C13[5:0]), .ALUOp(EX[3:1]), .sel(sel));
buffer3 ins15(.clk(CLK), .Adder(C15), .ALU(C17), .zf(ZF), .RD2(C12), .WB(WB1), .M(M1), .Mux5(B3), .sAdder(C18), .sALU(C19), .szf(ZF1), .sRD2(C20), .sWB(WB2), .sM(M2), .sMux5(B4));
AND ins16(.a(ZF1), .b(M2[2]), .s(PCSrc));
Mem ins17(.Address(C19), .WriteData(C20), .MemWrite(M2[0]), .MemRead(M2[1]), .ReadData(C21));
buffer4 ins18(.clk(CLK), .RData(C21), .ALU(C19), .Mux5(B4), .WB(WB2), .sRData(C22), .sALU(C23), .sMux5(B5), .sWB(WB3));
Mux ins19(.E1(C22), .E2(C23), .sel(WB3[0]), .S(C24)); //Despues del buffer4
endmodule

`timescale 1ns/1ns
module Procesador(
    input CLK
);
wire [31:0]C1,C2,C3,C4,C5,C6,C7,C8,C9,C11,C12,C13,C14,C15,C16,C16_1,C17,C20,C22,C25,C26,C27,C28,C31,C32,C33,C35;
wire [4:0]C18,C19,C24,C30,C34;
wire [3:0]C12,C23;
wire [2:0]C11;
wire [1:0]C10;
wire C29,C21; 

//Antes del contador de programa
Mux ins0(        
    .E1(C26),               //Salida de Sumador del Bufer3 y entrada del Mux0 en 1.
    .E2(C3),                //Salida del Sumador a la entrada del Mux0 en 0. 
    .sel(C29),            //Salida de la AND a la entrada del Selec del Mux0.   
    .S(C1)                  //Salida del Mux0 a la entrada del PC.
); 
//Contador de programa
PC ins1(        
    .PCI(C1),               //Salida del Mux0 a la entrada del PC. 
    .clk(CLK),              //Se instancia del clk del PC al CLK del procesador.         
    .PCO(C2)                //Salida del PC, entra a la entrada 1 del Sumador y a su vez a la Memoria de Instrucciones.
); 
//Sumador arriba de insmem
Adder ins2(
    .E1(C2),                //Salida del PC, entra a la entrada 1 del Sumador y a su vez a la Memoria de Instrucciones.
    .E2(32'd4),             //Es la constante de 4.  
    .S(C3)                  //Salida del Sumador a la entrada del Mux0 en 0 y a la entrada del Buffer1.
); 
InsMem ins3(
    .InsAd(C2),             //Salida del PC, entra a la entrada 1 del Sumador y a su vez a la Memoria de Instrucciones.
    .Ins(C4)                //Salida de la Memoria de Instrucciones a la entrada del Buffer1.
);
buffer1 ins4(
    .Adder(C3),             //Salida del Sumador a la entrada del Mux0 en 0 y a la entrada del Buffer1.
    .Ins(C4),               //Salida de la Memoria de Instrucciones a la entrada del Buffer1.
    .clk(CLK),              //Se instancia del clk del PC al CLK del Buffer1. 
    .SalAdder(C5),          //Salida del Buffer1 a la entrada 1 del Buffer2.
    .SalIns(C6)             //Salida 2 del Buffer1 a la entrada de UC, BancoReg en Ent1, Ent2, [15:0]SingExt, [20:16]Buffer2 en entrada 6 y del [15:11]Entrada7 del Buffer2             
);
UC ins5(
    .OP(),         //Salida 2 del Buffer1 a la entrada de UC, BancoReg en Ent1, Ent2, [15:0]SingExt, [20:16]Buffer2 en entrada 6 y del [15:11]Entrada7 del Buffer2 
    .RegDst(),         //Salida de EX en el bit [4] para RegDst del Mux2 de 5 bits.
    .Branch(),             //Salida de la UC a la entrada de M en el Buffer2.          
    .MemRead(),        //Salida del Buffer3 en M a la MemRead de la Memoria.
    .MemToReg(),       //Salida del MemToReg de la UC y entra al Buffer2. 
    .ALUOp(),        //Salida de EX del bit [3:1] para el selector de ALU Control. 
    .MemWrite(),          //Salida de M del Buffer3 y entra al MemWrite de la Memoria.
    .ALUSrc(),         //Salida de EX del bit [0] a la entrada del selector en el Mux1.
    .RegWrite()        //Salida del RegWrite de la UC y entra al Buffer2. 
);
BancReg ins6(
    .RegEn(C10[0]),         //Salida del WB [1] Para el RegWrite.(Banco de Registro) 
    .RR1(C6[25:21]),        //Salida 2 del Buffer1 a la entrada de UC, BancoReg en Ent1, Ent2, [15:0]SingExt, [20:16]Buffer2 en entrada 6 y del [15:11]Entrada7 del Buffer2  
    .RR2(C6[20:16]),        //Salida 2 del Buffer1 a la entrada de UC, BancoReg en Ent1, Ent2, [15:0]SingExt, [20:16]Buffer2 en entrada 6 y del [15:11]Entrada7 del Buffer2 
    .WriteRegister(C34),     //Salida 3 del Buffer4 a la entrada 3 del BancoReg.
    .WriteData(C35),        //Salida del Mux4 y entra en la entrada 4 del BancoReg.
    .RD1(C7),               //Salida 1 del BancoReg a la entrada 2 del Buffer2.
    .RD2(C8)                //Salida 2 del BancoReg a la entrada 3 del Buffer2.
);
SignExt ins7(
    .E(C6[15:0]),           //Salida 2 del Buffer1 a la entrada de UC, BancoReg en Ent1, Ent2, [15:0]SingExt, [20:16]Buffer2 en entrada 6 y del [15:11]Entrada7 del Buffer2 
    .S(C9)
);                //Salida del SignExt a la entrada 4 del Buffer2.
buffer2 ins8(
    .Adder(C5),             //Salida del Buffer1 a la entrada 1 del Buffer2. 
    .RD1(C7),               //Salida 1 del BancoReg a la entrada 2 del Buffer2. 
    .RD2(C8),               //Salida 2 del BancoReg a la entrada 3 del Buffer2.
    .SignEx(C9),            //Salida del SignExt a la entrada 4 del Buffer2.
    .Ins20(C6[20:16]),      //Salida 2 del Buffer1 a la entrada de UC, BancoReg en Ent1, Ent2, [15:0]SingExt, [20:16]Buffer2 en entrada 6 y del [15:11]Entrada7 del Buffer2  
    .Ins15(C6[15:11]),      //Salida 2 del Buffer1 a la entrada de UC, BancoReg en Ent1, Ent2, [15:0]SingExt, [20:16]Buffer2 en entrada 6 y del [15:11]Entrada7 del Buffer2  
    .EnWB(C10),              //Salida de la UC y entra en WB en el Buffer2. 
    .EnM(C11),               //Salida de M del Buffer3 y entra al MemWrite de la Memoria.
    .EnEX(C12),              //Salida de la UC a la entrada de EX en el Buffer2.
    .clk(CLK), 
    .sAdder(C13),           //Salida del Buffer2 a la entrada 1 del Sumador 2.
    .sRD1(C15),             //Salida 2 del Buffer2 a la entrada 1 de la ALU. 
    .sRD2(C16),             //Salida 3 del Buffer2 a la entrada del Mux1 en 0 y a la entrada 4 del Buffer3.  
    .sSignEx(C17),          //Salida del Buffer 2 a la entrada del Func de la AluControl y a la entrada 2 del Mux1 y a la entrada del Shift.
    .sIns20(C18),            //Salida 5 del Buffer2 a la entrada en 0 del Mux2.
    .sIns15(C19),            //Salida 6 del Buffer2 a la entrada en 1 del Mux2. 
    .sWB(C10),              //Salida del Buffer2 en WB a la entrada en WB en del Buffer3. 
    .sM(C11),                 //Salida de la UC a la entrada de M en el Buffer2.
    .sEX(C12)               //Salida del Buffer2 en EX a la entrada en Selec del Mux2, entra en el Sel de AluC y en el selector de Mux1
);
ShiftL ins9(
    .E(C17),                 //Salida del Buffer 2 a la entrada del Func de la AluControl y a la entrada 2 del Mux1 y a la entrada del Shift.
    .S(C14)                  //Salida del Shift y entrada a la entrada 2 del Sumador 2.
);
Adder ins10(
    .E1(C13),               //Salida del Buffer2 a la entrada 1 del Sumador 2.
    .E2(C14),               //Salida del Shift y entrada a la entrada 2 del Sumador 2.
    .S(C20)                 //Salida del Sumador 2 a la entrada 1 del Buffer 3.
);
Mux5bit ins11(
    .E1(C18),                //Salida 5 del Buffer2 a la entrada en 0 del Mux2.
    .E2(C19),                //Salida 6 del Buffer2 a la entrada en 1 del Mux2. 
    .RegDst(C12[0]),         //Salida de EX1 en el bit [4] para RegDst del Mux2 de 5 bits.
    .S(C24)                  //Salida del Mux2 a la entrada 5 del Buffer3.
); 
Mux ins12(
    .E1(C17),               //Salida del Buffer 2 a la entrada del Func de la AluControl y a la entrada 2 del Mux1 y a la entrada del Shift. 
    .E2(C16),               //Salida 3 del Buffer2 a la entrada del Mux1 en 0 y a la entrada 4 del Buffer3. 
    .sel(C12[3]),            //Salida de EX en el bit [0] para el Sel del Mux1. 
    .S(C16_1)                 //Salida del Mux1 a la entrada 2 de la ALU.
);
ALU ins13(
    .OP1(C16),              //Salida 2 del Buffer2 a la entrada 1 de la ALU.
    .OP2(C16_1),              //Salida del Mux1 a la entrada 2 de la ALU.
    .sel(C23),              //Salida de la ALU Control al Selector de la ALU. 
    .zf(C21),                //Salida del ZF a la entrada 2 del Buffer3. 
    .Res(C22)               //Salida de Res de la ALU a la entrada 3 del Buffer3.
);
ALUControl ins14(
    .Func(C17[5:9]),        //Salida del Buffer 2 a la entrada del Func de la AluControl y a la entrada 2 del Mux1 y a la entrada del Shift. 
    .ALUOp(C12[2:1]),       //Salida de EX del bit [3:1] para el selector de ALU Control.
    .sel(C23)               //Salida de la ALU Control al Selector de la ALU. 
);
buffer3 ins15(
    .clk(CLK), 
    .Adder(C20),            //Salida del Sumador 2 a la entrada 1 del Buffer 3. 
    .ALU(C22),              //Salida de Res de la ALU a la entrada 3 del Buffer3. 
    .zf(C21),                //Salida del ZF a la entrada 2 del Buffer3. 
    .RD2(C16),              //Salida 3 del Buffer2 a la entrada del Mux1 en 0 y a la entrada 4 del Buffer3.  
    .WB(C10),               //Salida del Buffer2 en WB a la entrada en WB en del Buffer3.
    .M(C11),                 //Salida de M del Buffer3 y entra al MemWrite de la Memoria.
    .Mux5(C24),              //Salida del Mux2 a la entrada 5 del Buffer3. 
    .sAdder(C25),           //Salida de Sumador del Bufer3 y entrada del Mux en 1.
    .sALU(C27),             //Salida 2 del Buffer3 a la entrada 1 de la Memoria y a la entrada 2 del Buffer4. 
    .szf(C26),              //Salida del ZF en el Buffer3 a la entrada 2 de la AND.  
    .sRD2(C28),             //Salida 3 del Buffer3 a la entrada 2 de la Memoria. 
    .sWB(C10),              //Salida WB del Buffer3 a la entrada WB del Buffer4. 
    .sM(C11),                //Salida del Buffer3 a la entrada 1 del AND, a la MemRead de la Memoria y la MemWrite de la Memoria.
    .sMux5(C30)              //Salida 3 del Buffer3 a la entrada 3 del Buffer4. 
);
AND ins16(
    .a(C11[0]),              //Sale del bit [2] en el Buffer 3 en M y entra a la primera entrada de AND. 
    .b(C26),                //Salida del ZF en el Buffer3 a la entrada 2 de la AND. 
    .s(C29)               //Salida de la AND a la entrada del Selec del Mux0.
);                            
Mem ins17(
    .Address(C27),          //Salida 2 del Buffer3 a la entrada 1 de la Memoria y a la entrada 2 del Buffer4.
    .WriteData(C28),        //Salida 3 del Buffer3 a la entrada 2 de la Memoria. 
    .MemWrite(C11[2]),       //Sale del bit [0] en el Buffer 3 en M y entra en MemWrite de la memoria.
    .MemRead(C11[1]),        //Sale del bit [1] en el Buffer 3 en M y entra en MemRead de la Memoria. 
    .ReadData(C31)          //Salida de la Memoria a la entrada 1 del Buffer4.
);
buffer4 ins18(
    .clk(CLK), 
    .RData(C31),            //Salida de la Memoria a la entrada 1 del Buffer4. 
    .ALU(C27),              //Salida 2 del Buffer3 a la entrada 1 de la Memoria y a la entrada 2 del Buffer4. 
    .Mux5(C30),              //Salida 3 del Buffer3 a la entrada 3 del Buffer4. 
    .WB(C10),               //Salida WB del Buffer3 a la entrada WB del Buffer4. 
    .sRData(C32),           //Salida 1 del Buffer4 a la entrada del Mux4 en 0.
    .sALU(C33),             //Salida 2 del Buffer4 a la entrada del Mux4 en 1.  
    .sMux5(C34),             //Salida 3 del Buffer4 a la entrada 3 del BancoReg.
    .sWB(C10)               //Salida del WB [1] Para el RegWrite.(Banco de Registro)
);
//Despues del buffer4
Mux ins19(
    .E1(C33),               //Salida 2 del Buffer4 a la entrada del Mux4 en 1. 
    .E2(C32),               //Salida 1 del Buffer4 a la entrada del Mux4 en 0.
    .sel(C10[1]),           //Salida del WB [0] para MemToReg del Mux4.
    .S(C35)                 //Salida del Mux4 y entra en la entrada 4 del BancoReg.
); 
endmodule*/