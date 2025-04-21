module r_station_new
import rv32i_types::*;
 #(
            parameter               DEPTH     = 16,
            parameter               PTR_SIZE  = $clog2(DEPTH),
            parameter               WIDTH     = 32

)(
    input   logic                   clk,//
    input   logic                   rst,//
    input   logic                   funct_unit_busy,
    input   logic                   load_station,
    input   dp_is_stage_reg_t       inst_in,
    output  dp_is_stage_reg_t       inst_out,
    output  logic                   valid_rdata,// 
    output  logic                   rename_q_stall, // 

    input   logic   [6:0]  data_paddr, //from bus
    input   logic   [31:0]     data_in    //from bus
    //maybe add ^ seperate for rs1 & rs2, maybe port to port from funct units

    //output  logic                   regf_we,
    //output  logic   [WIDTH-1:0]     rd_v,
    //output  logic   [PTR_SIZE-1:0]  rs1_s, rs2_s, rd_s
);

    dp_is_stage_reg_t station [DEPTH];

    logic full;
    logic empty;

    logic found_idx;
    logic [PTR_SIZE-1:0] open_idx;

    logic [PTR_SIZE-1:0] old_stat_idx;
    logic [3:0] old_rob_idx;

    logic remove;
    logic inst_is_ready;

    always_comb begin
        full = '1;
        empty = '1;
        for (integer i = 0; i < DEPTH; i++) begin
            full &= station[i].valid;
            empty &= ~(station[i].valid);
        end

        rename_q_stall = full;
        valid_rdata = ~empty;
    end

    // Find the first open index inside the station
    always_comb begin
        found_idx = '0;
        open_idx = '0;
        for (integer i = 0; i < DEPTH; i++) begin
            if (!station[i].valid && !found_idx) begin
                open_idx = 4'(unsigned'(i));
                found_idx = '1;
            end
        end
    end

    always_comb begin
        old_rob_idx = '1;
        old_stat_idx = '0;
        remove = '0;

        // Forward rd values from bus to source operands
        for (integer i = 0; i < DEPTH; i++) begin
            if (station[i].valid) begin

                // Forward rs1
                if (!station[i].rs1_ready && station[i].use_prs1 && 
                station[i].rs1_paddr == data_paddr) begin
                    station[i].rs1_data = data_in;
                    station[i].rs1_ready = '1;
                end

                // Forward rs2
                if (!station[i].rs2_ready &&
                station[i].use_prs2 && station[i].rs2_paddr == data_paddr) begin
                    station[i].rs2_data = data_in;
                    station[i].rs2_ready = '1;
                end

                // rs1 and rs2 have been forwarded: check if inst is ready
                inst_is_ready = (station[i].use_rs1 && station[i].rs1_ready && !station[i].use_rs2)
                || (station[i].use_rs2 && station[i].rs2_ready && !station[i].use_rs1) ||
                (station[i].use_rs1 && station[i].use_rs1 && station[i].rs1_ready && station[i].rs2_ready);

                // if the inst is ready, it is a candidate to be removed
                if (inst_is_ready) begin
                    // remove the valid inst with the lowest rob idx (oldest)
                    if (station[i].rob_idx <= old_rob_idx) begin
                        old_rob_idx = station[i].rob_idx;
                        old_stat_idx = 4'(unsigned'(i));
                        remove = '1;
                    end
                end
            end
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < DEPTH; i++) begin
                station[i] <= '0;
            end
            inst_out <= '0;
        end else begin
            if (!full && load_station) begin
                station[open_idx] <= inst_in;
                station[open_idx].valid <= '1;
            end

            if (!empty && !funct_unit_busy && remove) begin
                inst_out <= station[old_stat_idx];
                station[old_stat_idx].valid <= '0;
            end
        
        end
    end

endmodule : r_station_new