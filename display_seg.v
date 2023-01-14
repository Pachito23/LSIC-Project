`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:10:08 12/15/2022 
// Design Name: 
// Module Name:    display_seg 
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
module display_seg(
	input [3:0] data_in,
	input [3:0] dig_in,
	output reg [6:0] seg,
	output reg [3:0] dig_out
    );
	
	//reg [1:0] cnt_reg, cnt_nxt;

	always @ (*) begin
											     // gfedcba 
				if (data_in == 0) seg = ~(7'b0111111);
		else if ( data_in == 1) seg = ~(7'b0000110); 
		else if ( data_in == 2) seg = ~(7'b1011011); 
		else if ( data_in == 3) seg = ~(7'b1001111);  
		else if ( data_in == 4) seg = ~(7'b1100110);  
		else if ( data_in == 5) seg = ~(7'b1101101);  
		else if ( data_in == 6) seg = ~(7'b1111101);
		else if ( data_in == 7) seg = ~(7'b0000111);
		else if ( data_in == 8) seg = ~(7'b1111111);
		else if ( data_in == 9) seg = ~(7'b1101111);
		else seg = ~(7'b0000000);
		
		dig_out=dig_in;
		
		//dig=4'b0010; the 1 are the off anode
		
	end
	
endmodule
