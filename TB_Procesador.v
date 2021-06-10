`timescale 1ns/1ns 

module TB_Procesador();

reg TB_clk;

Procesador DUV_Fase2(
    .clk(TB_clk)
);

always 
#100 TB_clk = ~TB_clk;
initial begin
    TB_clk <= 0;
    #8000
    $stop;
end

endmodule
