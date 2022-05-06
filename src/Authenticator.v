module Authenticator(clk, rst, PasswordSwitch, PasswordButton, LogoutCommand_from_GC, LoggedOut, LoggedIn, isGuest_to_GC, PlayerAddress_to_GC);
                       
    input clk, rst;
    input [3:0] PasswordSwitch;
    input PasswordButton;
    input LogoutCommand_from_GC;

    output LoggedOut, LoggedIn;
    output isGuest_to_GC;
    output [4:0] PlayerAddress_to_GC;

    wire Shaped_button;
    wire MatchedID;
    wire isGuest_from_ID;
    wire[4:0] PlayerAddress_from_ID;
    wire Logout_to_ID; // Log Out due to wrong password attempts exceeded

    ButtonShaper ButtonPulse(PasswordButton, Shaped_button, clk, rst);

    IDHandler Check_ID(clk, rst, PasswordSwitch, Shaped_button, LogoutCommand_from_GC, MatchedID, PlayerAddress_from_ID, isGuest_from_ID);


    PasswordHandler Check_Password(clk, rst, PasswordSwitch, Shaped_button, MatchedID, PlayerAddress_from_ID,
                       LogoutCommand_from_GC, isGuest_from_ID, LoggedOut, LoggedIn, isGuest_to_GC, Logout_to_ID, PlayerAddress_to_GC);

endmodule