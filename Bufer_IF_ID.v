`timescale 1ns/1ns
//Creacion del modulo de I/O
module buffer1(
    input [31:0]Adder,
    input [31:0]Ins,
    input clk,
    output reg[31:0]SalAdder,
    output reg[31:0]SalIns
);

//Asignaciones, e/o instancias, y/o bloques secuenciales
always @(posedge clk) begin
     SalAdder <= Adder;
     SalIns <= Ins;   
end

endmodule
