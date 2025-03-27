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

    if_id_stage_reg_t if_id_reg, if_id_reg_next;

    always_ff @(posedge clk) begin
        if(rst) begin
            if_id_reg <= '0;
        end else if (!stall) begin
            if_id_reg <= if_id_reg_next;
        end
    end

    fifo #(
        .DEPTH      (8),
        .WIDTH      (32)
    ) inst_q(
        .clk(clk),
        .rst(rst),
        .enq(),
        .deq(),
        .inst_in(),
        .inst_out(),
        .valid_rdata(),
        .fifo_fetch_stall(stall)
    );

    pcreg pcreg(
        .rst(rst),
        .stall(stall),
        .pc(pc),
        .pc_next(pc_next)
    );

    cache icache(
        .clk(clk), // input
        .rst(rst), // input

        .ufp_addr(), // input
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

        .imem_addr(),
        .imem_rmask(),
        .imem_rdata(),
        .imem_resp(),

        .pc(pc),
        .pc_next(pc_next),

        .if_id(if_id_reg_next)
    );


endmodule : cpu