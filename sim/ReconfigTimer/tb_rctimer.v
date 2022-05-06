`timescale 1ns/100ps
module tb_rctimer();
    reg Clk, Rst, Enable, Clear;
    reg [9:0] CfgValue;
    wire Tick;

    always begin // 2ns
        Clk = 1'b0;
        #1;
        Clk = 1'b1;
        #1;
    end

    Timer_rc DUT_Timer(Enable, Clear, CfgValue, Tick, Clk, Rst);

    initial begin
        Rst = 1; Enable = 0; Clear = 0; CfgValue = 10'd15;
        @(posedge Clk);
        #1 Rst = 0;
        @(posedge Clk);
        #1 Rst = 1; Enable = 1;
    end

endmodule



