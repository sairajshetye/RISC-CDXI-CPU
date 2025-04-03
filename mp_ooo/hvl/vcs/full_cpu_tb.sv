module top_tb;//; top_tb

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

    logic   [31:0]      bmem_addr; // output
    logic               bmem_read; // output  
    logic               bmem_write; // output  
    logic   [63:0]      bmem_wdata; // output
    logic               bmem_ready; // input   

    logic   [31:0]      bmem_raddr; // input
    logic   [63:0]      bmem_rdata; // input   
    logic               bmem_rvalid; // input   

    // instantiate the dut
    cpu dut (
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

        rst = 1'b1;
        repeat (2) @(posedge clk);
        rst <= 1'b0;

        // cache sends a read request
        bmem_raddr <= '0;
        bmem_rdata <= '0;
        bmem_rvalid <= '0;
        bmem_ready <= '1;

        repeat (2) @(posedge clk);
        bmem_rvalid <= '1;
        bmem_raddr <= 32'hAAAAA000;
        bmem_rdata <= 64'hFFFFFFFFFFFFFFFF;

        repeat (1) @(posedge clk);
        bmem_rdata <= 64'hFFFFFFFFFFFFFFF0;

        repeat (1) @(posedge clk);
        bmem_rdata <= 64'hFFFFFFFFFFFFFF00;

        repeat (1) @(posedge clk);
        bmem_rdata <= 64'hFFFFFFFFFFFFF000;
        
        repeat (1) @(posedge clk);
        bmem_rvalid <= '0;

        repeat (30) @(posedge clk);

        $finish;


    end

    // `include "top_tb.svh"

endmodule