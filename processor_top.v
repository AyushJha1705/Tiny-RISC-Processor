`timescale 1ns/1ps

module processor_top(input clk, input reset);

    wire [31:0] pc, inst;
    wire [31:0] branchPC;
    wire isBranchTaken;

    wire [4:0] opcode;
    wire isImmediate;

    wire isRet,isSt,isCall,isJmp,isBeq,isBgt;
    wire isLd,isWb;
    wire [3:0] aluSignals;

    wire [3:0] rs1,rs2,rd;
    wire [31:0] immx, branchTarget;

    wire [31:0] op1, op2;
    wire [31:0] aluResult;
    wire [31:0] ldResult;
    wire [31:0] writeData;

    fetch_unit F(clk, reset, branchPC, isBranchTaken, inst, pc);

    operfetch OF(pc, inst, isRet, isSt, isCall,
                 opcode, isImmediate, rs1, rs2, rd, immx, branchTarget);

    control_signals CU(opcode, isImmediate,
        isRet, isSt, isCall,
        aluSignals, isBeq, isBgt, isJmp,
        isLd, isWb);

    registerfile RF(clk, reset, isWb,
        rs1, rs2, rd,
        writeData, op1, op2);

    execute_unit EX(
        clk, branchTarget, op1, op2, immx,
        isRet, isJmp, isBeq, isBgt, isImmediate,
        aluSignals, branchPC, isBranchTaken, aluResult);

    memory_access MEM(
        clk, isLd, isSt,
        aluResult, op2, ldResult);

    assign writeData = isLd ? ldResult : aluResult;

endmodule