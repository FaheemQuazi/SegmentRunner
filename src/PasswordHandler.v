// This module checks the password entered against the one of an authorized user in ROM. The password must match the ID of the user trying to access the game.
// ID functions are handled separately by the IDHandler module. 
// Inputs:
    // PasswordSwitch, PasswordButton, MatchedID, PlayerAddress_from_ID, LogoutCommand_from_GC, 
// Outputs:
    // LoggedOut, LoggedIn, IsGuest_to_GC, PlayerAddress_to_GC

module PasswordHandler(clk, rst, PasswordSwitch, PasswordButton, MatchedID, PlayerAddress_from_ID,
                       LogoutCommand_from_GC, LoggedOut, LoggedIn, PlayerAddress_to_GC);
    input[3:0] PasswordSwitch;
    input PasswordButton, MatchedID;
    input[2:0] PlayerAddress_from_ID;
    input LogoutCommand_from_GC;
    output LoggedOut, LoggedIn, IsGuest_to_GC;
    output[2:0] PlayerAddress_to_GC;

    reg[23:0] UserEnteredPassword;
    // ROM_16bit PasswordROM; // To be defined later

    parameter STANDBY = 0, DIGIT1 = 1, DIGIT2 = 2,
              DIGIT3 = 3, DIGIT4 = 4, FETCH_ROM = 5,
              CATCH_ROM = 6, COMPARE = 7, CHECK_GUEST = 8,
              WAIT = 9, PASSED = 10;
    reg [3:0] State;
    reg[2:0] ROM_Address;

