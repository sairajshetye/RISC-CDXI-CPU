module inst_q_tb // full_empty_tb

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

    logic                   enq;
    logic                   deq;
    if_id_stage_reg_t       inst_in;
    if_id_stage_reg_t       inst_out;
    logic                   fifo_fetch_stall;

    // instantiate the dut
    inst_q dut (
        .clk(clk),
        .rst(rst),
        .enq(enq), // input
        .deq(deq), // input
        .inst_in(inst_in), // input
        .inst_out(inst_out),
        .iq_stall(fifo_fetch_stall)
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

        enq <= '1;
        deq <= '0;
        

        inst_in.inst        <= 32'hA3F5D7E2;
        inst_in.pc          <= 32'h00000000;
        inst_in.pc_next     <= 32'h00000001;
        inst_in.order       <= 64'h0000000000000001;
        inst_in.valid       <= 1'b1;
        inst_in.fetch_stall <= 1'b0;
        inst_in.useless     <= 2'b00;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;
        
        inst_in.inst        <= 32'h4B2E9F87;
        inst_in.pc          <= 32'h00000001;
        inst_in.pc_next     <= 32'h00000002;
        inst_in.order       <= 64'h0000000000000002;
        inst_in.valid       <= 1'b1;
        inst_in.fetch_stall <= 1'b0;
        inst_in.useless     <= 2'b00;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;
        
        inst_in.inst        <= 32'hC7D82A5B;
        inst_in.pc          <= 32'h00000002;
        inst_in.pc_next     <= 32'h00000003;
        inst_in.order       <= 64'h0000000000000003;
        inst_in.valid       <= 1'b0;
        inst_in.fetch_stall <= 1'b1;
        inst_in.useless     <= 2'b00;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;
        
        inst_in.inst        <= 32'h9E3A47BC;
        inst_in.pc          <= 32'h00000003;
        inst_in.pc_next     <= 32'h00000004;
        inst_in.order       <= 64'h0000000000000004;
        inst_in.valid       <= 1'b1;
        inst_in.fetch_stall <= 1'b0;
        inst_in.useless     <= 2'b00;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;

        inst_in.inst        <= 32'h5A91EC3D;
        inst_in.pc          <= 32'h00000004;
        inst_in.pc_next     <= 32'h00000005;
        inst_in.order       <= 64'h0000000000000005;
        inst_in.valid       <= 1'b0;
        inst_in.fetch_stall <= 1'b1;
        inst_in.useless     <= 2'b00;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;
        
        inst_in.inst        <= 32'hF214AB76;
        inst_in.pc          <= 32'h00000005;
        inst_in.pc_next     <= 32'h00000006;
        inst_in.order       <= 64'h0000000000000006;
        inst_in.valid       <= 1'b1;
        inst_in.fetch_stall <= 1'b0;
        inst_in.useless     <= 2'b00;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;
        
        inst_in.inst        <= 32'h3CDE89F2;
        inst_in.pc          <= 32'h00000006;
        inst_in.pc_next     <= 32'h00000007;
        inst_in.order       <= 64'h0000000000000007;
        inst_in.valid       <= 1'b1;
        inst_in.fetch_stall <= 1'b0;
        inst_in.useless     <= 2'b00;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;
        
        inst_in.inst        <= 32'h8AF713BD;
        inst_in.pc          <= 32'h00000007;
        inst_in.pc_next     <= 32'h00000008;
        inst_in.order       <= 64'h0000000000000008;
        inst_in.valid       <= 1'b0;
        inst_in.fetch_stall <= 1'b1;
        inst_in.useless     <= 2'b00;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;
        inst_in.inst        <= 32'hD9014EAC;
        inst_in.pc          <= 32'h00000008;
        inst_in.pc_next     <= 32'h00000009;
        inst_in.order       <= 64'h0000000000000009;
        inst_in.valid       <= 1'b1;
        inst_in.fetch_stall <= 1'b0;
        inst_in.useless     <= 2'b00;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        enq <= '1;
        deq <= '0;
        
        inst_in.inst        <= 32'hE65BC923;
        inst_in.pc          <= 32'h00000009;
        inst_in.pc_next     <= 32'h0000000A;
        inst_in.order       <= 64'h000000000000000A;
        inst_in.valid       <= 1'b1;
        inst_in.fetch_stall <= 1'b0;
        inst_in.useless     <= 2'b00;

        @(posedge clk);
        enq <= '0;

        repeat (3) @(posedge clk);

        // start deqing

        enq <= '0;
        deq <= '1;
        inst_in <= 'x; 

        @(posedge clk);
        deq <= '0;

        repeat (3) @(posedge clk);

        enq <= '0;
        deq <= '1;
        inst_in <= 'x; 

        @(posedge clk);
        deq <= '0;

        repeat (3) @(posedge clk);

        enq <= '0;
        deq <= '1;
        inst_in <= 'x; 

        @(posedge clk);
        deq <= '0;

        repeat (3) @(posedge clk);

        enq <= '0;
        deq <= '1;
        inst_in <= 'x; 

        @(posedge clk);
        deq <= '0;

        repeat (3) @(posedge clk);

        enq <= '0;
        deq <= '1;
        inst_in <= 'x; 

        @(posedge clk);
        deq <= '0;

        repeat (3) @(posedge clk);

        enq <= '0;
        deq <= '1;
        inst_in <= 'x; 

        @(posedge clk);
        deq <= '0;

        repeat (3) @(posedge clk);

        enq <= '0;
        deq <= '1;
        inst_in <= 'x; 

        @(posedge clk);
        deq <= '0;

        repeat (3) @(posedge clk);

        enq <= '0;
        deq <= '1;
        inst_in <= 'x; 

        @(posedge clk);
        deq <= '0;

        repeat (3) @(posedge clk);

        enq <= '0;
        deq <= '1;
        inst_in <= 'x; 

        @(posedge clk);
        deq <= '0;

        repeat (3) @(posedge clk);

        enq <= '0;
        deq <= '1;
        inst_in <= 'x; 

        @(posedge clk);
        deq <= '0;

        repeat (3) @(posedge clk);

        $finish;


    end

    // `include "top_tb.svh"

endmodule
