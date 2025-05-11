module bp_q
import rv32i_types::*;
 #(
            parameter               DEPTH     = 8,
            parameter               PTR_SIZE  = $clog2(DEPTH)

)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   enq,
    input   logic                   deq,
    input   logic                   bq_rem,
    input   branch_t                br_pred_i,
    input   branch_t_state          branch_t_states_i,
    input   logic                   set_pc_br_i,
    input   logic    [31:0]         pc_br_pred_i,
    output   branch_t               br_pred_o,
    output   branch_t_state         branch_t_states_o,
    output   logic                  set_pc_br_o,
    output   logic    [31:0]        pc_br_pred_o,
    //input   id_ex_stage_reg_t     inst_in_d,
    //output  id_ex_stage_reg_t     inst_out_d,
    output  logic                   valid_rdata,
    output  logic                   dq_stall,
    output  logic                   dq_stall_next

);

    typedef struct packed {
        branch_t br_pred;
        branch_t_state branch_t_states;
        logic set_pc_br;
        logic    [31:0] pc_br_pred;

    } bq_packet;

    bq_packet inst_in_d, inst_out_d;

    logic valid_op;
    logic valid_enq;
    logic valid_deq;
    logic in_out;
    logic [PTR_SIZE:0] head;
    logic [PTR_SIZE:0] tail;
    logic [PTR_SIZE:0] tail_full;

    bq_packet internal_array_d [DEPTH];

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

        dq_stall = full;
        dq_stall_next = full_next;
        valid_rdata = ~empty;
        in_out = (enq && deq);

    end

   
    // always_comb begin
    //     inst_in_d.br_pred = not_taken;
    //     inst_in_d.branch_t_states = strongly_not_taken;
    //     inst_in_d.set_pc_br = '0;
    //     inst_in_d.pc_br_pred  = '0;

    //     br_pred_o = not_taken;
    //     branch_t_states_o = strongly_not_taken;
    //     set_pc_br_o = '0;
    //     pc_br_pred_o = '0;

    //     if (enq && deq) begin
    //         if (empty) begin    //in & out
    //             br_pred_o = br_pred_i;
    //             branch_t_states_o = branch_t_states_i;
    //             set_pc_br_o = set_pc_br_i;
    //             pc_br_pred_o = pc_br_pred_i;

    //         end else begin
    //             br_pred_o = internal_array_d[head[PTR_SIZE-1:0]].br_pred;
    //             branch_t_states_o = internal_array_d[head[PTR_SIZE-1:0]].branch_t_states;
    //             set_pc_br_o = internal_array_d[head[PTR_SIZE-1:0]].set_pc_br;
    //             pc_br_pred_o = internal_array_d[head[PTR_SIZE-1:0]].pc_br_pred;

    //             inst_in_d.br_pred = br_pred_i;
    //             inst_in_d.branch_t_states = branch_t_states_i;
    //             inst_in_d.set_pc_br = set_pc_br_i;
    //             inst_in_d.pc_br_pred  = pc_br_pred_i;

    //         end

    //     end else if (enq && !full) begin
    //         inst_in_d.br_pred = br_pred_i;
    //         inst_in_d.branch_t_states = branch_t_states_i;
    //         inst_in_d.set_pc_br = set_pc_br_i;
    //         inst_in_d.pc_br_pred  = pc_br_pred_i;

    //     end else if (deq && !empty) begin
    //         br_pred_o = internal_array_d[head[PTR_SIZE-1:0]].br_pred;
    //         branch_t_states_o = internal_array_d[head[PTR_SIZE-1:0]].branch_t_states;
    //         set_pc_br_o = internal_array_d[head[PTR_SIZE-1:0]].set_pc_br;
    //         pc_br_pred_o = internal_array_d[head[PTR_SIZE-1:0]].pc_br_pred;

    //     end

    // // end

    // end

    always_ff @(posedge clk) begin
        if (rst) begin
            inst_out_d <= '0;
            br_pred_o <= taken;
            branch_t_states_o <= weakly_taken;
            set_pc_br_o <= '0;
            pc_br_pred_o <= '0;
            for (integer i = 0; i < DEPTH; i++) begin
                internal_array_d[i].br_pred <= taken;
                internal_array_d[i].branch_t_states <= weakly_taken;
                internal_array_d[i].set_pc_br <= '0;
                internal_array_d[i].pc_br_pred <= '0;
                internal_array_d[i] <= '0;
            end
            tail <= '0;
            head <= '0;
        end else begin
            inst_out_d <= '0;
            br_pred_o <= taken;
            branch_t_states_o <= weakly_taken;
            set_pc_br_o <= '0;
            pc_br_pred_o <= '0;
            //if (inst_in_d.valid) begin
                if (enq && deq && !bq_rem) begin
                    // internal_array_d[tail[PTR_SIZE-1:0]] <= inst_in_d;
                    if (empty) begin
                        br_pred_o <= br_pred_i;
                        branch_t_states_o <= branch_t_states_i;
                        set_pc_br_o <= set_pc_br_i;
                        pc_br_pred_o <= pc_br_pred_i;
                        // inst_out_d <= inst_in_d;
                    end else if (full) begin
                        br_pred_o <= internal_array_d[head[PTR_SIZE-1:0]].br_pred;
                        branch_t_states_o <= internal_array_d[head[PTR_SIZE-1:0]].branch_t_states;
                        set_pc_br_o <= internal_array_d[head[PTR_SIZE-1:0]].set_pc_br;
                        pc_br_pred_o <= internal_array_d[head[PTR_SIZE-1:0]].pc_br_pred;

                        // inst_out_d <= internal_array_d[head[PTR_SIZE-1:0]];
                        // internal_array_d[tail[PTR_SIZE-1:0]] <= inst_in_d; 
                        internal_array_d[tail[PTR_SIZE-1:0]].br_pred <= br_pred_i;
                        internal_array_d[tail[PTR_SIZE-1:0]].branch_t_states <= branch_t_states_i;
                        internal_array_d[tail[PTR_SIZE-1:0]].set_pc_br <= set_pc_br_i;
                        internal_array_d[tail[PTR_SIZE-1:0]].pc_br_pred  <= pc_br_pred_i;
                    end else begin
                        br_pred_o <= internal_array_d[head[PTR_SIZE-1:0]].br_pred;
                        branch_t_states_o <= internal_array_d[head[PTR_SIZE-1:0]].branch_t_states;
                        set_pc_br_o <= internal_array_d[head[PTR_SIZE-1:0]].set_pc_br;
                        pc_br_pred_o <= internal_array_d[head[PTR_SIZE-1:0]].pc_br_pred;
                        // inst_out_d <= internal_array_d[head[PTR_SIZE-1:0]];
                        // internal_array_d[tail[PTR_SIZE-1:0]] <= inst_in_d; 
                        internal_array_d[tail[PTR_SIZE-1:0]].br_pred <= br_pred_i;
                        internal_array_d[tail[PTR_SIZE-1:0]].branch_t_states <= branch_t_states_i;
                        internal_array_d[tail[PTR_SIZE-1:0]].set_pc_br <= set_pc_br_i;
                        internal_array_d[tail[PTR_SIZE-1:0]].pc_br_pred  <= pc_br_pred_i;
                    end
                    // inst_out_d <= inst_in_d;
                    tail <= (tail + 4'b0001);
                    head <= (head + 4'b0001);
                end else if (enq && deq && bq_rem) begin
                    if (!empty) begin
                        //deq, no enq
                        br_pred_o <= internal_array_d[head[PTR_SIZE-1:0]].br_pred;
                        branch_t_states_o <= internal_array_d[head[PTR_SIZE-1:0]].branch_t_states;
                        set_pc_br_o <= internal_array_d[head[PTR_SIZE-1:0]].set_pc_br;
                        pc_br_pred_o <= internal_array_d[head[PTR_SIZE-1:0]].pc_br_pred;

                        // inst_out <= internal_array[head[PTR_SIZE-1:0]];
                        // internal_array[head[PTR_SIZE-1:0]] <= '0;
                        internal_array_d[head[PTR_SIZE-1:0]].br_pred <= taken;
                        internal_array_d[head[PTR_SIZE-1:0]].branch_t_states <= weakly_taken;
                        internal_array_d[head[PTR_SIZE-1:0]].set_pc_br <= '0;
                        internal_array_d[head[PTR_SIZE-1:0]].pc_br_pred <= '0;
                        head <= (head - 4'b0001);
                        
                    end 
                end
                
                else if (enq && !full && !bq_rem) begin
                    // inst_out_d <= '0;
                    br_pred_o <= taken;
                    branch_t_states_o <= weakly_taken;
                    set_pc_br_o <= '0;
                    pc_br_pred_o <= '0;
                    // internal_array_d[tail[PTR_SIZE-1:0]] <= inst_in_d; 
                    internal_array_d[tail[PTR_SIZE-1:0]].br_pred <= br_pred_i;
                    internal_array_d[tail[PTR_SIZE-1:0]].branch_t_states <= branch_t_states_i;
                    internal_array_d[tail[PTR_SIZE-1:0]].set_pc_br <= set_pc_br_i;
                    internal_array_d[tail[PTR_SIZE-1:0]].pc_br_pred  <= pc_br_pred_i;
                    tail <= (tail + 4'b0001);
                end else if (deq && !empty && !bq_rem) begin
                    br_pred_o <= internal_array_d[head[PTR_SIZE-1:0]].br_pred;
                    branch_t_states_o <= internal_array_d[head[PTR_SIZE-1:0]].branch_t_states;
                    set_pc_br_o <= internal_array_d[head[PTR_SIZE-1:0]].set_pc_br;
                    pc_br_pred_o <= internal_array_d[head[PTR_SIZE-1:0]].pc_br_pred;
                    // inst_out_d <= internal_array_d[head[PTR_SIZE-1:0]];
                    // internal_array_d[head[PTR_SIZE-1:0]] <= '0;
                    internal_array_d[head[PTR_SIZE-1:0]].br_pred <= taken;
                    internal_array_d[head[PTR_SIZE-1:0]].branch_t_states <= weakly_taken;
                    internal_array_d[head[PTR_SIZE-1:0]].set_pc_br <= '0;
                    internal_array_d[head[PTR_SIZE-1:0]].pc_br_pred <= '0;

                    head <= (head + 4'b0001);
                end
                else if (deq && !empty && bq_rem) begin
                    if ((tail - 4'b0001) == head) begin //if removing 1 entry makes it empty
                        //remove head, no deq
                        internal_array_d[head[PTR_SIZE-1:0]].br_pred <= taken;
                        internal_array_d[head[PTR_SIZE-1:0]].branch_t_states <= weakly_taken;
                        internal_array_d[head[PTR_SIZE-1:0]].set_pc_br <= '0;
                        internal_array_d[head[PTR_SIZE-1:0]].pc_br_pred <= '0;
                        // internal_array[head[PTR_SIZE-1:0]] <= '0;
                        //head <= (head - 4'b0001);
                        // inst_out <= '0;

                    end
                end
            //end
        end
    
    end

    


    // // always_ff @ (posedge clk) begin
    //     if (rst) begin
    //         inst_out_d <= '0;
    //     end
    //     else if (in_out) begin
    //         inst_out_d <= inst_in_d;
    //     end
    //     else if (empty) begin
    //         inst_out_d <= '0;
    //     end 
    //     else begin
    //         inst_out_d <= internal_array_d[head[PTR_SIZE-1:0]];
    //     end
    // end

endmodule : bp_q