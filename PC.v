`timescale 1ns/1ns

module PC(
    input [31:0]pce,
    input clk,
    output reg [31:0]pcs
);

initial
pcs = 32'b0;

always @(posedge clk) begin
    pcs = pce;
end

endmodule