module rat_arf
import rv32i_types::*;
(
    input   logic           clk,
    input   logic           rst,
    input   logic           flush,
    input   logic           regf_we,
    input   logic   [31:0]  rd_v,
    input   logic   [4:0]   rs1_s, rs2_s, rd_s,
    input   logic           rename_we,
    input   logic   [4:0]   rd_rename,
    input   logic   [6:0]   p_addr, // speculative (rat)
    input   logic   [6:0]   p_addr_ret, // (rrf)

    // RAT read
    input   logic   [4:0]   rat_rs1, rat_rs2,
    output  logic           rs1_renamed, rs2_renamed,
    output  logic   [6:0]   rs1_paddr, rs2_paddr,

    output  logic           fl_enq,
    output  logic   [6:0]   fl_data_in,

    //input   logic   [4:0]   rs1_s_ex, rs2_s_ex,
    //output  logic   [31:0]  rs1_v, rs2_v,
    //input   logic           load_stall,
    //input   logic           global_stall
    //output   arf_reg_t       ars1_v, ars2_v, ars1_v_comb, ars2_v_comb // outputs the full struct
    output   arf_reg_t       ars1_v_comb, ars2_v_comb
);

    // RAT + ARF + RRF
    // Has: valid, renamed, p_addr, value
    // DO WE NEED TO TRANSPARENT A READ AND A RENAME?



    arf_reg_t       data [32]; // 32 arch regs: valid, renamed, p_addr, value
    logic           transparent_1, transparent_2;

    assign transparent_1 = regf_we && (rd_s == rs1_s) && (rs1_s != 5'd0);
    assign transparent_2 = regf_we && (rd_s == rs2_s) && (rs2_s != 5'd0);

    always_ff @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < 32; i++) begin
                data[i].valid <= '1; // Always valid = 1 -> not used right now, use later?
                data[i].renamed <= '0;
                data[i].p_addr <= '0;
                data[i].p_addr_ret <= '0;
                data[i].value <= '0;
            end
            fl_enq <= '0;
            fl_data_in <= '0;
        end else if (flush) begin
            fl_data_in <= '0;
            fl_enq <= '0;
            for (integer i = 0; i < 32; i++) begin
                data[i].p_addr <= data[i].p_addr_ret;
            end
        end else begin
            fl_enq <= '0;
            fl_data_in <= '0;
            if (regf_we && (rd_s != 5'd0)) begin // write data - is this done on commit? -> should be commit 
                //data[rd_s].renamed <= '0; // when commited, can un-rename
                //data[rd_s].p_addr <= '0; // un renames
                // sent to free list
                if ((data[rd_s].p_addr_ret != p_addr_ret) && (data[rd_s].p_addr_ret != '0)) begin // if old != new
                    fl_enq <= '1;
                    fl_data_in <= data[rd_s].p_addr_ret;
                end
                else begin
                    fl_enq <= '0;
                    fl_data_in <= '0;
                end

                data[rd_s].p_addr_ret <= p_addr_ret; // allows for rolling back (later?)
                data[rd_s].value <= rd_v;
            end
            if (rename_we && (rd_rename != 5'd0)) begin // write renamed + p_addr
                data[rd_rename].renamed <= '1; // mark 1 = renamed
                data[rd_rename].p_addr <= p_addr; // assign to input p_addr
            end
        end
    end

    /* always_ff @(posedge clk) begin
        if (rst) begin
            ars1_v <= '0;
            ars2_v <= '0;
        end 
        else begin
            if (rs1_s != 5'd0) begin
                if (transparent_1) begin
                    //ars1_v <= (rs1_s != 5'd0) ? rd_v : '0;
                    ars1_v.valid <= data[rs1_s].valid;
                    ars1_v.renamed <= data[rs1_s].renamed;
                    ars1_v.p_addr <= data[rs1_s].p_addr;
                    ars1_v.p_addr_ret <= data[rs1_s].p_addr_ret;
                    ars1_v.value <= rd_v;

                end
                else begin
                    ars1_v <= data[rs1_s];
                end
            end
            else begin
                ars1_v.valid <= '1;
                ars1_v.renamed <= '0;
                ars1_v.p_addr <= '0;
                ars1_v.p_addr_ret <= '0;
                ars1_v.value <= '0;
            end
            if (rs2_s != 5'd0) begin
                if (transparent_2) begin
                    //ars2_v <= (rs2_s != 5'd0) ? rd_v : '0;
                    ars2_v.valid <= data[rs2_s].valid;
                    ars2_v.renamed <= data[rs2_s].renamed;
                    ars2_v.p_addr <= data[rs2_s].p_addr;
                    ars2_v.p_addr_ret <= data[rs2_s].p_addr_ret;
                    ars2_v.value <= rd_v;
                end
                else begin
                    ars2_v <= data[rs2_s];
                end
            end
            else begin
                ars2_v.valid <= '1;
                ars2_v.renamed <= '0;
                ars2_v.p_addr <= '0;
                ars2_v.p_addr_ret <= '0;
                ars2_v.value <= '0;
            end
        end */
        /*else if (!global_stall & !load_stall) begin
            if (transparent_1)
                rs1_v <= (rs1_s != 5'd0) ? rd_v : '0;
            else
                rs1_v <= (rs1_s != 5'd0) ? data[rs1_s] : '0;
            if (transparent_2)
                rs2_v <= (rs2_s != 5'd0) ? rd_v : '0;
            else
                rs2_v <= (rs2_s != 5'd0) ? data[rs2_s] : '0;
        end
        */
        /*
        
        else if (!global_stall & load_stall) begin // also for transparent, in case of stall due to load use
            if (regf_we && (rd_s == rs1_s_ex) && (rs1_s_ex != 5'd0))
                rs1_v <= (rs1_s_ex != 5'd0) ? rd_v : '0;
            if (regf_we && (rd_s == rs2_s_ex) && (rs2_s_ex != 5'd0))
                rs1_v <= (rs2_s_ex != 5'd0) ? rd_v : '0;
        end
        */
    //end
    always_comb begin
            if (rs1_s != 5'd0) begin
                if (transparent_1) begin
                    //ars1_v <= (rs1_s != 5'd0) ? rd_v : '0;
                    ars1_v_comb.valid = data[rs1_s].valid;
                    ars1_v_comb.renamed = data[rs1_s].renamed;
                    ars1_v_comb.p_addr = data[rs1_s].p_addr;
                    ars1_v_comb.p_addr_ret = data[rs1_s].p_addr_ret;
                    ars1_v_comb.value = rd_v;

                end
                else begin
                    ars1_v_comb = data[rs1_s];
                end
            end
            else begin
                ars1_v_comb.valid = '1;
                ars1_v_comb.renamed = '0;
                ars1_v_comb.p_addr = '0;
                ars1_v_comb.p_addr_ret = '0;
                ars1_v_comb.value = '0;
            end
            if (rs2_s != 5'd0) begin
                if (transparent_2) begin
                    //ars2_v <= (rs2_s != 5'd0) ? rd_v : '0;
                    ars2_v_comb.valid = data[rs2_s].valid;
                    ars2_v_comb.renamed = data[rs2_s].renamed;
                    ars2_v_comb.p_addr = data[rs2_s].p_addr;
                    ars2_v_comb.p_addr_ret = data[rs2_s].p_addr_ret;
                    ars2_v_comb.value = rd_v;
                end
                else begin
                    ars2_v_comb = data[rs2_s];
                end
            end
            else begin
                ars2_v_comb.valid = '1;
                ars2_v_comb.renamed = '0;
                ars2_v_comb.p_addr = '0;
                ars2_v_comb.p_addr_ret = '0;
                ars2_v_comb.value = '0;
            end
    //end


    //always_comb begin // always comb??????
        if (rst) begin
            rs1_renamed = '0;
            rs2_renamed = '0;
            rs1_paddr = '0;
            rs2_paddr = '0;
        end
        else begin
            rs1_renamed = data[rat_rs1].renamed;
            rs2_renamed = data[rat_rs2].renamed;
            rs1_paddr = data[rat_rs1].p_addr;
            rs2_paddr = data[rat_rs2].p_addr;
        end
    end

endmodule : rat_arf