module hw6q4_tb();

reg clk;
int test_num;
reg[31:0] first_stream;
reg[31:0] second_stream;
reg[31:0] running_sum;
reg[31:0] expected_runningSum;

stream streamer(
	.first_stream(first_stream),
	.second_stream(second_stream),
	.running_sum(running_sum),
	.clk(clk)
);

initial begin
	clk = 1'b0;
	forever begin
		# 1 clk = ~clk;
	end
end

initial begin
	$dumpfile("./sim/hw6q4.vcd");
	$dumpvars(0, hw6q4_tb);
end

initial begin
	//repeat(5) @(posedge clk);

	test_num = 1;
	first_stream                = 1;
	second_stream               = 2;
	#2;
	first_stream                = 3;
	second_stream               = 4;
	#2;
	first_stream                = 5;
	second_stream               = 9;
	#2;
	expected_runningSum       = 32'd24;
	repeat(70) @(posedge clk);

	$finish;
end

initial begin
	integer out_file, expected_file;
	out_file = $fopen("./vvp/hw6q4_out_display.text");
	expected_file = $fopen("./vvp/hw6q4_expected_display.text");
	clk = 1'b0;
	forever begin
		@(posedge clk) begin
			$display ("%t, running sum =  %d, expected running sum = %d", $time, running_sum, expected_runningSum);
			$fwrite(out_file, "%t, running sum = %d\n", $time, running_sum);
			$fwrite(expected_file, "%t, expected running sum = %d\n", $time, expected_runningSum);
		end
	end
	$fclose(out_file);
	$fclose(expected_file);
end
endmodule