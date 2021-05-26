`timescale 1ps/1ps
module PC(
    input [31:0]PCI,
    input clk,
    output reg [7:0]PCO
);

initial begin
    PCO <= 8'd0;
end

always @(posedge clk) begin
    PCO <= (PCI)?PCI[7:0]:0;
end
endmodule