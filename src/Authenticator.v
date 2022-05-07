module Authenticator(clk, rst, PasswordSwitch, PasswordButton, LogoutCommand_from_GC, LoggedOut, LoggedIn, isGuest_to_GC, PlayerAddress_to_GC, IDPassed);
                       
    input clk, rst;
    input [3:0] PasswordSwitch;
    input PasswordButton;
    input LogoutCommand_from_GC;

    output LoggedOut, LoggedIn;
    output isGuest_to_GC;
    output [4:0] PlayerAddress_to_GC;

    wire MatchedID;
    wire isGuest_from_ID;
    wire[4:0] PlayerAddress_from_ID;
    wire Logout_to_ID; // Log Out due to wrong password attempts exceeded

    output IDPassed;
    assign IDPassed = MatchedID;

    IDHandler Check_ID(clk, rst, PasswordSwitch, PasswordButton, LogoutCommand_from_GC, MatchedID, PlayerAddress_from_ID, isGuest_from_ID);


    PasswordHandler Check_Password(clk, rst, PasswordSwitch, PasswordButton, MatchedID, PlayerAddress_from_ID,
                       LogoutCommand_from_GC, isGuest_from_ID, LoggedOut, LoggedIn, isGuest_to_GC, Logout_to_ID, PlayerAddress_to_GC);

endmodule