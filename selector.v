`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:03:30 11/07/2022 
// Design Name: 
// Module Name:    selector 
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
module selector(
	input [3:0] data_in_dig1,
	input [3:0] data_in_dig2,
	input [3:0] data_in_dig3,
	input [3:0] data_in_dig4,
	input [3:0] digit_to_update,
	input fast_clk,
	input rst,
	output reg [3:0] sel,
	output reg [3:0] data_out
);

wire clk_slowed;

clk_div#(
		.WIDTH(26),
		.MAX(50_000)
	)
	
	clk_div_inst(
		.clk(fast_clk),         
		.rst(1'b0), 			 
		.en(1'b1),         
		.div_clk(clk_slowed) 
	);
	
reg [1:0] cnt=2'b0,cnt_next;

always @(posedge clk_slowed)
	begin
			cnt <= cnt + 1'b1;
	end

always @ (*) begin	
	
	if (cnt == 2'b0 ) begin 
		sel = ~(4'b0001);
		data_out=data_in_dig1;
	end
	else if (cnt == 2'b1 ) begin
		sel = ~(4'b0010);
		data_out=data_in_dig2;
	end
	else if (cnt == 2'b10)  begin
		sel = ~(4'b0100);
		data_out=data_in_dig3;
	end
	else if (cnt == 2'b11) begin
		sel = ~(4'b1000);
		data_out=data_in_dig4;
	end
		
	if(cnt == 2'b11)
		cnt_next=0;
end

endmodule