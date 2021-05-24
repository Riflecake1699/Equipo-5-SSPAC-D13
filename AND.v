`timescale 1ns/1ns

module AND(
    input AND,
    input AND1,
    output reg SAND
);

assign SAND = AND & AND1;

endmodule