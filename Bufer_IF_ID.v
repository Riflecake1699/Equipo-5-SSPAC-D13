`timescale 1ps/1ps
//Creacion del modulo de I/O
module buffer1(
    input [31:0]Adder,
    input [31:0]Ins,
    input clk,
    output reg[31:0]SalAdder,
    output reg[31:0]SalIns
);

//Asignacion de wires o reg
//Na

//Asignaciones, e/o instancias, y/o bloques secuenciales
always @(posedge clk) begin
     SalAdder = Adder;
     SalIns = Ins;   
end

endmodule
