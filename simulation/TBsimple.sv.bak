module TBsimple
	(
		input logic clk, done,
		output logic [15:0] inA,
		output logic go_l,
		input logic [15:0] sum, outResult
	);

	class testSumThread;
		localparam MAXSIZE = 6;
		local bit unsigned [15:0] total;

		local struct {
			bit unsigned [15:0] valuesToAdd[MAXSIZE];
			byte unsigned howMany;
		} pkt;

		function new();
			makePkt()
		endfunction: new

		task sendPktToAdd;
			for (byte i = 0; i <pkt.howMany; i++) begin
				@(posedge clk);
				inA <= pkt.valuesToAdd[i];
				go_l <= (i==0) ? 0 : 1;
			end
			@(posedge clk);
			inA <= 0;
		endtask: sendPktToAdd

		function checkTotal(bit unsigned [15:0] value);
			$display("checkTotal: value=%d, total=%d", value, total);
			return value == total;
		endfunction: checkTotal

		local function makePkt;
			total = 0;
			pkt.howMany = $urandom_range(MAXSIZE, 2);
			for (byte i = 0; i < pkt.howMany; i++) begin
				pkt.valuesToAdd[i] = $urandom_range(1000,1);
				total += pkt.valuesToAdd[i];
			end
		endfunction
	endclass: testSumThread

	initial begin
		testSumThread t;
		$monitor($stime, " inA=%3d, go_l=%b, done=%b, sum=%5d, outResult=%5d", inA, go_l, done, sum, outResult);
		go_l <= 1;
		repeat (5) begin
			t = new;
			t.sendPktToAdd();
			wait(done);
			$display("At time=%3d, %s", $stime, (t.checkTotal(sum))?"got right value" : "got wrong value");
		end
		#15 $finish;
	end
endmodule: TBsimple