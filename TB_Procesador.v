`timescale 1ns/1ns 

module TB_Procesador();

reg TB_CLK;

Procesador DUV_Fase2(
    .CLK(TB_CLK)
);

always 
#100 TB_CLK = ~TB_CLK;
initial begin
    TB_CLK <= 0;
    #8000
    $stop;
end

endmodule
