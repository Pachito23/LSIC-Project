`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:59:32 12/15/2022 
// Design Name: 
// Module Name:    counter_time 
// Project Name: 
module counter_time#(parameter WIDTH = 4,
                parameter MAX = 10
					 )(
					 input clk, input rst, input en, 
					 output en_next,
					 
					 output [WIDTH-1:0]out);

	reg [WIDTH-1:0]cnt_nxt, cnt_ff;
	reg en_next_dig;

	assign en_next=en_next_dig;
	assign out=cnt_ff;
	
	always @ (posedge clk or posedge rst) begin
		if(rst) begin
			cnt_ff <= 'b0;
		end
		else
			cnt_ff <= cnt_nxt;
	end
	
	always @ (*) begin
		//defaults 
		cnt_nxt=cnt_ff;
		en_next_dig=1'b0;
		
		if(en) begin
			if(cnt_ff==MAX-1)
			begin
				cnt_nxt='b0;
				en_next_dig=1'b1;
			end
			else
				begin
					cnt_nxt=cnt_ff+1'b1;
				end
		end
	end

endmodule
