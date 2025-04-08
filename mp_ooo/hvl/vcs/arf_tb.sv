module arf_tb // top_tb

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
    logic           regf_we; // input
    logic   [31:0]  rd_v; // input
    logic   [4:0]   rs1_s, rs2_s, rd_s; // input
    logic           rename_we; // input
    logic   [4:0]   rd_rename; // input
    logic   [6:0]   p_addr; // input
    logic   [6:0]   p_addr_ret; // input

    arf_reg_t       ars1_v, ars2_v; // outputs the full struct

    // instantiate the dut
    rat_arf dut (
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
        regf_we <= '0; // input
        rd_v <= '0; // input
        rs1_s <= '0; 
        rs2_s <= '0; 
        rd_s <= '0; // input
        rename_we <= '0; // input
        rd_rename <= '0; // input
        p_addr <= '0; // input
        p_addr_ret <= '0; // input


        repeat (1) @(posedge clk);
        // done upon a commit
        regf_we <= '1;
        p_addr_ret <=  7'h3A;
        rd_s <= 5'b00001;
        rd_v <= 32'hDEADBEEF;

        repeat (1) @(posedge clk);
        regf_we <= '0;
        p_addr_ret <=  '0;
        rd_s <= '0;
        rd_v <= '0;


        repeat (5) @(posedge clk);

        rs1_s <= 5'b00001;

        repeat (5) @(posedge clk);

        rename_we <= '1; 
        rd_rename <= 5'b00001; 
        p_addr <= 7'h3F; 

        repeat (1) @(posedge clk);
        rename_we <= '0; 
        rd_rename <= 5'b00000; 

        repeat (3) @(posedge clk); // need to add testing for the rrf part (p_addr_ret)

        $finish;


    end

    // `include "top_tb.svh"

endmodule