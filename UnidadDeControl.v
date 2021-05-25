`timescale 1ns/1ns

module UDC(
     input [5:0]op,
	 output reg Memtoreg,
	 output reg Memtowrite,
	 output reg[2:0]ALUop,
	 output reg Regwrite,
	 output reg RegDst,
	 output reg Branch,
	 output reg MemRead,
	 output reg ALUSrc
);

always @*
begin


		case(op)
		 6'b000100: //beq
		 begin
		                 //RegDst <= 1'b0;
		     ALUSrc <= 1'b0;
		                 //Memtoreg <= 1'b0;
		     Regwrite <= 1'b0;
		     Memtowrite <= 1'b0;
		     MemRead <= 1'b0;
		     Branch <= 1'b1;
		     ALUop <= 3'b010; //
		 end
		 6'b100011: //Sw
		 begin
			               //RegDst <= 1'b0;
		     ALUSrc <= 1'b1;
		                  //Memtoreg <= 1'b0;
		     Regwrite <= 1'b0;
		     Memtowrite <= 1'b1;
		     MemRead <= 1'b0;
		     Branch <= 1'b0;
		     ALUop <= 3'b010; //
		 end
		 6'b101011:  //lw
		 begin
			 RegDst <= 1'b0;
		     ALUSrc <= 1'b1;
		     Memtoreg <= 1'b1;
		     Regwrite <= 1'b1;
		     Memtowrite <= 1'b0;
		     MemRead <= 1'b1;
		     Branch <= 1'b0;
		     ALUop <= 3'b010; //
		 end
		 6'b000000:
		 begin
		     RegDst <= 1'b1;          
		     ALUSrc <= 1'b0;
		     Memtoreg <= 1'b0;
		     Regwrite <= 1'b1;
		     Memtowrite <= 1'b0;
		     MemRead <= 1'b0;
		     Branch <= 1'b0;
		     ALUop <= 3'b010; //intruccciones de tipo R
		 end
     	endcase
	
     
		 
end

endmodule

