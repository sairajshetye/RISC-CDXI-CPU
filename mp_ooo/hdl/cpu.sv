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

    logic lb_rvalid;
    logic lb_wen;

    logic [255:0] cache_rdata;

    logic [31:0] cache_rdata_32;

    logic [255:0] lb_rdata;

    logic iq_valid_rdata;

    logic cache_rdata_valid;

    // cache port variables

    logic   [31:0]  ufp_addr;
    logic   [3:0]   ufp_rmask;
    logic   [3:0]   ufp_wmask;
    logic   [31:0]  ufp_rdata;
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
        if (lb_rvalid) begin // is it in the line buffer?
            cache_rdata = lb_rdata;
            cache_rdata_valid = '1;
        end else if (dfp_read && dfp_resp) begin // its not in the line buffer
            cache_rdata = dfp_rdata;
            cache_rdata_valid = '1;
        end else begin
            cache_rdata = 'x;
            cache_rdata_valid = '0;
        end

        for (integer unsigned i = 0; i < 4; i++) begin
            // ufp_addr[4:0] = offset
            cache_rdata_32[unsigned'(i)*8+:8] = cache_rdata[((ufp_addr[4:0]*8)+(unsigned'(i)*8))+:8]; 
        end
    end

    always_comb begin
        if (rst) begin
            pc_next = 32'hAAAAA000;
        end else if (!iq_stall) begin // && !if_id_reg_next.fetch_stall
            pc_next = pc + 4;
        end else begin
            pc_next = pc;
        end
    end


    linebuffer #(
        .WIDTH      (256)
    ) lb(
            .clk(clk),
            .rst(rst),
            .new_bmem_addr(ufp_addr), 
            .wen(dfp_read && dfp_resp),
            .wdata(dfp_rdata),
            .rdata(lb_rdata),
            .rvalid(lb_rvalid)    
    );

    fifo #(
        .DEPTH      (8),
        .WIDTH      (162) // size of the if_id struct
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

    cache icache(
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
        .imem_resp(cache_rdata_valid),

        .pc(pc),
        .pc_next(pc_next),

        .if_id(if_id_reg_next)
    );


endmodule : cpu