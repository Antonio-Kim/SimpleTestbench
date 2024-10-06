module top;
	logic clk, rst, go_l;
	logic [15:0] inA, sum, outResult;
	logic done;

	sumItUp dut(.*);
	downStream ds(.*);
	TBsimple TB(.*);

	initial begin
		clk = 0;
		rst = 0;
		rst <= #1 1;
		repeat(20) #5 clk = ~clk;
	end
endmodule: top