module if_stage
import rv32i_types::*;
(
    input   logic           clk,
    input   logic           rst,
    input   logic           iq_stall,
    input   logic           flush,
    input   logic   [63:0]  order_br,
    input   logic           bp_flush,       //new
    input   logic           rob_valid_rdata,//new
    input   logic           rem_result,//new
    output  logic           enq,
    // output  logic           deq,

    output  logic   [31:0]  imem_addr,
    output  logic   [3:0]   imem_rmask,
    input   logic   [31:0]  imem_rdata,
    input   logic           imem_resp,

    input   logic   [31:0]  pc,
    input   logic   [31:0]  pc_next,

    output if_id_stage_reg_t if_id,
output logic done
);

    logic [63:0] order_reg;
    logic d;
    //done;


    //new
    always_ff @(posedge clk) begin
        
        if (rst) begin
            order_reg <= '0;
            done <= '0;
        end 
        else if (bp_flush && !flush && !rem_result && !iq_stall) begin //new
            order_reg <= order_reg; //order_br + 1; //new
        end
        else if (bp_flush && !flush && rem_result && !iq_stall) begin //new
            order_reg <= order_reg - 1; //new
        end

        // else if (flush) begin//new
        //     order_reg <= order_br ;//+ 1'b1;
        // end 
        else if (flush && rob_valid_rdata && imem_resp && !iq_stall) begin//new
            order_reg <= order_br + 1;
        end 
        else if (flush && imem_resp && !iq_stall) begin
            order_reg <= order_br;

        end
        else if (flush) begin//new
            order_reg <= order_br + 1;
        end 
        // else if (flush && bp_flush) begin
        //     order_reg <= order_br + 1;
        // end
        else if (imem_resp && !iq_stall) begin
            order_reg <= order_reg + 1;
            
        end 
        
        
        
    end

    always_comb begin

            if_id.inst = '0;
            if_id.pc = pc;
            if_id.pc_next = pc_next;
            if_id.order = order_reg;
            if_id.valid = '0;
            if_id.fetch_stall = '1;
            if_id.useless = '0;
            if_id.branch_pred = not_taken;    //new
            if_id.branch_t_state = strongly_not_taken; //new

            d = '0;

            imem_addr = pc_next;

            //if (!done && !iq_stall) begin
                imem_rmask = '1;
            //end else begin
            //    imem_rmask = '0;
            //end

            enq = '0;

            if_id.rfvi_monitor_vals = '0;

            if_id.rfvi_monitor_vals.monitor_order = order_reg;
            if_id.rfvi_monitor_vals.monitor_pc_rdata = pc;
            if_id.rfvi_monitor_vals.monitor_pc_wdata = pc_next;

            // if (dq_stall || iq_stall) begin
            //     deq = '0;
            //     if_id.deq = '0;
            // end
            // else begin
            //     deq = '1;
            //     if_id.deq = '1;
            // end

            if (imem_resp && !bp_flush && !flush) begin
                if_id.rfvi_monitor_vals.monitor_inst = imem_rdata;
                // if (imem_rdata == 'hf0002013) begin
                //     d = '1;
                // end
                if_id.rfvi_monitor_vals.monitor_valid = '1;

                if_id.inst = imem_rdata;
                if_id.fetch_stall = '0;
                if_id.valid = '1;

                if (!iq_stall) begin   //new
                     enq = '1;
                end

                // if (dq_stall) begin
                //     deq = '0;
                //     if_id.deq = '0;
                // end
                // else begin
                //     deq = '1;
                //     if_id.deq = '1;
                // end
            end
    end


endmodule : if_stage