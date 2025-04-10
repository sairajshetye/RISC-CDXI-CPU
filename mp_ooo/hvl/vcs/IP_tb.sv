module top_tb
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
    logic one, zero;
    logic [31:0] op1;  
    logic [31:0] op2;
    //logic [31:0] inst;

    logic [31:0] out_tb, test_out, test_div, test_rem;
    logic [63:0] full_mul;
    logic busy;

    dp_is_stage_reg_t prf_reg;

    // instantiate the dut
    multiply_divide_unit dut (
        
        .clk(clk), 
        .rst(rst), //active low
        .rs_out(prf_reg),
        .rs1_v(op1),
        .rs2_v(op2), 
        .funct_unit_busy(busy),
        .out(out_tb) 

    );
/*
things to test, 
MUL - neg & pos mul done
MULH - sxs, done
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
        repeat (1) @(posedge clk);
        op1 <= 'd1;
        op2 <= 'd2;
        prf_reg.funct3 <= 3'b0;
        rst <= 1'b1;
        
        @(posedge clk);
        //repeat (2) @(posedge clk);
        wait (!busy) begin
        if (out_tb != 'd1) begin        //positive test
            $error("wrong, 2 != %d", out_tb);
            $fatal;
        end
        end

        @(posedge clk);
        
        wait (!busy)
        op1 <= -'d4;
        
         @(posedge clk);
        //repeat (2) @(posedge clk);
        wait (!busy)begin
            @(posedge clk);
        if (out_tb != -'d8) begin   //negative test
            $error("wrong, -8 != %d", out_tb);
            $fatal;
        end
        end

        @(posedge clk);
         wait (!busy)
        op2 <= -'d4;

         @(posedge clk);
        //repeat (2) @(posedge clk);
        wait (!busy) begin
            @(posedge clk);
        if (out_tb != 'd16) begin   //neg*neg test
            $error("wrong, 16 != %d", out_tb);
            //$fatal;
        end
        end


        @(posedge clk);
        //MUL High sxs tests
         wait (!busy) begin
        op1 <= -'d4;
        op2 <= -'d8;
        prf_reg.funct3 <= 3'b001;   
         end
        @(posedge clk);
        full_mul = 64'(signed'(op1*op2));
        wait (!busy) begin
            @(posedge clk);
        if (out_tb != full_mul[63:32]) begin   //sxs test
            $error("wrong, %d != %d", full_mul[63:32], out_tb);
            $fatal;
        end
        end

        
        //MUL tests
        //prf_reg.funct3 <= 3'b0;
        /*
        repeat (2) @(posedge clk);
        if (out_tb != 'd1) begin        //positive test
            $error("wrong, 2 != %d", out_tb);
            $fatal;
        end

        repeat (1) @(posedge clk);
        op1 <= -'d4;
        repeat (2) @(posedge clk);
        if (out_tb != -'d8) begin   //negative test
            $error("wrong, 8 != %d", out_tb);
            $fatal;
        end

        repeat (1) @(posedge clk);
        op2 <= -'d4;
        repeat (2) @(posedge clk);
        if (out_tb != 'd16) begin   //neg*neg test
            $error("wrong, 16 != %d", out_tb);
            $fatal;
        end


        repeat (1) @(posedge clk);
        //MUL High sxs tests
        op1 <= -'d4;
        op2 <= -'d8;
        prf_reg.funct3 <= 3'b001;   
        repeat (2) @(posedge clk);
        full_mul = 64'(signed'(op1*op2));
        if (out_tb != full_mul[63:32]) begin   //sxs test
            $error("wrong, %d != %d", full_mul[63:32], out_tb);
            $fatal;
        end

        repeat (1) @(posedge clk);
        op1 <= -'d100000;
        repeat (2) @(posedge clk);
        full_mul = 64'(signed'(op1*op2));
        if (out_tb != full_mul[63:32]) begin   //1 op positive test
            $error("wrong, %d != %d", full_mul[63:32], out_tb);
            $fatal;
        end


        repeat (1) @(posedge clk);
        //MUL high sxu test
        op1 <= -'d4;
        op2 <= 'd8;
        prf_reg.funct3 <= 3'b010;   
        repeat (2) @(posedge clk);
        full_mul = 64'(signed'((signed'(op1))*(unsigned'(op2))));
        if (out_tb != full_mul[63:32]) begin   //1 op positive test
            $error("wrong, %d != %d", full_mul[63:32], out_tb);
            $fatal;
        end


        repeat (1) @(posedge clk);
        //MUL high uxu test
        op1 <= 'd4;
        op2 <= 'd8;
        prf_reg.funct3 <= 3'b011;
        repeat (2) @(posedge clk);
        full_mul = 64'(unsigned'(op1)*unsigned'(op2));
        if (out_tb != full_mul[63:32]) begin   //2 op positive test
            $error("wrong, %d != %d", full_mul[63:32], out_tb);
            $fatal;
        end


        repeat (1) @(posedge clk);
        //DIV (s) tests
        op1 <= -'d4;
        op2 <= -'d8;
        prf_reg.funct3 <= 3'b100;
        repeat (2) @(posedge clk);
        test_div <= signed'(op1)/signed'(op2);
        if (out_tb != test_div) begin   //s/s test
            $error("wrong, %d != %d", test_div, out_tb);
            $fatal;
        end
        op2 <= 'd0;
        repeat (2) @(posedge clk);
        //test_div <= signed'(op1)/signed'(op2);
        if (signed'(out_tb) != signed'('hFFFFFFFF)) begin   //s/0 test
            $error("wrong, -1 != %d", signed'(out_tb));
            $fatal;
        end


        repeat (1) @(posedge clk);
        //DIV (u) tests
        op1 <= 'd4;
        op2 <= 'd8;
        prf_reg.funct3 <= 3'b101;
        repeat (2) @(posedge clk);
        test_div <= op1/op2;
        if (out_tb != test_div) begin   //u/u test
            $error("wrong, %d != %d", test_div, out_tb);
            $fatal;
        end
        op2 <= 'd0;
        repeat (2) @(posedge clk);
        if (out_tb != 'hFFFFFFFF) begin   //u/0 test
            $error("wrong, %d != %d", test_div, out_tb);
            $fatal;
        end

        repeat (1) @(posedge clk);
        //REM (s) tests
        op1 <= -'d4;
        op2 <= -'d8;
        prf_reg.funct3 <= 3'b110;
        repeat (2) @(posedge clk);
        if (out_tb != -4) begin   //s%s test
            $error("wrong, -4 != %d", test_div, out_tb);
            $fatal;
        end
        op2 <= 'd0;
        repeat (2) @(posedge clk);
        if (out_tb != op1) begin   //s%0 test
            $error("wrong, %d != %d", op1, out_tb);
            $fatal;
        end

        repeat (1) @(posedge clk);
        //DIV (u) tests
        op1 <= 'd4;
        op2 <= 'd8;
        prf_reg.funct3 <= 3'b111;
        repeat (2) @(posedge clk);
        if (out_tb != 4) begin   //u%u test
            $error("wrong, 4 != %d", test_div, out_tb);
            $fatal;
        end
        op2 <= 'd0;
        repeat (2) @(posedge clk);
        if (out_tb != op1) begin   //u%0 test
            $error("wrong, %d != %d", op1, out_tb);
            $fatal;
        end
        
        */
        $display("All Tests Passed");
        $finish;


    end

    // `include "top_tb.svh"

endmodule