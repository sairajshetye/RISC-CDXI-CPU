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

    // memory side signals, dfp -> downward facing port
    output  logic   [31:0]  dfp_addr    [2],
    output  logic           dfp_read    [2],
    output  logic           dfp_write   [2],
    input   logic   [255:0] dfp_rdata   [2],
    output  logic   [255:0] dfp_wdata   [2],
    input   logic           dfp_resp    [2]

);
    

    // arbiter - takes in one cache request, sends to memory, memory returns back to cache
    // fetch -> i_cache asks mem -> arbiter2 -> arbiter1 -> mem unit -> arbiter1 -> arbiter2 -> i_cache -> fetch
    // ld/st -> d_cache asks mem -> arbiter2 -> arbiter1 -> mem unit -> arbiter1 -> arbiter2 -> d_cache -> ld/sr


    // arbiter2 inputs/outputs: from caches (inst and data)
    
    // if ufp_rmask high on both 0 and 1, pick the one that wasnt last used
    // if ufp_rmask 0 high, send request with 0
    // if ufp_rmask 1 high, send request with 1

    // get output back and assign to appropriate asking 


    logic   tiebreak;       // 0 = i_cache, 1 = d_cache
    logic   tiebreak_next;
    logic   both_req;

    always_ff @ (posedge clk) begin
        if (rst) begin
            tiebreak <= '0;
        end
        else begin
            tiebreak <= tiebreak_next;
        end
    end

    always_comb begin
        tiebreak_next = '0;
    end

    always_comb begin


    end











endmodule : arbiter2












