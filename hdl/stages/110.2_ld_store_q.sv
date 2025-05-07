 module lds_q
import rv32i_types::*;
 #(
            parameter               DEPTH     = 16,
            parameter               PTR_SIZE_LDS_Q  = $clog2(DEPTH),
            parameter               WIDTH     = 32,
            parameter               PTR_SIZE  = 6

)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   flush,
    input   logic                   enq,
    input   logic                   ready_deq,
    input   dp_is_stage_reg_t       inst_in_lds,
    output  dp_is_stage_reg_t       inst_out_lds,
    //output  dp_is_stage_reg_t       inst_out_lds_trans,
    output  logic                   valid_rdata,
    output  logic                   lds_stall,
    output  logic                   really_full,

    input   logic   [PTR_SIZE-1:0]  data_paddr_0, //from intfunct 
    input   logic   [31:0]     data_in_0,    //from intfunct  
    input   logic   [PTR_SIZE-1:0]  data_paddr_1, //from mult 
    input   logic   [31:0]     data_in_1,    //from mult
    input   logic   [PTR_SIZE-1:0]  data_paddr_2, //from br
    input   logic   [31:0]     data_in_2,    //from br
    input   logic   [PTR_SIZE-1:0]  data_paddr_3, //from ld
    input   logic   [31:0]     data_in_3    //from ld

);

    logic valid_op;
    logic valid_enq;
    logic valid_deq;
    logic deq;
    logic in_out; 
    logic [PTR_SIZE_LDS_Q:0] head;
    logic [PTR_SIZE_LDS_Q:0] head_next;
    logic [PTR_SIZE_LDS_Q:0] tail;
    logic [PTR_SIZE_LDS_Q:0] tail_next;

    dp_is_stage_reg_t internal_array_lds [DEPTH];

    logic full;
    logic empty;

    logic   [WIDTH-1:0]     data_t;
    logic   [DEPTH-1:0]     idx_rep;
    logic   [DEPTH-1:0]     rs1_rep, rs2_rep;   //0 for rs1, 2 for rs2 
    //logic   [DEPTH-1:0]     rs2_rep;
    dp_is_stage_reg_t inst_tmp;

    //logic [WIDTH-1:0] inst_in_reg;
    always_comb begin
        if (tail == '1) begin
            tail_next = '0;
        end else begin
            tail_next = tail + 1'b1;
        end
    end
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

        full = (head[PTR_SIZE_LDS_Q] != tail[PTR_SIZE_LDS_Q] && (head[PTR_SIZE_LDS_Q-1:0] == tail[PTR_SIZE_LDS_Q-1:0] )); 
        empty = (head == tail);

        lds_stall = full;
        valid_rdata = ~empty;
        really_full = (head[PTR_SIZE_LDS_Q-1:0] == tail_next[PTR_SIZE_LDS_Q-1:0]);
        // really_full = '1;
        // for (integer i = 0; i < DEPTH-2; i++) begin
        //     // if we are loading, then index 0 is technically valid but we havent put anything there
        //     if ((i == 0) && enq) begin
        //         really_full &= '1;
        //     end
        //     else begin
        //         really_full &= internal_array_lds[i].valid;
        //     end
        // end
        // if (!empty) begin
        //     deq = ready_deq;
        // end
        // else begin
        //     deq = '0;
        // end

        deq = ready_deq;
        //deq = (ready_deq && (internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]].use_rs2 == '1) && (internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]].rs1_ready == '1) && internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]].valid && !empty);

        in_out = (enq && deq);
        head_next = head + 1'b1;
        //tail_next = tail + 1'b1;
    end

    // always_ff @(posedge clk) begin // NOT BEING USED, CAN DELETE LATER?
    //     if (rst) begin
    //         inst_in_reg  <= 'x;
    //     end else begin
    //         inst_in_reg  <= inst_in;
    //     end
    // end
    always_comb begin
        data_t = '0;
        idx_rep = '0;
        rs1_rep = '0;
        rs2_rep = '0;
        for (integer i = 0; i < DEPTH; i++) begin
            if (internal_array_lds[i].valid) begin
                if (!internal_array_lds[i].rs1_ready && internal_array_lds[i].use_prs1) begin
                    if (internal_array_lds[i].rs1_paddr == data_paddr_0) begin
                        data_t = data_in_0;
                        idx_rep[i] = '1;
                        rs1_rep[i] = '1;
                    end else if (internal_array_lds[i].rs1_paddr == data_paddr_1) begin
                        data_t = data_in_1;
                        idx_rep[i] = '1;
                        rs1_rep[i] = '1;
                    end else if (internal_array_lds[i].rs1_paddr == data_paddr_2) begin
                        data_t = data_in_2;
                        idx_rep[i] = '1;
                        rs1_rep[i] = '1;
                    end else if (internal_array_lds[i].rs1_paddr == data_paddr_3) begin
                        data_t = data_in_3;
                        idx_rep[i] = '1;
                        rs1_rep[i] = '1;
                    end
                end

                if (!internal_array_lds[i].rs2_ready && internal_array_lds[i].use_prs2) begin
                    if (internal_array_lds[i].rs2_paddr == data_paddr_0) begin
                        data_t = data_in_0;
                        idx_rep[i] = '1;
                        rs2_rep[i] = '1;
                    end else if (internal_array_lds[i].rs2_paddr == data_paddr_1) begin
                        data_t = data_in_1;
                        idx_rep[i] = '1;
                        rs2_rep[i] = '1;
                    end else if (internal_array_lds[i].rs2_paddr == data_paddr_2) begin
                        data_t = data_in_2;
                        idx_rep[i] = '1;
                        rs2_rep[i] = '1;
                    end else if (internal_array_lds[i].rs2_paddr == data_paddr_3) begin
                        data_t = data_in_3;
                        idx_rep[i] = '1;
                        rs2_rep[i] = '1;
                    end
                end 

            end
        end
    end


    always_ff @(posedge clk) begin
        if (rst) begin
            inst_out_lds <= '0;
            //inst_out_lds_trans <= '0;
            for (integer i = 0; i < DEPTH; i++) begin
                internal_array_lds[i] <= '0;
            end
            tail <= '0;
            head <= '0;
        end else if (flush) begin
            inst_out_lds.valid <= '0;
            for (integer i = 0; i < DEPTH; i++) begin
                internal_array_lds[i] <= '0;
            end
            tail <= '0;
            head <= '0;
        end else begin
            inst_out_lds <= '0;

            for (integer i = 0; i < DEPTH; i++) begin
                if (idx_rep[i]) begin
                    if (rs2_rep[i]) begin   //rs2 replace
                        internal_array_lds[i].rs2_data <= data_t;
                        internal_array_lds[i].rs2_ready <= '1;
                    end 
                    if (rs1_rep[i]) begin      //rs1 replace
                        internal_array_lds[i].rs1_data <= data_t;
                        internal_array_lds[i].rs1_ready <= '1;
                    end
                end 
            end 
            
            if (!empty) begin
                if (!deq) begin
                    if (internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]].is_load) begin
                        if (internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]].rs1_ready) begin
                            inst_out_lds <= internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]];
                        end
                    end
                    else if (internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]].is_store) begin
                        if (internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]].rs1_ready && internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]].rs2_ready) begin
                            inst_out_lds <= internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]];
                        end
                    end
                end
                else begin
                    if (internal_array_lds[head_next[PTR_SIZE_LDS_Q-1:0]].is_load) begin
                        if (internal_array_lds[head_next[PTR_SIZE_LDS_Q-1:0]].rs1_ready) begin
                            inst_out_lds <= internal_array_lds[head_next[PTR_SIZE_LDS_Q-1:0]];
                        end
                    end
                    else if (internal_array_lds[head_next[PTR_SIZE_LDS_Q-1:0]].is_store) begin
                        if (internal_array_lds[head_next[PTR_SIZE_LDS_Q-1:0]].rs1_ready && internal_array_lds[head_next[PTR_SIZE_LDS_Q-1:0]].rs2_ready) begin
                            inst_out_lds <= internal_array_lds[head_next[PTR_SIZE_LDS_Q-1:0]];
                        end
                    end
                end
            end else begin
                inst_out_lds <= '0;
            end
            //if (inst_in_wb.valid) begin
                if (enq && deq) begin
                    //internal_array_wb[tail[PTR_SIZE_LDS_Q-1:0]] <= inst_in_wb;
                    //internal_array_wb[head[PTR_SIZE_LDS_Q-1:0]].valid <= '0;
                    //inst_out_wb <= inst_in_wb;
                    if (empty) begin
                        //inst_out_lds <= inst_in_lds;
                    end else if (full) begin
                        //inst_out_lds <= internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]];
                        internal_array_lds[tail[PTR_SIZE_LDS_Q-1:0]] <= inst_in_lds; 
                    end else begin
                        //inst_out_lds <= internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]];
                        internal_array_lds[tail[PTR_SIZE_LDS_Q-1:0]] <= inst_in_lds; 
                        internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]] <= '0;
                    end
                    tail <= (tail + 1'b1);
                    head <= (head + 1'b1);
                end else if (enq && !full) begin
                    //inst_out_lds <= internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]]; //'0;
                    internal_array_lds[tail[PTR_SIZE_LDS_Q-1:0]] <= inst_in_lds; 
                    tail <= (tail + 1'b1);
                end else if (deq && !empty) begin
                    //inst_out_lds <= internal_array_lds[head_next[PTR_SIZE_LDS_Q-1:0]];
                    internal_array_lds[head[PTR_SIZE_LDS_Q-1:0]] <= '0;
                    head <= (head + 1'b1);
                end
                
            //end
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
    //         inst_out_wb <= internal_array_wb[head[PTR_SIZE_LDS_Q-1:0]];
    //     end
    // end

endmodule : lds_q 
