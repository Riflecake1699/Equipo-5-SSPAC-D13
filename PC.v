`timescale 1ps/1ps
module PC(
    input [31:0]PCI,
    input clk,
    output reg [31:0]PCO
);

initial begin
    PCO <= 32'd0;
end

always @(posedge clk) begin
    PCO <= PCI;
end
endmodule