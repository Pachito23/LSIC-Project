`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:18:07 12/22/2022 
// Design Name: 
// Module Name:    memory 
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
module memory#(
		parameter ADDR_LINES=10,
		parameter LOC_SIZE=32
	)(
	input wr, en, clk,
	input [ADDR_LINES-1:0] rd_addr,wr_addr,
	input [LOC_SIZE-1:0] wr_data,
	output reg [LOC_SIZE-1:0] rd_data
    );

	reg [ADDR_LINES-1:0] ram_mem [LOC_SIZE-1:0];

	always @(posedge clk)
	begin
		if(wr && en)
			ram_mem[wr_addr]<=wr_data;
			else
			if(!wr && en)
				rd_data<=ram_mem[rd_addr];
	end

endmodule
