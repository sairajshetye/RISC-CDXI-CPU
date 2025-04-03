module cache_lb_tb;//; top_tb

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

    // declare dut signal

    // cpu side signals, ufp -> upward facing port
    logic   [31:0]  ufp_addr;  // input
    logic   [3:0]   ufp_rmask; // input
    logic   [3:0]   ufp_wmask; // input
    logic   [255:0]  ufp_rdata; // output
    logic   [31:0]  ufp_wdata; // input
    logic           ufp_resp;  // output

    // memory side signals, dfp -> downward facing port
    logic   [31:0]  dfp_addr;  // output
    logic           dfp_read;  // output
    logic           dfp_write; // output
    logic   [255:0] dfp_rdata; // input
    logic   [255:0] dfp_wdata; // output
    logic           dfp_resp;  // input

    // instantiate the dut
    cache_mod dut (
                .clk(clk),
                .rst(rst),

                .ufp_addr(ufp_addr),// input
                .ufp_rmask(ufp_rmask),// input
                .ufp_wmask(ufp_wmask),// input
                .ufp_rdata(ufp_rdata),
                .ufp_wdata(ufp_wdata),// input
                .ufp_resp(ufp_resp),

                .dfp_addr(dfp_addr),
                .dfp_read(dfp_read),
                .dfp_write(dfp_write),
                .dfp_rdata(dfp_rdata),// input
                .dfp_wdata(dfp_wdata),
                .dfp_resp(dfp_resp)// input
            );


    initial begin
        $fsdbDumpfile("dump.fsdb");
        if ($test$plusargs("NO_DUMP_ALL_ECE411")) begin
            $fsdbDumpvars(0, dut, "+all");
            $fsdbDumpoff();
        end else begin
            $fsdbDumpvars(0, dut, "+all");
        end

        rst = 1'b1; // toggle reset
        repeat (1) @(posedge clk);
        rst <= 1'b0;
        
        ufp_addr <= 32'h0;
        ufp_rmask <= 4'h0;
        ufp_wmask <= 4'h0;
        ufp_wdata <= 32'h0;
        dfp_resp <= '0;
        dfp_rdata <= '0;

        repeat (5) @(posedge clk);

        // clean miss read start

        ufp_addr <= 32'hafffece0;
        ufp_rmask <= 4'hF;
        ufp_wmask <= 4'h0;
        ufp_wdata <= 32'h0;
        

        repeat (10) @(posedge clk);
        dfp_rdata <= '1;
        dfp_resp <= '1;

        repeat (1) @(posedge clk);
        dfp_rdata <= '0;
        dfp_resp <= '0;

        wait(ufp_resp);
        @(posedge clk);
        ufp_addr <= '0;
        ufp_rmask <= '0;

        repeat (6) @(posedge clk);

        // clean miss read end 

        // clean miss read start

        ufp_addr <= 32'hafffece0;
        ufp_rmask <= 4'hF;
        ufp_wmask <= 4'h0;
        ufp_wdata <= 32'h0;
        

        repeat (10) @(posedge clk);
        dfp_rdata <= '1;
        dfp_resp <= '1;

        repeat (1) @(posedge clk);
        dfp_rdata <= '0;
        dfp_resp <= '0;

        wait(ufp_resp);
        @(posedge clk);
        ufp_addr <= '0;
        ufp_rmask <= '0;

        repeat (6) @(posedge clk);

        // clean miss read end 

        // clean miss read start

        ufp_addr <= 32'hafffece0;
        ufp_rmask <= 4'hF;
        ufp_wmask <= 4'h0;
        ufp_wdata <= 32'h0;
        

        repeat (10) @(posedge clk);
        dfp_rdata <= '1;
        dfp_resp <= '1;

        repeat (1) @(posedge clk);
        dfp_rdata <= '0;
        dfp_resp <= '0;

        wait(ufp_resp);
        @(posedge clk);
        ufp_addr <= '0;
        ufp_rmask <= '0;

        repeat (6) @(posedge clk);

        // clean miss read end 

        $finish;


    end

    // `include "top_tb.svh"

endmodule