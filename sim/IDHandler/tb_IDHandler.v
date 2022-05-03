`timescale 1 ns/100ps
module tb_IDHandler();

    reg clk, rst;
    reg LogoutCommand_from_GC, PasswordButton;
    reg [3:0] Switches;

    wire MatchedID;

    wire [4:0] PlayerAddress;

    IDHandler DUT_IDHandler (clk, rst, Switches, PasswordButton, LogoutCommand_from_GC, MatchedID, PlayerAddress);

    always begin
        clk = 1'b0;
        #10;
        clk = 1'b1;
        #10;
    end

    initial begin
        rst = 1'b1;
        @(posedge clk);
        @(posedge clk);
        rst = 1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        rst = 1'b1;
        Switches = 4'b0000;
        @(posedge clk);
        @(posedge clk);
        PasswordButton = 1'b1;
        @(posedge clk);
        PasswordButton = 1'b0;
        @(posedge clk);
        @(posedge clk);
        Switches = 4'b0011;
        @(posedge clk);
        @(posedge clk);
        PasswordButton = 1'b1;
        @(posedge clk);
        PasswordButton = 1'b0;
        @(posedge clk);
        @(posedge clk);
        Switches = 4'b0111;
        @(posedge clk);
        @(posedge clk);
        PasswordButton = 1'b1;
        @(posedge clk);
        PasswordButton = 1'b0;
        @(posedge clk);
        @(posedge clk);
        Switches = 4'b0100;
        @(posedge clk);
        @(posedge clk);
        PasswordButton = 1'b1;
        @(posedge clk);
        PasswordButton = 1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        LogoutCommand_from_GC = 1'b1;
        @(posedge clk);
        LogoutCommand_from_GC = 1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
    end
endmodule




