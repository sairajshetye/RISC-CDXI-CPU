module cache_mod (
    input   logic           clk,
    input   logic           rst,
    input   logic           flush,

    // cpu side signals, ufp -> upward facing port
    input   logic   [31:0]  ufp_addr,
    input   logic   [3:0]   ufp_rmask,
    input   logic   [3:0]   ufp_wmask,
    output  logic   [255:0] ufp_rdata,
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

     enum logic [1:0] {
        idle,
        compare,
        allocate,
        write_back
    } state, state_next;

    logic   [22:0]  tag;
    logic   [3:0]   set;
    logic   [4:0]   offset;

    logic   [31:0]  ufp_addr_reg;
    logic   [31:0]  ufp_addr_reg2;
    logic   [3:0]   ufp_rmask_reg;
    logic   [3:0]   ufp_wmask_reg;
    logic   [31:0]  ufp_wdata_reg;
    
    logic   [3:0]   web_way_data;
    logic   [3:0]   web_way_data_cache;
    logic   [3:0]   web_way_tag;
    logic   [3:0]   web_way_valid;
    logic   [3:0]   web_way_dirty;

    logic   [3:0]   data_addr; // index addr[8:5]
    logic   [255:0] data_d_in [4];
    logic   [255:0] data_d_out [4];
    logic   [31:0]  data_wmask [4];
    logic   [4:0]   data_offset;

    logic   [22:0]  tag_d_in [4];
    logic   [22:0]  tag_d_out [4];

    logic   [3:0]   valid_d_in;
    logic   [3:0]   valid_d_out;

    logic   [3:0]   dirty_d_in;
    logic   [3:0]   dirty_d_out;

    logic   [255:0] data_mem_in;
    logic   [255:0] data_mem_out [4];

    logic           lru_web;
    logic   [2:0]   lru_in;
    //logic   [2:0]   lru_out;

    logic           csb_s;
    logic           debug;

    // control unit
    logic           dirty;
    logic           valid;
    logic           hit;
    logic   [1:0]   way_hit;

    // LRU
    logic   [2:0]   lru_raw; 
    logic   [1:0]   lru_decode;

    // Line Buffer
    logic [255:0] lb_data_reg;
    logic [255:0] lb_data;
    logic [31:0] lb_addr_reg;
    logic [31:0] lb_addr;
    logic [22:0] lb_tag;
    logic [3:0] lb_set;

    assign lb_tag = lb_addr_reg[31:9];
    assign lb_set = lb_addr_reg[8:5];


    assign tag = ufp_addr_reg[31:9];
    assign set = ufp_addr_reg[8:5];
    assign offset = ufp_addr_reg[4:0];

    generate for (genvar i = 0; i < 4; i++) begin : arrays
        mp_cache_data_array data_array (
            .clk0       (clk),
            //.rst0       (rst),
            .csb0       (csb_s), // always select?
            .web0       (web_way_data[i]),
            .wmask0     (data_wmask[i]), // wmask
            .addr0      (data_addr), // addr (idx) 
            //.offset0    (data_offset),
            .din0       (data_d_in[i]), // data in 
            .dout0      (data_d_out[i]) // data out 

            //.csb1       ('0),
            //.web1       (web_way_data_cache[i]),
            //.addr1      (data_addr),
            //.din1       (data_mem_in),
            //.dout1      (data_mem_out[i])

        );
        mp_cache_tag_array tag_array (
            .clk0       (clk),
            //.rst0       (rst),
            .csb0       (csb_s),
            .web0       (web_way_tag[i]),
            .addr0      (data_addr),
            .din0       (tag_d_in[i]),
            .dout0      (tag_d_out[i])
        );
        sp_ff_array valid_array (
            .clk0       (clk),
            .rst0       (rst),
            .csb0       (csb_s),
            .web0       (web_way_valid[i]),
            .addr0      (data_addr),
            .din0       (valid_d_in[i]),
            .dout0      (valid_d_out[i])
        );
        sp_ff_array dirty_array (
            .clk0       (clk),
            .rst0       (rst),
            .csb0       (csb_s),
            .web0       (web_way_dirty[i]),
            .addr0      (data_addr),
            .din0       (dirty_d_in[i]),
            .dout0      (dirty_d_out[i])
        );
    end endgenerate

    sp_ff_array #(
        .WIDTH      (3)
    ) lru_array (
        .clk0       (clk),
        .rst0       (rst),
        .csb0       ('0),
        .web0       (lru_web),
        .addr0      (data_addr),
        .din0       (lru_in),
        .dout0      (lru_raw)
    );

    /*
    fsm control_unit (
        .*
    );
    */

    always_ff @(posedge clk) begin
        if (rst | flush) begin
            lb_data_reg <= '0;
            lb_addr_reg <= '0;
        end else if (hit) begin
            lb_data_reg <= lb_data;
            lb_addr_reg <= lb_addr;
        end
    end

    always_ff @(posedge clk) begin
        if (rst | flush)
            ufp_addr_reg2 <= 32'hAAAAA000;
        else if (|ufp_rmask)
            ufp_addr_reg2 <= ufp_addr;
    end

    always_ff @(posedge clk) begin
        if (rst | flush) begin
            state <= idle;
            ufp_addr_reg <= 32'hAAAAA000;
            ufp_rmask_reg <= '0;
            ufp_wmask_reg <= '0;
            ufp_wdata_reg <= '0;
        end
        else begin
            state <= state_next;
            ufp_addr_reg <= ufp_addr;
            ufp_rmask_reg <= ufp_rmask;
            ufp_wmask_reg <= ufp_wmask;
            ufp_wdata_reg <= ufp_wdata;
        end
    end

    assign dirty = dirty_d_out[lru_decode]; // find dirty status of least recently used
    assign valid = valid_d_out[0]; //ufp_addr_reg[8:5]
    assign debug = tag == tag_d_out[0] ? 1'b1 : 1'b0;

    always_comb begin
        state_next = state;
        ufp_resp = 1'b0;
        hit = 1'b0;
        //dirty = 'x;
        //valid = '0;
        data_addr = '0;
        // data_wmask[0] = '0;
        // data_wmask[1] = '0;
        // data_wmask[2] = '0;
        // data_wmask[3] = '0;
        for (integer unsigned i = 0; i < 4; i++) begin
            data_wmask[i] = '0;
            data_d_in[i] = '0;
            web_way_data[i] = '1; // active low!!
            tag_d_in[i] = '0;
            web_way_tag[i] = '1;
            valid_d_in[i] = '0;
            web_way_valid[i] = '1;
            dirty_d_in[i] = '0;
            web_way_dirty[i] = '1;
        end
        lru_web = '1;
        ufp_rdata = 'x;
        way_hit = '0; // or '0?
        csb_s = '0;

        dfp_read = '0;
        dfp_write = '0;
        dfp_addr = '0;
        dfp_wdata = 'x;

        lb_data = '0;
        lb_addr = '0;
        unique case (state)
            idle: begin
                //csb_s = '1;
                ufp_resp = '0;
                if (|ufp_wmask && (ufp_rmask == 4'b0000)) begin // valid CPU request
                    csb_s = '0;
                    data_addr = ufp_addr[8:5];
                    state_next = compare;
                end
                else if (|ufp_rmask && (ufp_wmask == 4'b0000)) begin // valid CPU request
                    csb_s = '0;

                    // CHECK TO SEE IF LINE BUFFER AND UFP ADDR MATCH (TAG TOO?) IF SO, SEND RESP AND BACK TO IDLE
                    // i use ufp_addr directly for tag and set since tag/set are a clock cycle late in register
                    if (lb_tag == ufp_addr_reg2[31:9] && lb_set == ufp_addr_reg2[8:5]) begin
                        ufp_rdata = lb_data_reg;
                        ufp_resp = '1;
                        state_next = idle;
                    end else begin
                        data_addr = ufp_addr[8:5];
                        state_next = compare;
                    end
                end
            end
            compare: begin
                //hit = 1'b0;
                //csb_s = '0;
                data_addr = set;
                //if (valid) begin
                hit = 1'b0;
                for (integer unsigned i = 0; i < 4; i++) begin // check all tags against our tag
                    if ((tag == tag_d_out[i]) && valid_d_out[i]) begin
                        hit = 1'b1;
                        way_hit = 2'(i);
                    end
                end
                if (hit) begin
                    lru_web = 1'b0;
                    if (|ufp_rmask_reg && (ufp_wmask_reg == 4'b0000)) begin
                        // ufp_rdata = 'x;
                        // for (integer unsigned i = 0; i < 4; i++) begin
                        //     if (ufp_rmask_reg[i]) begin
                        //         ufp_rdata[unsigned'(i)*8+:8] = data_d_out[way_hit][((offset*8)+(unsigned'(i)*8))+:8]; 
                        //     end
                        // end

                        // STORE THIS DATA IN A LINE BUFFER HERE
                        lb_data = data_d_out[way_hit];
                        lb_addr = ufp_addr_reg;

                        ufp_rdata = data_d_out[way_hit];
                    end
                    else if (|ufp_wmask_reg && (ufp_rmask_reg == 4'b0000)) begin
                        csb_s = '0;
                        data_addr = set;
                        data_wmask[way_hit] = '0;
                        data_wmask[way_hit][offset+:4] = ufp_wmask_reg; 
                        data_d_in[way_hit] = 'x;
                        data_d_in[way_hit][offset*8+:32] = ufp_wdata_reg;
                        web_way_data[way_hit] = '0;

                        tag_d_in[way_hit] = tag;
                        web_way_tag[way_hit] = '0;

                        dirty_d_in[way_hit] = '1;
                        web_way_dirty[way_hit] = '0;

                    end
                    ufp_resp = 1'b1;
                    state_next = idle;
                end
                else begin
                    if (dirty) begin
                        data_addr = set; // prepare to read from data array
                        state_next = write_back;
                    end
                    else begin
                        state_next = allocate;
                    end
                end
                
            end
            allocate: begin
                // read block
                dfp_read = '1;
                dfp_addr = {tag, set, 5'b00000};
                data_addr = set;
                state_next = allocate;
                if (dfp_resp) begin
                    // write block to data array after the read
                    csb_s = '0;
                    data_addr = set;
                    data_wmask[lru_decode] = '1;
                    data_d_in[lru_decode] = dfp_rdata;
                    web_way_data[lru_decode] = '0;

                    tag_d_in[lru_decode] = tag;
                    web_way_tag[lru_decode] = '0;

                    valid_d_in[lru_decode] = '1;
                    web_way_valid[lru_decode] = '0;

                    dirty_d_in[lru_decode] = '0;
                    web_way_dirty[lru_decode] = '0;

                    state_next = idle;
                end
                //else if (!dfp_resp) begin
                    //state_next = allocate;
                //end
            end
            write_back: begin
                // read from data, tag array, send to memory
                data_addr = set;
                dfp_write = '1;
                dfp_addr = {tag_d_out[lru_decode], set, 5'b00000};
                dfp_wdata = data_d_out[lru_decode];
                if (dfp_resp) begin
                    // write block to memory
                    state_next = allocate;
                end
            end
            default: begin

            end

        endcase


    end



    // LRU Logic

    // LRU decode - which to replace
    always_comb begin
        unique case (way_hit) // only accurate when want to write to LRU anyway
            2'b11: lru_in = {lru_raw[2], 1'b0, 1'b0}; // Way A = Way 3
            2'b10: lru_in = {lru_raw[2], 1'b1, 1'b0}; // Way B = Way 2
            2'b01: lru_in = {1'b0, lru_raw[1], 1'b1}; // Way C = Way 1
            2'b00: lru_in = {1'b1, lru_raw[1], 1'b1}; // Way D = Way 0
            default: lru_in = lru_raw;
        endcase

        unique casez (lru_raw)
            3'b0?0: lru_decode = 2'd0; // Way D = Way 0
            3'b1?0: lru_decode = 2'd1; // Way C = Way 1
            3'b?01: lru_decode = 2'd2; // Way B = Way 2
            3'b?11: lru_decode = 2'd3; // Way A = Way 3
            default: lru_decode = 2'd0; // default?
        endcase
    end

endmodule : cache_mod