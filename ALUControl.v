`timescale 1ns/1ns

module AC(
     input [2:0]Aop,
	 input [5:0]func,
	 output reg [2:0]s
);

always @*
begin
     if(Aop == 3'b010)
	 begin
	     case (func) //AND-, OR-, SUB-, MUL-, DIV-, ADD-, SLT-, NOP.
		 begin
		 6'b100000:
		     s <=3'b001; //AND
         6'b100010: 
		     s <=3'b010; //OR
		 6'b100100:
		     s <=3'b011; //SUB
		 6'b100101:
		     s <=3'b100; //MUL
		 6'b101010:
		     s <=3'b101; //DIV
		 6'b101011:
		     s <=3'b110; //ADD
		 6'b101111:
		     s <=3'b111; //SLT
		 6'b000000:
		     s<=3'b000; //NOP
		 endcase
	 end
end

endmodule