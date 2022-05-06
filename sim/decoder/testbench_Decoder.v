`timescale 1 ns/100 ps
module testbench_Decoder();
	reg playerPos, showScore;
	reg [5:0] ceilingBits, floorBits;
	reg [7:0] score;
	wire [6:0] disp5, disp4, disp3, disp2, disp1, disp0;

	Decoder DUT(ceilingBits, floorBits, playerPos, score, showScore, disp5, disp4, disp3, disp2, disp1, disp0);

	initial 
		begin
		showScore = 1'b1; score = 8'b11111111; ceilingBits = 6'b111111; floorBits = 6'b000000; playerPos = 1'b0;
		#10 showScore = 1'b0; 
		#10 showScore = 1'b1;
		#10 score = 8'b01101111;
		#10 showScore = 1'b0;
		#10 showScore = 1'b1;
		end
endmodule