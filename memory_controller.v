`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:35:50 12/22/2022 
// Design Name: 
// Module Name:    memory_controller 
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
module memory_controller(
	input clk,
	input fast_clk,
	input use_mem,
	input rst,
	input [3:0] dig1,dig2,dig3,dig4,
	output reg time_out,
	input [2:0] ctrl_in,
	output reg [2:0] ctrl_out
   );

	reg [4:0] addr_data_wr='b1;
	reg [4:0] addr_data_rd='b0;
	wire [15:0] data_out_w;
	reg [15:0] data_out;
	reg wr_en;
	wire [2:0] ctrl;
	reg [15:0] data_in;
	
	reg [2:0]start='b1;
	wire [4:0] counter_out_rd_w;
	reg [4:0] counter_out_rd;
	
	memy data_mem (
	//write
  .clka(fast_clk), // input clka
  .addra(addr_data_wr), // input [4 : 0] addra
  .dina(data_in), // input [15 : 0] dina
  //read
  .clkb(fast_clk), // input clkb
  .addrb(addr_data_rd), // input [4 : 0] addrb
  .doutb(data_out_w), // output [15 : 0] doutb
  
  // read/write
  .wea(wr_en) // input [0 : 0] wea
	);

		counter#(
		.WIDTH(4), 
		.MAX(16)
	)
	counter_addr_rd(
		.clk(clk), 
		.rst(rst),       
		.en(use_mem),      
		.out(counter_out_rd_w)      
	);
	
	
	
	always @(posedge fast_clk)
	begin
		wr_en<=1'b0;
		if(ctrl_in==3'b010)
			begin
				if(start=='b0)
				begin
					data_in <= {dig1,dig2,dig3,dig4};
					addr_data_wr <= 'b0;
					wr_en<=1'b1;
				end
			end
			
			if(use_mem)
			begin
				//read from memory
				if(addr_data_rd!='b0)
				begin
					addr_data_rd <= counter_out_rd;
					ctrl_out <= data_out[2:0];
				end
			end
		else
			begin
				ctrl_out<=ctrl_in;
			end
			
		if(start=='b1)
		begin
			wr_en<=1'b1;
			data_in<='b001;
			addr_data_wr<='d1;
			start<='b10;
		end
		if(start=='b10)
		begin
			wr_en<=1'b1;
			data_in<='b010;
			addr_data_wr<='d7;
			start<='b11;
		end
		if(start=='b11)
		begin
			wr_en<=1'b1;
			data_in<='b001;
			addr_data_wr<='d9;
			start<='b100;
		end
		if(start=='b100)
		begin
			wr_en<=1'b1;
			data_in<='b100;
			addr_data_wr<='d15;
			start<='b0;
		end
	end
	
	
	always @(*)
	begin
		data_out=data_out_w;
		counter_out_rd=counter_out_rd_w;
	end
	

endmodule
