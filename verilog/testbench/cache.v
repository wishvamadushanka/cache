`timescale 1ns/1ps

`include "../modules/cache.v"


module testcache;

    // input reset, clk;
    // input [line_size - 1:0] address;

    // output reg [line_size - 1:0] data;
    // output busywait;
    parameter line_size = 32;

    wire busywait;
    wire [line_size - 1:0] data;
    reg [line_size - 1:0] address;
    reg clk,reset;
    integer i,j;
    

    cache mycache(busywait, data, reset, clk, address);

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
        $dumpvars(0, mycache.c_valid_bit[9][0]);
        $dumpvars(0, mycache.c_valid_bit[9][1]);

        $dumpvars(0, mycache.c_tag[9][0]);
        $dumpvars(0, mycache.c_tag[9][1]);

        $dumpvars(0, mycache.c_word[9][0][2]);
        $dumpvars(0, mycache.c_word[9][1][2]);
        $dumpvars(0, mycache.c_word[9][0][3]);
        $dumpvars(0, mycache.c_word[9][1][3]);

        // $dumpvars(0, mycache.c_valid_bit[9][0]);
        // $dumpvars(0, mycache.c_valid_bit[9][1]);

        for(i = 0; i < 2; i = i + 1)begin
            // $dumpvars(0, mycache.c_valid_bit[1][i]);
            $dumpvars(0, mycache.valid_bit_frm_c[i]);
            $dumpvars(0, mycache.tag_frm_c[i]);
            $dumpvars(0, mycache.hit_frm_c[i]);
            $dumpvars(0, mycache.hit_frm_c_AND_valid_bit_frm_c[i]);
            $dumpvars(0, mycache.data_frm_c[i]);
        end
        
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
        address <= 32'b100000000000000000000001_1001_10_10;
        
        #10
        address <= 32'd2;

        #10
        reset <= 1'b1;

        #10

        $finish;

	end
		 
endmodule