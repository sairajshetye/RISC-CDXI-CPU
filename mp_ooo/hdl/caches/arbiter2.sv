module arbiter2
import rv32i_types::*;
(
    input   logic               clk,
    input   logic               rst,

    // cpu side signals, ufp -> upward facing port
    //input   logic   [31:0]  ufp_addr    [2],
    //input   logic   [3:0]   ufp_rmask   [2],
    //input   logic   [3:0]   ufp_wmask   [2],
    // output  logic   [31:0]  ufp_rdata   [2],
    //input   logic   [31:0]  ufp_wdata   [2],
    // output  logic           ufp_resp    [2],

    // things from caches
    input  logic   [31:0]  dfp_addr    [2],
    input  logic           dfp_read    [2],
    input  logic           dfp_write   [2],
    input  logic   [255:0] dfp_wdata   [2],

    // pick one cache, to arbiter 1
    output  logic   [31:0]  dfp_addr_arb,
    output  logic           dfp_read_arb,
    output  logic           dfp_write_arb,
    output  logic   [255:0] dfp_wdata_arb,
    
    // from arbiter
    input   logic           dfp_resp_arb,
    input   logic   [255:0] dfp_rdata_arb,

    // to cache
    output   logic   [255:0] dfp_rdata_cache   [2],
    output   logic           dfp_resp_cache    [2]
    

);
    

    // arbiter - takes in one cache request, sends to memory, memory returns back to cache
    // fetch -> i_cache asks mem -> arbiter2 -> arbiter1 -> mem unit -> arbiter1 -> arbiter2 -> i_cache -> fetch
    // ld/st -> d_cache asks mem -> arbiter2 -> arbiter1 -> mem unit -> arbiter1 -> arbiter2 -> d_cache -> ld/sr


    // arbiter2 inputs/outputs: from caches (inst and data)
    
    // if ufp_rmask high on both 0 and 1, pick the one that wasnt last used
    // if ufp_rmask 0 high, send request with 0
    // if ufp_rmask 1 high, send request with 1

    // get output back and assign to appropriate asking 
    enum logic [1:0] {
        idle,
        s_0,
        s_1
    } state, state_next;

    logic   tiebreak;       // 0 = i_cache, 1 = d_cache
    logic   tiebreak_next;
    logic   both_req;

    always_ff @ (posedge clk) begin
        if (rst) begin
            state <= idle;
            tiebreak <= '0;
        end
        else begin
            state <= state_next;
            tiebreak <= tiebreak_next;
        end
    end

    always_comb begin
        state_next = state;
        tiebreak_next = '0;

        dfp_addr_arb = '0;
        dfp_read_arb = '0;
        dfp_write_arb = '0;
        dfp_wdata_arb = '0;

        dfp_rdata_cache[0] = '0;
        dfp_resp_cache[0] = '0;
        dfp_rdata_cache[1] = '0;
        dfp_resp_cache[1] = '0;
        unique case (state)
            idle: begin
                if (dfp_read[0] && dfp_read[1]) begin // both read
                    if (tiebreak == '0) begin // 0 = i
                        dfp_addr_arb = dfp_addr[0];
                        dfp_read_arb = dfp_read[0];
                        state_next = s_0;
                    end
                    else begin // 1 = d
                        dfp_addr_arb = dfp_addr[1];
                        dfp_read_arb = dfp_read[1];
                        state_next = s_1;
                    end
                end
                else if (dfp_read[0] && dfp_write[1]) begin // read and write
                    if (tiebreak == '0) begin // 0 = i
                        dfp_addr_arb = dfp_addr[0];
                        dfp_read_arb = dfp_read[0];
                        state_next = s_0;
                    end
                    else begin // 1 = d
                        dfp_addr_arb = dfp_addr[1];
                        dfp_write_arb = dfp_write[1];
                        dfp_wdata_arb = dfp_wdata[1];
                        state_next = s_1;
                    end
                end
                else if (dfp_read[0]) begin // read i only
                    dfp_addr_arb = dfp_addr[0];
                    dfp_read_arb = dfp_read[0];
                    state_next = s_0;
                end
                else if (dfp_read[1]) begin // read d only
                    dfp_addr_arb = dfp_addr[1];
                    dfp_read_arb = dfp_read[1];
                    state_next = s_1;
                end  
                else if (dfp_write[1]) begin // read d only
                    dfp_addr_arb = dfp_addr[1];
                    dfp_write_arb = dfp_write[1];
                    dfp_wdata_arb = dfp_wdata[1];
                    state_next = s_1;
                end
                else begin // none
                    dfp_addr_arb = '0;
                    dfp_read_arb = '0;
                    dfp_write_arb = '0;
                    dfp_wdata_arb = '0;
                end
            end
            s_0: begin // process i cache request (read only)
                dfp_addr_arb = dfp_addr[0];
                dfp_read_arb = dfp_read[0];
                if (dfp_resp_arb) begin
                    dfp_rdata_cache[0] = dfp_rdata_arb;
                    dfp_resp_cache[0] = dfp_resp_arb;
                    tiebreak_next = '1;
                    state_next = idle;
                end
            end
            s_1: begin // process d cache request
                if (dfp_read[1]) begin // read
                    dfp_addr_arb = dfp_addr[1];
                    dfp_read_arb = dfp_read[1];
                    if (dfp_resp_arb) begin
                        dfp_rdata_cache[1] = dfp_rdata_arb;
                        dfp_resp_cache[1] = dfp_resp_arb;
                        tiebreak_next = '0;
                        state_next = idle;
                    end
                end
                else begin // write
                    dfp_addr_arb = dfp_addr[1];
                    dfp_write_arb = dfp_write[1];
                    dfp_wdata_arb = dfp_wdata[1];
                    if (dfp_resp_arb) begin
                        dfp_resp_cache[1] = dfp_resp_arb;
                        tiebreak_next = '0;
                        state_next = idle;
                    end
                end
            end
            default: begin
            end
        endcase
    end



endmodule : arbiter2











