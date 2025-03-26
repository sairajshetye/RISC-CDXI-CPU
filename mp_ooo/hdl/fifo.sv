module fifo #(
            parameter               DEPTH     = 8,
            parameter               PTR_SIZE  = $clog2(DEPTH),
            parameter               WIDTH     = 32
)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   enq,
    input   logic                   deq,
    input   logic   [WIDTH-1:0]     inst_in,
    output  logic   [WIDTH-1:0]     inst_out,
    output  logic                   valid_rdata,
    output  logic                   fifo_fetch_stall

);

    logic valid_op;
    logic valid_enq;
    logic valid_deq;
    logic [PTR_SIZE:0] head;
    logic [PTR_SIZE:0] tail;

    logic [WIDTH-1:0] internal_array [DEPTH];

    logic full;
    logic empty;

    logic [31:0] inst_in_reg;

    always_comb begin

        full = (head[3] != tail[3] && head[2:0] == tail[2:0]); 
        empty = (head == tail);
        valid_op = (enq || deq) && !(enq && deq);
        valid_enq = enq && valid_op && !full;
        valid_deq = deq && valid_op && !empty;
        fifo_fetch_stall = full;
        valid_rdata = ~empty;

    end

    always_ff @(posedge clk) begin
        if (rst) begin
            inst_in_reg  <= 'x;
        end else begin
            inst_in_reg  <= inst_in;
        end
    end


    always_ff @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < DEPTH; i++) begin
                internal_array[i] <= '0;
            end
            tail <= '0;
            head <= '0;
        end else begin
            if (valid_enq) begin
                internal_array[tail] <= inst_in; // specific set, way x
                tail <= (tail + 4'b0001);
            end else if (valid_deq) begin
                head <= (head + 4'b0001);
            end
        end
    
    end

    always_comb begin
        if (empty) begin
            inst_out = 'x;
        end else begin
            inst_out = internal_array[head[2:0]];
        end
    end

endmodule : fifo