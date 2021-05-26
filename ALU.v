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
     case(op2)         //8 OPERACIONES AND-, OR-, SUB-, MUL-, DIV-, ADD-, SLT-, NOP.
	     3'd0: //AND
		 begin
			 s= a & b;
		 end
	     3'd1: //OR
		 begin 
		     s= a | b;
		 end	 
	     3'd2: //sub
         begin		
    		 s= a - b;
		 end
	     3'd3: //MUL
         begin		
    		 s= a * b;
		 end
		 3'd4: //DIV
		 begin
		     s= a / b;
		 end
		 3'd5: //ADD
		 begin
		     s= a + b;
		 end
	     3'd6: // SLT
         begin		 
		     s= (a < b) ? 1:0;
		 end 
		 3'd7: //NOP
		 begin
		     s= a << 0;
		 end
	 endcase
	     Z <=(s)?0:1;
end
endmodule