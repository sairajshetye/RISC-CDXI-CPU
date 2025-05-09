module br_pred

import rv32i_types::*;
#(
    parameter               GHR_SIZE     = 8,       //??, N
    parameter               PHT_SIZE     = 256,      //??
    parameter               TAG_DATA_WIDTH = 28 //32-3
    //parameter               PTR_SIZE  = $clog2(DEPTH)
    //something changes with compressed so probably add parameter to deal with that
)( 

    input   logic                   clk,
    input   logic                   rst,
    input   logic                   flush,
    input   logic                   stall,
    input   logic                   imem_resp,

    input   logic   [31:0]          inst,
    input   logic   [31:0]          pc_in,     //to xor with GHR, don't need all bits, figure out how many

    // input   logic   [31:0]          pc_next,
    //input logic to update PHT
    //input   logic                   update_pht,

    //input logic to update GHR, speculative
    //update this at initial predict? except during flush?
    //input   logic                   u_ghr_s,        //trigger input
    //input   logic                   ghr_s_v,        //input data

    //input logic to update GHR, commit
    input   logic                   u_ghr_c,        //trigger input
    input   branch_t                ghr_c_v,        //input data
    input   logic   [31:0]          pc_commit,
    //input logic to update PHT
    //updated with ghr on commit (i think)
    input   branch_t                pht_c_v,        //input data (actual br taken v not taken result out of rob?)
    input   logic                   is_br_c,        //input data (if rob out inst is br)
    input   branch_t_state          branch_state_in,

    output  logic   [31:0]          pc_out,
    output  branch_t                br_pred,      //comb signal to set pc_next in cpu?
    output  branch_t_state          branch_t_states,
    output  logic                   set_pc_br,
    output  logic                   bp_flush,
    output  logic                   is_br
    


    //output to snapshot GHR to inst (goes to fetch)


);

/*
to do 
- store GHR snapshot in fetch packet in case of misprediction, does commit GHR fix this?
- BTB
- return addr stack
*/

//define FSM
// enum logic [1:0] {
//         strongly_not_taken = 2'b00,
//         weakly_not_taken = 2'b01,
//         weakly_taken = 2'b10,
//         strongly_taken = 2'b11,
// } state, state_next;
enum logic [1:0] {
        idle,
        compare_br,
        compare_jalr,
        compare_jal
        
    } state, state_next;

logic   [31:0]  b_imm, b_imm_reg;
logic   [31:0]  j_imm, j_imm_reg;

//define PHT
//logic [1:0] pattern_history_table [PHT_SIZE];     
logic [GHR_SIZE-1:0] pht_addr;
logic pht_write, pht_s;
logic [1:0] pht_wdata_in, pht_wdata_out;

//define GHR
logic u_ghr_s, ghr_s_v;
logic ghr_c_val;

logic [GHR_SIZE-1:0]  global_history_reg [2];        //outcomes of previous GHR_SIZE branches
// 0 = not taken, 1 = taken
//global_history_reg[0] = speculative GHR
//global_history_reg[1] = commit GHR

//define BTB
logic [3:0] btb_addr, btb_c_addr;   //from tag_array
logic [TAG_DATA_WIDTH-1:0] btb_wtag_in, btb_tag_out;
logic [31:0] btb_wdata_in, btb_data_out;
logic btb_write, btb_tag_write;
logic [3:0] btb_wmask;
logic btb_s;
logic btb_valid, btb_v_din, btb_v_dout;
logic btb_commit, btb_c_din, btb_c_dout;
logic [31:0] pc_out_lb;

/*
pc_in[3:0] = idx
pc_in[31:4] = tag
*/

//btb commit array?

logic [31:0] btb_buff_data, btb_buff_data_reg;
logic [TAG_DATA_WIDTH-1:0] btb_buff_tag_reg;
logic [3:0] btb_buff_addr, btb_buff_addr_reg;

logic [31:0] pc_in_reg;
logic [31:0] pc_commit_reg;
branch_t pht_c_v_reg;
logic is_br_c_reg;
branch_t_state branch_state_in_reg;
//define return stack

//logic 
logic   [6:0]   opcode;
//branch_t br_pred;
//logic br_en;
logic hit;
//logic   [22:0]  tag;
//logic   [3:0]   set;
//logic   [4:0]   offset;
logic pht_valid, pht_v_din, pht_v_dout;

logic flush_reg;
logic write, read, read_next, pht_read_v, btb_read_v;
// logic is_br;
logic [GHR_SIZE-1:0] addr_read, addr_write;



mp_ooo_pht_array pattern_history_table (
    .clk0       (clk && !pht_s),
    //.rst0       (rst),
    .csb0       (pht_s), // active low chip select (does not control power)
    .web0       (pht_write), // active low write control
    //.wmask0     (!pht_write), // wmask
    .addr0      (pht_addr), // addr (idx) 
    //.offset0    (data_offset),
    .din0       (pht_wdata_in), // data in 
    .dout0      (pht_wdata_out) // data out 
);
sp_ff_array #(
    .S_INDEX(GHR_SIZE)

)pht_valid_array (   //spec valid
            .clk0       (clk),
            .rst0       (rst),
            .csb0       (pht_s),
            .web0       (pht_valid),
            .addr0      (pht_addr),
            .din0       (pht_v_din),
            .dout0      (pht_v_dout)
);

