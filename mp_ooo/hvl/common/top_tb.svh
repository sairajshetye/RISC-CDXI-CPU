    longint timeout;
    initial begin
        $value$plusargs("TIMEOUT_ECE411=%d", timeout);
    end

    mem_itf_banked mem_itf(.*);
    dram_w_burst_frfcfs_controller mem(.itf(mem_itf));

    mon_itf #(.CHANNELS(8)) mon_itf(.*);
    monitor #(.CHANNELS(8)) monitor(.itf(mon_itf));

    cpu dut(
        .clk            (clk),
        .rst            (rst),

        .bmem_addr  (mem_itf.addr  ),
        .bmem_read  (mem_itf.read  ),
        .bmem_write (mem_itf.write ),
        .bmem_wdata (mem_itf.wdata ),
        .bmem_ready (mem_itf.ready ),
        .bmem_raddr (mem_itf.raddr ),
        .bmem_rdata (mem_itf.rdata ),
        .bmem_rvalid(mem_itf.rvalid)
    );

    `include "rvfi_reference.svh"

    logic test;
    logic [127:0] test_dupe; 
    logic [9:0] counter;
    real flush_counter, br_counter;
    real correct;
    real accuracy;
    integer pred_count, btb_count, write, taken_correct, not_taken_correct, taken, not_taken;
    //logic [6:0]   dupe_add;

    always @(posedge clk) begin
        if (mon_itf.halt) begin
            $display("%d branches, %d flushes/mispredicts, %d predicted correctly, %f%% accuracy", br_counter, flush_counter, correct, accuracy);
            $display("%d taken, %d taken correct, %d not taken, %d not taken correct", taken, taken_correct, not_taken, not_taken_correct);
            $display("%d non_static predictions, %d btb, %d writes", pred_count, btb_count, write);
            $finish;
        end
        if (timeout == 0) begin
            $error("TB Error: Timed out");
            $fatal;
        end
        if (mem_itf.error != 0 || mon_itf.error != 0) begin
            $fatal;
        end


        if (rst) begin
            flush_counter <= '0;
            br_counter <= '0;
            correct <= '0;
            accuracy <= '0;
            pred_count <= '0;
            btb_count <= '0;
            write <= '0;
            taken_correct <= '0;
            not_taken_correct <= '0;
            taken <= '0;
            not_taken <= '0;
            // take <= taken;
        end else begin
            if (dut.rob_out.is_br) begin
                br_counter <= br_counter + 1;
            end
            if (dut.flush) begin
                flush_counter <= flush_counter + 1;
            end
            if (dut.branch_predict.pht_read_v) begin
                pred_count <= pred_count + 1; 
            end
            if (dut.branch_predict.btb_read_v) begin
                btb_count <= btb_count + 1; 
            end
            if (dut.branch_predict.write) begin
                write <= write + 1; 
            end
            if (dut.rob_out.br_result == 1'b1 && dut.rob_out.is_br) begin
                taken <= taken + 1;
            end
            if (dut.rob_out.br_result == 1'b0 && dut.rob_out.is_br) begin
                not_taken <= not_taken + 1;
            end
            if (dut.rob_out.br_result == 1'b1 && dut.rob_out.is_br && !dut.flush) begin
                taken_correct <= taken_correct + 1;
            end
            if (dut.rob_out.br_result == 1'b0 && dut.rob_out.is_br && !dut.flush) begin
                not_taken_correct <= not_taken_correct + 1;
            end

            correct <= br_counter - flush_counter;
            accuracy <= (100/br_counter) * (br_counter - flush_counter);
        end

        // if (dut.free_list.p_addr_in == 7'd75) begin
        //     test <= '1;
        //     $display("YOOO time=%0t fl_enq=0x%0h fl_in=0x%0h head=0x%0h tail=0x%0h", $time, dut.free_list.enq, dut.free_list.p_addr_in, dut.free_list.head[6:0], dut.free_list.tail[6:0]);
        // end
        // if (dut.free_list.p_addr_out == 7'd75) begin
        //     $display("time=%0t fl_deq=0x%0h fl_out=0x%0h head=0x%0h tail=0x%0h", $time, dut.free_list.deq, dut.free_list.p_addr_out, dut.free_list.head[6:0], dut.free_list.tail[6:0]);
        // end

        // if ($time==1646105000 ) begin
        //     if (dut.free_list.p_addr_in == 7'd75) begin
        //         test <= '1;
        //         $display("YOOO time=%0t fl_enq=0x%0h fl_in=0x%0h head=0x%0h tail=0x%0h", $time, dut.free_list.enq, dut.free_list.p_addr_in, dut.free_list.head[6:0], dut.free_list.tail[6:0]);
        //     end
        //     $display("CHECK flush=0x%0h inst=0x%0h p_addr_rob=0x%0h p_addr_rat=0x%0h rd_s=0x%0h", dut.flush, dut.monitor_inst, dut.robert.p_addr_ret, dut.rat_arf_1.fl_data_in, dut.rat_arf_1.rd_s); //dut.rat_arf_1.data[dut.rat_arf_1.rd_s].p_addr_ret
        // end
        // if (rst) begin
        //     test <= '0;
        //     //counter <= '0;
        // end
        // test_dupe <= '0;
        //dupe_add <= '0;
        // for (integer i = 0; i < 128; i++) begin
        //     if (dut.free_list.internal_array[i] == 7'd75 && dut.free_list.deq && dut.free_list.p_addr_out == 7'd75) begin
        //         //$display("YOOO time=%0t fl_value=0x%0h", $time, dut.free_list.enq, dut.free_list.p_addr_in, dut.free_list.head[6:0], dut.free_list.tail[6:0]);
        //         test_dupe[i] <= 1'b1;
        //         //dupe_add <= dupe_add + 1'b1;
        //         if ($time > 1646000000) begin
        //             $display("YOOO time=%0t value=0x%0h index=0x%0h head=0x%0h", $time, dut.free_list.internal_array[i], i, dut.free_list.head[6:0]);
        //         end
        //     end
        // end
        // if (rst) begin
        //     counter <= '0;
        // end
        // else begin
        //     counter <= counter + 1'b1;
        // end
        // for (integer i = 0; i < 32; i++) begin
        //     for (integer j = 0; j < 32; j++) begin
        //         if (dut.monitor_order > 64'd119334) begin
        //             if (dut.rat_arf_1.data[i].p_addr == dut.rat_arf_1.data[j].p_addr && i != j && dut.rat_arf_1.data[j].p_addr != '0 && dut.rat_arf_1.data[j].renamed && dut.rat_arf_1.data[i].renamed) begin
        //                 //$display("YOOO time=%0t fl_value=0x%0h", $time, dut.free_list.enq, dut.free_list.p_addr_in, dut.free_list.head[6:0], dut.free_list.tail[6:0]);
        //                 test <= '1;
        //                 //dupe_add <= dupe_add + 1'b1;
        //                 //if (test != '1) begin
        //                     //$display("YOOO time=%0t value=0x%0h index1=0x%0h index2=0x%0h head=0x%0h", $time, dut.rat_arf_1.data[i].p_addr, i, j, dut.free_list.head[6:0]);
        //                 //end
        //                 //else if (test == '1) begin
        //                     //if (counter == '0) begin
        //                         $display("YOOO time=%0t value=0x%0h index1=0x%0h index2=0x%0h head=0x%0h", $time, dut.rat_arf_1.data[i].p_addr, i, j, dut.free_list.head[6:0]);
        //                     //end
        //                 //end
        //             end
        //         end
        //     end
        // end

        // if (dut.monitor_order == 119334) begin
        //     $display("END: time=%0t areg_value=0x%0h", $time, dut.rat_arf_1.data[13].value);
        // end

        // if (|test_dupe) begin
        //     $display("YOOO time=%0t add=0x%0h", $time, dupe_add);
        // end

        //$monitor ("[$monitor] test=fl_in=0x%0h", test); //fl_enq=0x%0h fl_in=0x%0h  dut.free_list.enq, dut.free_list.p_addr_in
        timeout <= timeout - 1;
    end
