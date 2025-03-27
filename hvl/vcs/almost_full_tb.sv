module top_tb;

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

    logic                   enq;
    logic                   deq;
    logic   [31:0]          inst_in;
    logic   [31:0]          inst_out;
    logic                   fifo_fetch_stall;

    // instantiate the dut
    fifo test_fifo (
        .clk(clk),
        .rst(rst),
        .enq(enq), // input
        .deq(deq), // input
        .inst_in(inst_in), // input
        .inst_out(inst_out),
        .fifo_fetch_stall(fifo_fetch_stall)
    );

    initial begin
        $fsdbDumpfile("dump.fsdb");
        if ($test$plusargs("NO_DUMP_ALL_ECE411")) begin
            $fsdbDumpvars(0, test_fifo, "+all");
            $fsdbDumpoff();
        end else begin
            $fsdbDumpvars(0, test_fifo, "+all");
        end

        rst = 1'b1;
        repeat (2) @(posedge clk);
        rst <= 1'b0;

        enq <= '1;
        deq <= '0;
        inst_in <= 32'hAAAAAAAA;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;
        inst_in <= 32'hBBBBBBBB;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;
        inst_in <= 32'hCCCCCCCC;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;
        inst_in <= 32'hDDDDDDDD;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;
        inst_in <= 32'hEEEEEEEE;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;
        inst_in <= 32'hFFFFFFFF;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;
        inst_in <= 32'h11111111;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk); // 7 things inserted so far

        enq <= '1;
        deq <= '1;
        inst_in <= 32'h22222222; // 8 things inserted

        @(posedge clk);
        enq <= '0;
        deq <= '0;

        repeat (3) @(posedge clk);

        $finish;


    end

    // `include "top_tb.svh"

endmodule
