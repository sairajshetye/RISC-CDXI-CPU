module top_tb // prf_tb

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
    logic               regf_we;
    logic   [31:0]      rd_v;
    logic   [6:0]       rs1_s, rs2_s, rd_s;
    prf_t               prs1_v, prs2_v;

    // instantiate the dut
    prf dut (
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
        regf_we <= '0;
        rd_v <= '0;
        rs1_s <= '0;
        rs2_s <= '0;
        rd_s <= '0;
        // prs1_v <= '0;
        // prs2_v <= '0;

        // write
        repeat (1) @(posedge clk);
        regf_we <= '1;
        rd_s <= 7'b0;
        rd_v <= 32'b0;
        repeat (1) @(posedge clk);
        rd_s <= 7'b1;
        rd_v <= 32'b1;
        repeat (1) @(posedge clk);
        rd_s <= 7'b10;
        rd_v <= 32'b10;
        repeat (1) @(posedge clk);
        rd_s <= 7'b11;
        rd_v <= 32'b11;
        repeat (1) @(posedge clk);
        rd_s <= 7'b100;
        rd_v <= 32'b100;
        repeat (1) @(posedge clk);
        rd_s <= 7'b101;
        rd_v <= 32'b101;
        // read
        repeat (1) @(posedge clk);
        regf_we <= '0;
        rs1_s <= 7'b0;
        rs2_s <= 7'b1;
        repeat (1) @(posedge clk);
        rs1_s <= 7'b10;
        rs2_s <= 7'b11;
        repeat (1) @(posedge clk);
        rs1_s <= 7'b100;
        rs2_s <= 7'b101;

        repeat (10) @(posedge clk);


        $finish;


    end

    // `include "top_tb.svh"

endmodule