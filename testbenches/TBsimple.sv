program TBsimple
	(
		input logic clk, done,
		output logic [15:0] inA,
		output logic go_l,
		input logic [15:0] sum, outResult
	);

	initial begin
		$monitor($stime, " inA=%3d, go_l=%b, done=%b, sum=%5d, outResult=%5d", inA, go_l, done, sum, outResult);
		go_l <= 1;
		@(posedge clk);
		inA <= 55;
		go_l <= 0;

		@(posedge clk);
		inA <= 22;
		go_l <= 1;

		@(posedge clk);
		inA <= 1;
		
		@(posedge clk);
		inA <= 0;

		#15 $finish;
	end
endprogram: TBsimple