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
    input   logic   [WIDTH-1:0]     inst_in,
    output  logic   [WIDTH-1:0]     inst_out,
    output  logic                   valid_rdata,
    output  logic                   rename_q_stall,
    output  logic                   really_full

    input   logic   [6:0]  data_paddr_0, //from intfunct 
    input   logic   [31:0]     data_in_0,    //from intfunct  
    input   logic   [6:0]  data_paddr_1, //from mult 
    input   logic   [31:0]     data_in_1,    //from mult
    input   logic   [6:0]  data_paddr_2, //from br
    input   logic   [31:0]     data_in_2    //from br

);

    logic [WIDTH-1:0] station [DEPTH];

    logic full;
    logic empty;

    logic quit;

    logic output_idx;

    logic [WIDTH-1:0] inst_in_reg;

    logic   [WIDTH-1:0]     data_t;
    logic   [DEPTH-1:0]     idx_rep; 
    logic   [DEPTH-1:0]     rs1_rep, rs2_rep;   //0 for rs1, 2 for rs2
    logic remove;
    dp_is_stage_reg_t inst_tmp;

    always_comb begin
        full = '1;
        empty = '1;
        for (integer i = 0; i < DEPTH; i++) begin
            full &= station[i].valid;
            empty &= ~(station[i].valid);
        end

        rename_q_stall = full;
        valid_rdata = ~empty;

        output_idx = '0;
        quit = '0;
        remove = '0;

        // Find the oldest instruction - this is the instruction we'll output
        for (integer i = DEPTH-1; i >= 0; i--) begin
            if (station[i].valid && !funct_unit_busy && !quit) begin
                if (station[i].valid && station[i].use_rs1 && station[i].use_rs2) begin
                    if (station[i].rs1_ready && station[i].rs2_ready) begin
                        output_idx = PTR_SIZE'(unsigned'(i));
                        quit = '1;
                        remove = '1;
                    end
                end else if (station[i].valid && station[i].use_rs1) begin
                    if (station[i].rs1_ready) begin
                        output_idx = PTR_SIZE'(unsigned'(i));
                        quit = '1;
                        remove = '1;
                    end
                end else if (station[i].valid && station[i].use_rs2) begin
                    if (station[i].rs2_ready) begin
                        output_idx = PTR_SIZE'(unsigned'(i));
                        quit = '1;
                        remove = '1;
                    end
                end
            end
        end

        data_t = '0;
        idx_rep = '0;
        rs1_rep = '0;
        rs2_rep = '0;

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
                end else if (!station[i].rs2_ready && station[i].use_prs2) begin
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


        

    end

    always_ff @(posedge clk) begin
        // shift register functionality
        for (integer i = 1; i < DEPTH; i++) begin
            if (!station[i].valid) begin
                station[i] <= station[i-1];
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
            for (integer i = 0; i < DEPTH; i++) begin
                if (idx_rep[i]) begin
                    if (rs2_rep[i]) begin   //rs2 replace
                        station[i].rs2_data <= data_t;
                        station[i].rs2_ready <= '1;
                    end 
                    if (rs1_rep[i]) begin      //rs1 replace
                        station[i].rs1_data <= data_t;
                        station[i].rs1_ready <= '1;
                    end
                end 
            end
        end
    end

    always_comb begin
        if (empty) begin
            inst_out = 'x;
        end else begin
            inst_out = internal_array[head[PTR_SIZE-1:0]];
        end
    end

endmodule : r_station_shift