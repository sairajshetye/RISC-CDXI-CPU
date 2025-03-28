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

    logic   [31:0]          new_bmem_addr; 
    logic                   wen;
    logic   [255:0]         wdata;
    logic   [255:0]         rdata;
    logic                   rvalid  ;  

    // instantiate the dut
    linebuffer test_lb (
        .clk(clk), // input
        .rst(rst), // input
        .new_bmem_addr(new_bmem_addr), // input
        .wen(wen), // input
        .wdata(wdata), // input
        .rdata(rdata),
        .rvalid(rvalid)
    );

    initial begin
        $fsdbDumpfile("dump.fsdb");
        if ($test$plusargs("NO_DUMP_ALL_ECE411")) begin
            $fsdbDumpvars(0, test_lb, "+all");
            $fsdbDumpoff();
        end else begin
            $fsdbDumpvars(0, test_lb, "+all");
        end

        rst = 1'b1;
        repeat (2) @(posedge clk);
        rst <= 1'b0;

        repeat (1) @(posedge clk);

        new_bmem_addr = 32'hAAAAAFFF;
        wen = '1;
        wdata = 256'hDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEF;

        @(posedge clk)

        new_bmem_addr = '0;
        wen = '0;
        wdata = '0;

        repeat (3) @(posedge clk);
        
        new_bmem_addr = 32'hBBBBBFFF;
        wen = '0;
        wdata = '0;

        @(posedge clk)

        new_bmem_addr = '0;
        wen = '0;
        wdata = '0;

        repeat (3) @(posedge clk);

        $finish;

    end

    // `include "top_tb.svh"

endmodule
