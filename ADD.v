`timescale 1ns/1ns

module ADD(
    input EADD,
    input Ecuatro,
    output reg[31:0]SADD  
);
//assign Ecuatro = 4;

initial 
begin
         
     SADD =  EADD + Ecuatro;   
end
endmodule