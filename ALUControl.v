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
	     case (func)
		 6'b100000:
		     s <=3'b001;
         6'b100010:
		     s <=3'b010;
		 6'b100100:
		     s <=3'b011;
		 6'b100101:
		     s <=3'b100;
		 6'b101010:
		     s <=3'b101;
		 6'b101011:
		     s <=3'b110;	 
		 
		 endcase
	 end
end

endmodule
