module cache (
    busywait, data, reset, clk, address
);
    input reset, clk;
    input [line_size - 1:0] address;

    output reg [line_size - 1:0] data;
    output busywait;

    parameter line_size = 32, assiotivity = 2, index_depth = 4, offset_size = 2;
    parameter tag_size = line_size - index_depth - offset_size - 2;


    reg [line_size - 1 : 0] word_reg[0 : (2**index_depth) - 1][0 : (2**assiotivity) - 1][0 : (2**offset_size) - 1];
    reg [tag_size - 1 : 0] tag_reg[0 : (2**index_depth) - 1][0 : (2**assiotivity) - 1];
    reg valid_bit_reg [0 : (2**index_depth) - 1][0 : (2**assiotivity) - 1];

    wire valid, hit;
    wire [offset_size - 1:0] offset;
    wire [index_depth - 1:0] index;
    wire [tag_size - 1:0] tag;

    //{tag:}{index:}{offset:}{2}
    assign offset = address[offset_size + 1:2];
    assign index = address[index_depth + offset_size + 1:offset_size + 2];
    assign tag = address[line_size - 1:index_depth + offset_size + 2];

    // assign valid = valid_bit_reg[index];
    genvar v_b;
    generate for (v_b = 0; v_b < 2**assiotivity; v_b = v_b + 1)
        begin : valid_bit_assiotivity
            wire valid_b;
            assign valid_b = valid_bit_reg[index][v_b];
        end
    endgenerate



    // always @() begin
        
    // end



endmodule