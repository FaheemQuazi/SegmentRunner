`timescale 1 ns/100 ps
module testbench_Decoder();
	reg playerPos, showScore, loggedIn, clk;
	reg [5:0] ceilingBits, floorBits;
	reg [13:0] score;
	wire [6:0] disp5, disp4, disp3, disp2, disp1, disp0;

	always 
		begin
		clk = 0;
		#10;
		clk = 1;
		#10;
		end

	Decoder DUT(clk, loggedIn, ceilingBits, floorBits, playerPos, score, showScore, disp5, disp4, disp3, disp2, disp1, disp0);

	initial 
		begin
		showScore = 1'b0; score = 14'b10011100001111; ceilingBits = 6'b111111; floorBits = 6'b000000; playerPos = 1'b0; loggedIn = 1'b0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		loggedIn = 1'b1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		showScore = 1'b1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		showScore = 1'b0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		showScore = 1'b1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		showScore = 1'b1;
		end
endmodule