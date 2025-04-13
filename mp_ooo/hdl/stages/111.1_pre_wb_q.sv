module pre_wb_q
import rv32i_types::*;
 #(
            parameter               DEPTH     = 8,
            parameter               PTR_SIZE  = $clog2(DEPTH)

)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   enq,
    input   logic                   ready_deq,
    input   dp_is_stage_reg_t       inst_in_wb,
    output  dp_is_stage_reg_t       inst_out_wb,
    output  logic                   valid_rdata,
    output  logic                   wb_stall

);

    logic valid_op;
    logic valid_enq;
    logic valid_deq;
    logic deq;
    logic in_out; 
    logic [PTR_SIZE:0] head;
    logic [PTR_SIZE:0] tail;

    dp_is_stage_reg_t internal_array_wb [DEPTH];

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

        wb_stall = full;
        valid_rdata = ~empty;

        // if (!empty) begin
        //     deq = ready_deq;
        // end
        // else begin
        //     deq = '0;
        // end

        deq = ready_deq;

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
            inst_out_wb <= '0;
            for (integer i = 0; i < DEPTH; i++) begin
                internal_array_wb[i] <= '0;
            end
            tail <= '0;
            head <= '0;
        end else begin
            inst_out_wb <= '0;
            if (inst_in_wb.valid) begin
                if (enq && deq) begin
                    //internal_array_wb[tail[PTR_SIZE-1:0]] <= inst_in_wb;
                    //internal_array_wb[head[PTR_SIZE-1:0]].valid <= '0;
                    //inst_out_wb <= inst_in_wb;
                    if (empty) begin
                        inst_out_wb <= inst_in_wb;
                    end else if (full) begin
                        inst_out_wb <= internal_array_wb[head[PTR_SIZE-1:0]];
                        internal_array_wb[tail[PTR_SIZE-1:0]] <= inst_in_wb; 
                    end else begin
                        inst_out_wb <= internal_array_wb[head[PTR_SIZE-1:0]];
                        internal_array_wb[tail[PTR_SIZE-1:0]] <= inst_in_wb; 
                    end
                    tail <= (tail + 4'b0001);
                    head <= (head + 4'b0001);
                end else if (enq && !full) begin
                    inst_out_wb <= '0;
                    internal_array_wb[tail[PTR_SIZE-1:0]] <= inst_in_wb; 
                    tail <= (tail + 4'b0001);
                end else if (deq && !empty) begin
                    inst_out_wb <= internal_array_wb[head[PTR_SIZE-1:0]];
                    internal_array_wb[head[PTR_SIZE-1:0]] <= '0;
                    head <= (head + 4'b0001);
                end
            end
        end
    
    end

    // always_ff @ (posedge clk) begin
    //     if (rst) begin
    //         inst_out_wb <= '0;
    //     end
    //     else if (in_out) begin
    //         inst_out_wb <= inst_in_wb;
    //         //inst_out_wb.valid <= '0;
    //     end
    //     else if (empty) begin
    //         inst_out_wb <= '0;
    //     end 
    //     else begin
    //         inst_out_wb <= internal_array_wb[head[PTR_SIZE-1:0]];
    //     end
    // end

endmodule : pre_wb_q