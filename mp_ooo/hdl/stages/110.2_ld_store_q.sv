 module lds_q
import rv32i_types::*;
 #(
            parameter               DEPTH     = 16,
            parameter               PTR_SIZE  = $clog2(DEPTH),
            parameter               WIDTH     = 32

)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   enq,
    input   logic                   ready_deq,
    input   dp_is_stage_reg_t       inst_in_lds,
    output  dp_is_stage_reg_t       inst_out_lds,
    output  dp_is_stage_reg_t       inst_out_lds_trans,
    output  logic                   valid_rdata,
    output  logic                   lds_stall,

    input   logic   [6:0]  data_paddr_0, //from intfunct 
    input   logic   [31:0]     data_in_0,    //from intfunct  
    input   logic   [6:0]  data_paddr_1, //from mult 
    input   logic   [31:0]     data_in_1,    //from mult
    input   logic   [6:0]  data_paddr_2, //from br
    input   logic   [31:0]     data_in_2,    //from br
    input   logic   [6:0]  data_paddr_3, //from ld
    input   logic   [31:0]     data_in_3    //from ld

);

    logic valid_op;
    logic valid_enq;
    logic valid_deq;
    logic deq;
    logic in_out; 
    logic [PTR_SIZE:0] head;
    logic [PTR_SIZE:0] tail;

    dp_is_stage_reg_t internal_array_lds [DEPTH];

    logic full;
    logic empty;

    logic   [WIDTH-1:0]     data_t;
    logic   [DEPTH-1:0]     idx_rep; 
    //logic   [DEPTH-1:0]     rs2_rep;
    dp_is_stage_reg_t inst_tmp;

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

        lds_stall = full;
        valid_rdata = ~empty;

        // if (!empty) begin
        //     deq = ready_deq;
        // end
        // else begin
        //     deq = '0;
        // end

        //deq = ready_deq;
        deq = (ready_deq && (internal_array_lds[head[PTR_SIZE-1:0]].use_rs2 == '1) && (internal_array_lds[head[PTR_SIZE-1:0]].rs1_ready == '1) && internal_array_lds[head[PTR_SIZE-1:0]].valid && !empty);

        in_out = (enq && deq);

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
        for (integer i = 0; i < DEPTH; i++) begin
            if (internal_array_lds[i].valid && internal_array_lds[i].is_store) begin
                if (!internal_array_lds[i].rs2_ready && internal_array_lds[i].use_prs2 && (internal_array_lds[i].rs2_paddr == data_paddr_0)) begin      //if using rs2 check if bus_in is for rs2
                        data_t = data_in_0;
                        idx_rep[i] = '1;
                        //rs2_rep[i] = '1;
                        //replace = '1;
                        //internal_array_lds[i].rs2_data = data_in;
                       // internal_array_lds[i].rs2_ready = data_in;
                end
                else if (!internal_array_lds[i].rs2_ready && internal_array_lds[i].use_prs2 && (internal_array_lds[i].rs2_paddr == data_paddr_1)) begin      //if using rs2 check if bus_in is for rs2
                        data_t = data_in_1;
                        idx_rep[i] = '1;
                        //rs2_rep[i] = '1;
                        //replace = '1;
                        //internal_array_lds[i].rs2_data = data_in;
                       // internal_array_lds[i].rs2_ready = data_in;
                end
                else if (!internal_array_lds[i].rs2_ready && internal_array_lds[i].use_prs2 && (internal_array_lds[i].rs2_paddr == data_paddr_2)) begin      //if using rs2 check if bus_in is for rs2
                        data_t = data_in_2;
                        idx_rep[i] = '1;
                        //rs2_rep[i] = '1;
                        //replace = '1;
                        //internal_array_lds[i].rs2_data = data_in;
                       // internal_array_lds[i].rs2_ready = data_in;
                end
                else if (!internal_array_lds[i].rs2_ready && internal_array_lds[i].use_prs2 && (internal_array_lds[i].rs2_paddr == data_paddr_3)) begin      //if using rs2 check if bus_in is for rs2
                        data_t = data_in_3;
                        idx_rep[i] = '1;
                        //rs2_rep[i] = '1;
                        //replace = '1;
                        //internal_array_lds[i].rs2_data = data_in;
                       // internal_array_lds[i].rs2_ready = data_in;
                end
            end
        end
    end


    always_ff @(posedge clk) begin
        if (rst) begin
            inst_out_lds <= '0;
            inst_out_lds_trans <= '0;
            for (integer i = 0; i < DEPTH; i++) begin
                internal_array_lds[i] <= '0;
            end
            tail <= '0;
            head <= '0;
        end else begin
            inst_out_lds <= '0;

            for (integer i = 0; i < DEPTH; i++) begin
                if (idx_rep[i]) begin
                    internal_array_lds[i].rs2_data <= data_t;
                    internal_array_lds[i].rs2_ready <= '1;
                end 
            end 
            


            //if (inst_in_wb.valid) begin
                if (enq && deq) begin
                    //internal_array_wb[tail[PTR_SIZE-1:0]] <= inst_in_wb;
                    //internal_array_wb[head[PTR_SIZE-1:0]].valid <= '0;
                    //inst_out_wb <= inst_in_wb;
                    if (empty) begin
                        inst_out_lds <= inst_in_lds;
                    end else if (full) begin
                        inst_out_lds <= internal_array_lds[head[PTR_SIZE-1:0]];
                        internal_array_lds[tail[PTR_SIZE-1:0]] <= inst_in_lds; 
                    end else begin
                        inst_out_lds <= internal_array_lds[head[PTR_SIZE-1:0]];
                        internal_array_lds[tail[PTR_SIZE-1:0]] <= inst_in_lds; 
                    end
                    tail <= (tail + 1'b1);
                    head <= (head + 1'b1);
                end else if (enq && !full) begin
                    inst_out_lds <= '0;
                    internal_array_lds[tail[PTR_SIZE-1:0]] <= inst_in_lds; 
                    tail <= (tail + 1'b1);
                end else if (deq && !empty) begin
                    inst_out_lds <= internal_array_lds[head[PTR_SIZE-1:0]];
                    internal_array_lds[head[PTR_SIZE-1:0]] <= '0;
                    head <= (head + 1'b1);
                end
                inst_out_lds_trans <= internal_array_lds[head[PTR_SIZE-1:0]];
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
    //         inst_out_wb <= internal_array_wb[head[PTR_SIZE-1:0]];
    //     end
    // end

endmodule : lds_q 