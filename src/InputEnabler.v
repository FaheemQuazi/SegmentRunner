// ECE 5440
// Author: Faheem Quazi (1586686)
// Module: InputEnabler
// Description: Only passes through input to output if Enable is HIGH

module InputEnabler(In, Enable, Out);
    input In, Enable;
    output Out;
    reg Out;

    always@(In, Enable) begin
        Out = In & Enable;
    end
endmodule
