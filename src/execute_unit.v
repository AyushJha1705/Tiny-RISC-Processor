`timescale 1ns/1ps

module execute_unit (
    input clk,
    input [31:0] branchTarget,
    input [31:0] op1, op2, immx,
    input isRet, isJmp, isBeq, isBgt, isImmediate,
    input [3:0] aluSignals,
    output [31:0] branchPC,
    output isBranchTaken,
    output reg [31:0] aluResult
);

    wire [31:0] B = isImmediate ? immx : op2;
    wire [31:0] sub = op1 - B;

    assign branchPC = isRet ? op1 : branchTarget;

   reg eq; reg gt;   
   always @(posedge clk) begin     
    if (aluSignals == 4'd5) begin 
        eq <= (sub == 0);
        gt <= ($signed(op1) > $signed(B));
    end
end

    assign isBranchTaken = isJmp | (isBeq & eq) | (isBgt & gt);

    always @(*) begin
        case (aluSignals)
            4'd0: aluResult = op1 + B;
            4'd1: aluResult = sub;
            4'd2: aluResult = op1 * B;
            4'd3: aluResult = (B!=0)? op1/B : 0;
            4'd4: aluResult = (B!=0)? op1%B : 0;
            4'd6: aluResult = op1 & B;
            4'd7: aluResult = op1 | B;
            4'd8: aluResult = ~B;
            4'd9: aluResult = B;
            4'd10: aluResult = op1 << B[4:0];
            4'd11: aluResult = op1 >> B[4:0];
            4'd12: aluResult = $signed(op1) >>> B[4:0];
            default: aluResult = 0;
        endcase
    end
endmodule