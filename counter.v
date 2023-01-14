`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:42:12 11/06/2022 
// Design Name: 
// Module Name:    counter 
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
module counter#(parameter WIDTH = 4,
                parameter MAX = 10)(
					 input clk, input rst, input en, 
					 output [WIDTH-1:0]out);

	reg [WIDTH-1:0]cnt_nxt, cnt_ff;

	assign out=cnt_ff;
	
	always @ (*) begin
		//defaults 
		cnt_nxt=cnt_ff;
		
		if(en) begin
			cnt_nxt=(cnt_ff==MAX-1)? 'b0 : cnt_ff+1'b1;
		end
	end
	
	always @ (posedge clk or posedge rst) begin
		if(rst) begin
			cnt_ff <= 'b0;
		end
		else begin
			cnt_ff <= cnt_nxt;
		end
	end

endmodule
