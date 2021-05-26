`timescale 1ps/1ps
module InsMem (
    input [7:0]InsAd,
    output reg [31:0]Ins
);

reg [7:0]IM[0:400];
reg [7:0] p0, p1, p2, p3; 

initial begin
    $readmemb("memins.mem", IM);
end

always @* begin
    p0 <= IM[InsAd];
    p1 <= IM[InsAd+1];
    p2 <= IM[InsAd+2];
    p3 <= IM[InsAd+3];
    Ins <= {p0,p1,p2,p3};
end
endmodule