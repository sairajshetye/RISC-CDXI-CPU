module robert
import rv32i_types::*;
 #(
            parameter               DEPTH     = 16,
            parameter               PTR_SIZE  = $clog2(DEPTH)

)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   enq,
    input   logic                   lds_deq,
    input   logic                   ld_status_0,
    input   logic                   ld_status_1,
    input   logic                   ld_status_2,
    input   logic                   ld_status_3,
    input   status_t                status_in_0,
    input   status_t                status_in_1,
    input   status_t                status_in_2,
    input   status_t                status_in_3,
    input   logic                   ld_branch_res,
    input   branch_t                branch_res_in, 
    input   logic [31:0]            br_pc_next,
    //input   logic [63:0]            order_out_wb,
    input   rob_entry_t             rob_in,
    input   logic [PTR_SIZE-1:0]    rob_idx_in,     //read idx
    input   logic [PTR_SIZE-1:0]    rob_idx_ld_0,     //for ld status
    input   logic [PTR_SIZE-1:0]    rob_idx_ld_1,     //for ld status
    input   logic [PTR_SIZE-1:0]    rob_idx_ld_2,     //for ld status
    input   logic [PTR_SIZE-1:0]    rob_idx_ld_3,     //for ld status
    input   rfvi_packet_t           rfvi_monitor_vals_0,
    input   rfvi_packet_t           rfvi_monitor_vals_1,
    input   rfvi_packet_t           rfvi_monitor_vals_2,
    input   rfvi_packet_t           rfvi_monitor_vals_3,
    output  rob_entry_t             rob_out,
    output  logic                   valid_rdata,
    output  logic                   alloc_stall,
    output  logic                   decode_stall,
    output  logic                   deq,
    output  logic [PTR_SIZE-1:0]    rob_tail_idx,
    output  logic [PTR_SIZE-1:0]    rob_head_idx,
    output  logic                   rob_overflow,
    output  logic                   aregf_we,
    output  logic [4:0]             ard_s,
    output  logic [6:0]             p_addr_ret,
    output logic flush

);

    logic valid_op;
    logic valid_enq;
    logic valid_deq;
    logic [PTR_SIZE:0] head;
    logic [PTR_SIZE:0] tail;
    logic [PTR_SIZE:0] tail_full;

    rob_entry_t rob[DEPTH];

    logic full, full_next;
    logic empty;
    //logic deq;

    // rob_entry_t rob_in_reg;
    assign tail_full = tail + 1'b1;

    always_comb begin

        full_next = (head[PTR_SIZE] != tail_full[PTR_SIZE] && head[PTR_SIZE-1:0] == (tail_full[PTR_SIZE-1:0])); 
        full = (head[PTR_SIZE] != tail[PTR_SIZE] && head[PTR_SIZE-1:0] == (tail[PTR_SIZE-1:0])); 
        empty = (head == tail);

        alloc_stall = full;
        decode_stall = full_next;
        //valid_rdata = ~empty;

        rob_tail_idx = tail[PTR_SIZE-1:0]; // in rename and allocate, set inst rob idx field to this tail
        rob_overflow = tail[PTR_SIZE];

        if (rob[head[PTR_SIZE-1:0]].ld_store) begin
            deq = lds_deq;
        end else begin
            deq = (rob[head[PTR_SIZE-1:0]].status == done && rob[head[PTR_SIZE-1:0]].valid && !empty);
        end
    end

    // always_ff @(posedge clk) begin // NOT BEING USED, CAN DELETE LATER?
    //     if (rst) begin
    //         rob_in_reg  <= 'x;
    //     end else begin
    //         rob_in_reg  <= rob_in;
    //     end
    // end


    always_ff @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < DEPTH; i++) begin
                rob[i] <= '0;
            end
            tail <= '0;
            head <= '0;
        end else begin
            if (enq && deq) begin
                if (full) begin
                    rob[tail[PTR_SIZE-1:0]] <= rob_in;
                end
                else begin
                    rob[tail[PTR_SIZE-1:0]] <= rob_in;
                    rob[head[PTR_SIZE-1:0]] <= '0;
                end
                // rob[head[PTR_SIZE-1:0]].valid <= '0;
                tail <= (tail + 4'b0001);
                head <= (head + 4'b0001);
            end else if (enq && !full) begin
                rob[tail[PTR_SIZE-1:0]] <= rob_in; 
                tail <= (tail + 4'b0001);
            end else if (deq && !empty) begin
                rob[head[PTR_SIZE-1:0]] <= '0;
                head <= (head + 4'b0001);
            end
        end

        // aregf_we <= '0;
        // ard_s <= '0;
        // p_addr_ret <= '0;
        if (ld_status_0) begin
            rob[rob_idx_ld_0].status <= status_in_0;
            //rob[rob_idx_ld].valid <= '0;
            if (status_in_0 == done) begin
                //aregf_we <= '1;
                //ard_s <= rob[rob_idx_ld].rd_addr;
                //p_addr_ret <= rob[rob_idx_ld].rd_paddr;
                rob[rob_idx_ld_0].rfvi_monitor_vals <= rfvi_monitor_vals_0;
            end
        end

        if (ld_status_1) begin
            rob[rob_idx_ld_1].status <= status_in_1;
            //rob[rob_idx_ld].valid <= '0;
            if (status_in_1 == done) begin
                //aregf_we <= '1;
                //ard_s <= rob[rob_idx_ld].rd_addr;
                //p_addr_ret <= rob[rob_idx_ld].rd_paddr;
                rob[rob_idx_ld_1].rfvi_monitor_vals <= rfvi_monitor_vals_1;
            end
        end

        if (ld_status_2) begin
            rob[rob_idx_ld_2].status <= status_in_2;
            //rob[rob_idx_ld].valid <= '0;
            if (status_in_2 == done) begin
                //aregf_we <= '1;
                //ard_s <= rob[rob_idx_ld].rd_addr;
                //p_addr_ret <= rob[rob_idx_ld].rd_paddr;
                rob[rob_idx_ld_2].rfvi_monitor_vals <= rfvi_monitor_vals_2;
            end
        end

        if (ld_status_3) begin
            rob[rob_idx_ld_3].status <= status_in_3;
            //rob[rob_idx_ld].valid <= '0;
            if (status_in_3 == done) begin
                //aregf_we <= '1;
                //ard_s <= rob[rob_idx_ld].rd_addr;
                //p_addr_ret <= rob[rob_idx_ld].rd_paddr;
                rob[rob_idx_ld_3].rfvi_monitor_vals <= rfvi_monitor_vals_3;
            end
        end

        if (ld_branch_res) begin
            rob[rob_idx_in].br_result <= branch_res_in;
            rob[rob_idx_in].pc_next <= br_pc_next;
            //rob[rob_idx_in].order <= order_out_wb;
        end

    
    end

    // always_comb begin
    //     if (empty) begin
    //         rob_out = 'x;
    //     end else begin
    //         rob_out = rob[rob_idx_in];
    //     end
    // end

    always_ff @ (posedge clk) begin
        if (rst) begin
            rob_out <= '0;
            aregf_we <= '0;
            ard_s <= '0;
            p_addr_ret <= '0;
            flush <= '0;
            valid_rdata <= '0;
            rob_head_idx <= '0;
        end
        else if (empty) begin
            rob_out <= '0;
            aregf_we <= '0;
            ard_s <= '0;
            p_addr_ret <= '0;
            flush <= '0;
            valid_rdata <= '0;
            rob_head_idx <= '0;
        end else begin
            if (rob[head[PTR_SIZE-1:0]].status == done) begin
                aregf_we <= (rob[head[PTR_SIZE-1:0]].ld_store) ? '0 : '1;
                ard_s <= rob[head[PTR_SIZE-1:0]].rd_addr;
                p_addr_ret <= rob[head[PTR_SIZE-1:0]].rd_paddr;
                valid_rdata <= rob[head[PTR_SIZE-1:0]].valid;
            end
            else begin
                aregf_we <= '0;
                ard_s <= '0;
                p_addr_ret <= '0;
                valid_rdata <= '0;
            end
            if (rob[head[PTR_SIZE-1:0]].br_pred != rob[head[PTR_SIZE-1:0]].br_result) begin
                flush <= '1;
                
            end else begin
                flush <= '0; //???
            end
            rob_out <= rob[head[PTR_SIZE-1:0]];
            rob_head_idx <= head[PTR_SIZE-1:0];
            
        end
    end

endmodule : robert