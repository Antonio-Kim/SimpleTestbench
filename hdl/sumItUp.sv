module sumItUp
	(
		input logic clk, rst, go_l,
		input logic [15:0] inA,
		output logic done,
		output logic [15:0] sum
	);

	logic ld_l, cl_l, inAeq;
	logic [15:0] addOut;

	enum bit {sA, sB} state;

	always_ff@(posedge clk, negedge rst) 
		begin: state_machine
			if(~rst)
				state <= sA;
			else begin
				if(((state==sA) & go_l) | ((state==sB) & inAeq))
					state <= sA;
				if(((state==sA) & ~go_l) | ((state==sB) & ~inAeq))
					state <= sB;
			end
		end:state_machine
	
	always_ff@(posedge clk, negedge rst)
		begin: reg_sum
			if(~rst) sum <= 0;
			else if(~ld_l) sum <= addOut;
			else if(~cl_l) sum <= 0;
		end: reg_sum

	assign addOut = inA + sum,
		   ld_l = ~(((state==sA)&~go_l)|((state==sB)&~inAeq));
		   cl_l = ~((state==sB)&inAeq),
		   done = (state==sB)&inAeq,
		   inAeq = inA == 0;
endmodule: sumItUp