`timescale 1ns/100ps
module testbench_ROM ();

    reg clk;
    reg [4:0] addr;
    wire[15:0] q_ROM;

    PlayerIDROM_16 DUT_Rom(addr, clk, q_ROM);

    always begin
        clk = 1'b0;
        #10;
        clk = 1'b1;
        #10;
    end

    initial 
    begin
        @(posedge clk);
        addr = 5'b0000;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        addr = 5'b0001;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        addr = 5'b0010;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        addr = 5'b0011;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        addr = 5'b0100;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
    end  
endmodule
