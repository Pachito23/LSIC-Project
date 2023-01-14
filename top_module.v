`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:51:51 11/06/2022 
// Design Name: 
// Module Name:    top_module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_module#(
	parameter CLK_DIV_WIDTH=26,
	parameter CLK_DIV_MAX=50_000_000,
	//parameter CLK_DIV_MAX=50_000,

	
	parameter COUNTER_WIDTH=4,
	parameter COUNTER_MAX=2**COUNTER_WIDTH
	)

   (input clk, rst,
	input [2:0] ctrl,
	input use_mem,
	output [3:0] dig,
	output [6:0] seg,
   output [COUNTER_WIDTH-1:0] Led);
	
	wire clk_slow;
	wire rst_counter;
	wire en_counter;
	wire [2:0] ctrl_processed;
	wire [3:0] dig1,dig2,dig3,dig4;
	
	
	
	clk_div#(
		.WIDTH(CLK_DIV_WIDTH),
		.MAX(CLK_DIV_MAX)
	)
	clk_div_inst(
		.clk(clk),         
		.rst(rst), 			 
		.en(1'b1),         
		.div_clk(clk_slow) 
	);
	
	
	
	stopwatch stopwatch_inst(
		.clk(clk),
		.rst_in(rst),
		.ctrl(ctrl_processed), 
		.rst_counter(rst_counter), //outputs
		.en_counter(en_counter)		//outputs
		);



	memory_controller mem_ctrl(
		.clk(clk_slow),
		.rst(rst),
		.fast_clk(clk),
		.ctrl_in(ctrl),
		.use_mem(use_mem),
		.ctrl_out(ctrl_processed),
		.dig1(dig1),
		.dig2(dig2),
		.dig3(dig3),
		.dig4(dig4)
		);
	
	
	
	counter#(
		.WIDTH(COUNTER_WIDTH), 
		.MAX(COUNTER_MAX)
	)
	counter_inst(
		.clk(clk_slow), 
		.rst(rst_counter),       
		.en(en_counter),      
		.out(Led)      
	);
	
	

	sev_seg_disp display(
	.clk(clk_slow), 
	.rst(rst_counter),
	.fast_clk(clk),
	.en(en_counter),
	.seg(seg),
	.dig(dig),
	.dig_1_out(dig1),
	.dig_2_out(dig2),
	.dig_3_out(dig3),
	.dig_4_out(dig4)
    );

endmodule
