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
    output  logic   [WIDTH-1:0]     inst_out

);

    logic valid_op;
    logic valid_enq;
    logic valid_deq;
    logic [PTR_SIZE-1:0] head_ptr;
    logic [PTR_SIZE-1:0] tail_ptr;

    logic [WIDTH-1:0] internal_array [DEPTH];

    logic full;

    always_comb begin

        assign full = (head[3] != tail[3] && head[2:0] == 
        assign valid_op = (enq || deq) && !(enq && deq);
        assign valid_enq = enq && valid_op;
        assign valid_deq = deq && valid_op;

    end


    always_ff @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < DEPTH; i++) begin
                internal_array[i] <= '0;
            end
        end else begin
            if (enq) begin
                internal_array[tail_ptr] <= inst_in; // specific set, way x
                tail_ptr <= (tail_ptr + 1) % DEPTH;
            end else if (deq) begin
                head_ptr <= (head_ptr + 1) % DEPTH;
            end
        end
    
    end



endmodule : fifo