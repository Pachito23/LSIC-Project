`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:29:01 10/10/2022 
// Design Name: 
// Module Name:    stopwatch 
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
// states
	`define IDLE 2'b00
	`define START 2'b01
	`define PAUSE 2'b10
	`define STOP 2'b11

module stopwatch(
	input clk,
	input rst_in,
	input [2:0] ctrl, // 001 - START, 010 - PAUSE, 100 - STOP
	output rst_counter,en_counter
   );
	
	reg [1:0] state_nxt, state_reg;
	reg rst, en;
	
	assign rst_counter = rst;
	assign en_counter = en;

	always @ (posedge clk or posedge rst_in) begin
		if (rst_in)  begin
			state_reg <= `STOP;
		end
		else begin
			state_reg <= state_nxt;
		end
	end
	
	always @ (*) begin
		state_nxt = state_reg;
		
		case (state_reg)
			`IDLE: begin
				en=1'b0;
				rst=1'b0;
				if (ctrl == 3'b001) 
					state_nxt = `START;
				else if (ctrl == 3'b010)
					state_nxt = `PAUSE;
				else if (ctrl == 3'b100)
					state_nxt = `STOP;
			end
			
			`START: begin
				en=1'b1;
				rst=1'b0;
				if (ctrl == 3'b001)
					state_nxt = `START;
				else if (ctrl == 3'b010)
					state_nxt = `PAUSE;
				else if (ctrl == 3'b100)
					state_nxt = `STOP;
			end
			`PAUSE: begin
				en=1'b0;
				rst=1'b0;
				if (ctrl == 3'b001)
					state_nxt = `START;
				else if (ctrl == 3'b010)
					state_nxt = `PAUSE;
				else if (ctrl == 3'b100)
					state_nxt = `STOP;
			end
			`STOP: begin
				en=1'b0;
				rst=1'b1;
				if (ctrl == 3'b001)
					state_nxt = `START;
				else if (ctrl == 3'b010)
					state_nxt = `PAUSE;
				else if (ctrl == 3'b100)
					state_nxt = `STOP;
			end					
		endcase
	end
endmodule
