`timescale 1ns/1ns
module Mem(
    input [31:0]Address,
    input [31:0]WriteData,
    input MemWrite,
    input MemRead,
    output reg [31:0]ReadData
);

reg [31:0]Mem[0:3100];

initial begin
    $readmemh("data.txt", Mem);
end

always @* begin
    if (MemRead) begin
        ReadData = Mem[Address];
    end
    if (MemWrite) begin
        Mem[Address] = WriteData;
    end
end
endmodule