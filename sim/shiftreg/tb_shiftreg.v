`timescale 1ns/100ps
module tb_shiftreg();
    reg BitIn, Shift, Clk, Rst;
    reg [5:0] RstValue;
    wire [5:0] RegContent;
    
    always begin // 2ns
        Clk = 1'b0;
        #1;
        Clk = 1'b1;
        #1;
    end


    ShiftReg_6b DUT_SR(BitIn, Shift, RegContent, Clk, Rst, RstValue);

    initial begin
        Rst = 1; Shift = 0; BitIn = 0; RstValue = 6'b110010;
        #2 Rst = 0;
        #2 Rst = 1; Shift = 1;
        #2 Shift = 0; BitIn = 1;
        #2 Shift = 1;
        #2 Shift = 0; BitIn = 0;
        #2 Shift = 1;
        #2 Shift = 0; RstValue = 6'b000000;
        #2 Rst = 0;
        #2 Rst = 1;
    end

endmodule



