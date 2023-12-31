module cache (
    busywait, data, reset, clk, address
);
    input reset, clk;
    input [line_size - 1:0] address;

    output reg [line_size - 1:0] data;
    output busywait;

    parameter line_size = 32, assiotivity = 1, index_depth = 4, offset_size = 2;
    parameter tag_size = line_size - index_depth - offset_size - 2;
    integer i, j;

    reg [line_size - 1 : 0] word_reg[0 : (2**index_depth) - 1][0 : (2**assiotivity) - 1][0 : (2**offset_size) - 1];
    reg [tag_size - 1 : 0] tag_reg[0 : (2**index_depth) - 1][0 : (2**assiotivity) - 1];
    reg valid_bit_reg [0 : (2**index_depth) - 1][0 : (2**assiotivity) - 1];

    wire [offset_size - 1:0] offset;
    wire [index_depth - 1:0] index;
    wire [tag_size - 1:0] tag;


    reg valid_assiotivity [0 : (2**assiotivity) - 1], hit_tag_assiotivity [0 : (2**assiotivity) - 1], hit_AND_valid [0 : (2**assiotivity) - 1];
    reg [tag_size - 1:0] tag_assiotivity [0 : (2**assiotivity) - 1];
    reg [line_size - 1 : 0] data_cache [0 : (2**assiotivity) - 1];

    reg [assiotivity - 1 : 0] hit_cache_assiotivity;
    reg hit;


    //{tag:}{index:}{offset:}{2}
    assign offset = address[offset_size + 1:2];
    assign index = address[index_depth + offset_size + 1:offset_size + 2];
    assign tag = address[line_size - 1:index_depth + offset_size + 2];


    always @(*) begin
        hit = 1'b0;
        for (i = 0; i < assiotivity; i = i + 1) begin
            valid_assiotivity[i] = valid_bit_reg[index][i];
            tag_assiotivity[i] = tag_reg[index][i];
            hit_tag_assiotivity[i] = (tag === tag_assiotivity[i]) ? 1'b1 : 1'b0;
            hit_AND_valid[i] = valid_assiotivity[i] && hit_tag_assiotivity[i];
            data_cache[i] = word_reg[index][i][offset];

            if (hit_AND_valid[i]) begin
                hit = 1'b1;
                data = data_cache[i]; 
            end
            // else
            // begin
            //     hit = 1'b0;
            // end

        end
    end

    always @(posedge clk, reset)
    begin
        if(reset)
        begin
            for (i = 0; i < 2**index_depth; i = i + 1) begin
                for (j = 0; j < 2**assiotivity; j = j + 1) begin
                    valid_bit_reg[i][j] = 0;
                end
            end
        end
        else
        begin
            //need to integreate
            for (i = 0; i < 2**index_depth; i = i + 1) begin
                for (j = 0; j < 2**assiotivity; j = j + 1) begin
                    valid_bit_reg[9][0] = 0;
                    tag_reg[9][0] = 24'h800001;
                    word_reg[9][0][2] = 32'b11;
                end
            end
        end
    end
    

endmodule