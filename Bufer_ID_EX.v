`timescale 1ns/1ns 

//Creacion del modulo de I/O
module buffer2(
    input [31:0]EnBuf,
    input [31:0]EnRd1,
    input [31:0]EnRd2,
    input [31:0]EnSX,
    input [4:0]EnIns1,
    input [4:0]EnIns2,
    input [1:0]EnWB,    
    input [2:0]EnM,
    input [4:0]EnEX,
    input clk,
    output reg[31:0]SalAdd,
    output reg[31:0]SalAdd1,
    output reg[31:0]SalMux2,
    output reg[31:0]SalAlu,
    output reg[4:0]SalMux3,
    output reg[4:0]SalMux31,
    output reg[1:0]SalWB,
    output reg[2:0]SalM,
    output reg [4:0]SalEX
);

//Asignacion de wire o reg
//NA
/*initial begin
    SalAdd <= 32'd0;
end*/
//Asignaciones, e/o instancias, y/o bloques secuenciales
always @(posedge clk) begin
    SalAdd <= EnBuf;
    SalAdd1 <= EnRd1;
    SalMux2 <= EnRd2;
    SalAlu <= EnSX;
    SalMux3 <= EnIns1;
    SalMux31 <= EnIns2;
    SalWB <= EnWB;
    SalM <= EnM;
    SalEX <= EnEX;
end

endmodule    
