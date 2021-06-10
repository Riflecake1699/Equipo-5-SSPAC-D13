`timescale 1ns/1ns
module PC(
    input [31:0]PCI,
    input clk,
    output reg [31:0]PCO
);

initial begin
    PCO <= 32'd0;
end

always @(posedge clk) begin
    if (PCI)
        PCO = PCI;
    else PCO = 32'b0;
    /*PCO <= (PCI)?PCI:0;*/
end
endmodule