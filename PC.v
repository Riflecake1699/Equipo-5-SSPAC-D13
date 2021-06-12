`timescale 1ns/1ns
module PC(
    input [31:0]PCI,
    input clk,
    output reg [31:0]PCO
);

always @(posedge clk) begin
    if (PCI) begin
        PCO = PCI;
    end
    else begin
        PCO = 32'd0;
    end
end
endmodule