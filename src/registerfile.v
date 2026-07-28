`timescale 1ns/1ps

module registerfile(
    input clk, input reset,
    input isWb,
    input [3:0] rs1, rs2, rd,
    input [31:0] writeData,
    output [31:0] op1, op2
);

    reg [31:0] regFile [0:15];
    integer i;

    assign op1 = regFile[rs1];
    assign op2 = regFile[rs2];

    always @(posedge clk or posedge reset) begin
        if (reset)
            for (i=0; i<16; i=i+1)
                regFile[i] <= 32'd0;
        else if (isWb)
            regFile[rd] <= writeData;
    end
endmodule