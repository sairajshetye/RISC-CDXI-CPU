//-----------------------------------------------------------------------------
// Title                 : random_tb
// Project               : ECE 411 mp_verif
//-----------------------------------------------------------------------------
// File                  : random_tb.sv
// Author                : ECE 411 Course Staff
//-----------------------------------------------------------------------------
// IMPORTANT: If you don't change the random seed, every time you do a `make run`
// you will run the /same/ random test. SystemVerilog calls this "random stability",
// and it's to ensure you can reproduce errors as you try to fix the DUT. Make sure
// to change the random seed or run more instructions if you want more extensive
// coverage.
//------------------------------------------------------------------------------
module random_tb #( // random_tb
    parameter CHANNELS = 2,
    parameter MAGIC = 1
)(
    mem_itf_banked.mem itf
);
    import rv32i_types::*;

    initial itf.rvalid = 1'b0;

    `include "randinst.svh"

    RandInst gen1 = new();
    RandInst gen2 = new();
    RandInst gen3 = new();
    RandInst gen4 = new();
    RandInst gen5 = new();
    RandInst gen6 = new();
    RandInst gen7 = new();
    RandInst gen8 = new();

    // Do a bunch of LUIs to get useful register state.
    task init_register_state();
        itf.ready <= 1'b1;
        for (int i = 0; i < 64; ++i) begin
            @(posedge itf.clk iff itf.read);
            if (i % 2 == 0) begin
                gen1.randomize() with {
                    instr.j_type.opcode == op_b_lui;
                    instr.j_type.rd == i[5:1];
                };
                gen2.randomize() with {
                    instr.j_type.opcode == op_b_lui;
                    instr.j_type.rd == i[5:1];
                };
                gen3.randomize() with {
                    instr.j_type.opcode == op_b_lui;
                    instr.j_type.rd == i[5:1];
                };
                gen4.randomize() with {
                    instr.j_type.opcode == op_b_lui;
                    instr.j_type.rd == i[5:1];
                };
                gen5.randomize() with {
                    instr.j_type.opcode == op_b_lui;
                    instr.j_type.rd == i[5:1];
                };
                gen6.randomize() with {
                    instr.j_type.opcode == op_b_lui;
                    instr.j_type.rd == i[5:1];
                };
                gen7.randomize() with {
                    instr.j_type.opcode == op_b_lui;
                    instr.j_type.rd == i[5:1];
                };
                gen8.randomize() with {
                    instr.j_type.opcode == op_b_lui;
                    instr.j_type.rd == i[5:1];
                };
            end else begin
                gen1.randomize() with {
                    instr.i_type.opcode == op_b_imm;
                    instr.i_type.rs1 == i[5:1];
                    instr.i_type.funct3 == arith_f3_add;
                    instr.i_type.rd == i[5:1];
                };
                gen2.randomize() with {
                    instr.i_type.opcode == op_b_imm;
                    instr.i_type.rs1 == i[5:1];
                    instr.i_type.funct3 == arith_f3_add;
                    instr.i_type.rd == i[5:1];
                };
                gen3.randomize() with {
                    instr.i_type.opcode == op_b_imm;
                    instr.i_type.rs1 == i[5:1];
                    instr.i_type.funct3 == arith_f3_add;
                    instr.i_type.rd == i[5:1];
                };
                gen4.randomize() with {
                    instr.i_type.opcode == op_b_imm;
                    instr.i_type.rs1 == i[5:1];
                    instr.i_type.funct3 == arith_f3_add;
                    instr.i_type.rd == i[5:1];
                };
                gen5.randomize() with {
                    instr.i_type.opcode == op_b_imm;
                    instr.i_type.rs1 == i[5:1];
                    instr.i_type.funct3 == arith_f3_add;
                    instr.i_type.rd == i[5:1];
                };
                gen6.randomize() with {
                    instr.i_type.opcode == op_b_imm;
                    instr.i_type.rs1 == i[5:1];
                    instr.i_type.funct3 == arith_f3_add;
                    instr.i_type.rd == i[5:1];
                };
                gen7.randomize() with {
                    instr.i_type.opcode == op_b_imm;
                    instr.i_type.rs1 == i[5:1];
                    instr.i_type.funct3 == arith_f3_add;
                    instr.i_type.rd == i[5:1];
                };
                gen8.randomize() with {
                    instr.i_type.opcode == op_b_imm;
                    instr.i_type.rs1 == i[5:1];
                    instr.i_type.funct3 == arith_f3_add;
                    instr.i_type.rd == i[5:1];
                };
            end

            // Your code here: package these memory interactions into a task.
            itf.rvalid <= 1'b1;
            itf.raddr <= itf.addr;

            itf.rdata <= {gen2.instr.word, gen1.instr.word};

            @(posedge itf.clk) 
            itf.rdata <= {gen4.instr.word, gen3.instr.word};

            @(posedge itf.clk) 
            itf.rdata <= {gen6.instr.word, gen5.instr.word};

            @(posedge itf.clk) 
            itf.rdata <= {gen8.instr.word, gen7.instr.word};

            @(posedge itf.clk) begin
                itf.rvalid <= 1'b0;
                itf.raddr <= '0;
                itf.rdata <= 'x;
            end


        end
    endtask : init_register_state

    // Note that this memory model is not consistent! It ignores
    // writes and always reads out a random, valid instruction.
    task run_random_instrs();
        itf.ready <= 1'b1;
        repeat (5000) begin
            @(posedge itf.clk iff (itf.read || itf.write));

            // 32'h00000013; nop = addi x0, x0, 0

            // Always read out a valid instruction.
            if (itf.read) begin
                gen1.randomize();
                gen2.randomize();
                // gen3.randomize();
                // gen4.randomize();
                // gen5.randomize();
                // gen6.randomize();
                // gen7.randomize();
                // gen8.randomize();
                itf.rdata <= {gen2.instr.word, gen1.instr.word};
            end

            // If it's a write, do nothing and just respond.
            itf.rvalid <= 1'b1;
            itf.raddr <= itf.addr;
            @(posedge itf.clk) begin
                itf.rvalid <= 1'b0;
                itf.raddr <= '0;
            end
        end
    endtask : run_random_instrs

    always @(posedge itf.clk iff !itf.rst) begin
        if ($isunknown(itf.read) || $isunknown(itf.write)) begin
            $error("Memory Error: mask containes 1'bx");
            itf.error <= 1'b1;
        end
        if ((itf.read) && (itf.write)) begin
            $error("Memory Error: Simultaneous memory read and write");
            itf.error <= 1'b1;
        end
        if ((itf.read) || (itf.write)) begin
            if ($isunknown(itf.addr)) begin
                $error("Memory Error: Address contained 'x");
                itf.error <= 1'b1;
            end
            // Only check for 16-bit alignment since instructions are
            // allowed to be at 16-bit boundaries due to JALR.
            if (itf.addr[0] != 1'b0) begin
                $error("Memory Error: Address is not 16-bit aligned");
                itf.error <= 1'b1;
            end
        end
    end

    // A single initial block ensures random stability.
    initial begin

        // Wait for reset.
        @(posedge itf.clk iff itf.rst == 1'b0);

        // Get some useful state into the processor by loading in a bunch of state.
        init_register_state();

        // Run!
        run_random_instrs();

        // Finish up
        $display("Random testbench finished!");
        $finish;
    end

endmodule : random_tb
