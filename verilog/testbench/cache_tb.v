`timescale 1ns/1ps

`include "../modules/cache.v"
`include "../modules/memory.v"


module testcache;

    // input reset, clk;
    // input [line_size - 1:0] address;

    // output reg [line_size - 1:0] data;
    // output busywait;
    parameter  c_block_size = 2, c_line_size = 32, address_size = 32;

    wire c_busywait_o;
    wire [c_line_size - 1:0] c_data_o;
    reg [address_size - 1:0] address, c_write_data_i;
    reg clk, reset, c_read_i, c_wr_i;
    integer i,j;
    
    wire c_m_busywait_i, c_m_read_o, c_m_wr_o, m_write_done, m_read_done;
    wire [2**c_block_size*c_line_size - 1 : 0] c_m_read_data_i;
    wire [2**c_block_size*c_line_size - 1 : 0] c_m_write_data_o;
    wire [address_size - c_block_size - 3:0] c_m_address_o;

    //c_busywait_o, c_data_o, c_m_write_data_o, c_m_read_o, c_m_wr_o, c_m_address_o, reset_i, clk_i, address_i, c_read_i, c_wr_i, c_m_busywait_i, c_m_read_data_i
    cache mycache(c_busywait_o, c_data_o, c_m_write_data_o, c_m_read_o, c_m_wr_o, c_m_address_o, reset, clk, address, c_read_i, c_wr_i, c_write_data_i, c_m_busywait_i, c_m_read_data_i, m_write_done, m_read_done);
    //memory module connect
    memory data_memory(c_m_busywait_i, c_m_read_data_i, m_write_done, m_read_done, clk, reset, c_m_read_o, c_m_wr_o, c_m_address_o, c_m_write_data_o);
    //m_busywait_o, m_read_data_o, m_clk_i, m_read_i, m_wr_i, m_reset_i, m_addr_i, m_wr_data_i


	//wavedata file
	initial
	begin
		$dumpfile("wavedata.vcd");
		$dumpvars(0,testcache);
        // $dumpvars(0, mycache.tag_reg[0]);
    
        // for(i = 0; i < 4; i = i + 1)begin
        //     // $dumpvars(0, mycache.c_valid_bit[1][i]);
        //     $dumpvars(0, mycache.c_valid_bit[9][i]);
        // end
        $dumpvars(0, mycache.c_valid_bit[0][0]);
        $dumpvars(0, mycache.c_valid_bit[0][1]);

        $dumpvars(0, mycache.c_tag[0][0]);
        $dumpvars(0, mycache.c_tag[0][1]);

        $dumpvars(0, mycache.c_word[0][0]);

        // $dumpvars(0, mycache.c_word[0][1]);
        $dumpvars(0, mycache.c_usability_bit[0][1]);
        $dumpvars(0, mycache.c_dirty_bit[0][1]);


        ////////


        $dumpvars(0, mycache.c_valid_bit[1][0]);
        $dumpvars(0, mycache.c_valid_bit[1][1]);

        $dumpvars(0, mycache.c_tag[1][0]);
        $dumpvars(0, mycache.c_tag[1][1]);

        $dumpvars(0, mycache.c_word[1][0]);
        // $dumpvars(0, mycache.c_word[0][1]);

        $dumpvars(0, mycache.c_usability_bit[1][1]);

        $dumpvars(0, mycache.c_dirty_bit[1][1]);
        /////////////////


        $dumpvars(0, mycache.valid_bit_frm_c[0]);
        $dumpvars(0, mycache.valid_bit_frm_c[1]);
        $dumpvars(0, mycache.valid_bit_frm_c[2]);
        $dumpvars(0, mycache.valid_bit_frm_c[3]);

        $dumpvars(0, mycache.tag_frm_c[0]);
        $dumpvars(0, mycache.tag_frm_c[1]);
        $dumpvars(0, mycache.tag_frm_c[2]);
        $dumpvars(0, mycache.tag_frm_c[3]);

        $dumpvars(0, mycache.hit_frm_c[0]);
        $dumpvars(0, mycache.hit_frm_c[1]);
        $dumpvars(0, mycache.hit_frm_c[2]);
        $dumpvars(0, mycache.hit_frm_c[3]);

        $dumpvars(0, mycache.hit_frm_c_AND_valid_bit_frm_c[0]);
        $dumpvars(0, mycache.hit_frm_c_AND_valid_bit_frm_c[1]);
        $dumpvars(0, mycache.hit_frm_c_AND_valid_bit_frm_c[2]);
        $dumpvars(0, mycache.hit_frm_c_AND_valid_bit_frm_c[3]);

        $dumpvars(0, mycache.data_frm_c[0]);
        $dumpvars(0, mycache.data_frm_c[1]);
        $dumpvars(0, mycache.data_frm_c[2]);
        $dumpvars(0, mycache.data_frm_c[3]);

        $dumpvars(0, mycache.usability_bit_frm_c[0]);
        $dumpvars(0, mycache.usability_bit_frm_c[1]);
        $dumpvars(0, mycache.usability_bit_frm_c[2]);
        $dumpvars(0, mycache.usability_bit_frm_c[3]);

        $dumpvars(0, mycache.dirty_bit_frm_c[0]);
        $dumpvars(0, mycache.dirty_bit_frm_c[1]);
        $dumpvars(0, mycache.dirty_bit_frm_c[2]);
        $dumpvars(0, mycache.dirty_bit_frm_c[3]);

        $dumpvars(0, data_memory.memory[0]);
        $dumpvars(0, data_memory.memory[1]);
        $dumpvars(0, data_memory.memory[2]);
        $dumpvars(0, data_memory.memory[3]);

        // for(i = 0; i < 2; i = i + 1)begin
        //     // $dumpvars(0, mycache.c_valid_bit[1][i]);
        //     $dumpvars(0, mycache.valid_bit_frm_c[i]);
        //     $dumpvars(0, mycache.tag_frm_c[i]);
        //     $dumpvars(0, mycache.hit_frm_c[i]);
        //     $dumpvars(0, mycache.hit_frm_c_AND_valid_bit_frm_c[i]);
        //     $dumpvars(0, mycache.data_frm_c[i]);
        // end
        
	end

  //clock 
	always 
	begin
		#5	clk = ~clk;
	end

	//running
	initial
	begin
        clk = 1'b1;
        #1
        reset <= 1'b1;

        #1
        reset <= 1'b0;

        #5 
        address <= 32'b000000000000000000000000_0000_11_10;


        c_read_i <= 1'b1;
        c_wr_i <= 1'b0;

        // #
        
        #74
        address <= 32'b000000000000000000000000_0000_10_10;

        #10
        address <= 32'b000000000000000000000000_0001_01_10;
        // address <= 32'd2;


        #80
        address <= 32'b000000000000000000000000_0001_11_10;

        c_read_i <= 1'b0;
        c_wr_i <= 1'b0;


        #10
        address <= 32'b000000000000000000000000_0001_10_10;
        c_write_data_i <= 32'd3;
        c_read_i <= 1'b0;
        c_wr_i <= 1'b1;

        #9
        address <= 32'b000000000000000000000000_0001_10_10;
        c_write_data_i <= 32'd3;
        c_read_i <= 1'b0;
        c_wr_i <= 1'b0;


        #10
        // reset <= 1'b1;

        #10
        #10
        #10
        #10
        #10
        #10
        #10
        #10
        #10
        #10
        #10
        #10
        #10
        #10

        $finish;

	end
		 
endmodule