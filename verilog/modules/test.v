// assign hit = hit_AND_valid;

    // always @(*) begin
        
    // end

    // genvar assiotivity_num;
    // generate for (assiotivity_num = 0; assiotivity_num < 2**assiotivity; assiotivity_num = assiotivity_num + 1)
    //     begin : cache_assiotivity
    //         // wire valid, hit_assiotivity, hit_AND_valid;
    //         // wire [tag_size - 1:0] tag_assiotivity;
    //         // wire [line_size - 1 : 0] data_cache;
    //         assign valid_assiotivity = valid_bit_reg[index][assiotivity_num];
    //         assign tag_assiotivity = tag_reg[index][assiotivity_num];
    //         assign hit_assiotivity = (tag === tag_assiotivity) ? 1'b1 : 1'b0;
    //         assign hit_AND_valid = valid_assiotivity && hit_assiotivity;
    //         assign data_cache = word_reg[index][assiotivity_num][offset];
    //     end
    // endgenerate

    // always @ (*)
    // begin
    //     for (i = 0; i < assiotivity; i = i + 1) begin
    //         if (cache_assiotivity[i].hit_AND_valid)
    //         begin
    //             data = cache_assiotivity[i].data_cache;
    //         end
    //     end
    // end

    // genvar get_;
    // generate for (valid_ass_AND_hit_ass = 0; valid_ass_AND_hit_ass < 2**assiotivity; valid_ass_AND_hit_ass = valid_ass_AND_hit_ass + 1) 
    //     begin : 

    //     end
    // endgenerate