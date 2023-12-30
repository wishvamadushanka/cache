module cache (
    busywait, data, reset, clk, address
);
    input reset, clk;
    input [line_size - 1:0] address;

    output reg [line_size - 1:0] data;
    output busywait;

    parameter line_size = 32, assiotivity = 2, index_depth = 4, offset_size = 2;
    parameter tag_size = line_size - assiotivity - index_depth - offset_size - 2;


    reg [line_size - 1:0] word_reg[0:index_depth - 1][0:offset_size - 1][0:assiotivity - 1];
    reg [tag_size - 1:0] tag_reg[0:index_depth - 1][0:assiotivity - 1];
    reg valid_bit_reg [0:index_depth - 1];

    wire valid, hit;
    wire [offset_size - 1:0] offset;
    wire [index_depth - 1:0] index;
    wire [tag_size - 1:0] tag;

    assign offset = address[offset_size + 2:2];
    assign tag = address[line_size - 1 -(index_depth + offset_size + 2) : index_depth + offset_size + 2];
    assign index = address[index_depth + offset_size + 2:offset_size + 2];

    assign valid = valid_bit_reg[index];



    // always @() begin
        
    // end



endmodule