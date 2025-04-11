module rename_q
import rv32i_types::*;
 #(
            parameter               DEPTH     = 8,
            parameter               PTR_SIZE  = $clog2(DEPTH)

)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   enq,
    input   logic                   deq,
    input   ra_dp_stage_reg_t       inst_in_r,
    output  ra_dp_stage_reg_t       inst_out_r,
    output  logic                   valid_rdata,
    output  logic                   rq_stall

);

    logic valid_op;
    logic valid_enq;
    logic valid_deq;
    logic in_out;
    logic [PTR_SIZE:0] head;
    logic [PTR_SIZE:0] tail;

    ra_dp_stage_reg_t internal_array_r [DEPTH];

    logic full;
    logic empty;

    //logic [WIDTH-1:0] inst_in_reg;

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

        full = (head[PTR_SIZE] != tail[PTR_SIZE] && head[PTR_SIZE-1:0] == tail[PTR_SIZE-1:0]); 
        empty = (head == tail);

        rq_stall = full;
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
            for (integer i = 0; i < DEPTH; i++) begin
                internal_array_r[i] <= '0;
            end
            tail <= '0;
            head <= '0;
        end else begin
            if (inst_in_r.valid) begin
                if (enq && deq) begin
                    internal_array_r[tail] <= inst_in_r;
                    tail <= (tail + 4'b0001);
                    head <= (head + 4'b0001);
                end else if (enq && !full) begin
                    internal_array_r[tail] <= inst_in_r; 
                    tail <= (tail + 4'b0001);
                end else if (deq && !empty) begin
                    head <= (head + 4'b0001);
                end
            end
        end
    
    end

    always_ff @ (posedge clk) begin
        if (rst) begin
            inst_out_r <= '0;
        end
        else if (in_out) begin
            inst_out_r <= inst_in_r;
        end
        else if (empty) begin
            inst_out_r <= '0;
        end 
        else begin
            inst_out_r <= internal_array_r[head[PTR_SIZE-1:0]];
        end
    end

endmodule : rename_q