mp_ooo_btb_array br_target_buff (
    .clk0       (clk && !btb_s),
    //.rst0       (rst),
    .csb0       (btb_s), // always select?
    .web0       (btb_write),
    .wmask0     (btb_wmask), // wmask
    .addr0      (btb_addr), // addr (idx) 
    //.offset0    (data_offset),
    .din0       (btb_wdata_in), // data in 
    .dout0      (btb_data_out) // data out 

);
mp_ooo_tag_array #(
    .DATA_WIDTH(TAG_DATA_WIDTH)

) btb_tag_array (
    .clk0       (clk && !btb_s),
    //.rst0       (rst),
    .csb0       (btb_s),
    .web0       (btb_tag_write),
    .addr0      (btb_addr),
    .din0       (btb_wtag_in),
    .dout0      (btb_tag_out)
);
sp_ff_array btb_valid_array (   //spec valid
            .clk0       (clk),
            .rst0       (rst),
            .csb0       (btb_s),
            .web0       (btb_valid),
            .addr0      (btb_addr),
            .din0       (btb_v_din),
            .dout0      (btb_v_dout)
);
sp_ff_array btb_commit_array (      //commit valid
            .clk0       (clk),
            .rst0       (rst),
            .csb0       (btb_s),
            .web0       (btb_commit),
            .addr0      (btb_c_addr),
            .din0       (btb_c_din),
            .dout0      (btb_c_dout)
);

assign ghr_c_val = (ghr_c_v == taken) ? '1: '0;

always_ff @(posedge clk) begin
        if (rst) begin
            btb_buff_data_reg <= '0;
            btb_buff_addr_reg <= '0;
            pc_in_reg <= '0;
            b_imm_reg <= '0;
            j_imm_reg <= '0;
            pc_commit_reg <= '0;
            pht_c_v_reg <= not_taken;
            is_br_c_reg <= '0;
            branch_state_in_reg <= weakly_taken;
            flush_reg <= '0;
        end else begin
        if (flush) begin
            btb_buff_data_reg <= '0;
            btb_buff_addr_reg <= '0;
            pc_in_reg <= '0;
            b_imm_reg <= '0;
            j_imm_reg <= '0;

        end else begin
            pc_in_reg <= pc_in;
            b_imm_reg <= b_imm;
            j_imm_reg <= j_imm;
            
        end
        
        if (hit) begin
            btb_buff_data_reg <= btb_buff_data;
            btb_buff_addr_reg <= btb_buff_addr;
        end 
        if (is_br_c) begin
            pc_commit_reg <= pc_commit;
            pht_c_v_reg <= pht_c_v;
            is_br_c_reg <= is_br_c;
            branch_state_in_reg <= branch_state_in;
        end
            flush_reg <= flush;
        
        end
        // is_br_c_reg <= '0;
        // if (!pht_valid) begin   //pht write, clear reg
        //     is_br_c_reg <= '0;
        // end
    end

assign btb_buff_tag_reg = btb_buff_data_reg[31:4];

always_ff @(posedge clk) begin
    if (rst) begin
        state <= idle;
        //for (integer i = 0; i < PHT_SIZE; i++) begin
        //    pattern_history_table[i] <= 2'b00;
        //end
        global_history_reg[0] <= '0;
        global_history_reg[1] <= '0;
        addr_read <= '0;
        addr_write <= '0;
        read <= '0;
    end else begin
        state <= state_next;
        read <= read_next;
    //end

    if (flush) begin
        if (u_ghr_c) begin  //commit in on flush
            //pattern_history_table[] <= 
            global_history_reg[0] <= { global_history_reg[1][GHR_SIZE-2:0], ghr_c_val };
            global_history_reg[1] <= { global_history_reg[1][GHR_SIZE-2:0], ghr_c_val };
            // addr_read <= { global_history_reg[1][GHR_SIZE-2:0], ghr_c_val } ^ pc_in[GHR_SIZE+1:2];
            // addr_write <= { global_history_reg[1][GHR_SIZE-2:0], ghr_c_val } ^ pc_commit[GHR_SIZE+1:2];

        end else begin
            global_history_reg[0] <= global_history_reg[1];
            // addr_read <= global_history_reg[1] ^ pc_in[GHR_SIZE+1:2];
            // addr_write <= '0;
        end
    end
    else begin
        // addr_read <= global_history_reg[0] ^ pc_in[GHR_SIZE+1:2];
        if (u_ghr_s) begin  //update ghr speculative
            global_history_reg[0] <= { global_history_reg[0][GHR_SIZE-2:0], ghr_s_v };  //shift reg
            // addr_read <= { global_history_reg[0][GHR_SIZE-2:0], ghr_s_v } ^ pc_in[GHR_SIZE+1:2];
        end 

        if (u_ghr_c) begin  //update ghr commit
            //pattern_history_table[] <= pht_c_v;
            global_history_reg[1] <= { global_history_reg[1][GHR_SIZE-2:0], ghr_c_val };  //shift reg
            // addr_write <= { global_history_reg[1][GHR_SIZE-2:0], ghr_c_val } ^ pc_commit[GHR_SIZE+1:2];
            //global_history_reg[0] <= { global_history_reg[0][GHR_SIZE-2:0], ghr_c_val }; 
        end 
    end
