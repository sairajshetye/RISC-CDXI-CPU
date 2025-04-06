module top_tb

;

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
    logic one, zero;
    logic [31:0] op1;
    logic [31:0] op2;
    logic [31:0] inst;

    logic [31:0] out_tb;
    // instantiate the dut
    multiply_divide_unit dut (
        
        .clk(clk), 
        .rst(rst), //active low
        .inst(inst),
        .op1(op1),
        .op2(op2), 
        .out(out_tb) 

    );
/*
things to test, 
MUL - 
MULH - sxs
MULHSU - sxu ?
MULHU - uxu
DIV - 
DIVU - 
REM - 
REMU - 

*/
    initial begin
        $fsdbDumpfile("dump.fsdb");
        if ($test$plusargs("NO_DUMP_ALL_ECE411")) begin
            $fsdbDumpvars(0, dut, "+all");
            $fsdbDumpoff();
        end else begin
            $fsdbDumpvars(0, dut, "+all");
        end

        rst = 1'b0;     //active low reset
        repeat (2) @(posedge clk);
        rst <= 1'b1;
        
        inst <= 32'b0;

        op1 <= 'd1;
        op2 <= 'd2;
        

        @(posedge clk);
        op1 <= 'd4;

        repeat (3) @(posedge clk);
        inst <= 32'h3800;   //funct3 = 111

        repeat (3) @(posedge clk);
        /*enq <= '1;
        deq <= '1;
        inst_in <= 32'hBBBBBBBB;

        @(posedge clk);
        enq <= '0;
        deq <= '0;

        repeat (3) @(posedge clk);
        */
        $finish;


    end

    // `include "top_tb.svh"

endmodule
