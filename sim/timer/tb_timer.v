`timescale 1ns/100ps
module tb_timer();
    reg Clk_s, Rst_s, Enable_s;
    wire TickReg_s, TickLFSR_s;

    always begin // 20ns
        Clk_s = 1'b0;
        #10;
        Clk_s = 1'b1;
        #10;
    end

    Timer_1ms DUT_Timer(Enable_s, TickReg_s, Clk_s, Rst_s);

    initial begin
        Rst_s = 1; Enable_s = 0;
        @(posedge Clk_s);
        #1 Rst_s = 0;
        @(posedge Clk_s);
        #1 Rst_s = 1; Enable_s = 1;
    end

endmodule


