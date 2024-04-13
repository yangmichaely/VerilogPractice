module hw6q3_tb();

reg clk;
int test_num;
reg[31:0] in;
reg[31:0] avg;
reg ready;
reg overflow;
reg[31:0] expected_avg;
reg expected_ready;
reg expected_overflow;

average averager(
	.in(in),
	.clk(clk),
	.avg(avg),
	.ready(ready),
	.overflow(overflow)
);

initial begin
	clk = 1'b0;
	forever begin
		# 1 clk = ~clk;
	end
end

initial begin
	$dumpfile("./sim/hw6q3.vcd");
	$dumpvars(0, hw6q3_tb);
end

initial begin
	//repeat(5) @(posedge clk);

	test_num = 1;
	in                = 32'd1;
	#2;
	in                = 32'd2;
	#2;
	in                = 32'd3;
	#2;
	in                = 32'd4;
	#2;
	in                = 32'd5;
	#2;
	in                = 32'd9;
	#2;
	expected_avg       = 32'd4;
	expected_ready      = 1'b1;
	expected_overflow      = 32'd0;
	repeat(70) @(posedge clk);

	$finish;
end

initial begin
	integer out_file, expected_file;
	out_file = $fopen("./vvp/hw6q3_out_display.text");
	expected_file = $fopen("./vvp/hw6q3_expected_display.text");
	clk = 1'b0;
	forever begin
		@(posedge clk) begin
			$display ("%t, avg =  %d, ready bit =  %d, overflow bit = %d, expected avg = %d, expected ready = %d, expected bit = %d", $time, avg, ready, overflow, expected_avg, expected_ready, expected_overflow);
			$fwrite(out_file, "%t, avg = %d, ready bit = %d, overflow bit = %d\n", $time, avg, ready, overflow);
			$fwrite(expected_file, "%t, expected avg = %d, expected_ready = %d, expected overflow = %d\n", $time, expected_avg, expected_ready, expected_overflow);
		end
	end
	$fclose(out_file);
	$fclose(expected_file);
end
endmodule