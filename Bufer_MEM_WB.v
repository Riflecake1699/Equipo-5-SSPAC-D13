`timescale 1ps/1ps 

//Creacion del modulo de I/O
module buffer4(
    input clk,
    input [31:0]RData,
    input [31:0]ALU,
    input [4:0]Mux5,
    input [1:0]WB,
    output reg [31:0]sRData,
    output reg [31:0]sALU,
    output reg [4:0]sMux5,
    output reg [1:0]sWB
);

//Asignacion de reg o wire
//NA

//Asignaciones, e/o instancias, y/o bloques secuenciales
always @ (posedge clk) begin    
    sRData <= RData;
    sALU <= ALU;
    sMux5 <= Mux5;
    sWB <= WB;
end

endmodule