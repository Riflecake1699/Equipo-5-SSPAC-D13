`timescale 1ns/1ns

module MDI(
    input address,
    output reg[31:0]Ins
);

reg [7:0]MI[0:400];

initial 
begin
  $readmemb("TestF1_MemInst.mem",MI);
end

always @* begin
    Ins = {MI[address],MI[address+1],MI[address+2],MI[address+3]};
end

endmodule