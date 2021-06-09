`timescale 1ps/1ps
//Creacion del modulo de I/O
module bufer1(
    input [31:0]EnAdd,
    input [31:0]EnInsM,
    input clk,
    output reg[31:0]SalBuf,
    output reg[31:0]SalInst
);

//Asignacion de wires o reg
//Na
initial begin
    SalBuf <= 32'd0;
end
//Asignaciones, e/o instancias, y/o bloques secuenciales
always @(posedge clk) begin
     SalBuf = EnAdd;
     SalInst = EnInsM;   
end

endmodule
