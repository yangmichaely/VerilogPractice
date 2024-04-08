module queue(
    input clk,
    input wire [31:0] in,
    input signal,
    output wire [31:0] out,
    output queue_full,
    output queue_empty
);

    reg [31:0] queue [7:0];
    reg full = 0, empty = 1;
    reg [31:0] deqOut;
    integer size = 0;

    always @(posedge clk) begin
        if (signal == 1) begin
            if(size < 8) begin
                queue[size] = in;
                size = size + 1;
                empty = 0;
                if(size == 8) begin
                    full = 1;
                end
            end
        end
        else begin
            if(size > 0) begin
                deqOut = queue[0];
                $display("Dequeued %d", deqOut);
                for (int i = 0; i < size - 1; i = i + 1) begin
                    queue[i] = queue[i + 1];
                end
                size = size - 1;
                full = 0;
                if(size == 0) begin
                    empty = 1;
                end
            end
        end
    end

    assign out = deqOut;
    assign queue_full = full;
    assign queue_empty = empty;

endmodule