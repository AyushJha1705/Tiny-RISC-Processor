`timescale 1ns/1ps

module fetch_unit (
    input clk,
    input reset,
    input [31:0] branchPC,
    input isBranchTaken,
    output [31:0] inst,
    output [31:0] pc
);

    reg [31:0] pc_reg;
    reg [31:0] instr_mem [0:255];

    wire [31:0] next_pc = isBranchTaken ? branchPC : (pc_reg + 32'd4);

   always @(posedge clk or posedge reset) begin
        if (reset)
            pc_reg <= 32'd0;
        else
            pc_reg <= next_pc;
    end

    assign pc = pc_reg;
    assign inst = instr_mem[pc_reg[9:2]];

endmodule