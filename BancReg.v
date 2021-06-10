`timescale 1ns/1ns

module BancReg(
    input RegEn,
    input [4:0]RR1,
    input [4:0]RR2,
    input [4:0]WriteRegister,
    input [31:0]WriteData,
    output reg[31:0]RD1,
    output reg[31:0]RD2
);
reg [31:0]Banco[0:31];

initial begin
    $readmemh("TestF1_BReg.mem", Banco);
end

always @* begin
    RD1 = Banco[RR1];
    RD2 = Banco[RR2];
    if (RegEn) begin
        Banco[WriteRegister] <= WriteData;
    end
end
    
endmodule