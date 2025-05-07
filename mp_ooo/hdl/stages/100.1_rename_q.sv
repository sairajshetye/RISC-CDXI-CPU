module rename_q
import rv32i_types::*;
 #(
            parameter               DEPTH     = 8,
            parameter               PTR_SIZE  = $clog2(DEPTH)

)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   flush,
    input   logic                   enq,
    input   logic                   deq,
    input   ra_dp_stage_reg_t       inst_in_r,
    output  ra_dp_stage_reg_t       inst_out_r,
    output  logic                   valid_rdata,
    output  logic                   rq_stall,
    output  logic                   rq_stall_next

);

    logic valid_op;
    logic valid_enq;
    logic valid_deq;
    logic in_out;
    logic [PTR_SIZE:0] head;
    logic [PTR_SIZE:0] tail;
    logic [PTR_SIZE:0] tail_full;

    ra_dp_stage_reg_t internal_array_r [DEPTH];

    logic full, full_next;
    logic empty;

    //logic [WIDTH-1:0] inst_in_reg;
    assign tail_full = tail + 1'b1;

    always_comb begin

        // edge cases

        // 1:
        // the fifo is almost empty (has only 1 element)
        // enq and deq in same clock should maintain the fifo not being empty
        // the fifo is empty 
        // enq and deq in same clock should maintain the fifo being empty 

        // 2:
        // the fifo is almost full (all but 1 element)
        // enq and deq in same clock should maintain the fifo not being full
        // the fifo is full 
        // enq and deq in same clock should maintain the fifo being full

        // 3:
        // the fifo is full
        // enq by itself should not be allowed since full

        // 4:
        // the fifo is empty
        // deq by itself should not be allowed since empty
        full_next = (head[PTR_SIZE] != tail_full[PTR_SIZE] && head[PTR_SIZE-1:0] == (tail_full[PTR_SIZE-1:0]));
        full = (head[PTR_SIZE] != tail[PTR_SIZE] && head[PTR_SIZE-1:0] == tail[PTR_SIZE-1:0]); 
        empty = (head == tail);

        rq_stall = full;
        rq_stall_next = full_next;
        valid_rdata = ~empty;
        in_out = (enq && deq);

    end

    // always_ff @(posedge clk) begin // NOT BEING USED, CAN DELETE LATER?
    //     if (rst) begin
    //         inst_in_reg  <= 'x;
    //     end else begin
    //         inst_in_reg  <= inst_in;
    //     end
    // end


    always_ff @(posedge clk) begin
        if (rst) begin
            inst_out_r <= '0;
            for (integer i = 0; i < DEPTH; i++) begin
                internal_array_r[i] <= '0;
            end
            tail <= '0;
            head <= '0;
        end else if (flush) begin
            inst_out_r.valid <= '0;
            tail <= '0;
            head <= '0;
        end else begin
            inst_out_r.valid <= '0;
            //if (inst_in_r.valid) begin
                if (enq && deq) begin
                    // internal_array_r[tail[PTR_SIZE-1:0]] <= inst_in_r;
                    if (empty) begin
                        inst_out_r <= inst_in_r;
                    end else if (full) begin
                        inst_out_r <= internal_array_r[head[PTR_SIZE-1:0]];
                        internal_array_r[tail[PTR_SIZE-1:0]] <= inst_in_r; 
                    end else begin
                        inst_out_r <= internal_array_r[head[PTR_SIZE-1:0]];
                        internal_array_r[tail[PTR_SIZE-1:0]] <= inst_in_r; 
                    end
                    tail <= (PTR_SIZE+1)'(tail + 1);
                    head <= (PTR_SIZE+1)'(head + 1);
                end else if (enq && !full) begin
                    inst_out_r.valid <= '0;
                    internal_array_r[tail[PTR_SIZE-1:0]] <= inst_in_r; 
                    tail <= (PTR_SIZE+1)'(tail + 1);
                end else if (deq && !empty) begin
                    inst_out_r <= internal_array_r[head[PTR_SIZE-1:0]];
                    internal_array_r[head[PTR_SIZE-1:0]].valid <= '0;
                    head <= (PTR_SIZE+1)'(head + 1);
                end
            //end
        end
    
    end

endmodule : rename_q