module TBsimple
	(
		input logic clk, done,
		output logic [15:0] inA,
		output logic go_l,
		input logic [15:0] sum, outResult
	);

	class sumPkt;
		rand bit [15:0] howMany;
		rand bit [15:0] item[];

		constraint N {howMany inside {[2:10]};}
		constraint arraySize {item.size == howMany;}
	endclass

	class testSumThread;
		local bit unsigned [15:0] total;
		local sumPkt pkt = new;

		task sendPktToThread;
			total = 0;
			assert (pkt.randomize()) else $error("oops");
			for (byte i = 0; i < pkt.howMany; i++) begin
				@(posedge clk);
				inA <= pkt.item[i];
				total += pkt.item[i];
				go_l <= (i == 0) ? 0 : 1;
			end
			@(posedge clk);
			inA <= 0;
		endtask

		function bit checkTotal(bit unsigned [15:0] value);
			$display("checkTotal: value=%d, total=%d", value, total);
			return value == total;
		endfunction: checkTotal
	endclass: testSumThread

	initial begin
		testSumThread t = new();
		$monitor($stime, " inA=%3d, go_l=%b, done=%b, sum=%5d, outResult=%5d", inA, go_l, done, sum, outResult);
		go_l <= 1;
		repeat (5) begin
			t.sendPktToThread();
			wait(done);
			ChkTotal: assert (t.checkTotal(sum)) else $error("OOPS");
		end
		#15 $finish;
	end
endmodule: TBsimple