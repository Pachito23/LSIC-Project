`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:37:11 12/14/2022 
// Design Name: 
// Module Name:    sev_seg_disp 
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
module sev_seg_disp(
	input clk, rst, en,
	input fast_clk,
	output [6:0] seg,
	output [3:0] dig,
	output [3:0] dig_1_out, dig_2_out, dig_3_out, dig_4_out
    );

	wire en_dig_2,en_dig_3,en_dig_4;
	wire [3:0] dig_1, dig_2, dig_3, dig_4;
	reg [3:0] dig_to_update;
	wire [3:0] sel,to_update;
	assign dig_1_out = dig_1;
	assign dig_2_out = dig_2;
	assign dig_3_out = dig_3;
	assign dig_4_out = dig_4;
	
	counter_time#(
		.WIDTH(4), 
		.MAX(10)
	)
	
	counter_time_dig_1(
		.clk(clk), 
		.rst(rst),       
		.en(en), 
		.en_next(en_dig_2), //output
		.out(dig_1)      //output
	);
	
	
	
		counter_time#(
		.WIDTH(4), 
		.MAX(6)

	)
	
	counter_time_dig_2(
		.clk(clk), 
		.rst(rst),       
		.en(en_dig_2), 
		.en_next(en_dig_3), //output
		.out(dig_2)      //output
	);
	
	
	
		counter_time#(
		.WIDTH(4), 
		.MAX(10)

	)
	
	counter_time_dig_3(
		.clk(clk), 
		.rst(rst),       
		.en(en_dig_3), 
		.en_next(en_dig_4), //output
		.out(dig_3)      //output
	);
	
	
	
	counter_time#(
		.WIDTH(4), 
		.MAX(6)

	)
	
	counter_time_dig_4(
		.clk(clk), 
		.rst(rst),       
		.en(en_dig_4), 
		.en_next(), //output
		.out(dig_4)      //output
	);
	
	always @(*)
	begin
		dig_to_update[0]=en;
		dig_to_update[1]=en_dig_2;
		dig_to_update[2]=en_dig_3;
		dig_to_update[3]=en_dig_4;
	end
	
	
	selector s(
	.data_in_dig1(dig_1),
	.data_in_dig2(dig_2),
	.data_in_dig3(dig_3),
	.data_in_dig4(dig_4),
	.fast_clk(fast_clk),
	.digit_to_update(dig_to_update),
	.sel(sel),
	.rst(rst),
	.data_out(to_update)
);
	
	
	
	display_seg display1_0_9(
	.data_in(to_update),
	.seg(seg),
	.dig_in(sel),
	.dig_out(dig)
    );

endmodule
