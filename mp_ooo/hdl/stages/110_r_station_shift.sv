module r_station_shift
import rv32i_types::*;
 #(
            parameter               DEPTH     = 8,
            parameter               PTR_SIZE  = $clog2(DEPTH),
            parameter               WIDTH     = 32

)(
    input   logic                   clk,
    input   logic                   rst,
    input   logic                   funct_unit_busy,
    input   logic                   load_station,
    input   dp_is_stage_reg_t       inst_in,
    output  dp_is_stage_reg_t       inst_out,
    output  logic                   valid_rdata,
    output  logic                   dispatch_stall,
    output  logic                   really_full,

    input   logic   [6:0]  data_paddr_0, //from intfunct 
    input   logic   [31:0]     data_in_0,    //from intfunct  
    input   logic   [6:0]  data_paddr_1, //from mult 
    input   logic   [31:0]     data_in_1,    //from mult
    input   logic   [6:0]  data_paddr_2, //from br
    input   logic   [31:0]     data_in_2    //from br

);

    dp_is_stage_reg_t station [DEPTH];

    logic full;
    logic empty;

    logic quit;

    logic [PTR_SIZE-1:0] output_idx;
    logic [PTR_SIZE-1:0] open_idx;

    logic   [WIDTH-1:0]     data_t;
    logic   [DEPTH-1:0]     idx_rep; 
    logic   [DEPTH-1:0]     rs1_rep, rs2_rep;   //0 for rs1, 2 for rs2
    logic                   remove;
    dp_is_stage_reg_t       inst_tmp;

    always_comb begin
        full = '1;
        empty = '1;
        for (integer i = 0; i < DEPTH; i++) begin
            full &= station[i].valid;
            empty &= ~(station[i].valid);
        end

        really_full = '1;
        for (integer i = 0; i < DEPTH; i++) begin
            // if we are loading, then index 0 is technically valid but we havent put anything there
            if ((i == 0) && load_station) begin
                really_full &= '1;
            end
            else begin
                really_full &= station[i].valid;
            end
        end

        dispatch_stall = full;
        valid_rdata = ~empty;

        output_idx = '0;
        quit = '0;
        remove = '0;

        // INSTRUCTION THAT IS GOING TO BE REMOVED

        // Find the oldest instruction - this is the instruction we'll output
        for (integer i = DEPTH-1; i >= 0; i--) begin
            if (station[i].valid && !funct_unit_busy && !quit) begin
                if (station[i].valid && station[i].use_prs1 && station[i].use_prs2) begin
                    if (station[i].rs1_ready && station[i].rs2_ready) begin
                        output_idx = PTR_SIZE'(unsigned'(i));
                        quit = '1;
                        remove = '1;
                    end
                end else if (station[i].valid && station[i].use_prs1 && !station[i].use_prs2) begin
                    if (station[i].rs1_ready) begin
                        output_idx = PTR_SIZE'(unsigned'(i));
                        quit = '1;
                        remove = '1;
                    end
                end else if (station[i].valid && station[i].use_prs2 && !station[i].use_prs1) begin
                    if (station[i].rs2_ready) begin
                        output_idx = PTR_SIZE'(unsigned'(i));
                        quit = '1;
                        remove = '1;
                    end
                end else if (station[i].valid && !station[i].use_prs2 && !station[i].use_prs1) begin
                    //if (station[i].rs2_ready) begin
                    output_idx = PTR_SIZE'(unsigned'(i));
                    quit = '1;
                    remove = '1;
                    //end
                end
            end
        end

        quit = '0;
        open_idx = '0;

        for (integer i = 0; i < DEPTH; i++) begin
            if (!quit) begin
                if (station[i].valid) begin
                    if (remove) begin 
                        open_idx = PTR_SIZE'(unsigned'(i));
                        quit = '1;
                    end else begin
                        open_idx = PTR_SIZE'(unsigned'(i-1));
                        quit = '1;
                    end
                end else if (empty) begin
                    open_idx = PTR_SIZE'(unsigned'(DEPTH-1));
                    quit = '1;
                end
            end
        end

        data_t = '0;
        idx_rep = '0;
        rs1_rep = '0;
        rs2_rep = '0;

        // FORWARD DATA TO INSTRUCTIONS

        // Check if any of the rs1/rs2 can be forwarded, and remember their indices
        for (integer i = 0; i < DEPTH; i++) begin
            if (station[i].valid) begin
                if (!station[i].rs1_ready && station[i].use_prs1) begin
                    if (station[i].rs1_paddr == data_paddr_0) begin
                        data_t = data_in_0;
                        idx_rep[i] = '1;
                        rs1_rep[i] = '1;
                    end else if (station[i].rs1_paddr == data_paddr_1) begin
                        data_t = data_in_1;
                        idx_rep[i] = '1;
                        rs1_rep[i] = '1;
                    end else if (station[i].rs1_paddr == data_paddr_2) begin
                        data_t = data_in_2;
                        idx_rep[i] = '1;
                        rs1_rep[i] = '1;
                    end
                end 

                if (!station[i].rs2_ready && station[i].use_prs2) begin
                    if (station[i].rs2_paddr == data_paddr_0) begin
                        data_t = data_in_0;
                        idx_rep[i] = '1;
                        rs2_rep[i] = '1;
                    end else if (station[i].rs2_paddr == data_paddr_1) begin
                        data_t = data_in_1;
                        idx_rep[i] = '1;
                        rs2_rep[i] = '1;
                    end else if (station[i].rs2_paddr == data_paddr_2) begin
                        data_t = data_in_2;
                        idx_rep[i] = '1;
                        rs2_rep[i] = '1;
                    end
                end
            end
        end

        // Set the instruction temp in that will be put into the reservation station
        inst_tmp = inst_in;
        if (inst_in.valid) begin 
            if (inst_in.use_prs1) begin
                if (inst_in.rs1_paddr == data_paddr_0) begin 
                    inst_tmp.rs1_data = data_in_0;
                    inst_tmp.rs1_ready = '1;
                end else if (inst_in.rs1_paddr == data_paddr_1) begin
                    inst_tmp.rs1_data = data_in_1;
                    inst_tmp.rs1_ready = '1;
                end else if (inst_in.rs1_paddr == data_paddr_2) begin
                    inst_tmp.rs1_data = data_in_2;
                    inst_tmp.rs1_ready = '1;
                end
            end
            
            if (inst_in.use_prs2) begin
                if (inst_in.rs2_paddr == data_paddr_0) begin 
                    inst_tmp.rs2_data = data_in_0;
                    inst_tmp.rs2_ready = '1;
                end else if (inst_in.rs2_paddr == data_paddr_1) begin
                    inst_tmp.rs2_data = data_in_1;
                    inst_tmp.rs2_ready = '1;
                end else if (inst_in.rs2_paddr == data_paddr_2) begin
                    inst_tmp.rs2_data = data_in_2;
                    inst_tmp.rs2_ready = '1;
                end
            end
        end


        // for (integer i = 1; i < DEPTH; i++) begin
        //     if (remove) begin 
        //         if (PTR_SIZE'(unsigned'(i)) <= output_idx) begin
        //             station[i] <= station[i-1];
        //         end
        //     end
        // end

    end

    always_ff @(posedge clk) begin

        // RESET THE RESERVATION STATION
         if (rst) begin
            for (integer i = 0; i < DEPTH; i++) begin
                station[i] <= '0;
            end
            inst_out <= '0;
        end else begin

             // MAKE RES STATION INTO A SHIFT REGISTER

            // shift register functionality
            if (remove && !load_station) begin
                station[open_idx] <= '0;
            end
            for (integer i = 1; i < DEPTH; i++) begin
                if (remove) begin 
                    if (PTR_SIZE'(unsigned'(i)) <= output_idx) begin
                        station[i] <= station[i-1];
                    end
                end
            end

            // PUT IN THE FORWARDED DATA
            for (integer i = 0; i < DEPTH; i++) begin
                if (idx_rep[i]) begin
                    if (rs2_rep[i]) begin   //rs2 replace
                        if (PTR_SIZE'(unsigned'(i)) <= output_idx) begin
                            if ((i+1) < (DEPTH)) begin
                                station[i+1].rs2_data <= data_t;
                                station[i+1].rs2_ready <= '1;
                            end
                        end else begin 
                            station[i].rs2_data <= data_t;
                            station[i].rs2_ready <= '1;
                        end
                    end 
                    if (rs1_rep[i]) begin      //rs1 replace
                        if (PTR_SIZE'(unsigned'(i)) <= output_idx) begin
                            if ((i+1) < (DEPTH)) begin
                                station[i+1].rs1_data <= data_t;
                                station[i+1].rs1_ready <= '1;
                            end
                        end else begin 
                            station[i].rs1_data <= data_t;
                            station[i].rs1_ready <= '1;
                        end
                    end
                end 
            end

            // if not full and we are loading, just put into open_idx
            if (!full && load_station && inst_tmp.valid && ((inst_tmp.use_rs1 && !inst_tmp.rs1_ready)||(inst_tmp.use_rs2 && !inst_tmp.rs2_ready))) begin
                station[open_idx] <= inst_tmp;
                station[open_idx].valid <= '1;
            end 
            else if (!full && load_station && inst_tmp.valid && !((inst_tmp.use_rs1 && !inst_tmp.rs1_ready)||(inst_tmp.use_rs2 && !inst_tmp.rs2_ready)) && (remove || funct_unit_busy)) begin
                station[open_idx] <= inst_tmp;
                station[open_idx].valid <= '1;
            end 
            
            if (!empty && !funct_unit_busy && remove) begin
                inst_out <= station[output_idx];
                // station[output_idx] <= '0;
            end else if (!funct_unit_busy && load_station) begin 
                if ((!inst_tmp.use_rs2) && (!inst_tmp.use_rs1)) begin
                    inst_out <= inst_tmp;
                    station[output_idx] <= '0;
                end else if ((inst_tmp.use_rs1 && inst_tmp.rs1_ready) && (inst_tmp.use_rs2 && inst_tmp.rs2_ready)) begin
                    inst_out <= inst_tmp;
                    station[output_idx] <= '0;
                end else if (inst_tmp.use_rs1 && inst_tmp.rs1_ready && !inst_tmp.use_rs2) begin
                    inst_out <= inst_tmp;
                    station[output_idx] <= '0;
                end else if (inst_tmp.use_rs2 && inst_tmp.rs2_ready && !inst_tmp.use_rs1) begin
                    inst_out <= inst_tmp;
                    station[output_idx] <= '0;
                end
            end 
            else if (empty && !funct_unit_busy) begin
                inst_out <= '0;
            end
            else if (funct_unit_busy) begin
                inst_out <= '0;
            end




        end
    end

endmodule : r_station_shift