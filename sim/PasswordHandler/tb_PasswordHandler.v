`timescale 1 ns/100ps
module tb_PasswordHandler();

    reg clk, rst;
    reg LogoutCommand_from_GC, PasswordButton;
    reg [3:0] Switches;
    reg MatchedID;
    reg[4:0] PlayerAddress_from_ID;
    reg isGuest_from_ID;
    wire LoggedIn, LoggedOut, isGuest_to_GC, Logout_to_ID;
    wire [4:0] PlayerAddress_to_GC;


    wire [4:0] PlayerAddress;

    PasswordHandler DUT_PasswordHandler(clk, rst, Switches, PasswordButton, MatchedID, PlayerAddress_from_ID,
                       LogoutCommand_from_GC, isGuest_from_ID, LoggedOut, LoggedIn, isGuest_to_GC, Logout_to_ID, PlayerAddress_to_GC);

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
        @(posedge clk);
        @(posedge clk);
        MatchedID = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        MatchedID = 1; // It should not activate until IDHandler finds match
        PlayerAddress_from_ID = 1; // Testcase: Player 1 - Zain Password is 'DA5A55'
        isGuest_from_ID = 0;
        @(posedge clk);
        @(posedge clk);
        Switches = 4'b0000; // Start Entering a Wrong Password
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
        Switches = 4'b0100;
        @(posedge clk);
        @(posedge clk);
        PasswordButton = 1'b1;
        @(posedge clk);
        PasswordButton = 1'b0;
        @(posedge clk);
        @(posedge clk);
        Switches = 4'b0110;
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
        Switches = 4'b1101; // Start Correct Password
        @(posedge clk);
        @(posedge clk);
        PasswordButton = 1'b1;
        @(posedge clk);
        PasswordButton = 1'b0;
        @(posedge clk);
        @(posedge clk);
        Switches = 4'b1010;
        @(posedge clk);
        @(posedge clk);
        PasswordButton = 1'b1;
        @(posedge clk);
        PasswordButton = 1'b0;
        @(posedge clk);
        @(posedge clk);
        Switches = 4'b0101;
        @(posedge clk);
        @(posedge clk);
        PasswordButton = 1'b1;
        @(posedge clk);
        PasswordButton = 1'b0;
        @(posedge clk);
        @(posedge clk);
        Switches = 4'b1010;
        @(posedge clk);
        @(posedge clk);
        PasswordButton = 1'b1;
        @(posedge clk);
        PasswordButton = 1'b0;
        @(posedge clk);
        @(posedge clk);
        Switches = 4'b0101;
        @(posedge clk);
        @(posedge clk);
        PasswordButton = 1'b1;
        @(posedge clk);
        PasswordButton = 1'b0;
        @(posedge clk);
        @(posedge clk);
        Switches = 4'b0101;
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
        LogoutCommand_from_GC = 1'b1;
        @(posedge clk);
        MatchedID = 0;
        @(posedge clk);
        LogoutCommand_from_GC = 1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        MatchedID = 1;
        PlayerAddress_from_ID = 4;
        isGuest_from_ID = 1;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
    end
endmodule




