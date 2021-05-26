`timescale 1ns/1ns

module BR(
         input [4:0]RA1,
		 input [4:0]RA2,
		 input [31:0]Di,
		 input [4:0]Dir,
		 input Write,
		 output reg[31:0]Dr1,
		 output reg[31:0]Dr2
);

reg [31:0]REGI[0:31];

initial
begin
     $readmemb("TestF1_BReg",REGI);
end

always @*
begin
     
	 Dr1 = REGI[RA1];
	 Dr2 = REGI[RA2];
	 
	 if (Write == 1)
	 begin
	     REGI[Dir] <= Di;
	 end


end

endmodule	 
