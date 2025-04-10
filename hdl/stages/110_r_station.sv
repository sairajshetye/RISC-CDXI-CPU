module r_station
import rv32i_types::*;
 #(
            parameter               DEPTH     = 16,
            parameter               PTR_SIZE  = $clog2(DEPTH),
            parameter               WIDTH     = 32

)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   funct_unit_busy,
    input   dp_is_stage_reg_t       inst_in,
    output  dp_is_stage_reg_t       inst_out,
    output  logic                   valid_rdata,
    output  logic                   dispatch_stall,

    input   logic   [PTR_SIZE-1:0]  data_paddr, //from bus
    input   logic   [WIDTH-1:0]     data_in    //from bus
    //maybe add ^ seperate for rs1 & rs2, maybe port to port from funct units

    //output  logic                   regf_we,
    //output  logic   [WIDTH-1:0]     rd_v,
    //output  logic   [PTR_SIZE-1:0]  rs1_s, rs2_s, rd_s
);

    dp_is_stage_reg_t station [DEPTH];

    logic full;
    logic empty;
    logic in_out;
    //logic valid_rdata;  //indicates there is something in res station

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

    // check all instructions currently in res station
    // if valid and ready, 
    // find the oldest rob idx
    // this is the instruction we 
    // will issue to the functional unit 
    always_comb begin
        oldest_inst_rob_idx = '1;
        for (integer i = 0; i < DEPTH; i++) begin
            if (!funct_unit_busy && station[i].valid) begin //if funct unit busy do nothing, if no inst in fu do nothing
            // need to add rs1_ready and rs2_ready fields to dispatch struct? change from if_id struct to that
            //  && station[i].rs1_ready && station[i].rs2_ready (put in first if statement once fields are created)
                if (station[i].use_rs1 && (station[i].rs1_paddr == data_paddr)) begin    //if using rs1 check if bus_in is for rs1
                        station[i].rs1_data = data_in;
                        station[i].rs1_ready = data_in;
                end
                if (station[i].use_rs2 && (station[i].rs2_paddr == data_paddr)) begin      //if using rs2 check if bus_in is for rs2
                        station[i].rs2_data = data_in;
                        station[i].rs2_ready = data_in;
                end
                
                if ((station[i].use_rs1 && station[i].rs1_ready) && (station[i].use_rs2 && station[i].rs2_ready)) begin //use both rs1 & rs2 & both ready
                    if (station[i].rob_idx <= oldest_inst_rob_idx) begin
                        oldest_inst_rob_idx = station[i].rob_idx;
                        oldest_inst_station_idx = i;
                    end
                end
                else if ((station[i].use_rs1 && station[i].rs1_ready) && !(station[i].use_rs2)) begin   //only use rs1 & rs1 ready
                    if (station[i].rob_idx <= oldest_inst_rob_idx) begin
                        oldest_inst_rob_idx = station[i].rob_idx;
                        oldest_inst_station_idx = i;
                    end
                end 
                else if ((station[i].use_rs2 && station[i].rs2_ready) && !(station[i].use_rs1)) begin   //only use rs2 & rs2 ready
                    if (station[i].rob_idx <= oldest_inst_rob_idx) begin
                        oldest_inst_rob_idx = station[i].rob_idx;
                        oldest_inst_station_idx = i;
                    end
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
                if (station[open_idx].use_rs1 && (station[open_idx].rs1_paddr == data_paddr)) begin    //if using rs1 check if bus_in is for rs1
                        station[open_idx].rs1_data <= data_in;
                        station[open_idx].rs1_ready <= data_in;
                end
                if (station[open_idx].use_rs2 && (station[open_idx].rs2_paddr == data_paddr)) begin      //if using rs2 check if bus_in is for rs2
                        station[open_idx].rs2_data <= data_in;
                        station[open_idx].rs2_ready <= data_in;
                end
            end
        end
    end

    // removing instrs happens on the clock
    // check that valid_rdata is high before reading inst_out outside of this module
    always_ff @(posedge clk) begin
        if (empty | funct_unit_busy) begin
            inst_out <= '0;
        end 
        //need in_out case b4 checking if empty?
        else begin
            inst_out <= station[oldest_inst_station_idx];
            // remove from station if and only if it can be put into the funct_unit
            if (!funct_unit_busy) begin
                station[oldest_inst_station_idx].valid <= '0;
            end
        end
    end

endmodule : r_station