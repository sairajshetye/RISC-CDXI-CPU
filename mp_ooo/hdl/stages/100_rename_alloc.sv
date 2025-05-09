module rename_alloc
import rv32i_types::*;
#(
            parameter               PTR_SIZE = 6,
            parameter               ROB_PTR_SIZE = 3
)
(
    input   logic           clk,    //new
    input   logic           rst,    //new

    input id_ex_stage_reg_t id_ex, // comes from decode queue

    input   branch_t        br_pred,        //new
    input   branch_t_state  branch_t_states,    //new
    input   logic           set_pc_br,      //new
    input   logic    [31:0] pc_br_pred,     //new

    // inputs from RAT, FL, stalls?
    input   logic   [PTR_SIZE-1:0]   p_addr,
    input   logic   [ROB_PTR_SIZE-1:0]   rob_idx,
    input   logic           rob_overflow,
    // from RAT
    input   logic           rs1_renamed, rs2_renamed,
    input   logic   [PTR_SIZE-1:0]   rs1_paddr, rs2_paddr,

    // input   logic           res_stall,
    // input   logic           rob_stall,
    input   logic           rq_stall,
    input   logic   [PTR_SIZE:0]   fl_head,
    // output to ROB + dispatch, RAT
    //output  [4:0]   rd_s,
    output  logic           enq,
    // output  logic           deq,
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
    logic   [PTR_SIZE-1:0]   prd_s; 

    logic [31:0] prev_pc_reg;

    //logic           rs1_renamed, rs2_renamed;
    //logic   [6:0]   rs1_paddr, rs2_paddr;

    // assign deq = '0; // don't dequeue for now

    always_ff @(posedge clk) begin
        if (rst) begin
            prev_pc_reg <= '0;
        end else if (id_ex.valid) begin
            prev_pc_reg <= id_ex.pc;
        end
    end

    always_comb begin
        rat_rs1 = id_ex.rs1_s;
        rat_rs2 = id_ex.rs2_s;
        rd_s = id_ex.rd_s;
        if (id_ex.valid && id_ex.use_rd && rd_s != 5'd0) begin // only rename if rd != 0 and being used
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
        // if (id_ex.valid && !rob_stall) begin
        //     rob_enq = '1;
        // end
        // else begin
        //     rob_enq = '0;
        // end
        if (id_ex.valid) begin
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
       
        rob_entry.br_result = not_taken; // should be not known CHANGE LATER
        rob_entry.rfvi_monitor_vals = '0;
        // rob_entry.pc_next = id_ex.pc_next;
        rob_entry.ld_store = (id_ex.is_load || id_ex.is_store) ? '1 : '0;
        rob_entry.fl_head = fl_head;

        //new below
        if (id_ex.is_br && set_pc_br) begin
            rob_entry.br_pred = br_pred;      //new
            rob_entry.branch_t_state = branch_t_states;    //new
            rob_entry.pc_next = pc_br_pred;
        end else begin
            rob_entry.br_pred = id_ex.branch_pred;      //new
            rob_entry.branch_t_state = id_ex.branch_t_state;    //new
            rob_entry.pc_next = id_ex.pc_next;
        end
        if (prev_pc_reg != (id_ex.pc + 'd4)) begin
            rob_entry.br_pred = taken;
            rob_entry.branch_t_state = weakly_taken;    //new
        end else begin
            rob_entry.br_pred = br_pred;
        end

        // if ((id_ex.pc + 'd4) != id_ex.pc_next) begin
        //     rob_entry.br_pred = taken;
        // end else begin
        //     rob_entry.br_pred = br_pred;
        // end
        rob_entry.is_br = id_ex.is_br;  //new
        rob_entry.need_flush = '0;      //new
        // rob_entry.branch_t_state = branch_t_states;    //new
        rob_entry.pc = id_ex.pc;    //new
        //rob_entry.order = id_ex.order;
    end

    // 3. send to dispatch
    always_comb begin
        ra_dp.inst = id_ex.inst;
        ra_dp.pc = id_ex.pc;
        ra_dp.order = id_ex.order;
        // ra_dp.pc_next = id_ex.pc_next;
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
        ra_dp.is_br = id_ex.is_br;
        ra_dp.head = (id_ex.is_br) ? '0 : fl_head;
        ra_dp.is_store = id_ex.is_store;
        ra_dp.is_load = id_ex.is_load;
        ra_dp.use_rd = id_ex.use_rd;

        //new below
        if (id_ex.is_br && set_pc_br) begin
            ra_dp.branch_pred = br_pred; //id_ex.branch_pred; //new
            ra_dp.branch_t_state = branch_t_states;
            ra_dp.pc_next = pc_br_pred;


        end else begin
            ra_dp.branch_pred = id_ex.branch_pred;
            ra_dp.branch_t_state = id_ex.branch_t_state;
            ra_dp.pc_next = id_ex.pc_next;
        end
        if (prev_pc_reg != (id_ex.pc + 'd4)) begin
            ra_dp.branch_pred = taken;
            ra_dp.branch_t_state = weakly_taken;
        end else begin
            ra_dp.branch_pred = br_pred;

        end
        // if ((id_ex.pc + 'd4) != id_ex.pc_next) begin
        //     ra_dp.branch_pred = taken;
        // end else begin
        //     ra_dp.branch_pred = br_pred;
        // end
        // new above

        ra_dp.rob_idx = rob_idx;
        ra_dp.rob_overflow = rob_overflow;
        ra_dp.use_prs1 = rs1_renamed; // inputs from RAT
        ra_dp.rs1_paddr = rs1_renamed ? rs1_paddr : (PTR_SIZE-1)'(8'h7E);
        ra_dp.rs1_ready = '0; // not ready
        ra_dp.use_prs2 = rs2_renamed;
        ra_dp.rs2_paddr = rs2_renamed ? rs2_paddr : (PTR_SIZE-1)'(8'h7E);
        ra_dp.rs2_ready = '0;
        ra_dp.rd_paddr = prd_s;
        ra_dp.useless = '0;

        // if (res_stall) begin
        //     deq = '0;
        //     ra_dp.deq = '0;
        // end
        // else begin
        //     deq = '1;
        //     ra_dp.deq = '1;
        // end

        if (!rq_stall && id_ex.valid) begin
            enq = '1;
        end else begin
            enq = '0;
        end

        // enq = id_ex.deq;

        ra_dp.rfvi_monitor_vals = id_ex.rfvi_monitor_vals;
    end



endmodule : rename_alloc