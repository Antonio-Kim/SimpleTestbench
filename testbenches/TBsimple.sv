module TBsimple
	(
		input logic clk, done,
		output logic [15:0] inA,
		output logic go_l,
		input logic [15:0] sum, outResult
	);

	typedef struct{
		bit [15:0] valuesToAdd[5];
		byte howMany;
	} sumItPkt_t;

	sumItPkt_t pkt;

	initial begin
		$monitor($stime, " inA=%3d, go_l=%b, done=%b, sum=%5d, outResult=%5d", inA, go_l, done, sum, outResult);
		pkt.valuesToAdd[0] = 55;
		pkt.valuesToAdd[1] = 22;
		pkt.valuesToAdd[2] = 11;
		pkt.howMany = 3;
		go_l <= 1;

		sendPktToAdd(pkt);
		#100 $finish;
	end

	task sendPktToAdd(input sumItPkt_t pkt);
		for (byte i = 0; pkt.howMany; i++) begin
			@(posedge clk);
			inA <= pkt.valuesToAdd[i];
			go_l <= (i ==0) ? 0 : 1;
		end
		@(posedge clk);
		inA <= 0;
	endtask
endmodule: TBsimple