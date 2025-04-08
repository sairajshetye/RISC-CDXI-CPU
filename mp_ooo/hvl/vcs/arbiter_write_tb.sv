module arbiter_write_tb;//top_tb;

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

    logic   [31:0]      bmem_raddr; // input
    logic   [63:0]      bmem_rdata; // input
    logic               bmem_rvalid; // input
    logic               cache_read; // input

    logic   [31:0]      a_raddr; // output
    logic   [255:0]     a_rdata; // output
    logic               a_resp; // output
    logic               bmem_read; // output

    logic   [31:0]      cache_addr; // input
    logic   [255:0]     cache_wdata; // input
    logic               cache_write; // input

    logic   [31:0]      bmem_addr; // output
    logic   [63:0]      bmem_wdata; // output
    logic               bmem_write; // output

    logic               bmem_ready; // input

    // instantiate the dut
    arbiter dut (
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
        cache_read <= '0;
        cache_addr <= 32'hecebece0;
        cache_wdata <= 256'hDEADBEEFDEADB000DEADBEEFDEADBE00DEADBEEFDEADBEE0DEADBEEFDEADBEEF;
        cache_write <= '1;
        bmem_raddr <= 'x;
        bmem_rdata <= 'x;
        bmem_rvalid <= '0;
        bmem_ready <= '0;
        // DRAM sends a read response
        repeat (10) @(posedge clk);
        bmem_ready <= '1; // not really being used right now - it is
        
        // repeat (1) @(posedge clk);
        // bmem_ready <= '0;
        repeat (1) @(posedge clk); // can also check if it took longer than 1 clock cycle to change
        bmem_ready <= '0;

        repeat (1) @(posedge clk); // can also check if it took longer than 1 clock cycle to change
        bmem_ready <= '1;
        //bmem_rdata <= 64'hFFFFFFFFFFFFFFF0;

        // repeat (1) @(posedge clk);
        // bmem_ready <= '0;
        repeat (1) @(posedge clk); // can also check if it took longer than 1 clock cycle to change
        bmem_ready <= '1;
        //bmem_rdata <= 64'hFFFFFFFFFFFFFF00;

        // repeat (1) @(posedge clk);
        // bmem_ready <= '0;
        repeat (1) @(posedge clk); // can also check if it took longer than 1 clock cycle to change
        bmem_ready <= '1;
        //bmem_rdata <= 64'hFFFFFFFFFFFFF000;
        
        repeat (1) @(posedge clk);
        cache_write <= '0;

        repeat (20) @(posedge clk);

        repeat (3) @(posedge clk);

        $finish;


    end

    // `include "top_tb.svh"

endmodule