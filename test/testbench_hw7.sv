module hw7_tb();

reg clk;
int test_num;
reg[31:0] in;
reg signal;
reg[31:0] out;
reg queue_full;
reg queue_empty;
reg[31:0] expected_out;
reg expected_queue_full;
reg expected_queue_empty;

queue hw7_tb(
	.in(in),
	.signal(signal),
	.out(out),
	.queue_full(queue_full),
	.queue_empty(queue_empty),
	.clk(clk)
);

initial begin
	clk = 1'b0;
	forever begin
		# 1 clk = ~clk;
	end
end

initial begin
	$dumpfile("./sim/hw7.vcd");
	$dumpvars(0, hw7_tb);
end

initial begin
	//repeat(5) @(posedge clk);

	test_num = 1;
	in                = 32'd1;
	signal               = 1'b1;
	#2;
	in                = 32'd5;
	signal               = 1'b1;
	#2;
	signal               = 1'b0;
	expected_out       = 32'd1;
	expected_queue_empty = 0;
	expected_queue_full = 0;
	repeat(1) @(posedge clk);

	$finish;
end

initial begin
	
end
endmodule