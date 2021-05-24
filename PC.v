`timescale 1ns/1ns

module PC(
    input pce,
    input clk,
    output reg pcs
);
reg [1:0]regi[0:1]
always @(posedge clk) begin
    pcs = pce;
end

endmodule