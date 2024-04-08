module divider(
	input wire [31:0] dividend,
	input wire [31:0] divisor,
	input clk,
	output wire [31:0] quotient,
	output wire [31:0] remainder
);

	parameter init = 2'b00;
	parameter shift = 2'b01;
	parameter subtract = 2'b10;
	parameter store = 2'b11;

	reg [31:0] q;
	reg [31:0] temp_dividend;
	reg [31:0] i;
	reg [1:0] state;

	initial begin
		temp_dividend = 0;
		q = 0;
		i = 0;
		state = init;
	end

	always @(posedge clk) begin
		case(state)
			init: begin
				temp_dividend = 0;
				q = 0;
				i = 0;
				state = shift;
			end
			shift: begin
				if(temp_dividend >= divisor) begin
					state = subtract;
				end
				else if(i > 31) begin
					state = store;
				end
				else if (temp_dividend < divisor && i < 32) begin
					temp_dividend[31:0] = {temp_dividend[30:0], dividend[31 - i]};
					q[31:0] = {q[30:0], 1'b0};
					state = shift;
					i = i + 1;
				end
			end
			subtract: begin
				temp_dividend = temp_dividend - divisor;
				q = q + 1;
				state = shift;
			end
			store: begin
				state = store;
			end
		endcase
	end

	assign quotient = q;
	assign remainder = temp_dividend;

endmodule

module factorial(
	input wire [31:0] val,
	input clk,
	output wire[31:0] factorial,
	output ready,
	output overflow
);
	parameter init = 2'b00;
	parameter multiply = 2'b01;
	parameter store = 2'b10;

	reg [31:0] counter;
	reg [31:0] ans = 1;
	reg [1:0] state, nextState;
	reg [31:0] temp = 1;
	reg readyBit = 0;
	reg overflowBit = 0;

	initial begin
		state = init;
		nextState = multiply;
		temp = 0;
	end

	always @(posedge clk) begin
		case(state)
			init: nextState = multiply;
			multiply: nextState = (counter > 1) ? multiply : store;
			store: nextState = store;
		endcase
	end

	always @(posedge clk) begin
		state = nextState;
	end

	always @(posedge clk) begin
		case(state)
			init: begin
				readyBit = 0;
				overflowBit = 0;
				counter = val;
				ans = 1;
			end
			multiply: begin
				temp = ans * counter;
				if(temp < counter || temp < ans) begin
					overflowBit = 1;
				end
				ans = temp;
				counter = counter - 1;
			end
			store: begin
				readyBit = 1;
			end
		endcase
	end
	assign factorial = ans;
	assign ready = readyBit;
	assign overflow = overflowBit;
endmodule

module average(
	input wire [31:0] in,
	input clk,
	output wire [31:0] avg,
	output ready,
	output overflow
);
	localparam sum = 1'b0;
	localparam store = 1'b1;

	reg [31:0] counter;
	reg [31:0] ans = 0;
	reg state;
	reg [31:0] temp;
	reg readyBit = 0;
	reg overflowBit = 0;

	initial begin
		state = sum;
		temp = 0;
		counter = 0;
		readyBit = 0;
		overflowBit = 0;
		ans = 0;
	end

	always @(posedge clk) begin
		case(state)
			sum: begin
				$display("ans = %d, in = %d, countr = %d", ans, in, counter);
				temp = ans + in;
				if(temp < ans || temp < in) begin
					overflowBit = 1;
				end
				ans = temp;
				if(counter >= 5) begin
					readyBit = 1;
					state = store;
				end
				counter = counter + 1;
			end
			store: begin
			end
		endcase
	end
	assign avg = ans / 6;
	assign ready = readyBit;
	assign overflow = overflowBit;
endmodule

module stream(
	input wire [31:0] first_stream,
	input wire [31:0] second_stream,
	input clk,
	output wire[31:0] running_sum
);

	reg [31:0] sum = 0;

	always @(posedge clk) begin
		sum <= sum + first_stream + second_stream;
	end

	assign running_sum = sum;

endmodule