end

end

//set taken or not taken from inst???
assign opcode = inst[6:0];
assign b_imm  = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
assign j_imm  = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};

//assign dirty = dirty_d_out[lru_decode]; // find dirty status of least recently used
//assign valid = valid_d_out[0]; //ufp_addr_reg[8:5]
//assign tag == tag_d_out[0] ? 1'b1 : 1'b0;

always_comb begin
    state_next = state;
    read_next = '0;

    //pht
    pht_addr = '0;
    pht_write = '1;
    pht_wdata_in = '0;
    br_pred = taken;
    pht_s = '1;

    //btb
    hit = 1'b0;
    btb_addr = '0;
    btb_c_addr = '0;
    btb_wtag_in = '0;
    btb_wdata_in = '0;
    btb_s = '1;
    btb_v_din = '0;
    btb_c_din = '0;

    //active low writes
    btb_tag_write = '1;
    btb_write = '1;
    btb_wmask = '1;
    btb_commit = '1;
    btb_valid = '1;


    set_pc_br = '0;
    u_ghr_s = '0;   //update spec GHR
    ghr_s_v = '0;   //spec GHR data
    pc_out = pc_in;//+ 3'b100;
    btb_buff_data ='0;
    btb_buff_addr = '0;
    pht_valid = '1;
    pht_v_din = '0;
    bp_flush = '0;

    branch_t_states = weakly_taken;
    is_br = '0;
    write = '0;
    pht_read_v = '0;
    btb_read_v = '0;


    //get prediction + update spec
    unique case (state)
        idle : begin
            if (!stall && imem_resp && !flush) begin
            unique case (opcode)
                7'b1100011 : begin      //br
                    // if (btb_buff_tag_reg == pc_in[31:4] && (btb_buff_addr_reg == pc_in[3:0]) && (pht_wdata_out[1] == 1'b1)) begin //buffer
                    //     pc_out = btb_buff_data_reg;
                    //     set_pc_br = '1;
                    //     // if (is_br_c) begin
                    //     //     state_next = write;
                    //     // end else begin
                    //     //     state_next = idle;
                    //     // end
                    // end else begin
                        pht_addr = global_history_reg[1] ^ pc_in[GHR_SIZE+1:2];
                        pht_s = '0;
                        btb_addr = pc_in[3:0];
                        state_next = compare_br;
                        btb_s = '0;
                        read_next = '1;
                        // is_br = '1;
                        // bp_stall = '1;
                    // end
                end
                7'b1100111 : begin     //jalr
                    // if (btb_buff_tag_reg == pc_in[31:4] && (btb_buff_addr_reg == pc_in[3:0]) && (pht_wdata_out[1] == 1'b1)) begin //buffer
                    //     pc_out = btb_buff_data_reg;
                    //     set_pc_br = '1;
                    //     // if (is_br_c) begin
                    //     //     state_next = write;
                    //     // end else begin
                    //     //     state_next = idle;
                    //     // end
                    // end else begin
                        pht_addr =  global_history_reg[1] ^ pc_in[GHR_SIZE+1:2];
                        pht_s = '0;
                        btb_addr = pc_in[3:0];
                        state_next = compare_jalr;
                        btb_s = '0;
                        read_next = '1;
                        // is_br = '1;
                        // bp_stall = '1;
                    // end

                end
                7'b1101111 : begin      //jal
                    // if (btb_buff_tag_reg == pc_in[31:4] && (btb_buff_addr_reg == pc_in[3:0]) && (pht_wdata_out[1] == 1'b1)) begin //buffer
                    //     pc_out = btb_buff_data_reg;
                    //     set_pc_br = '1;
                    //     // if (is_br_c) begin
                    //     //     state_next = write;
                    //     // end else begin
                    //     //     state_next = idle;
                    //     // end
                    // end else begin
                        pht_addr = global_history_reg[1] ^ pc_in[GHR_SIZE+1:2];
                        pht_s = '0;
                        btb_addr = pc_in[3:0];
                        state_next = compare_jal;
                        btb_s = '0;
                        // is_br = '1;
                        // bp_stall = '1;
                    // end

                end
                default : begin
                    // if (is_br_c) begin
                    //     state_next = write;
                    // end else begin
                        state_next = idle;
                    // end

                end


            endcase
            end 

            else begin
                // if (is_br_c && !flush) begin
                //     if (pht_c_v == taken) begin
                //         pht_wdata_in = 2'b10;
                //         pht_addr = pc_commit[GHR_SIZE+1:2];
                //         pht_write = '0;
                //     pht_s = '0;
                //     pht_valid = '0;
                //     pht_v_din = '1;
                //     state_next = idle;

                //     end else begin
                //         pht_wdata_in = 2'b01;

                //     end
                //     // if (u_ghr_c) begin
                //     //     pht_addr = { global_history_reg[1][GHR_SIZE-2:0], ghr_c_val } ^ pc_commit[GHR_SIZE+1:2];
                //     // end else begin
                //     //     pht_addr = global_history_reg[1] ^ pc_commit[GHR_SIZE+1:2];
                //     // // end
                //     // pht_write = '0;
                //     // pht_s = '0;
                //     // pht_valid = '0;
                //     // pht_v_din = '1;
                //     // state_next = idle;

                // end
                if (is_br_c && !flush) begin
                    // if (is_br_c_reg) begin
                    write = '1;
                        pht_addr = global_history_reg[1] ^ pc_commit[GHR_SIZE+1:2]; //ghr 0 or 1???
                        // pht_write = '0; //active low
                        pht_wdata_in = 2'b00;
                        
                        if (branch_state_in == 2'b00) begin
                                if (pht_c_v == taken) begin  //br taken
                                    pht_wdata_in = 2'b01;
                                end else begin      //br not taken
                                    pht_wdata_in = 2'b00;
                                    //dont need to update
                                end

                            end else if (branch_state_in == 2'b01) begin
                                if (pht_c_v == taken) begin  //br taken
                                    pht_wdata_in = 2'b10;
                                end else begin      //br not taken
                                    pht_wdata_in = 2'b00;
                                end
                            end else if (branch_state_in == 2'b10) begin
                                if (pht_c_v == taken) begin  //br taken
                                    pht_wdata_in = 2'b11;
                                end else begin      //br not taken
                                    pht_wdata_in = 2'b01;
                                end
                            end else if (branch_state_in == 2'b11) begin
                                if (pht_c_v == taken) begin  //br taken
                                    pht_wdata_in = 2'b11;
                                    //dont need to update
                                end else begin      //br not taken
                                    pht_wdata_in = 2'b10;
                                end
                            end
                            pht_write = '0;
                            pht_s = '0;
                        
                            pht_valid = '0;
                            pht_v_din = '1;
                            pht_s = '0; //active low
                            btb_addr = pc_commit[3:0];
                            btb_write = '0;
                            btb_wmask = '1;
                            btb_wdata_in = pc_commit;
                            btb_tag_write = '0; //active low
                            btb_wtag_in = pc_commit[31:4];
                            btb_valid = '0; //active low
                            btb_v_din = '1;
                            btb_s = '0; //active low

                        state_next = idle;
                    // end
                end else begin
                    state_next = idle;
                end
            // end
            
            // state_next = idle;
            // end else begin  
            //     if (is_br_c) begin
            //         pht_addr = global_history_reg[1] ^ pc_commit[GHR_SIZE+1:2];
            //         pht_wdata_in = 2'b00;
            //     if (branch_state_in == 2'b00) begin
            //             if (pht_c_v == taken) begin  //br taken
            //                 pht_wdata_in = 2'b01;
            //             end else begin      //br not taken
            //                 //pht_wdata_in = 2'b00;
            //                 //dont need to update
            //             end

            //         end else if (branch_state_in == 2'b01) begin
            //             if (pht_c_v == taken) begin  //br taken
            //                 pht_wdata_in = 2'b10;
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b00;
            //             end
            //         end else if (branch_state_in == 2'b10) begin
            //             if (pht_c_v == taken) begin  //br taken
            //                 pht_wdata_in = 2'b11;
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b01;
            //             end
            //         end else if (branch_state_in == 2'b11) begin
            //             if (pht_c_v == taken) begin  //br taken
            //                 pht_wdata_in = 2'b11;
            //                 //dont need to update
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b10;
            //             end
            //         end
            //         pht_write = '0;
            //         pht_s = '0;
                
            //         pht_valid = '0;
            //         pht_v_din = '1;
            //         //pht_s = '0; //active low
            //         btb_addr = pc_commit[3:0];
            //         btb_write = '0;
            //         btb_wmask = '1;
            //         btb_wdata_in = pc_commit;
            //         btb_tag_write = '0; //active low
            //         btb_wtag_in = pc_commit[31:4];
            //         btb_valid = '0; //active low
            //         btb_v_din = '1;
            //         btb_s = '0; //active low

            //     state_next = idle;
            // end

            // else begin
            // if (is_br_c) begin
            //     state_next = write;
            // end else begin
            //     state_next = idle;
            // // end
            end


        end 
        compare_br : begin
            // is_br = '1;
            if (pht_v_dout && !flush_reg && read) begin       //if pht valid
            is_br = '1;
            pht_read_v = '1;
            unique case (pht_wdata_out)
                2'b00 : begin
                    br_pred = not_taken;
                    branch_t_states = strongly_not_taken;
                end
                2'b01 : begin 
                    br_pred = not_taken;
                    branch_t_states = weakly_not_taken;
                    //bp_flush = '1;
                end
                2'b10 : begin
                    br_pred = taken;
                    branch_t_states = weakly_taken;
                end 
                2'b11 : begin
                    br_pred = taken;
                    branch_t_states = strongly_taken;
                end
            endcase

            if (pc_in_reg[31:4] == btb_tag_out && (btb_tag_out != '0) && (pht_wdata_out[1] == 1'b1) && btb_v_dout) begin      //btb hit & predicted taken
                btb_read_v = '1;
                pc_out = btb_data_out;
                set_pc_br = '1;
                btb_buff_data = btb_data_out;
                btb_buff_addr = pc_in_reg[3:0];
                hit = '1;
                
            end
            
            // else if ((pht_wdata_out[1] == 1'b1)) begin  //no hit but predicted taken
                //pc_out = pc_in_reg + b_imm_reg;
                //set_pc_br = '1;
                //write this to btb, but will be removed if flush
                //spec
                // btb_s = '0;
                // btb_wdata_in = pc_in_reg + b_imm_reg;
                // btb_wtag_in = pc_in_reg[31:4];  //29 bits?
                // btb_write = '0;
                // btb_wmask = '1; 
                // btb_tag_write = '1;
                // btb_valid = '0;
                // btb_v_din = '1;


            // end else if (pc_in_reg[31:4] == btb_tag_out && (btb_tag_out != '0) && btb_v_dout) begin    //btb hit, but pht pred not taken, update pht?
                // pc_out = btb_data_out;
                // set_pc_br = '1;
                // hit = '1;   //???
                //bp_flush = '1;
                //update pht?

            // end 
            else begin  //no hit, predicted not taken
                pc_out = pc_in_reg + 3'b100;
                // set_pc_br = '1;
            end

            u_ghr_s = '1;
            ghr_s_v = (pht_wdata_out[1] == 1'b1) ? '1 : '0;
            state_next = idle;
            end else begin      //pht not valid
            if (!flush_reg) begin
                br_pred = taken;
                pc_out = pc_in_reg + b_imm_reg;
                set_pc_br = '1;
                state_next = idle;
                branch_t_states = weakly_taken;
                u_ghr_s = '1;
                ghr_s_v = '1;//(br_pred == taken) ? '1 : '0;
                is_br = '1;
                // u_ghr_s = '1;
                // ghr_s_v = (br_pred == taken) ? '1 : '0;
                //state_next = idle;
            end
                // bp_flush = '1;
                //predict weakly taken and add to btb/pht?


            end
            // if (is_br_c_reg) begin      //update pht && btb
            //     pht_addr = global_history_reg[1] ^ pc_commit_reg[GHR_SIZE+1:2]; //ghr 0 or 1???
            //     // pht_write = '0; //active low
            //     pht_wdata_in = 2'b01;
            //     write = '1;
                
            //         if (branch_state_in_reg == 2'b00) begin
            //             if (pht_c_v_reg == taken) begin  //br taken
            //                 pht_wdata_in = 2'b01;
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b00;
            //                 //dont need to update
            //             end

            //         end else if (branch_state_in_reg == 2'b01) begin
            //             if (pht_c_v_reg == taken) begin  //br taken
            //                 pht_wdata_in = 2'b10;
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b00;
            //             end
            //         end else if (branch_state_in_reg == 2'b10) begin
            //             if (pht_c_v_reg == taken) begin  //br taken
            //                 pht_wdata_in = 2'b11;
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b01;
            //             end
            //         end else if (branch_state_in_reg == 2'b11) begin
            //             if (pht_c_v_reg == taken) begin  //br taken
            //                 pht_wdata_in = 2'b11;
            //                 //dont need to update
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b10;
            //             end
            //         end
            //         pht_write = '0;
            //         pht_s = '0;
                
            //         pht_valid = '0;
            //         pht_v_din = '1;
            //         btb_addr = pc_commit_reg[3:0];
            //         btb_write = '0;
            //         btb_wmask = '1;
            //         btb_wdata_in = pc_commit_reg;
            //         btb_tag_write = '0; //active low
            //         btb_wtag_in = pc_commit_reg[31:4];
            //         btb_valid = '0; //active low
            //         btb_v_din = '1;
            //         btb_s = '0; //active low

            //     state_next = idle;
                

            // end 
        //     if (!stall && imem_resp && !is_br_c_reg) begin
        //     unique case (opcode)
        //         7'b1100011 : begin      //br
        //                 pht_addr = global_history_reg[1] ^ pc_in[GHR_SIZE+1:2];
        //                 pht_s = '0;
        //                 btb_addr = pc_in[3:0];
        //                 state_next = compare_br;
        //                 btb_s = '0;
        //         end
        //         7'b1100111 : begin     //jalr
        //                 pht_addr = global_history_reg[1] ^ pc_in[GHR_SIZE+1:2];
        //                 pht_s = '0;
        //                 btb_addr = pc_in[3:0];
        //                 state_next = compare_jalr;
        //                 btb_s = '0;
        //         end
        //         7'b1101111 : begin      //jal
        //                 pht_addr = global_history_reg[1] ^ pc_in[GHR_SIZE+1:2];
        //                 pht_s = '0;
        //                 btb_addr = pc_in[3:0];
        //                 state_next = compare_jal;
        //                 btb_s = '0;
        //         end
        //         default : begin
        //             if (is_br_c) begin
        //                 state_next = write;
        //             end else begin
        //                 state_next = idle;
        //             end

        //         end


        //     endcase
        // end else begin

        //     state_next = idle;
                    
        //     end
            // else if (is_br_c) begin
            //     pht_addr = global_history_reg[1] ^ pc_commit[GHR_SIZE+1:2]; //ghr 0 or 1???
            //     pht_write = '0; //active low
            //     //if (!flush) begin   //correct assumption
            //         if (branch_state_in == 2'b00) begin
            //             if (pht_c_v == taken) begin  //br taken
            //                 pht_wdata_in = 2'b01;
            //             end else begin      //br not taken
            //                 //pht_wdata_in = 2'b00;
            //                 //dont need to update
            //             end

            //         end else if (branch_state_in == 2'b01) begin
            //             if (pht_c_v == taken) begin  //br taken
            //                 pht_wdata_in = 2'b10;
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b00;
            //             end
            //         end else if (branch_state_in == 2'b10) begin
            //             if (pht_c_v == taken) begin  //br taken
            //                 pht_wdata_in = 2'b11;
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b01;
            //             end
            //         end else if (branch_state_in == 2'b11) begin
            //             if (pht_c_v == taken) begin  //br taken
            //                 pht_wdata_in = 2'b11;
            //                 //dont need to update
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b10;
            //             end
            //         end
            //         pht_write = '0;
            //         pht_s = '0;
                
            //         pht_valid = '0;
            //         pht_v_din = '1;
            //         //pht_s = '0; //active low
            //         btb_addr = pc_commit[3:0];
            //         btb_write = '0;
            //         btb_wmask = '1;
            //         btb_wdata_in = pc_commit;
            //         btb_tag_write = '0; //active low
            //         btb_wtag_in = pc_commit[31:4];
            //         btb_valid = '0; //active low
            //         btb_v_din = '1;
            //         btb_s = '0; //active low

            //     state_next = idle;

            // end
        end
        compare_jalr : begin
            // is_br = '1;
            if (pht_v_dout && !flush_reg && read) begin
                is_br = '1;
                pht_read_v = '1;
            unique case (pht_wdata_out)
                2'b00 : begin
                    br_pred = not_taken;
                    branch_t_states = strongly_not_taken;
                end
                2'b01 : begin 
                    br_pred = not_taken;
                    branch_t_states = weakly_not_taken;
                    //bp_flush = '1;
                end
                2'b10 : begin
                    br_pred = taken;
                    branch_t_states = weakly_taken;
                end 
                2'b11 : begin
                    br_pred = taken;
                    branch_t_states = strongly_taken;
                end
            
            endcase
            //br_pred = pht_wdata_out;
            if (pc_in_reg[31:4] == btb_tag_out && (btb_tag_out != '0) && (pht_wdata_out[1] == 1'b1) && btb_v_dout) begin      //btb hit & predicted taken
                btb_read_v = '1;
                pc_out = btb_data_out;
                set_pc_br = '1;
                btb_buff_data = btb_data_out;
                btb_buff_addr = pc_in_reg[3:0];
                hit = '1;

            end
            // else if ((pht_wdata_out[1] == 1'b1)) begin  //no hit but predicted taken
            //     //not sure, for now predict not taken
            //     br_pred = not_taken;    //?
            //     pc_out = pc_in_reg + 3'b100;
            //     // set_pc_br = '1;

            // end else begin //no hit, predicted not taken
            //     br_pred = not_taken;
            //     pc_out = pc_in_reg + 3'b100;
            //     // set_pc_br = '1;

            // end

            u_ghr_s = '1;
            ghr_s_v = (pht_wdata_out[1] == 1'b1) ? '1 : '0;
            state_next = idle;
            end else begin      //pht not valid
                br_pred = not_taken;
                state_next = idle;
                u_ghr_s = '1;
                ghr_s_v = '0;
                //state_next = idle;
                //predict weakly taken and add to btb/pht?


            end
            // if (is_br_c_reg) begin      //update pht && btb
            //     pht_addr = global_history_reg[1] ^ pc_commit_reg[GHR_SIZE+1:2]; //ghr 0 or 1???
            //     // pht_write = '0; //active low
            //     write = '1;
            //     pht_wdata_in = 2'b00;
            //         if (branch_state_in_reg == 2'b00) begin
            //             if (pht_c_v_reg == taken) begin  //br taken
            //                 pht_wdata_in = 2'b01;
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b00;
            //             end

            //         end else if (branch_state_in_reg == 2'b01) begin
            //             if (pht_c_v_reg == taken) begin  //br taken
            //                 pht_wdata_in = 2'b10;
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b00;
            //             end
            //         end else if (branch_state_in_reg == 2'b10) begin
            //             if (pht_c_v_reg == taken) begin  //br taken
            //                 pht_wdata_in = 2'b11;
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b01;
            //             end
            //         end else if (branch_state_in_reg == 2'b11) begin
            //             if (pht_c_v_reg == taken) begin  //br taken
            //                 pht_wdata_in = 2'b11;
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b10;
            //             end
            //         end
            //         pht_write = '0;
            //         pht_s = '0;
            //         pht_valid = '0;
            //         pht_v_din = '1;
            //         btb_addr = pc_commit_reg[3:0];
            //         btb_write = '0;
            //         btb_wmask = '1;
            //         btb_wdata_in = pc_commit_reg;
            //         btb_tag_write = '0; //active low
            //         btb_wtag_in = pc_commit_reg[31:4];
            //         btb_valid = '0; //active low
            //         btb_v_din = '1;
            //         btb_s = '0; //active low

            //     state_next = idle;
                

            // end
        //     if (!stall && imem_resp && !is_br_c_reg) begin
        //     unique case (opcode)
        //         7'b1100011 : begin      //br
        //                 pht_addr =  pc_in[GHR_SIZE+1:2];
        //                 pht_s = '0;
        //                 btb_addr = pc_in[3:0];
        //                 state_next = compare_br;
        //                 btb_s = '0;
        //         end
        //         7'b1100111 : begin     //jalr
        //                 pht_addr = pc_in[GHR_SIZE+1:2];
        //                 pht_s = '0;
        //                 btb_addr = pc_in[3:0];
        //                 state_next = compare_jalr;
        //                 btb_s = '0;
        //         end
        //         7'b1101111 : begin      //jal
        //                 pht_addr = pc_in[GHR_SIZE+1:2];
        //                 pht_s = '0;
        //                 btb_addr = pc_in[3:0];
        //                 state_next = compare_jal;
        //                 btb_s = '0;
        //         end
        //         default : begin
        //             // if (is_br_c) begin
        //             //     state_next = write;
        //             // end else begin
        //                 state_next = idle;
        //             // end

        //         end
        //     endcase
        // end else begin
        //         state_next = idle;
        //     end
        end
        compare_jal : begin
            // is_br = '1;
            // if (pht_v_dout && !flush_reg) begin
            //     pht_read_v = '1;
            // unique case (pht_wdata_out)
            //     2'b00 : begin
            //         br_pred = not_taken;
            //         branch_t_states = strongly_not_taken;
            //     end
            //     2'b01 : begin 
            //         br_pred = not_taken;
            //         branch_t_states = weakly_not_taken;
            //         //bp_flush = '1;
            //     end
            //     2'b10 : begin
            //         br_pred = taken;
            //         branch_t_states = weakly_taken;
            //     end 
            //     2'b11 : begin
            //         br_pred = taken;
            //         branch_t_states = strongly_taken;
            //     end
            // endcase

            //  if (pc_in_reg[31:4] == btb_tag_out && (btb_tag_out != '0) && (pht_wdata_out[1] == 1'b1) && btb_v_dout) begin      //btb hit & predicted taken
            //     btb_read_v = '1;
            //     pc_out = btb_data_out;
            //     btb_buff_data = btb_data_out;
            //     btb_buff_addr = pc_in_reg[3:0];
            //     hit = '1;
            //     set_pc_br = '1;
            //     branch_t_states = weakly_taken;

            // end
            // else if ((pht_wdata_out[1] == 1'b1)) begin
            //     pc_out = pc_in_reg + j_imm_reg;
            //     set_pc_br = '1;
            //     state_next = idle;
            //     u_ghr_s = '1;
            //     ghr_s_v = '1;

            // end
            // else if ((pht_wdata_out[1] == 1'b1)) begin  //no hit but predicted taken
            //     pc_out = pc_in_reg + j_imm_reg;
            //     set_pc_br = '1;
            //     //write this to btb, but will be removed if flush
            //     //spec
            //     // btb_s = '0;
            //     // btb_wdata_in = pc_in_reg + j_imm_reg;
            //     // btb_wtag_in = pc_in_reg[31:4];  //29 bits?
            //     // btb_write = '0;
            //     // btb_wmask = '1;
            //     // btb_tag_write = '1;
            //     // btb_valid = '0;
            //     // btb_v_din = '1;


            // end 
            // else begin  //no hit, predicted not taken
            //     pc_out = pc_in_reg + 3'b100;
            //     // set_pc_br = '1;

            // end

            //update spec GHR
            // u_ghr_s = '1;
            // ghr_s_v = (br_pred == taken) ? '1 : '0;
            // state_next = idle;
            // end else begin      //pht not valid
            if (!flush_reg) begin
                is_br = '1;
                br_pred = taken;
                pc_out = pc_in_reg + j_imm_reg;
                set_pc_br = '1;
                state_next = idle;
                branch_t_states = strongly_taken;
                u_ghr_s = '1;
                ghr_s_v = '1;
                // ghr_s_v = (br_pred == taken) ? '1 : '0;
                //state_next = idle;
            end
            // end
                // bp_flush = '1;
                //predict weakly taken and add to btb/pht?


            // end
            // if (is_br_c_reg) begin      //update pht && btb
            // write = '1;
            //     pht_addr = global_history_reg[1] ^ pc_commit_reg[GHR_SIZE+1:2]; //ghr 0 or 1???
            //     // pht_write = '0; //active low
            //     pht_wdata_in = 2'b01;
            //         if (branch_state_in_reg == 2'b00) begin
            //             if (pht_c_v_reg == taken) begin  //br taken
            //                 pht_wdata_in = 2'b01;
            //             end else begin      //br not taken
            //                 //pht_wdata_in = 2'b00;
            //                 //dont need to update
            //             end

            //         end else if (branch_state_in_reg == 2'b01) begin
            //             if (pht_c_v_reg == taken) begin  //br taken
            //                 pht_wdata_in = 2'b10;
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b00;
            //             end
            //         end else if (branch_state_in_reg == 2'b10) begin
            //             if (pht_c_v_reg == taken) begin  //br taken
            //                 pht_wdata_in = 2'b11;
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b01;
            //             end
            //         end else if (branch_state_in_reg == 2'b11) begin
            //             if (pht_c_v_reg == taken) begin  //br taken
            //                 pht_wdata_in = 2'b11;
            //                 //dont need to update
            //             end else begin      //br not taken
            //                 pht_wdata_in = 2'b10;
            //             end
            //         end
            //         pht_write = '0;
            //         pht_s = '0;
            //         pht_valid = '0;
            //         pht_v_din = '1;
            //         pht_s = '0; //active low
            //         btb_addr = pc_commit_reg[3:0];
            //         btb_write = '0;
            //         btb_wmask = '1;
            //         btb_wdata_in = pc_commit_reg;
            //         btb_tag_write = '0; //active low
            //         btb_wtag_in = pc_commit_reg[31:4];
            //         btb_valid = '0; //active low
            //         btb_v_din = '1;
            //         btb_s = '0; //active low

            //     state_next = idle;
            // end
            // if (!stall && imem_resp && !is_br_c_reg) begin
            // unique case (opcode)
            //     7'b1100011 : begin      //br
            //             pht_addr = pc_in[GHR_SIZE+1:2];
            //             pht_s = '0;
            //             btb_addr = pc_in[3:0];
            //             state_next = compare_br;
            //             btb_s = '0;
            //     end
            //     7'b1100111 : begin     //jalr
            //             pht_addr = pc_in[GHR_SIZE+1:2];
            //             pht_s = '0;
            //             btb_addr = pc_in[3:0];
            //             state_next = compare_jalr;
            //             btb_s = '0;
            //     end
            //     7'b1101111 : begin      //jal
            //             pht_addr = pc_in[GHR_SIZE+1:2];
            //             pht_s = '0;
            //             btb_addr = pc_in[3:0];
            //             state_next = compare_jal;
            //             btb_s = '0;
            //     end
            //     default : begin
            //         // if (is_br_c) begin
            //         //     state_next = write;
            //         // end else begin
            //             state_next = idle;
            //         // end

            //     end
            // endcase
            // end else begin
            //     state_next = idle;
            // end
            end
        // end
        // write : begin
        //     if (is_br_c_reg) begin
        //         pht_addr = global_history_reg[1] ^ pc_commit_reg[GHR_SIZE+1:2]; //ghr 0 or 1???
        //         // pht_write = '0; //active low
        //         pht_wdata_in = 2'b00;
        //         if (branch_state_in_reg == 2'b00) begin
        //                 if (pht_c_v_reg == taken) begin  //br taken
        //                     pht_wdata_in = 2'b01;
        //                 end else begin      //br not taken
        //                     //pht_wdata_in = 2'b00;
        //                     //dont need to update
        //                 end

        //             end else if (branch_state_in_reg == 2'b01) begin
        //                 if (pht_c_v_reg == taken) begin  //br taken
        //                     pht_wdata_in = 2'b10;
        //                 end else begin      //br not taken
        //                     pht_wdata_in = 2'b00;
        //                 end
        //             end else if (branch_state_in_reg == 2'b10) begin
        //                 if (pht_c_v_reg == taken) begin  //br taken
        //                     pht_wdata_in = 2'b11;
        //                 end else begin      //br not taken
        //                     pht_wdata_in = 2'b01;
        //                 end
        //             end else if (branch_state_in_reg == 2'b11) begin
        //                 if (pht_c_v_reg == taken) begin  //br taken
        //                     pht_wdata_in = 2'b11;
        //                     //dont need to update
        //                 end else begin      //br not taken
        //                     pht_wdata_in = 2'b10;
        //                 end
        //             end
        //             pht_write = '0;
        //             pht_s = '0;
                
        //             pht_valid = '0;
        //             pht_v_din = '1;
        //             //pht_s = '0; //active low
        //             // btb_addr = pc_commit_reg[3:0];
        //             // btb_write = '0;
        //             // btb_wmask = '1;
        //             // btb_wdata_in = pc_commit_reg;
        //             // btb_tag_write = '0; //active low
        //             // btb_wtag_in = pc_commit_reg[31:4];
        //             // btb_valid = '0; //active low
        //             // btb_v_din = '1;
        //             // btb_s = '0; //active low

        //         state_next = idle;
        //     end
        //     if (!stall && imem_resp && !is_br_c_reg) begin
        //     unique case (opcode)
        //         7'b1100011 : begin      //br
        //                 pht_addr = global_history_reg[1] ^ pc_in[GHR_SIZE+1:2];
        //                 pht_s = '0;
        //                 btb_addr = pc_in[3:0];
        //                 state_next = compare_br;
        //                 btb_s = '0;
        //         end
        //         7'b1100111 : begin     //jalr
        //                 pht_addr = global_history_reg[1] ^ pc_in[GHR_SIZE+1:2];
        //                 pht_s = '0;
        //                 btb_addr = pc_in[3:0];
        //                 state_next = compare_jalr;
        //                 btb_s = '0;
        //         end
        //         7'b1101111 : begin      //jal
        //                 pht_addr = global_history_reg[1] ^ pc_in[GHR_SIZE+1:2];
        //                 pht_s = '0;
        //                 btb_addr = pc_in[3:0];
        //                 state_next = compare_jal;
        //                 btb_s = '0;
        //         end
        //         default : begin
        //             if (is_br_c) begin
        //                 state_next = write;
        //             end else begin
        //                 state_next = idle;
        //             end

        //         end
        //     endcase
        //     end else begin
        //         state_next = idle;
        //     end


        // end
        default : begin
            state_next = idle;
        end
    endcase

end


endmodule : br_pred