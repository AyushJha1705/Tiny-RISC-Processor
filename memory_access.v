`timescale 1ns/1ps

module memory_access (
    input clk,
    input isLd,
    input isSt,
    input [31:0] aluResult,
    input [31:0] op2,
    output reg [31:0] ldResult
);

    reg [31:0] dataMem [0:255];

    always @(*) begin
        if (isLd)
            ldResult = dataMem[aluResult[9:2]];
        else
            ldResult = 32'd0;
    end

    always @(posedge clk) begin
        if (isSt)
            dataMem[aluResult[9:2]] <= op2;
    end
endmodule