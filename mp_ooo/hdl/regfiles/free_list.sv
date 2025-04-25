module free_list
import rv32i_types::*;
 #(
            parameter               DEPTH     = 128,
            parameter               PTR_SIZE  = $clog2(DEPTH),
            parameter               WIDTH     = 7

)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   enq,
    input   logic                   deq,
    input   logic                   flush,
    input   logic   [7:0]           fl_head,
    input   logic   [WIDTH-1:0]     p_addr_in, // there are 128 physical registers
    output  logic   [WIDTH-1:0]     p_addr_out,
    output  logic                   valid_rdata,
    output  logic                   fl_stall,
    output  logic   [PTR_SIZE:0]    head_out

);

    logic valid_op;
    logic valid_enq;
    logic valid_deq;
    logic [PTR_SIZE:0] head;
    logic [PTR_SIZE:0] tail;

    logic [WIDTH-1:0] internal_array [DEPTH];

    logic in_array [DEPTH];

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
        
        fl_stall = empty;
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
                internal_array[i] <= 7'(unsigned'(i)); 
                in_array[i] <= '1;
            end
            tail <= {1'b1, {(PTR_SIZE){1'b0}}};
            head <= 8'b0001;
        end else begin

            if (enq && deq) begin
                
                if (!in_array[p_addr_in]) begin
                    internal_array[tail[PTR_SIZE-1:0]] <= p_addr_in;
                    in_array[p_addr_in] <= '1;
                    tail <= (tail + 4'b0001);
                end
                in_array[internal_array[head[PTR_SIZE-1:0]]] <= '0;
                //tail <= (tail + 4'b0001);
                head <= (head + 4'b0001);
            end else if (enq && !full) begin
                if (!in_array[p_addr_in]) begin
                    internal_array[tail[PTR_SIZE-1:0]] <= p_addr_in;
                    in_array[p_addr_in] <= '1;
                
                tail <= (tail + 4'b0001);
                end
            end else if (deq && !empty) begin
                in_array[internal_array[head[PTR_SIZE-1:0]]] <= '0;
                head <= (head + 4'b0001);

            end
        if (flush) begin
            foreach (internal_array[i]) begin
                if (i <= integer'(head) && i > integer'(fl_head)) begin
                    in_array[internal_array[i]] <= '0;

                end
            end

                head <= fl_head;
            end
        end
    
    end

    always_comb begin
        if (empty) begin
            p_addr_out = '0;
        end else begin
            p_addr_out = internal_array[head[PTR_SIZE-1:0]];
        end
        head_out = head;
    end

endmodule : free_list