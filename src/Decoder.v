module Decoder(ceilingBits, floorBits, playerPos, score, showScore, disp5, disp4, disp3, disp2, disp1, disp0);
	input playerPos, showScore;
	input [5:0] ceilingBits, floorBits;
	input [13:0] score;
	output [6:0] disp5, disp4, disp3, disp2, disp1, disp0; // disp5 is the leftmost display and disp0 is the rightmost 
	reg [6:0] disp5, disp4, disp3, disp2, disp1, disp0;
	reg [3:0] seg3_in, seg2_in, seg1_in, seg0_in;
	wire [6:0] seg3_out, seg2_out, seg1_out, seg0_out;

	Decoder_7seg D3(seg3_in, seg3_out);
	Decoder_7seg D2(seg2_in, seg2_out);
	Decoder_7seg D1(seg1_in, seg1_out);
	Decoder_7seg D0(seg0_in, seg0_out);

	always @(ceilingBits, floorBits, playerPos, showScore, score)
		begin
		if(showScore == 1'b0) //Gameplay
			begin
			disp5 = {3'b111, floorBits[5], 2'b11, ceilingBits[5]};
			disp3 = {3'b111, floorBits[3], 2'b11, ceilingBits[3]};
			disp2 = {3'b111, floorBits[2], 2'b11, ceilingBits[2]};
			disp1 = {3'b111, floorBits[1], 2'b11, ceilingBits[1]};
			disp0 = {3'b111, floorBits[0], 2'b11, ceilingBits[0]};
			if(playerPos == 1'b0) //Player on floor
				begin
				disp4 = {3'b111, floorBits[4], 2'b01, ceilingBits[4]};
				end
			else //Player on ceiling
				begin
				disp4 = {3'b111, floorBits[4], 2'b10, ceilingBits[4]};
				end
			end
		else //Display score
			begin
			disp5 = 7'b1111111;
			disp4 = 7'b1111111;
			seg3_in = score / 1000;
			seg2_in = (score % 1000) / 100;
			seg1_in = (score % 100) / 10;
			seg0_in = (score % 10);
			disp3 = seg3_out;
			disp2 = seg2_out;
			disp1 = seg1_out;
			disp0 = seg0_out;
			end
		end
endmodule
