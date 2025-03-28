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

    logic stall;
    logic [31:0] pc;
    logic [31:0] pc_next;

    logic iq_enq;
    logic iq_deq;

    if_id_stage_reg_t if_id_reg_next;

    if_id_stage_reg_t inst_out;

    logic lb_rvalid;
    logic lb_wen;

    logic [255:0] cache_rdata;
    logic [255:0] lb_rdata;

    logic iq_valid_rdata;



    always_comb begin
        if (lb_rvalid) begin
            cache_rdata = lb_rdata;
            lb_wen = '0;
        end
        // end else begin
        //     // cache_rdata = output of arbiter
        //     // lb_wen = '1;
        // end
    end

    linebuffer #(
        .WIDTH      (256)
    ) lb(
            .clk(clk),
            .rst(rst),
            .new_bmem_addr(bmem_addr), 
            .wen(),
            .wdata(),
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
        .fifo_stall(stall)
    );

    pcreg pcreg(
        .rst(rst),
        .stall(stall),
        .fetch_stall(fetch_stall),
        .pc(pc),
        .pc_next(pc_next)
    );

    cache icache(
        .clk(clk), // input
        .rst(rst), // input

        .ufp_addr(bmem_raddr), // input
        .ufp_rmask(), // input
        .ufp_wmask(), // input
        .ufp_rdata(),
        .ufp_wdata(), // input
        .ufp_resp(),

        // memory side signals, dfp -> downward facing port
        .dfp_addr(),
        .dfp_read(),
        .dfp_write(),
        .dfp_rdata(), // input
        .dfp_wdata(),
        .dfp_resp() // input
    );

    if_stage if_stage_1 (
        .clk(clk),
        .rst(rst),
        .stall(stall),
        .enq(iq_enq),
        .deq(iq_deq),

        .imem_addr(),
        .imem_rmask(),
        .imem_rdata(),
        .imem_resp(),

        .pc(pc),
        .pc_next(pc_next),

        .if_id(if_id_reg_next)
    );


endmodule : cpu