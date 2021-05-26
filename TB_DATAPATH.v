`timescale 1ns/1ns

module TB_DATAPATH();

reg TB_Clk;

DATAPATH h(TB_Clk);

always 
 #100 TB_Clk = ~TB_Clk;
 
 initial
 begin
     TB_Clk <= 0;
	 #1600 $stop;
 end

endmodule