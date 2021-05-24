`timescale 1ns/1ns

module signextend(
    input [15:0]Esix,
    output reg[31:0]Ssix
);

always @*
begin
  Esix <= {{16{Esix[15]}},Esix}
end
    
endmodule