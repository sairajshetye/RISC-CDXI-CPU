module arbiter
import rv32i_types::*;
(
    input   logic               clk,
    input   logic               rst,

    input   logic   [31:0]      bmem_raddr,
    input   logic   [63:0]      bmem_rdata,
    input   logic               bmem_rvalid,
    input   logic               cache_read,

    output  logic   [31:0]      a_raddr, // does cache need?
    output  logic   [255:0]     a_rdata, // to cache
    output  logic               a_resp, // to cache (resp)
    output  logic               bmem_read,

    input   logic   [31:0]      cache_addr,
    input   logic   [255:0]     cache_wdata,
    input   logic               cache_write,

    output  logic   [31:0]      bmem_addr,
    output  logic   [63:0]      bmem_wdata,
    output  logic               bmem_write,

    input   logic               bmem_ready

    
);

/* output  logic   [31:0]      bmem_addr, //yes
    output  logic               bmem_read,
    output  logic               bmem_write, //yes
    output  logic   [63:0]      bmem_wdata, //yes
    input   logic               bmem_ready, //yes

    input   logic   [31:0]      bmem_raddr, //yes
    input   logic   [63:0]      bmem_rdata, //yes
    input   logic               bmem_rvalid //yes */


    enum logic [1:0] {
        rw_0,
        rw_1,
        rw_2,
        rw_3
    } state, state_next;


    logic   [255:0]     cache_rdata_reg;
    logic   [255:0]     cache_rdata_reg_next;

    logic               ready;

    assign ready = bmem_ready;

    always_ff @(posedge clk) begin
        if (rst) begin
            state <= rw_0;
            cache_rdata_reg <= '0;
        end
        else begin
            state <= state_next;
            cache_rdata_reg <= cache_rdata_reg_next;
        end
    end

    always_comb begin
        // default signals go here
        state_next = state;

        // outputs to DRAM
        bmem_addr = cache_addr;
        bmem_read = cache_read;
        bmem_write = cache_write;
        bmem_wdata = 'x; // cache_wdata[63:0];

        cache_rdata_reg_next = cache_rdata_reg;
        a_rdata = '0;
        a_raddr = bmem_raddr; // not needed?
        a_resp = '0;
        unique case (state)
            rw_0: begin
                if (bmem_rvalid && cache_read && ready) begin
                    cache_rdata_reg_next = {cache_rdata_reg[255:64], bmem_rdata};
                    a_rdata = '0;
                    a_resp = '0;
                    state_next = rw_1;
                end
                else if (cache_write && ready) begin
                    a_resp = '0;
                    bmem_wdata = cache_wdata[63:0];
                    state_next = rw_1;
                end
            end
            rw_1: begin
                if (bmem_rvalid && cache_read && ready) begin
                    cache_rdata_reg_next = {cache_rdata_reg[255:128], bmem_rdata, cache_rdata_reg[63:0]};
                    a_rdata = '0;
                    a_resp = '0;
                    state_next = rw_2;
                end
                else if (cache_write && ready) begin
                    a_resp = '0;
                    bmem_wdata = cache_wdata[127:64];
                    state_next = rw_2;
                end
            end
            rw_2: begin
                if (bmem_rvalid && cache_read && ready) begin
                    cache_rdata_reg_next = {cache_rdata_reg[255:192], bmem_rdata, cache_rdata_reg[127:0]};
                    a_rdata = '0;
                    a_resp = '0;
                    state_next = rw_3;
                end
                else if (cache_write && ready) begin
                    a_resp = '0;
                    bmem_wdata = cache_wdata[191:128];
                    state_next = rw_3;
                end
            end
            rw_3: begin
                if (bmem_rvalid && cache_read && ready) begin
                    cache_rdata_reg_next = {bmem_rdata, cache_rdata_reg[191:0]};
                    a_rdata = {bmem_rdata, cache_rdata_reg[191:0]};
                    a_resp = '1; // resp high
                    state_next = rw_0;
                end
                else if (cache_write && ready) begin
                    a_resp = '1;
                    bmem_wdata = cache_wdata[255:192];
                    state_next = rw_0;
                end
            end
            default: begin
            end
        endcase
    end





endmodule : arbiter