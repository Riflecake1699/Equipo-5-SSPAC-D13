`timescale 1ps/1ps 

//Creacion del modulo de I/O
module buffer3(
    input clk,
    input [31:0]Adder,
    input [31:0]ALU,
    input zf,
    input [31:0]RD2,
    input [1:0]WB,
    input [2:0]M,
    input [4:0]Mux5,
    output reg [31:0]sAdder,
    output reg [31:0]sALU,
    output reg szf,
    output reg [31:0]sRD2,
    output reg [1:0]sWB,
    output reg [2:0]sM,
    output reg [4:0]sMux5
);

always @ (posedge clk) begin
    sAdder <= Adder;
    sALU <= ALU;
    szf <= zf;
    sRD2 <= RD2;
    sWB <= WB;
    sM <= M;
    sMux5 <= Mux5;
end

endmodule
