module cpu
import rv32i_types::*;
(
    input   logic               clk,
    input   logic               rst,

    output  logic   [31:0]      bmem_addr,
    output  logic               bmem_read,
    output  logic               bmem_write,
    output  logic   [63:0]      bmem_wdata,
    input   logic               bmem_ready,

    input   logic   [31:0]      bmem_raddr,
    input   logic   [63:0]      bmem_rdata,
    input   logic               bmem_rvalid
);

    logic [31:0] pc;
    logic [31:0] pc_next;

    logic iq_enq, dq_enq, rq_enq, fl_enq, rob_enq;
    logic iq_deq, dq_deq, rq_deq, fl_deq;

    if_id_stage_reg_t if_id_reg_next, if_id_inst_out;
    id_ex_stage_reg_t id_ex_reg_next, id_ex_inst_out;
    ra_dp_stage_reg_t ra_dp_reg_next, ra_dp_inst_out;

    rob_entry_t rob_entry, rob_out;

    logic [255:0] cache_rdata;

    logic [31:0] cache_rdata_32;

    logic [255:0] lb_rdata;

    logic iq_valid_rdata, dq_valid_rdata, rq_valid_rdata, fl_valid_rdata, rob_valid_rdata;
    logic iq_stall, dq_stall, rq_stall, fl_stall, rob_stall;

    //logic [31:0] rs1_v, rs2_v;
    logic [4:0] rs1_s, rs2_s;

    logic [6:0] p_addr_in, p_addr_out; // free list

    logic [3:0] rob_tail_idx;
    logic [6:0] rs1_paddr, rs2_paddr;

    logic [4:0] rat_rs1, rat_rs2;

    arf_reg_t ars1_v, ars2_v;

    logic rs1_renamed, rs2_renamed;
    logic       rename_we;


    // cache port variables

    logic   [31:0]  ufp_addr;
    logic   [3:0]   ufp_rmask;
    logic   [3:0]   ufp_wmask;
    logic   [255:0]  ufp_rdata;
    logic   [31:0]  ufp_wdata;
    logic           ufp_resp;

    logic   [31:0]  dfp_addr;
    logic           dfp_read;
    logic           dfp_write;
    logic   [255:0] dfp_rdata;
    logic   [255:0] dfp_wdata;
    logic           dfp_resp;
    
    // other arbiter variables

    logic [31:0] a_raddr;

    assign ufp_wdata = '0;
    assign ufp_wmask = '0;
    

    always_comb begin
        if (|ufp_rmask && ufp_resp) begin
            cache_rdata = ufp_rdata;
        end else begin
            cache_rdata = 'x;
        end

        for (integer unsigned i = 0; i < 4; i++) begin
            // ufp_addr[4:0] = offset
            cache_rdata_32[unsigned'(i)*8+:8] = cache_rdata[((pc[4:0]*8)+(unsigned'(i)*8))+:8]; 
        end
    end

    always_comb begin
        if (rst) begin
            pc_next = 32'hAAAAA000;
        end else if (!iq_stall && !if_id_reg_next.fetch_stall) begin // && !if_id_reg_next.fetch_stall
            pc_next = pc + 4;
        end else begin
            pc_next = pc;
        end
    end

    pcreg pcreg(
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .pc_next(pc_next)
    );

    if_stage if_stage_1 (
        .clk(clk),
        .rst(rst),
        .iq_stall(iq_stall),
        .dq_stall(dq_stall),
        .enq(iq_enq),
        .deq(iq_deq),

        .imem_addr(ufp_addr),
        .imem_rmask(ufp_rmask),
        .imem_rdata(cache_rdata_32),
        .imem_resp(ufp_resp),

        .pc(pc),
        .pc_next(pc_next),

        .if_id(if_id_reg_next)
    );

    inst_q #(
        .DEPTH      (8)
    ) inst_q(
        .clk(clk),
        .rst(rst),
        .enq(iq_enq),
        .deq(iq_deq),
        .inst_in(if_id_reg_next),
        .inst_out(if_id_inst_out),
        .valid_rdata(iq_valid_rdata),
        .iq_stall(iq_stall)
    );

    id_stage id_stage_1 (
        .if_id(if_id_inst_out),
        //.rs1_v(rs1_v),
        //.rs2_v(rs2_v),
        .rq_stall(rq_stall),
        .enq(dq_enq),
        .deq(dq_deq),
        .rs1_s(rs1_s),
        .rs2_s(rs2_s),
        .id_ex(id_ex_reg_next)
    );

    decode_q #(
        .DEPTH      (8)
    ) decode_q(
        .clk(clk),
        .rst(rst),
        .enq(dq_enq),
        .deq(dq_deq),
        .inst_in_d(id_ex_reg_next),
        .inst_out_d(id_ex_inst_out),
        .valid_rdata(dq_valid_rdata),
        .dq_stall(dq_stall)
    );

    rename_alloc rename_alloc_1 (
        .id_ex(id_ex_inst_out), // comes from decode queue
        // inputs from RAT, FL, stalls?
        .p_addr(p_addr_out), // FL
        .rob_idx(rob_tail_idx),
        // from RAT
        .rs1_renamed(rs1_renamed), 
        .rs2_renamed(rs2_renamed),
        .rs1_paddr(rs1_paddr), 
        .rs2_paddr(rs2_paddr),
        // output to ROB + dispatch, RAT
        .enq(rq_enq),
        .deq(rq_deq),
        .rename_we(rename_we),
        .fl_deq(fl_deq),
        .rob_enq(rob_enq),
        // to RAT
        .rat_rs1(rat_rs1),
        .rat_rs2(rat_rs2),
        .rob_entry(rob_entry),
        .ra_dp(ra_dp_reg_next)
    );

    rat_arf rat_arf_1 (
        .clk(clk),
        .rst(rst),
        .regf_we('0),
        .rd_v('0),
        .rs1_s(rs1_s), 
        .rs2_s(rs2_s), 
        .rd_s('0),
        .rename_we(rename_we),
        .rd_rename(ra_dp_reg_next.rd_s),
        .p_addr(ra_dp_reg_next.rd_paddr), // speculative (rat)
        .p_addr_ret('0), // real (rrf)
        .rat_rs1(rat_rs1), 
        .rat_rs2(rat_rs2),
        .rs1_renamed(rs1_renamed), 
        .rs2_renamed(rs2_renamed),
        .rs1_paddr(rs1_paddr), 
        .rs2_paddr(rs2_paddr),
        .ars1_v(ars1_v), 
        .ars2_v(ars2_v)
    );

    rename_q #(
        .DEPTH      (8)
    ) rename_q(
        .clk(clk),
        .rst(rst),
        .enq(rq_enq),
        .deq(rq_deq),
        .inst_in_r(ra_dp_reg_next),
        .inst_out_r(ra_dp_inst_out),
        .valid_rdata(rq_valid_rdata),
        .rq_stall(rq_stall)
    );

    free_list #(
        .DEPTH      (128)
    ) free_list(
        .clk(clk),
        .rst(rst),
        .enq(fl_enq),
        .deq(fl_deq),
        .p_addr_in(rob_out.rd_paddr),
        .p_addr_out(p_addr_out),
        .valid_rdata(fl_valid_rdata),
        .rename_stall(fl_stall)
    );

    robert #(
        .DEPTH      (16)
    ) robert(
        .clk(clk),
        .rst(rst),
        .enq(rob_enq),
        .ld_status('0),
        .status_in(waiting), // '0
        .ld_branch_res('0),
        .branch_res_in(not_taken), // '0
        .rob_in(rob_entry),
        .rob_idx_in('0),
        .rob_out(rob_out),
        .valid_rdata(rob_valid_rdata),
        .alloc_stall(rob_stall),
        .deq(fl_enq),
        .rob_tail_idx(rob_tail_idx)
    );
    












    arbiter arbiter(
        .clk(clk), // input
        .rst(rst), // input

        .bmem_raddr(bmem_raddr), // input
        .bmem_rdata(bmem_rdata), // input
        .bmem_rvalid(bmem_rvalid), // input
        .cache_read(dfp_read), // input

        .a_raddr(a_raddr), // does cache need?
        .a_rdata(dfp_rdata), // to cache
        .a_resp(dfp_resp), // to cache (resp)
        .bmem_read(bmem_read),

        .cache_addr(dfp_addr), // input
        .cache_wdata(dfp_wdata), // input
        .cache_write(dfp_write), // input

        .bmem_addr(bmem_addr),
        .bmem_wdata(bmem_wdata),
        .bmem_write(bmem_write),

        .bmem_ready(bmem_ready) // input
    );

    cache_mod icache(
        .clk(clk), // input
        .rst(rst), // input

        .ufp_addr(ufp_addr), // input
        .ufp_rmask(ufp_rmask), // input
        .ufp_wmask(ufp_wmask), // input
        .ufp_rdata(ufp_rdata),
        .ufp_wdata(ufp_wdata), // input
        .ufp_resp(ufp_resp),

        // memory side signals, dfp -> downward facing port
        .dfp_addr(dfp_addr),
        .dfp_read(dfp_read),
        .dfp_write(dfp_write),
        .dfp_rdata(dfp_rdata), // input
        .dfp_wdata(dfp_wdata),
        .dfp_resp(dfp_resp) // input
    );


    /*
            logic           monitor_valid;
            logic   [63:0]  monitor_order;
            logic   [31:0]  monitor_inst;
            logic   [4:0]   monitor_rs1_addr;
            logic   [4:0]   monitor_rs2_addr;
            logic   [31:0]  monitor_rs1_rdata;
            logic   [31:0]  monitor_rs2_rdata;
            logic           monitor_regf_we;
            logic   [4:0]   monitor_rd_addr;
            logic   [31:0]  monitor_rd_wdata;
            logic   [31:0]  monitor_pc_rdata;
            logic   [31:0]  monitor_pc_wdata;
            logic   [31:0]  monitor_mem_addr;
            logic   [3:0]   monitor_mem_rmask;
            logic   [3:0]   monitor_mem_wmask;
            logic   [31:0]  monitor_mem_rdata;
            logic   [31:0]  monitor_mem_wdata;
    
    assign monitor_valid     = mem_wb_reg.valid&~global_stall;
    assign monitor_order     = mem_wb_reg.order;
    assign monitor_inst      = mem_wb_reg.inst;
    assign monitor_rs1_addr  = mem_wb_reg.rs1_s;
    assign monitor_rs2_addr  = mem_wb_reg.rs2_s;
    assign monitor_rs1_rdata = mem_wb_reg.rs1_v; // need
    assign monitor_rs2_rdata = mem_wb_reg.rs2_v; // need
    assign monitor_rd_addr   = mem_wb_reg.regf_we ? mem_wb_reg.rd_s : 5'd0; // need
    assign monitor_rd_wdata  = mem_wb_reg.rd_v; // need
    assign monitor_pc_rdata  = mem_wb_reg.pc;
    assign monitor_pc_wdata  = mem_wb_reg.pc_next;
    assign monitor_mem_addr  = mem_wb_reg.dmem_addr; // should be i or d?
    assign monitor_mem_rmask = mem_wb_reg.dmem_rmask;
    assign monitor_mem_wmask = mem_wb_reg.dmem_wmask;
    assign monitor_mem_rdata = mem_wb_reg.dmem_rdata;
    assign monitor_mem_wdata = mem_wb_reg.dmem_wdata;
    */

endmodule : cpu