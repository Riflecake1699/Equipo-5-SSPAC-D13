`timescale 1ns/1ns
module InsMem (
    input [31:0]InsAd,
    output reg [31:0]Ins
);

reg [7:0]IM[0:400];


initial begin
    $readmemb("TestF2_MemInst.mem", IM);
end

always @* begin
    Ins = {IM[InsAd], IM[InsAd+1], IM[InsAd+2], IM[InsAd+3]};
end

endmodule