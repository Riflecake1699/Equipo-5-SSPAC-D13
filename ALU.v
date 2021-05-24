`timescale 1ns/1ns

//creacion del modulo
module ALU(
             input [31:0]a,b,
			 input [2:0]op2,
			 output reg[31:0]s,
			 output reg Z
);
always @*
begin
     case(op2)
	     3'd0: //AND
		 begin
			 s<= a & b;
		 end
	     3'd1: //OR
		 begin 
		     s<= a | b;
		 end	 
	     3'd2: //suma
         begin		
    		s<= a + b;
		 end
	     3'd3: //resta
         begin		
    		 s<= a - b;
		 3'd4: //NOR
         begin		
    		 s<= a ~| b;
		 end
	     3'd5: // SLT
         begin		 
		     s<= (a > b) ? 1:0;
		 end 
	 endcase
	     Z <=(s)?0:1;
end
endmodule
