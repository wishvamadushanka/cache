module cache (
    busywait, data, reset, clk, address
);
    input reset, clk;
    input [line_size - 1:0] address;

    output reg [line_size - 1:0] data;
    output busywait;

    parameter line_size = 32, assiotivity = 0, index_depth = 4, offset_size = 2;
    parameter tag_size = line_size - index_depth - offset_size - 2;
    integer i, j;


    reg [line_size - 1 : 0] word_reg[0 : (2**index_depth) - 1][0 : (2**assiotivity) - 1][0 : (2**offset_size) - 1];
    reg [tag_size - 1 : 0] tag_reg[0 : (2**index_depth) - 1][0 : (2**assiotivity) - 1];
    reg valid_bit_reg [0 : (2**index_depth) - 1][0 : (2**assiotivity) - 1];

    wire [offset_size - 1:0] offset;
    wire [index_depth - 1:0] index;
    wire [tag_size - 1:0] tag;

    wire valid, hit;
    // wire [line_size - 1 : 0] data;

    //{tag:}{index:}{offset:}{2}
    assign offset = address[offset_size + 1:2];
    assign index = address[index_depth + offset_size + 1:offset_size + 2];
    assign tag = address[line_size - 1:index_depth + offset_size + 2];

    genvar assiotivity_num;
    generate for (assiotivity_num = 0; assiotivity_num < 2**assiotivity; assiotivity_num = assiotivity_num + 1)
        begin : cache_assiotivity
            wire valid, hit_assiotivity, hit_AND_valid;
            wire [tag_size - 1:0] tag_assiotivity;
            wire [line_size - 1 : 0] data_cache;
            assign valid_assiotivity = valid_bit_reg[index][assiotivity_num];
            assign tag_assiotivity = tag_reg[index][assiotivity_num];
            assign hit_assiotivity = (tag === tag_assiotivity) ? 1'b1 : 1'b0;
            assign hit_AND_valid = valid_assiotivity && hit_assiotivity;
            assign data_cache = word_reg[index][assiotivity_num][offset];
        end
    endgenerate

    always @ (*)
    begin
        
    end

    // genvar get_;
    // generate for (valid_ass_AND_hit_ass = 0; valid_ass_AND_hit_ass < 2**assiotivity; valid_ass_AND_hit_ass = valid_ass_AND_hit_ass + 1) 
    //     begin : 

    //     end
    // endgenerate

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
                    valid_bit_reg[i][j] = 1;
                end
            end
        end
    end
    

endmodule