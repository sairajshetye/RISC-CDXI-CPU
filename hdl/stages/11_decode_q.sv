module decode_q
import rv32i_types::*;
 #(
            parameter               DEPTH     = 8,
            parameter               PTR_SIZE  = $clog2(DEPTH)

)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   enq,
    input   logic                   deq,
    input   id_ex_stage_reg_t     inst_in,
    output  id_ex_stage_reg_t     inst_out,
    output  logic                   valid_rdata,
    output  logic                   dq_stall

);

    logic valid_op;
    logic valid_enq;
    logic valid_deq;
    logic [PTR_SIZE:0] head;
    logic [PTR_SIZE:0] tail;

    id_ex_stage_reg_t internal_array [DEPTH];

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

        full = (head[3] != tail[3] && head[2:0] == tail[2:0]); 
        empty = (head == tail);

        dq_stall = full;
        valid_rdata = ~empty;

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
                internal_array[i] <= '0;
            end
            tail <= '0;
            head <= '0;
        end else begin
            if (enq && deq) begin
                internal_array[tail] <= inst_in;
                tail <= (tail + 4'b0001);
                head <= (head + 4'b0001);
            end else if (enq && !full) begin
                internal_array[tail] <= inst_in; 
                tail <= (tail + 4'b0001);
            end else if (deq && !empty) begin
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

endmodule : decode_q