`timescale 1ps/1ps 

//Creacion del modulo de I/O
module bufer4(
    input [31:0]EnRD,
    input [31:0]EnBuf3,
    input [4:0]EnBf3,
    input [1:0]EnWB,
    input clk,
    output reg[31:0]SalMux4,
    output reg[31:0]SalMux40,
    output reg[4:0]SalWR,
    output reg[1:0]SalWB
);

//Asignacion de reg o wire
//NA

//Asignaciones, e/o instancias, y/o bloques secuenciales
always @ (posedge clk) begin    
    SalMux4 <= EnRD;
    SalMux40 <= EnBuf3;
    SalWR <= EnBf3;
    SalWB <= EnWB;
end

endmodule