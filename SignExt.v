`timescale 1ps/1ps
module SignExt(
    input [15:0]E,
    output reg [31:0]S
);

always @* begin
    S <= {{16{E[15]}},E};
end

endmodule