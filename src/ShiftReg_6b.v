module ShiftReg_6b(BitIn, Shift, RegContent, Rst, RstValue);
    input BitIn, Shift, Rst;
    input [5:0] RstValue;
    output [5:0] RegContent;
    reg [5:0] RegContent;

    always@(negedge Rst) begin
        RegContent <= RstValue;
    end

    always@(posedge Shift) begin
        RegContent[5] <= RegContent[4];
        RegContent[4] <= RegContent[3];
        RegContent[3] <= RegContent[2];
        RegContent[2] <= RegContent[1];
        RegContent[1] <= RegContent[0];
        RegContent[0] <= BitIn;
    end
endmodule