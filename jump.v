`timescale 1ns/1ns
module jump(
    input [25:0]E,
    output reg [27:0]S
);

always @* begin
    S = {E, 2'b00};
end

endmodule