`timescale 1ns/1ps

module operfetch(
    input [31:0] pc,
    input [31:0] inst,
    input isRet, isSt, isCall,

    output [4:0] opcode,
    output isImmediate,
    output [3:0] rs1, rs2, rd,
    output reg [31:0] immx,
    output [31:0] branchTarget
);

    wire [26:0] offset = inst[26:0];
    wire [3:0] rd_i  = inst[25:22];
    wire [3:0] rs1_i = inst[21:18];
    wire [3:0] rs2_i = inst[17:14];
    wire [15:0] imm = inst[15:0];
    wire [1:0] modif = inst[17:16];

    assign opcode = inst[31:27];
    assign isImmediate = inst[26];

    assign rs1 = isRet ? 4'd15 : rs1_i;
    assign rs2 = isSt  ? rd_i  : rs2_i;
    assign rd  = rd_i;

    always @(*) begin
        case(modif)
            2'b00: immx = {{16{imm[15]}}, imm};
            2'b01: immx = {16'd0, imm};
            2'b10: immx = {imm, 16'd0};
            default: immx = {{16{imm[15]}}, imm};
        endcase
    end

    assign branchTarget = pc + {{3{offset[26]}}, offset, 2'b00};

endmodule