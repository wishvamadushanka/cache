module cache (
    c_busywait_o, c_data_o, reset_i, clk_i, address_i
);
    parameter c_line_size = 32, c_assiotivity = 1, c_index = 4, c_block_size = 2; // cache line size, assiotivity, index size, block size
    parameter c_tag_size = c_line_size - c_index - c_block_size - 2;
    integer i, j;

    input reset_i, clk_i;
    input [c_line_size - 1:0] address_i;

    output reg [c_line_size - 1:0] c_data_o;
    output reg c_busywait_o;


    reg [c_line_size - 1 : 0] c_word[0 : (2**c_index) - 1][0 : (2**c_assiotivity) - 1][0 : (2**c_block_size) - 1]; //cache word
    reg [c_tag_size - 1 : 0] c_tag[0 : (2**c_index) - 1][0 : (2**c_assiotivity) - 1];  //cache tag
    reg c_valid_bit [0 : (2**c_index) - 1][0 : (2**c_assiotivity) - 1]; //cache valid bit

    wire [c_block_size - 1:0] offset_addr;
    wire [c_index - 1:0] index_addr;
    wire [c_tag_size - 1:0] tag_addr;


    reg valid_bit_frm_c [0 : (2**c_assiotivity) - 1], hit_frm_c [0 : (2**c_assiotivity) - 1], hit_frm_c_AND_valid_bit_frm_c [0 : (2**c_assiotivity) - 1];
    reg [c_tag_size - 1:0] tag_frm_c [0 : (2**c_assiotivity) - 1];
    reg [c_line_size - 1 : 0] data_frm_c [0 : (2**c_assiotivity) - 1];

    reg [c_assiotivity - 1 : 0] hit_cache_assiotivity;
    reg c_hit;


    //{tag_addr:}{index_addr:}{offset_addr:}{2}
    assign offset_addr = address_i[c_block_size + 1:2];
    assign index_addr = address_i[c_index + c_block_size + 1:c_block_size + 2];
    assign tag_addr = address_i[c_line_size - 1:c_index + c_block_size + 2];


    always @(*) begin
        c_hit = 1'b0;
        for (i = 0; i < c_assiotivity; i = i + 1) begin
            valid_bit_frm_c[i] = c_valid_bit[index_addr][i];
            tag_frm_c[i] = c_tag[index_addr][i];
            hit_frm_c[i] = (tag_addr === tag_frm_c[i]) ? 1'b1 : 1'b0;
            hit_frm_c_AND_valid_bit_frm_c[i] = valid_bit_frm_c[i] && hit_frm_c[i];
            data_frm_c[i] = c_word[index_addr][i][offset_addr];

            if (hit_frm_c_AND_valid_bit_frm_c[i]) begin
                c_hit = 1'b1;
                c_data_o = data_frm_c[i]; 
            end
            // else
            // begin
            //     hit = 1'b0;
            // end

        end
    end

    //busy wait
    always @(posedge clk_i) begin
        if (!c_hit) 
            c_busywait_o = 1'b1;
        else
            c_busywait_o = 1'b0;
    end

    

    always @(posedge clk_i, reset_i)
    begin
        if(reset_i)
        begin
            for (i = 0; i < 2**c_index; i = i + 1) begin
                for (j = 0; j < 2**c_assiotivity; j = j + 1) begin
                    c_valid_bit[i][j] = 0;
                end
            end
        end
        else
        begin
            //need to integreate
            for (i = 0; i < 2**c_index; i = i + 1) begin
                for (j = 0; j < 2**c_assiotivity; j = j + 1) begin
                    c_valid_bit[9][0] = 0;
                    c_tag[9][0] = 24'h800001;
                    c_word[9][0][2] = 32'b11;
                end
            end
        end
    end
    

endmodule