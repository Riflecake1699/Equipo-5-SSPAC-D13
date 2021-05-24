`timescale 1ns/1ns

module Mem2(
             input Ewr,
             input [31:0]Dir,
			 input [31:0]Din,
			 output reg[31:0]Dout
);

reg [31:0] E [0:31];

always @*begin
     
	 if (Ewr == 1)
	     begin
		 E[Dir] <= Din;
		 Dout <= 32'dx;
		 end
	 else
	     begin
		 Dout <= E[Dir];
		 end
	 
end
/*$readmemb("data.mem",M);*/
	 
endmodule
