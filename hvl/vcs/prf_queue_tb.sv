module prf_queue_tb // top_tb

import rv32i_types::*;
();

    timeunit 1ps;
    timeprecision 1ps;

    int clock_half_period_ps;
    initial begin
        $value$plusargs("CLOCK_PERIOD_PS_ECE411=%d", clock_half_period_ps);
        clock_half_period_ps = clock_half_period_ps / 2;
    end

    bit clk;
    always #(clock_half_period_ps) clk = ~clk;
    bit rst;

    // declare dut signals
    logic                   enq; // input
    logic                   deq;
    logic   [31:0]          reg_v_in; // from the bus
    logic                   ld_prf; // load from bus
    logic   [6:0]           prf_idx_in; // to which reg
    logic   [6:0]           prf_idx_read; // to which reg

    prf_t                   prf_out; // output
    logic                   valid_rdata;
    logic                   prf_stall;
    logic   [6:0]           prf_tail_idx; // p_addr

    // instantiate the dut
    prf_queue dut (
        .*
    );

    initial begin
        $fsdbDumpfile("dump.fsdb");
        if ($test$plusargs("NO_DUMP_ALL_ECE411")) begin
            $fsdbDumpvars(0, dut, "+all");
            $fsdbDumpoff();
        end else begin
            $fsdbDumpvars(0, dut, "+all");
        end

        rst <= 1'b1;
        repeat (2) @(posedge clk);
        rst <= 1'b0;

        // input stuff
        enq <= '0; 
        deq <= '0;
        reg_v_in <= '0; 
        ld_prf <= '0; 
        prf_idx_in <= '0; 
        prf_idx_read <= '0;


        // create 3 registers - monitor the output p_addr
        repeat (3) @(posedge clk);
        enq <= '1; 
        repeat (1) @(posedge clk);
        enq <= '1; 
        repeat (1) @(posedge clk);
        enq <= '1; 
        repeat (1) @(posedge clk);
        enq <= '0; 

        repeat (3) @(posedge clk);


        repeat (10) @(posedge clk);
        prf_idx_in <= 7'b1;
        ld_prf <= '1;
        reg_v_in <= 32'hDEADBEEF;
        repeat (1) @(posedge clk);
        prf_idx_in <= '0;
        ld_prf <= '0;
        reg_v_in <= '0;

        repeat (10) @(posedge clk);
        reg_v_in <= '1;

        $finish;


    end

    // `include "top_tb.svh"

endmodule