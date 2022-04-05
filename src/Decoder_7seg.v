// THIS WAS COPIED FOR REFERENCE AND IS BASICALLY A PLACEHOLDER FOR THIS FOLDER //

// ECE 5440
// Author: Faheem Quazi (1586686)
// Module: Decoder_7seg
// Description: Convert a 4-bit number to a 7-bit 7-segment representation

module Decoder_7seg(bits_in, bits_out);
    input [3:0] bits_in;
    output [6:0] bits_out;
    reg [6:0] bits_out;

    always @(bits_in) begin
        case (bits_in)
            4'b0000: begin bits_out = 7'b1000000; end // 0
            4'b0001: begin bits_out = 7'b1111001; end // 1
            4'b0010: begin bits_out = 7'b0100100; end // 2
            4'b0011: begin bits_out = 7'b0110000; end // 3
            4'b0100: begin bits_out = 7'b0011001; end // 4
            4'b0101: begin bits_out = 7'b0010010; end // 5
            4'b0110: begin bits_out = 7'b0000010; end // 6
            4'b0111: begin bits_out = 7'b1111000; end // 7
            4'b1000: begin bits_out = 7'b0000000; end // 8
            4'b1001: begin bits_out = 7'b0010000; end // 9
            4'b1010: begin bits_out = 7'b0001000; end // A
            4'b1011: begin bits_out = 7'b0000011; end // B
            4'b1100: begin bits_out = 7'b1000110; end // C
            4'b1101: begin bits_out = 7'b0100001; end // D
            4'b1110: begin bits_out = 7'b0000110; end // E
            4'b1111: begin bits_out = 7'b0001110; end // F
            default: begin bits_out = 7'b0110110; end // ≡ (unknown)
        endcase
    end
endmodule
