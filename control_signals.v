`timescale 1ns/1ps

module control_signals(
    input [4:0] opcode, input isImmediate,
    output reg isRet, isSt, isCall,
    output reg [3:0] aluSignals,
    output reg isBeq, isBgt, isJmp,
    output reg isLd, isWb
);

always @(*) begin
    isRet=0; isSt=0; isCall=0;
    aluSignals=4'd0;
    isBeq=0; isBgt=0; isJmp=0;
    isLd=0; isWb=0;

    case(opcode)
        5'b00000,5'b00001,5'b00010,5'b00011,
        5'b00100,5'b00101,5'b00110,5'b00111,5'b01000:   
            begin isWb=1; aluSignals=opcode[3:0]; end

        5'b01001: begin isWb=1; aluSignals=4'd9; end  //mov (ops same as ALU, just separating)

        5'b01010,5'b01011,5'b01100:                   //lsl, lsr, asr
            begin isWb=1; aluSignals=opcode[3:0]; end

        5'b01110: begin isWb=1; isLd=1; aluSignals=4'd0; end  //ld
        5'b01111: begin isSt=1; aluSignals=4'd0; end          //st

        5'b10000: begin isBeq=1; aluSignals=4'd1; end    //beq   
        5'b10001: begin isBgt=1; aluSignals=4'd1; end    //bgt   

        5'b10010: begin isJmp=1; end                      //b
        5'b10011: begin isJmp=1; isCall=1; isWb=1; end    //call
        5'b10100: begin isJmp=1; isRet=1; end             //ret
    endcase
end
endmodule