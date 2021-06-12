`timescale 1ns/1ns 

//Creacion del modulo de I/O
module buffer3(
    input [31:0]Adder,
    input [31:0]ALU,
    input [31:0]RD2,
    input [4:0]Mux5bit,
    input [1:0]WB,
    input [2:0]M,
    input ZF,
    input clk,
    output reg[31:0]sAdder,
    output reg[31:0]sALU,
    output reg[31:0]sRD2,
    output reg[4:0]sMux5bit,
    output reg[1:0]sWB,
    output reg sZF,
    output reg [2:0]sM
);

//Asignacion de reg o wire
//NA

//Asignaciones, e/o instancias, y/o bloques secuenciales
always @ (posedge clk) begin
    sAdder <= Adder;
    sALU  <= ALU;
    sRD2 <= RD2;
    sMux5bit <= Mux5bit;
    sWB <= WB;
    sZF <= ZF;
    sM <= M;
end

endmodule
