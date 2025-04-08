module r_station
import rv32i_types::*;
 #(
            parameter               DEPTH     = 16,
            parameter               PTR_SIZE  = $clog2(DEPTH)

)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   funct_unit_busy,
    input   if_id_stage_reg_t       inst_in,
    output  if_id_stage_reg_t       inst_out,
    output  logic                   valid_rdata,
    output  logic                   dispatch_stall
);

    if_id_stage_reg_t station [DEPTH];

    logic full;
    logic empty;

    logic found_idx;
    logic [PTR_SIZE-1:0] open_idx;

    logic [PTR_SIZE-1:0] oldest_inst_station_idx;
    logic [3:0] oldest_inst_rob_idx;

    always_comb begin
        full = '1;
        empty = '1;
        for (integer i = 0; i < DEPTH; i++) begin
            full &= station[i].valid;
            empty &= ~(station[i].valid);
        end

        dispatch_stall = full;
        valid_rdata = ~empty;
    end

    // check all instructions
    // if valid and ready, 
    // find the oldest rob idx
    // this is the instruction we 
    // will issue to the functional unit 
    always_comb begin
        oldest_inst_rob_idx = '1;
        for (integer i = 0; i < DEPTH; i++) begin
            // need to add rs1_ready and rs2_ready fields to dispatch struct? change from if_id struct to that
            //  && station[i].rs1_ready && station[i].rs2_ready (put in first if statement once fields are created)
            if (station[i].valid) begin
                if (station[i].rob_idx <= oldest_inst_rob_idx) begin
                    oldest_inst_rob_idx = station[i].rob_idx;
                    oldest_inst_station_idx = i;
                end
            end
        end
    end

    // find an open index
    // in the station
    always_comb begin
        found_idx = '0;
        for (integer i = 0; i < DEPTH; i++) begin
            if (!station[i].valid && !found_idx) begin
                open_idx = i;
                found_idx = '1;
            end
        end
    end

    // adding instrs happens on the clock
    always_ff @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < DEPTH; i++) begin
                station[i] <= '0;
            end
        end else begin
            if (!full) begin
                station[open_idx] <= inst_in;
                station[open_idx].valid <= '1;
            end
        end
    end

    // removing instrs happens on the clock
    // check that valid_rdata is high before reading inst_out outside of this module
    always_ff @(posedge clk) begin
        if (empty) begin
            inst_out <= 'x;
        end else begin
            inst_out <= station[oldest_inst_station_idx];
            // remove from station if and only if it can be put into the funct_unit
            if (!funct_unit_busy) begin
                station[oldest_inst_station_idx].valid <= '0;
            end
        end
    end

endmodule : r_station