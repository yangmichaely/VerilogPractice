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
	reg [1:0] state = init;

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
	output wire[31:0] factorial,
	input clk,
	output ready,
	output overflow
);
	parameter init = 2'b00;
	parameter multiply = 2'b01;
	parameter store = 2'b10;

	reg [31:0] counter;
	reg [31:0] ans = 1;
	reg [1:0] state = init;
	reg readyBit = 0;
	reg overflowBit = 0;

	assign overflow = (val > 11) ? 1 : overflowBit;
	assign ready = (val > 11) ? 1 : readyBit;
	assign factorial = (val > 11) ? 0 : ans;

	always @(posedge clk) begin
		case(state)
			init: begin
				readyBit = 0;
				overflowBit = 0;
				counter = val;
				ans = 1;
				state = multiply;
			end
			multiply: begin
				ans = ans * counter;
				counter = counter - 1;
				if(counter > 1) begin
					state = multiply;
				end
				else begin
					state = store;
				end
			end
			store: begin
				readyBit = 1;
				state = store;
			end
		endcase
	end
endmodule

module average(
	input wire [31:0] in,
	input clk,
	output wire [31:0] avg,
	output ready,
	output overflow
);
	localparam init = 2'b00;
	localparam sum = 2'b01;
	localparam store = 2'b10;

	reg [31:0] counter;
	reg [31:0] ans;
	reg state = init;
	reg [31:0] temp;
	reg readyBit;
	reg overflowBit;

	always @(posedge clk) begin
		case(state)
			init: begin
				counter = 0;
				ans = 0;
				temp = 0;
				readyBit = 0;
				overflowBit = 0;
				state = sum;
			end
			sum: begin
				temp = ans + in;
				if(temp < ans || temp < in) begin
					overflowBit = 1;
					ans = 0;
					state = store;
				end
				ans = temp;
				if(counter >= 5) begin
					state = store;
				end
				counter = counter + 1;
			end
			store: begin
				readyBit = 1;
				state = init;
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
		sum <= running_sum;
	end

	assign running_sum = sum + first_stream + second_stream;

endmodule