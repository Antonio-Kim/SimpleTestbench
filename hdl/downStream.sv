module downStream
	(
		input logic clk, rst, done,
		input logic[15:0] sum,
		output logic[15:0] outResult
	);

	always_ff@(posedge clk, negedge rst)
		if(~rst) outResult <= 0;
		else if(done) outResult <= sum;
endmodule: downStream