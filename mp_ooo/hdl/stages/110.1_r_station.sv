module r_station_two
import rv32i_types::*;
 #(
            parameter               DEPTH     = 16,
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
    logic in_out;
    logic remove;
    //logic valid_rdata;  //indicates there is something in res station

    logic found_idx;
    logic [PTR_SIZE-1:0] open_idx;

    logic [PTR_SIZE-1:0] oldest_inst_station_idx;
    logic [3:0] oldest_inst_rob_idx;
    logic       oldest_inst_rob_overflow;

    logic   [WIDTH-1:0]     data_t;
    integer idx_rep; 
    logic rs1_or_rs2;   //0 for rs1, 2 for rs2
    logic replace;      //0 for no replace, 1 for yes replace
    dp_is_stage_reg_t inst_tmp;

    always_comb begin
        


    end

endmodule : r_station_two