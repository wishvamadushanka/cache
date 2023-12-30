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
    integer i;
    

    cache mycache(busywait, data, reset, clk, address);

	//wavedata file
	initial
	begin
		$dumpfile("wavedata.vcd");
		$dumpvars(0,testcache);
        // $dumpvars(0, mycache.tag_reg[0]);
    
        // for(i = 0; i < 1; i = i + 1)begin
        //     $dumpvars(0, mycache.valid_bit_assiotivity[0].valid_b);
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
        reset <= 1'b1;

        #1
        reset <= 1'b0;

        #9 
        address <= 32'b100000000000000000000001_1001_11_10;
        
        #10
        address <= 32'd2;

        #10
        reset <= 1'b1;

        $finish;

	end
		 
endmodule