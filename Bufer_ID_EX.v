`timescale 1ns/1ns 

//Creacion del modulo de I/O
module buffer2(
    input [31:0]Adder,
    input [31:0]RD1,
    input [31:0]RD2,
    input [31:0]SignEx,
    input [4:0]Ins20,
    input [4:0]Ins15,
    input [1:0]EnWB,    
    input [2:0]EnM,
    input [4:0]EnEX,
    input clk,
    output reg [31:0]sAdder,
    output reg [31:0]sRD1,
    output reg [31:0]sRD2,
    output reg [31:0]sSignEx,
    output reg [4:0]sIns20,
    output reg [4:0]sIns15,
    output reg [1:0]sWB,    
    output reg [2:0]sM,
    output reg [4:0]sEX
);

//Asignacion de wire o reg
//NA

//Asignaciones, e/o instancias, y/o bloques secuenciales
always @ (posedge clk) begin
    sAdder = Adder;
    sRD1 = RD1;
    sRD2 = RD2;
    sSignEx = SignEx;
    sIns20 = Ins20;
    sIns15 = Ins15;
    sWB = EnWB;
    sM = EnM;
    sEX = EnEX;
end

endmodule    
