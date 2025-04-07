module robert
import rv32i_types::*;
 #(
            parameter               DEPTH     = 16,
            parameter               PTR_SIZE  = $clog2(DEPTH)

)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   enq,
    input   logic                   ld_status,
    input   status_t                status_in,
    input   logic                   ld_branch_res,
    input   branch_t                branch_res_in, 
    input   rob_entry_t             rob_in,
    input   logic [PTR_SIZE-1:0]    rob_idx_in,     
    output  rob_entry_t             rob_out,
    output  logic                   valid_rdata,
    output  logic                   alloc_stall,
    output  logic [PTR_SIZE-1:0]    rob_tail_idx

);

    logic valid_op;
    logic valid_enq;
    logic valid_deq;
    logic [PTR_SIZE:0] head;
    logic [PTR_SIZE:0] tail;

    rob_entry_t rob[DEPTH];

    logic full;
    logic empty;
    logic deq;

    rob_entry_t rob_in_reg;

    always_comb begin

        full = (head[PTR_SIZE] != tail[PTR_SIZE] && head[PTR_SIZE-1:0] == tail[PTR_SIZE-1:0]); 
        empty = (head == tail);

        alloc_stall = full;
        valid_rdata = ~empty;

        rob_tail_idx = tail[PTR_SIZE-1:0]; // in rename and allocate, set inst rob idx field to this tail

        deq = (rob[head[PTR_SIZE-1:0]].status == done);

    end

    always_ff @(posedge clk) begin // NOT BEING USED, CAN DELETE LATER?
        if (rst) begin
            rob_in_reg  <= 'x;
        end else begin
            rob_in_reg  <= rob_in;
        end
    end


    always_ff @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < DEPTH; i++) begin
                rob[i] <= '0;
            end
            tail <= '0;
            head <= '0;
        end else begin
            if (enq && deq) begin
                rob[tail] <= rob_in;
                tail <= (tail + 4'b0001);
                head <= (head + 4'b0001);
            end else if (enq && !full) begin
                rob[tail] <= rob_in; 
                tail <= (tail + 4'b0001);
            end else if (deq && !empty) begin
                head <= (head + 4'b0001);
            end
        end

        if (ld_status) begin
            rob[rob_idx_in].status <= status_in;
        end

        if (ld_branch_res) begin
            rob[rob_idx_in].status <= branch_res_in;
        end
    
    end

    always_comb begin
        if (empty) begin
            rob_out = 'x;
        end else begin
            rob_out = rob[rob_idx_in];
        end
    end

endmodule : robert