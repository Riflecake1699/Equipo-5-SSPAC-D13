`timescale 1ns/1ns

module ADD(
    input [31:0]EADD,
    input [31:0]Ecuatro,
    output reg[31:0]SADD  
);
//assign Ecuatro = 4;

initial 
begin
         
     SADD =  EADD + Ecuatro;   
end
endmodule