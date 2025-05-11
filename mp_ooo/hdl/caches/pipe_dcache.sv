module cache_pipe_d
import rv32i_types::*;
#(
        parameter           SETS        = 16,
        parameter           SETS_SIZE   = $clog2(SETS),
        parameter           DATA_SIZE   = 32,
        parameter           OFFSET_SIZE = 5, 
        parameter           TAG_SIZE    = DATA_SIZE-SETS_SIZE-OFFSET_SIZE,
        parameter           NUM_WAYS    = 4,
        parameter           PLRU        = NUM_WAYS-1,
        parameter           LRU_D       = $clog2(NUM_WAYS)
)(
    input   logic           clk,
    input   logic           rst,
    //input   logic           flush,

    // cpu side signals, ufp -> upward facing port
    input   logic   [31:0]  ufp_addr,
    input   logic   [3:0]   ufp_rmask,
    input   logic   [3:0]   ufp_wmask,
    output  logic   [31:0] ufp_rdata,
    input   logic   [31:0]  ufp_wdata,
    output  logic           ufp_resp,

    // memory side signals, dfp -> downward facing port
    output  logic   [31:0]  dfp_addr,
    output  logic           dfp_read,
    output  logic           dfp_write,
    input   logic   [255:0] dfp_rdata,
    output  logic   [255:0] dfp_wdata,
    input   logic           dfp_resp
);

    //  enum logic [1:0] {
    //     idle,
    //     compare,
    //     allocate,
    //     write_back
    // } state, state_next;
    typedef struct packed {
        logic [TAG_SIZE-1:0]    tag;
        logic [SETS_SIZE-1:0]   set;
        logic [OFFSET_SIZE-1:0] offset;
    } addr_t;

    typedef struct packed {
        logic                   valid;
        logic [31:0]            ufp_addr;
        logic [3:0]             ufp_rmask;
        logic [3:0]             ufp_wmask;
        logic [31:0]            ufp_wdata;

        addr_t                  addr_dec;

        logic                   dfp_resp_alloc; // signifies done alloc
        logic                   dfp_resp_wb; // signifies done wb

        logic [LRU_D-1:0]       hit_way;
        logic                   hit;
        logic                   dirty;
        logic                   valid_read;
        // logic [TAG_SIZE-1:0]    tag;
        // logic [SETS_SIZE-1:0]   set; // just get from ufp_addr
        // logic [OFFSET_SIZE-1:0] offset;
    } stage_reg_t;


    stage_reg_t cache_stage, cache_stage_next;

    // logic   [TAG_SIZE-1:0]      tag; // param
    // logic   [SETS_SIZE-1:0]     set; // param
    // logic   [OFFSET_SIZE-1:0]   offset;
    
    logic   [NUM_WAYS-1:0]   web_way_data0, web_way_data1;
    logic   [NUM_WAYS-1:0]   web_way_tag0, web_way_tag1;
    logic   [NUM_WAYS-1:0]   web_way_valid0, web_way_valid1;
    logic   [NUM_WAYS-1:0]   web_way_dirty0, web_way_dirty1;

    logic   [SETS_SIZE-1:0]   data_addr_read; // index addr[8:5]
    logic   [SETS_SIZE-1:0]   data_addr_write; // index addr[8:5]
    logic   [255:0] data_d_in0 [NUM_WAYS];
    logic   [255:0] data_d_out0 [NUM_WAYS];
    logic   [31:0]  data_wmask0 [NUM_WAYS];

    logic   [255:0] data_d_in1 [NUM_WAYS];
    logic   [255:0] data_d_out1 [NUM_WAYS];
    logic   [31:0]  data_wmask1 [NUM_WAYS];

    logic   [TAG_SIZE-1:0]  tag_d_in0 [NUM_WAYS];
    logic   [TAG_SIZE-1:0]  tag_d_out0 [NUM_WAYS];

    logic   [TAG_SIZE-1:0]  tag_d_in1 [NUM_WAYS];
    logic   [TAG_SIZE-1:0]  tag_d_out1 [NUM_WAYS];

    logic   [NUM_WAYS-1:0]   valid_d_in0;
    logic   [NUM_WAYS-1:0]   valid_d_out0;

    logic   [NUM_WAYS-1:0]   valid_d_in1;
    logic   [NUM_WAYS-1:0]   valid_d_out1;

    logic   [NUM_WAYS-1:0]   dirty_d_in0;
    logic   [NUM_WAYS-1:0]   dirty_d_out0;

    logic   [NUM_WAYS-1:0]   dirty_d_in1;
    logic   [NUM_WAYS-1:0]   dirty_d_out1;

    logic                lru_web0;
    logic   [PLRU-1:0]   lru_in0;

    logic                lru_web1;
    logic   [PLRU-1:0]   lru_in1;
    //logic   [2:0]   lru_out;

    logic           csb_s;
    //logic           debug;

    // control unit
    logic               dirty;
    logic               valid;
    logic               hit;
    logic   [LRU_D-1:0] way_hit;

    // LRU
    logic   [LRU_D-1:0]     idx; // new
    logic   [LRU_D-1:0]     idx_d; // new
    logic   [PLRU-1:0]      lru_raw0; 
    logic   [LRU_D-1:0]     lru_decode;

    logic   [PLRU-1:0]      lru_raw1; 

    logic                   dfp_resp_d;
    logic                   dfp_resp_alloc;
    logic                   dfp_resp_wb;

    // Line Buffer
    // logic [255:0] lb_data_reg;
    // logic [255:0] lb_data;
    // logic [31:0] lb_addr_reg;
    // logic [31:0] lb_addr;
    // logic [TAG_SIZE-1:0] lb_tag;
    // logic [SETS_SIZE-1:0] lb_set;

    // assign lb_tag = lb_addr_reg[31:OFFSET_SIZE+SETS_SIZE];
    // assign lb_set = lb_addr_reg[OFFSET_SIZE+SETS_SIZE-1:OFFSET_SIZE];


    //assign tag = ufp_addr_reg[31:OFFSET_SIZE+SETS_SIZE];
    //assign set = ufp_addr_reg[OFFSET_SIZE+SETS_SIZE-1:OFFSET_SIZE];
    //assign offset = ufp_addr_reg[OFFSET_SIZE-1:0];


    logic stall;
    logic request_read, request_write;
    //logic clk0;

    assign request_read = (|ufp_rmask && (ufp_wmask == 4'b0000));
    assign request_write = (|ufp_wmask && (ufp_rmask == 4'b0000));
    //assign clk0 = clk&!csb_s;

    generate for (genvar i = 0; i < NUM_WAYS; i++) begin : arrays
        mp_cache_data_array_p data_array (
            .clk0       (clk),
            .csb0       (csb_s), // always select?
            .web0       (web_way_data0[i]),
            .wmask0     (data_wmask0[i]), // wmask
            .addr0      (data_addr_read), // addr (idx) 
            .din0       (data_d_in0[i]), // data in 
            .dout0      (data_d_out0[i]), // data out 
            .clk1       (clk),
            .csb1       (csb_s),
            .web1       (web_way_data1[i]),
            .wmask1     (data_wmask1[i]), // wmask
            .addr1      (data_addr_write),
            .din1       (data_d_in1[i]),
            .dout1      (data_d_out1[i])

        );
        mp_cache_tag_array_p tag_array (
            .clk0       (clk),
            .csb0       (csb_s),
            .web0       (web_way_tag0[i]),
            .addr0      (data_addr_read),
            .din0       (tag_d_in0[i]),
            .dout0      (tag_d_out0[i]),
            .clk1       (clk),
            .csb1       (csb_s),
            .web1       (web_way_tag1[i]),
            .addr1      (data_addr_write),
            .din1       (tag_d_in1[i]),
            .dout1      (tag_d_out1[i])
        );
        sp_ff_array_p #(
            .S_INDEX    (SETS_SIZE),
            .WIDTH      (1)
        ) valid_array (
            .clk0       (clk),
            .rst0       (rst),
            .csb0       (csb_s),
            .web0       (web_way_valid0[i]),
            .addr0      (data_addr_read),
            .din0       (valid_d_in0[i]),
            .dout0      (valid_d_out0[i]),
            //.clk1       (clk),
            .rst1       (rst),
            .csb1       (csb_s),
            .web1       (web_way_valid1[i]),
            .addr1      (data_addr_write),
            .din1       (valid_d_in1[i]),
            .dout1      (valid_d_out1[i])
        );
        sp_ff_array_p #(
            .S_INDEX    (SETS_SIZE),
            .WIDTH      (1)
        ) dirty_array (
            .clk0       (clk),
            .rst0       (rst),
            .csb0       (csb_s),
            .web0       (web_way_dirty0[i]),
            .addr0      (data_addr_read),
            .din0       (dirty_d_in0[i]),
            .dout0      (dirty_d_out0[i]),
            //.clk1       (clk),
            .rst1       (rst),
            .csb1       (csb_s),
            .web1       (web_way_dirty1[i]),
            .addr1      (data_addr_write),
            .din1       (dirty_d_in1[i]),
            .dout1      (dirty_d_out1[i])
        );
    end endgenerate

    sp_ff_array_p #(
        .S_INDEX    (SETS_SIZE),
        .WIDTH      (PLRU)
    ) lru_array (
        .clk0       (clk),
        .rst0       (rst),
        .csb0       ('0),
        .web0       (lru_web0),
        .addr0      (data_addr_read),
        .din0       (lru_in0),
        .dout0      (lru_raw0),
        //.clk1       (clk),
        .rst1       (rst),
        .csb1       ('0),
        .web1       (lru_web1),
        .addr1      (data_addr_write),
        .din1       (lru_in1),
        .dout1      (lru_raw1)
    );


    /*
    typedef struct packed {
        logic                   valid;
        logic [31:0]            ufp_addr;
        addr_t                  addr_dec;
        logic [LRU_D-1:0]       hit_way;
        logic                   hit;
        logic                   dirty;
        logic                   valid_read;
    } stage_reg_t; */


    assign data_addr_read = stall ? cache_stage.addr_dec.set : cache_stage_next.addr_dec.set; // ternary with web instead


    always_comb begin
        cache_stage_next = '0;
        if ((request_read | request_write)) begin
            cache_stage_next.valid = '1; 

            cache_stage_next.ufp_addr = ufp_addr; 
            cache_stage_next.ufp_rmask = ufp_rmask;
            cache_stage_next.ufp_wmask = ufp_wmask;
            cache_stage_next.ufp_wdata = ufp_wdata;

            cache_stage_next.addr_dec.tag = ufp_addr[31:OFFSET_SIZE+SETS_SIZE];
            cache_stage_next.addr_dec.set = ufp_addr[OFFSET_SIZE+SETS_SIZE-1:OFFSET_SIZE];
            cache_stage_next.addr_dec.offset = ufp_addr[OFFSET_SIZE-1:0];

            cache_stage_next.dfp_resp_alloc = '0;
            cache_stage_next.dfp_resp_wb = '0;

            cache_stage_next.hit_way = '0; 
            cache_stage_next.hit = '0; 
            cache_stage_next.dirty = '0; 
            cache_stage_next.valid_read = '0; 
        end
        // else if (request_write) begin
        //     cache_stage_next.valid = '1; 

        //     cache_stage_next.ufp_addr = ufp_addr; 
        //     cache_stage_next.ufp_rmask = ufp_rmask;
        //     cache_stage_next.ufp_wmask = ufp_wmask;
        //     cache_stage_next.ufp_wdata = ufp_wdata;

        //     cache_stage_next.addr_dec.tag = ufp_addr[31:OFFSET_SIZE+SETS_SIZE];
        //     cache_stage_next.addr_dec.set = ufp_addr[OFFSET_SIZE+SETS_SIZE-1:OFFSET_SIZE];
        //     cache_stage_next.addr_dec.offset = ufp_addr[OFFSET_SIZE-1:0];

        //     cache_stage_next.dfp_resp = '0;

        //     cache_stage_next.hit_way = '0; 
        //     cache_stage_next.hit = '0; 
        //     cache_stage_next.dirty = '0; 
        //     cache_stage_next.valid_read = '0; 
        // end
    end

    always_ff @ (posedge clk) begin
        if (rst) begin
            dfp_resp_d <= '0;
        end
        else begin
            dfp_resp_d <= dfp_resp;
        end

    end


    always_ff @ (posedge clk) begin
        if (rst) begin
            cache_stage <= '0;
            cache_stage.ufp_addr <= 32'hAAAAA000;
            cache_stage.addr_dec.tag <= 23'h555550;
            cache_stage.addr_dec.set <= 4'b0;
            cache_stage.addr_dec.offset <= 5'b0;
        end
        else if (!stall && !dfp_resp_d) begin
            cache_stage <= cache_stage_next;
        end
        else if (stall && dfp_resp_alloc) begin
            cache_stage.dfp_resp_alloc <= '1;
        end
        else if (stall && dfp_resp_wb) begin
            cache_stage.dfp_resp_wb <= '1;
        end
    end


    always_comb begin
        // to cpu
        ufp_rdata = 32'b0;
        ufp_resp = 1'b0;

        // to bmem
        dfp_addr = 32'b0;
        dfp_read = 1'b0;
        dfp_write = 1'b0;
        dfp_wdata = 256'b0;

        // if (cache_stage_next.valid | cache_stage.valid) begin
        //     csb_s = '0; // always on for now
        // end
        // else begin
        //     csb_s = '1;
        // end
        csb_s = '0;
        lru_web0 = 1'b1;
        lru_web1 = 1'b1;
        stall = 1'b0;
        lru_in0 = '0;

        data_addr_write = '0;

        dfp_resp_alloc = '0;
        dfp_resp_wb = '0;

        for (integer unsigned i = 0; i < NUM_WAYS; i++) begin
            data_wmask0[i] = '0;
            data_d_in0[i] = '0;
            web_way_data0[i] = '1; // active low!!
            tag_d_in0[i] = '0;
            web_way_tag0[i] = '1;
            valid_d_in0[i] = '0;
            web_way_valid0[i] = '1;
            dirty_d_in0[i] = '0;
            web_way_dirty0[i] = '1;

            data_wmask1[i] = '0;
            data_d_in1[i] = '0;
            web_way_data1[i] = '1; // active low!!
            tag_d_in1[i] = '0;
            web_way_tag1[i] = '1;
            valid_d_in1[i] = '0;
            web_way_valid1[i] = '1;
            dirty_d_in1[i] = '0;
            web_way_dirty1[i] = '1;
        end


        hit = 1'b0;
        way_hit = '0;
        for (integer unsigned i = 0; i < NUM_WAYS; i++) begin // check all tags against our tag
            if ((cache_stage.addr_dec.tag == tag_d_out0[i]) && valid_d_out0[i] && cache_stage.valid) begin
                hit = 1'b1;
                way_hit = LRU_D'(i);
            end
        end

        if (hit && cache_stage.valid) begin
            lru_web1 = 1'b0;
            data_addr_write = cache_stage.addr_dec.set;
            if (|cache_stage.ufp_rmask && (cache_stage.ufp_wmask == 4'b0000)) begin
                ufp_resp = 1'b1;
                ufp_rdata = '0;
                for (integer unsigned i = 0; i < 4; i++) begin
                    if (cache_stage.ufp_rmask[i]) begin
                        ufp_rdata[unsigned'(i)*8+:8] = data_d_out0[way_hit][((cache_stage.addr_dec.offset*8)+(unsigned'(i)*8))+:8]; 
                    end
                end

                // STORE THIS DATA IN A LINE BUFFER HERE
                //lb_data = data_d_out[way_hit];
                //lb_addr = ufp_addr_reg;
                
                //ufp_rdata = data_d_out0[way_hit];
            end
            else if (|cache_stage.ufp_wmask && (cache_stage.ufp_rmask == 4'b0000)) begin
                //csb_s = '0;
                //data_addr = cache_stage.addr_dec.set;
                ufp_resp = 1'b1;
                data_addr_write = cache_stage.addr_dec.set;
                data_wmask1[way_hit] = '0;
                data_wmask1[way_hit][cache_stage.addr_dec.offset+:4] = cache_stage.ufp_wmask; 
                data_d_in1[way_hit] = '0;
                data_d_in1[way_hit][cache_stage.addr_dec.offset*8+:32] = cache_stage.ufp_wdata;
                web_way_data1[way_hit] = '0;

                // tag_d_in[way_hit] = tag; dont need to write tag during a hit
                // web_way_tag[way_hit] = '0;

                dirty_d_in1[way_hit] = '1;
                web_way_dirty1[way_hit] = '0;
            end
        end
        else if (cache_stage.valid) begin
            // first check if dirty
            if (dirty && !cache_stage.dfp_resp_wb) begin
                // need to write back first
                // dont do yet, icache cant be dirty ever anyway
                stall = '1;

                dfp_write = '1;
                dfp_addr = {tag_d_out0[lru_decode], cache_stage.addr_dec.set, 5'b00000};
                dfp_wdata = data_d_out0[lru_decode];
                if (dfp_resp) begin
                    // block was written
                    dfp_resp_wb = '1;
                end
            end
            else if (dirty && cache_stage.dfp_resp_wb && !cache_stage.dfp_resp_alloc) begin
                // ask memory
                // check if reg is valid
                stall = '1;

                dfp_read = '1;
                dfp_addr = {cache_stage.addr_dec.tag, cache_stage.addr_dec.set, 5'b00000};
                //data_addr = set;
                if (dfp_resp) begin
                    // write block to data array after the read
                    // dfp_read = '0;
                    // dfp_addr = '0;
                    dfp_resp_alloc = '1;
                    csb_s = '0;
                    data_addr_write = cache_stage.addr_dec.set;
                    data_wmask1[lru_decode] = '1;
                    data_d_in1[lru_decode] = dfp_rdata;
                    web_way_data1[lru_decode] = '0;

                    tag_d_in1[lru_decode] = cache_stage.addr_dec.tag;
                    web_way_tag1[lru_decode] = '0;

                    valid_d_in1[lru_decode] = '1;
                    web_way_valid1[lru_decode] = '0;

                    dirty_d_in1[lru_decode] = '0;
                    web_way_dirty1[lru_decode] = '0;

                end
            end
            else if (!dirty && !cache_stage.dfp_resp_alloc)begin
                // ask memory
                // check if reg is valid
                stall = '1;

                dfp_read = '1;
                dfp_addr = {cache_stage.addr_dec.tag, cache_stage.addr_dec.set, 5'b00000};
                //data_addr = set;
                if (dfp_resp) begin
                    // write block to data array after the read
                    // dfp_read = '0;
                    // dfp_addr = '0;
                    dfp_resp_alloc = '1;
                    csb_s = '0;
                    data_addr_write = cache_stage.addr_dec.set;
                    data_wmask1[lru_decode] = '1;
                    data_d_in1[lru_decode] = dfp_rdata;
                    web_way_data1[lru_decode] = '0;

                    tag_d_in1[lru_decode] = cache_stage.addr_dec.tag;
                    web_way_tag1[lru_decode] = '0;

                    valid_d_in1[lru_decode] = '1;
                    web_way_valid1[lru_decode] = '0;

                    dirty_d_in1[lru_decode] = '0;
                    web_way_dirty1[lru_decode] = '0;

                end
            end
        end
    end


    // always_ff @(posedge clk) begin
    //     if (rst | flush) begin
    //         lb_data_reg <= '0;
    //         lb_addr_reg <= '0;
    //     end else if (hit) begin
    //         lb_data_reg <= lb_data;
    //         lb_addr_reg <= lb_addr;
    //     end
    // end

    // always_ff @(posedge clk) begin
    //     if (rst | flush)
    //         ufp_addr_reg2 <= 32'hAAAAA000;
    //     else if (|ufp_rmask)
    //         ufp_addr_reg2 <= ufp_addr;
    // end

    // always_ff @(posedge clk) begin
    //     if (rst | flush) begin
    //         state <= idle;
    //         ufp_addr_reg <= 32'hAAAAA000;
    //         ufp_rmask_reg <= '0;
    //         ufp_wmask_reg <= '0;
    //         ufp_wdata_reg <= '0;
    //     end
    //     else begin
    //         state <= state_next;
    //         ufp_addr_reg <= ufp_addr;
    //         ufp_rmask_reg <= ufp_rmask;
    //         ufp_wmask_reg <= ufp_wmask;
    //         ufp_wdata_reg <= ufp_wdata;
    //     end
    // end

    assign dirty = dirty_d_out0[lru_decode]; // find dirty status of least recently used
    //assign valid = valid_d_out[0]; //ufp_addr_reg[8:5] NOT USED
    //assign debug = tag == tag_d_out[0] ? 1'b1 : 1'b0;

    // always_comb begin
    //     state_next = state;
    //     ufp_resp = 1'b0;
    //     hit = 1'b0;
    //     //dirty = 'x;
    //     //valid = '0;
    //     data_addr = '0;
    //     // data_wmask[0] = '0;
    //     // data_wmask[1] = '0;
    //     // data_wmask[2] = '0;
    //     // data_wmask[3] = '0;
    //     for (integer unsigned i = 0; i < NUM_WAYS; i++) begin
    //         data_wmask[i] = '0;
    //         data_d_in[i] = '0;
    //         web_way_data[i] = '1; // active low!!
    //         tag_d_in[i] = '0;
    //         web_way_tag[i] = '1;
    //         valid_d_in[i] = '0;
    //         web_way_valid[i] = '1;
    //         dirty_d_in[i] = '0;
    //         web_way_dirty[i] = '1;
    //     end
    //     lru_web = '1;
    //     ufp_rdata = 'x;
    //     way_hit = '0; // or '0?
    //     csb_s = '1;

    //     dfp_read = '0;
    //     dfp_write = '0;
    //     dfp_addr = '0;
    //     dfp_wdata = 'x;

    //     lb_data = '0;
    //     lb_addr = '0;
    //     unique case (state)
    //         idle: begin
    //             //csb_s = '0;
    //             ufp_resp = '0;
    //             if (|ufp_wmask && (ufp_rmask == 4'b0000)) begin // valid CPU request
    //                 csb_s = '0;
    //                 data_addr = ufp_addr[OFFSET_SIZE+SETS_SIZE-1:OFFSET_SIZE];
    //                 state_next = compare;
    //             end
    //             else if (|ufp_rmask && (ufp_wmask == 4'b0000)) begin // valid CPU request
    //                 csb_s = '0;

    //                 // CHECK TO SEE IF LINE BUFFER AND UFP ADDR MATCH (TAG TOO?) IF SO, SEND RESP AND BACK TO IDLE
    //                 // i use ufp_addr directly for tag and set since tag/set are a clock cycle late in register
    //                 if (lb_tag == ufp_addr_reg2[31:OFFSET_SIZE+SETS_SIZE] && lb_set == ufp_addr_reg2[OFFSET_SIZE+SETS_SIZE-1:OFFSET_SIZE]) begin
    //                     ufp_rdata = lb_data_reg;
    //                     ufp_resp = '1;
    //                     state_next = idle;
    //                 end else begin
    //                     data_addr = ufp_addr[OFFSET_SIZE+SETS_SIZE-1:OFFSET_SIZE];
    //                     state_next = compare;
    //                 end
    //             end
    //         end
    //         compare: begin
    //             //hit = 1'b0;
    //             csb_s = '0;
    //             data_addr = set;
    //             //if (valid) begin
    //             hit = 1'b0;
    //             for (integer unsigned i = 0; i < NUM_WAYS; i++) begin // check all tags against our tag
    //                 if ((tag == tag_d_out[i]) && valid_d_out[i]) begin
    //                     hit = 1'b1;
    //                     way_hit = LRU_D'(i);
    //                 end
    //             end
    //             if (hit) begin
    //                 lru_web = 1'b0;
    //                 if (|ufp_rmask_reg && (ufp_wmask_reg == 4'b0000)) begin
    //                     // ufp_rdata = 'x;
    //                     // for (integer unsigned i = 0; i < 4; i++) begin
    //                     //     if (ufp_rmask_reg[i]) begin
    //                     //         ufp_rdata[unsigned'(i)*8+:8] = data_d_out[way_hit][((offset*8)+(unsigned'(i)*8))+:8]; 
    //                     //     end
    //                     // end

    //                     // STORE THIS DATA IN A LINE BUFFER HERE
    //                     lb_data = data_d_out[way_hit];
    //                     lb_addr = ufp_addr_reg;

    //                     ufp_rdata = data_d_out[way_hit];
    //                 end
    //                 else if (|ufp_wmask_reg && (ufp_rmask_reg == 4'b0000)) begin
    //                     csb_s = '0;
    //                     data_addr = set;
    //                     data_wmask[way_hit] = '0;
    //                     data_wmask[way_hit][offset+:4] = ufp_wmask_reg; 
    //                     data_d_in[way_hit] = 'x;
    //                     data_d_in[way_hit][offset*8+:32] = ufp_wdata_reg;
    //                     web_way_data[way_hit] = '0;

    //                     tag_d_in[way_hit] = tag;
    //                     web_way_tag[way_hit] = '0;

    //                     dirty_d_in[way_hit] = '1;
    //                     web_way_dirty[way_hit] = '0;

    //                 end
    //                 ufp_resp = 1'b1;
    //                 state_next = idle;
    //             end
    //             else begin
    //                 if (dirty) begin
    //                     data_addr = set; // prepare to read from data array
    //                     state_next = write_back;
    //                 end
    //                 else begin
    //                     state_next = allocate;
    //                 end
    //             end
                
    //         end
    //         allocate: begin
    //             // read block
    //             dfp_read = '1;
    //             dfp_addr = {tag, set, 5'b00000};
    //             data_addr = set;
    //             state_next = allocate;
    //             if (dfp_resp) begin
    //                 // write block to data array after the read
    //                 csb_s = '0;
    //                 data_addr = set;
    //                 data_wmask[lru_decode] = '1;
    //                 data_d_in[lru_decode] = dfp_rdata;
    //                 web_way_data[lru_decode] = '0;

    //                 tag_d_in[lru_decode] = tag;
    //                 web_way_tag[lru_decode] = '0;

    //                 valid_d_in[lru_decode] = '1;
    //                 web_way_valid[lru_decode] = '0;

    //                 dirty_d_in[lru_decode] = '0;
    //                 web_way_dirty[lru_decode] = '0;

    //                 state_next = idle;
    //             end
    //             //else if (!dfp_resp) begin
    //                 //state_next = allocate;
    //             //end
    //         end
    //         write_back: begin
    //             // read from data, tag array, send to memory
    //             csb_s = '0;
    //             data_addr = set;
    //             dfp_write = '1;
    //             dfp_addr = {tag_d_out[lru_decode], set, 5'b00000};
    //             dfp_wdata = data_d_out[lru_decode];
    //             if (dfp_resp) begin
    //                 // write block to memory
    //                 state_next = allocate;
    //             end
    //         end
    //         default: begin

    //         end

    //     endcase


    // end



    // LRU Logic
    // always_comb begin
    //     idx = LRU_D'(0);
    //     lru_in = lru_raw;
    //     for (integer i = 0; i < LRU_D; i++) begin
    //         lru_in[idx] = ~way_hit[LRU_D'(unsigned'(((LRU_D-1)-i)))];
    //         if (way_hit[LRU_D'(unsigned'(((LRU_D-1)-i)))]) begin
    //             idx = idx + 1'b1;
    //         end
    //         else begin
    //             idx = idx + LRU_D'(unsigned'(((NUM_WAYS/(2*(i+1))))));
    //         end
    //     end
    // end

    // always_comb begin
    //     idx_d = LRU_D'(0);
    //     lru_decode = LRU_D'(0);
    //     for (integer i = 0; i < LRU_D; i++) begin
    //         lru_decode[LRU_D'(unsigned'(((LRU_D-1)-i)))] = lru_raw[idx_d];
    //         if (lru_raw[idx_d]) begin
    //             idx_d = idx_d + 1'b1;
    //         end
    //         else begin
    //             idx_d = idx_d + LRU_D'(unsigned'(((NUM_WAYS/(2*(i+1))))));
    //         end
    //     end

    // end



    // LRU decode - which to replace
    always_comb begin
        unique case (way_hit) // only accurate when want to write to LRU anyway
            2'b11: lru_in1 = {lru_raw0[2], 1'b0, 1'b0}; // Way A = Way 3
            2'b10: lru_in1 = {lru_raw0[2], 1'b1, 1'b0}; // Way B = Way 2
            2'b01: lru_in1 = {1'b0, lru_raw0[1], 1'b1}; // Way C = Way 1
            2'b00: lru_in1 = {1'b1, lru_raw0[1], 1'b1}; // Way D = Way 0
            default: lru_in1 = lru_raw0;
        endcase

        unique casez (lru_raw0)
            3'b0?0: lru_decode = 2'd0; // Way D = Way 0
            3'b1?0: lru_decode = 2'd1; // Way C = Way 1
            3'b?01: lru_decode = 2'd2; // Way B = Way 2
            3'b?11: lru_decode = 2'd3; // Way A = Way 3
            default: lru_decode = 2'd0; // default?
        endcase
    end

endmodule : cache_pipe_d