module prf_queue
import rv32i_types::*;
 #(
            parameter               DEPTH     = 128,
            parameter               PTR_SIZE  = $clog2(DEPTH),
            parameter               WIDTH     = 32

)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   enq,
    input   logic                   deq,
    input   logic   [WIDTH-1:0]     reg_v_in, // from the bus
    input   logic                   ld_prf, // load from bus
    input   logic   [PTR_SIZE-1:0]  prf_idx_in, // to which reg
    input   logic   [PTR_SIZE-1:0]  prf_idx_read, // want to read from prf
    output  prf_t                   prf_out,
    output  logic                   valid_rdata,
    output  logic                   prf_stall,
    output  logic   [PTR_SIZE-1:0]           prf_tail_idx

);

    logic valid_op;
    logic valid_enq;
    logic valid_deq;
    logic [PTR_SIZE:0] head;
    logic [PTR_SIZE:0] tail;

    prf_t prf [DEPTH];

    logic full;
    logic empty;

    // logic [WIDTH-1:0] inst_in_reg;

    always_comb begin

        full = (head[PTR_SIZE] != tail[PTR_SIZE] && head[PTR_SIZE-1:0] == tail[PTR_SIZE-1:0]); 
        empty = (head == tail);

        prf_stall = full;
        valid_rdata = ~empty;

        prf_tail_idx = tail[6:0]; // p_addr = prf_tail (use in renaming)

    end

    // always_ff @(posedge clk) begin // NOT BEING USED, CAN DELETE LATER?
    //     if (rst) begin
    //         inst_in_reg  <= 'x;
    //     end else begin
    //         inst_in_reg  <= inst_in;
    //     end
    // end


    always_ff @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < DEPTH; i++) begin
                prf[i] <= '0;
            end
            tail <= '0;
            head <= '0;
        end else begin
            if (enq && deq) begin
                prf[tail].valid <= '0; // not valid
                prf[tail].value <= '0; // data not avail
                tail <= (tail + 4'b0001);
                head <= (head + 4'b0001);
            end else if (enq && !full) begin
                prf[tail].valid <= '0; // not valid
                prf[tail].value <= '0; // data not avail
                tail <= (tail + 4'b0001);
            end else if (deq && !empty) begin
                head <= (head + 4'b0001);
            end
        end

        if (ld_prf) begin
            prf[prf_idx_in].valid <= '1; // data valid
            prf[prf_idx_in].value <= reg_v_in; // input data
        end
    
    end

    always_comb begin
        if (empty) begin
            prf_out = 'x;
        end else begin
            prf_out = prf[prf_idx_read]; // reading from PRF, does not do transparent reading
        end
    end

endmodule : prf_queue