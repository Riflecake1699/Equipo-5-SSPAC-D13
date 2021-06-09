`timescale 1ps/1ps 

//Creacion del modulo de I/O
module bufer3(
    input [31:0]EnAdd,
    input [31:0]EnAlRes,
    input [31:0]EnBu,
    input [4:0]EnMux3,
    input [1:0]EnWB,
    input [2:0]EnM,
    input ZF,
    input clk,
    output reg[31:0]SalMux1,
    output reg[31:0]SalDM,
    output reg[31:0]SalDMW,
    output reg[4:0]SalBu4,
    output reg[1:0]SalWB,
    output reg SalZF,
    output reg [2:0]SalM
);

//Asignacion de reg o wire
//NA
initial begin
    SalMux1 <= 32'd0;
end
//Asignaciones, e/o instancias, y/o bloques secuenciales
always @ (posedge clk) begin
    SalMux1 <= EnAdd;
    SalDM <= EnAlRes;
    SalDMW <= EnBu;
    SalBu4 <= EnMux3;
    SalWB <= EnWB;
    SalZF <= ZF;
    SalM <= EnM;
end

endmodule
