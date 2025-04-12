module rename_alloc
import rv32i_types::*;
(
    input id_ex_stage_reg_t id_ex, // comes from decode queue

    // inputs from RAT, FL, stalls?
    input   logic   [6:0]   p_addr,
    input   logic   [3:0]   rob_idx,
    input   logic           rob_overflow,
    // from RAT
    input   logic           rs1_renamed, rs2_renamed,
    input   logic   [6:0]   rs1_paddr, rs2_paddr,

    input   logic           res_stall,
    input   logic           rob_stall,
    // output to ROB + dispatch, RAT
    //output  [4:0]   rd_s,

    // FORWARD FROM THE BUS
    input logic [6:0]    data_paddr,
    input logic [31:0]   data_in,

    output  logic           enq,
    output  logic           deq,
    output  logic           rename_we,
    output  logic           fl_deq,
    output  logic           rob_enq,

    // to RAT
    output  logic   [4:0]   rat_rs1,
    output  logic   [4:0]   rat_rs2,

    output  rob_entry_t rob_entry,

    output ra_dp_stage_reg_t ra_dp
);


    // 1. rename the rd of the input instruction
    // - dequeue the free list -> read from free list (comb read)
    // take the addr from the free list and put that into the RAT entry
    logic   [4:0]   rd_s;
    logic   [6:0]   prd_s; 

    //logic           rs1_renamed, rs2_renamed;
    //logic   [6:0]   rs1_paddr, rs2_paddr;

    // assign deq = '0; // don't dequeue for now

    always_comb begin
        rat_rs1 = id_ex.rs1_s;
        rat_rs2 = id_ex.rs2_s;
        rd_s = id_ex.rd_s;
        if (id_ex.use_rd && rd_s != 5'd0) begin // only rename if rd != 0 and being used
            prd_s = p_addr;
            rename_we = '1;
            fl_deq = '1;
        end
        else begin
            prd_s = '0;
            rename_we = '0;
            fl_deq = '0;
        end
    end

    // 2. allocate the rob
    // enqueue into the rob
    // - set rob idx in the ra_dp 
    always_comb begin
        if (id_ex.valid && !rob_stall) begin
            rob_enq = '1;
        end
        else begin
            rob_enq = '0;
        end
        rob_entry.valid = '1;
        rob_entry.status = waiting;
        rob_entry.opcode = id_ex.opcode;
        rob_entry.use_rd = id_ex.use_rd;
        rob_entry.rd_paddr = prd_s;
        rob_entry.rd_addr = id_ex.rd_s; 
        rob_entry.br_pred = not_taken;
        rob_entry.br_result = not_taken; // should be not known CHANGE LATER
        rob_entry.rfvi_monitor_vals = '0;
    end

    // 3. send to dispatch
    always_comb begin
        ra_dp.inst = id_ex.inst;
        ra_dp.pc = id_ex.pc;
        ra_dp.order = id_ex.order;
        ra_dp.pc_next = id_ex.pc_next;
        ra_dp.valid = id_ex.valid;
        ra_dp.stall = id_ex.stall;
        //ra_dp.funct3 = id_ex.funct7;???
        ra_dp.funct3 = id_ex.funct3;
        ra_dp.funct7 = id_ex.funct7;
        ra_dp.opcode = id_ex.opcode;
        ra_dp.i_imm = id_ex.i_imm;
        ra_dp.s_imm = id_ex.s_imm;
        ra_dp.b_imm = id_ex.b_imm;
        ra_dp.u_imm = id_ex.u_imm;
        ra_dp.j_imm = id_ex.j_imm;
        ra_dp.rs1_s = id_ex.rs1_s;
        ra_dp.use_rs1 = id_ex.use_rs1;
        ra_dp.rs2_s = id_ex.rs2_s;
        ra_dp.use_rs2 = id_ex.use_rs2;
        ra_dp.rd_s = id_ex.rd_s;
        ra_dp.regf_we = id_ex.regf_we;
        ra_dp.is_store = id_ex.is_store;
        ra_dp.use_rd = id_ex.use_rd;

        // new
        ra_dp.rob_idx = rob_idx;
        ra_dp.rob_overflow = rob_overflow;
        ra_dp.use_prs1 = rs1_renamed; // inputs from RAT
        ra_dp.rs1_paddr = rs1_renamed ? rs1_paddr : 7'h7E;
        ra_dp.rs1_ready = '0; // not ready
        ra_dp.use_prs2 = rs2_renamed;
        ra_dp.rs2_paddr = rs2_renamed ? rs2_paddr : 7'h7E;
        ra_dp.rs2_ready = '0;
        ra_dp.rd_paddr = prd_s;
        ra_dp.useless = '0;

        ra_dp.rs1_data = '0;
        ra_dp.rs2_data = '0;

        // FORWARDING

        // if (ra_dp.use_rs1 && ra_dp.rs1_paddr == data_paddr) begin
        //     ra_dp.rs1_ready = '1;
        //     ra_dp.rs1_data = data_in;
        // end

        // if (ra_dp.use_rs2 && ra_dp.rs2_paddr == data_paddr) begin
        //     ra_dp.rs2_ready = '1;
        //     ra_dp.rs2_data = data_in;
        // end


        if (res_stall) begin
            deq = '0;
            ra_dp.deq = '0;
        end
        else begin
            deq = '1;
            ra_dp.deq = '1;
        end

        enq = id_ex.deq;

        ra_dp.rfvi_monitor_vals = id_ex.rfvi_monitor_vals;
    end



endmodule : rename_alloc