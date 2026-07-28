`timescale 1ns/1ps

module processor_tb;

    reg clk;
    reg reset;

    // Instantiate UUT (Unit Under Test)
    processor_top uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation (10ns period)
    always #10 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #15;         
        reset = 0;  
        #600;       
        $finish;
    end

    integer i;
    initial begin      
        // Clear instruction memory
        for (i = 0; i < 256; i = i + 1)
            uut.F.instr_mem[i] = 32'd0;
            
            uut.F.instr_mem[0] = 32'b01001100010000000000000000000001; 
            uut.F.instr_mem[1] = 32'b01001100100000000000000000000101; 
            uut.F.instr_mem[2] = 32'b00010000010001001000000000000000;
            uut.F.instr_mem[3] = 32'b00001100100010000000000000000001;
            uut.F.instr_mem[4] = 32'b00101100000010000000000000000001;
            uut.F.instr_mem[5] = 32'b10001111111111111111111111111101;
            uut.F.instr_mem[6] = 32'b01001000110000000100000000000000; 
    end
    
    // Monitor Output
    initial begin
        $monitor("Time=%0t | PC=%0d | R1=%0d R2=%0d R3=%0d R4=%0d eq=%b gt=%b isBeq=%b, isBgt=%b",
            $time,
            uut.pc,
            uut.RF.regFile[1],
            uut.RF.regFile[2],
            uut.RF.regFile[3],
            uut.RF.regFile[4],
            uut.EX.eq,
            uut.EX.gt,
            uut.CU.isBeq,
            uut.CU.isBgt
        );
    end

endmodule