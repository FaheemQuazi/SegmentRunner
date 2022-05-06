module ShiftReg_6b(BitIn, Shift, RegContent, Clk, Rst, RstValue);
    input BitIn, Shift, Clk, Rst;
    input [5:0] RstValue;
    output [5:0] RegContent;
    reg [5:0] RegContent;

    always@(posedge Clk) begin
        if (Rst == 1'b0) begin
            RegContent <= RstValue;
        end else if (Shift == 1'b1) begin
            RegContent[5] <= RegContent[4];
            RegContent[4] <= RegContent[3];
            RegContent[3] <= RegContent[2];
            RegContent[2] <= RegContent[1];
            RegContent[1] <= RegContent[0];
            RegContent[0] <= BitIn;
        end
    end
endmodule