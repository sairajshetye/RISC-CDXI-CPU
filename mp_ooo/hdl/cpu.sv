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

    logic iq_stall;
    logic [31:0] pc;
    logic [31:0] pc_next;

    logic iq_enq;
    logic iq_deq;

    if_id_stage_reg_t if_id_reg_next;

    if_id_stage_reg_t inst_out;

    id_ex_stage_reg_t id_ex_stage_next;

    logic lb_rvalid;
    logic lb_wen;

    logic [255:0] cache_rdata;

    logic [31:0] cache_rdata_32;

    logic [255:0] lb_rdata;

    logic iq_valid_rdata;

    //logic [31:0] rs1_v, rs2_v;
    logic [4:0] rs1_s, rs2_s;


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
            cache_rdata_32[unsigned'(i)*8+:8] = cache_rdata[((ufp_addr[4:0]*8)+(unsigned'(i)*8))+:8]; 
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

    fifo #(
        .DEPTH      (8),
        .WIDTH      (164) // size of the if_id struct
    ) inst_q(
        .clk(clk),
        .rst(rst),
        .enq(iq_enq),
        .deq(iq_deq),
        .inst_in(if_id_reg_next),
        .inst_out(inst_out),
        .valid_rdata(iq_valid_rdata),
        .iq_stall(iq_stall)
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

    pcreg pcreg(
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .pc_next(pc_next)
    );

    // cache icache(
    //     .clk(clk), // input
    //     .rst(rst), // input

    //     .ufp_addr(ufp_addr), // input
    //     .ufp_rmask(ufp_rmask), // input
    //     .ufp_wmask(ufp_wmask), // input
    //     .ufp_rdata(ufp_rdata),
    //     .ufp_wdata(ufp_wdata), // input
    //     .ufp_resp(ufp_resp),

    //     // memory side signals, dfp -> downward facing port
    //     .dfp_addr(dfp_addr),
    //     .dfp_read(dfp_read),
    //     .dfp_write(dfp_write),
    //     .dfp_rdata(dfp_rdata), // input
    //     .dfp_wdata(dfp_wdata),
    //     .dfp_resp(dfp_resp) // input
    // );

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

    if_stage if_stage_1 (
        .clk(clk),
        .rst(rst),
        .iq_stall(iq_stall),
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

    id_stage id_stage_1 (
        .if_id(inst_out),
        //.rs1_v(rs1_v),
        //.rs2_v(rs2_v),
        .rs1_s(rs1_s),
        .rs2_s(rs2_s),
        .id_ex(id_ex_stage_next)
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