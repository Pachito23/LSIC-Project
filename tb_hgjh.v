`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:45:35 01/09/2023
// Design Name:   top_module
// Module Name:   /home/student/Vivaldo/tb_hgjh.v
// Project Name:  Vivaldo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_hgjh;

	// Inputs
	reg clk;
	reg rst;
	reg [2:0] ctrl;
	reg use_mem;

	// Outputs
	wire [3:0] dig;
	wire [6:0] seg;
	wire [3:0] Led;

	// Instantiate the Unit Under Test (UUT)
	top_module uut (
		.clk(clk), 
		.rst(rst), 
		.ctrl(ctrl), 
		.use_mem(use_mem), 
		.dig(dig), 
		.seg(seg), 
		.Led(Led)
	);

parameter PERIOD = 5;

   initial begin
      clk = 1'b0;
      #(PERIOD/2);
      forever
         #(PERIOD/2) clk = ~clk;
   end
	
initial begin
	rst =0;
	repeat (5) @ (posedge clk);
	rst = 1 ;
	repeat (5) @ (posedge clk);
	rst =0;
end

initial begin
     ctrl= 0 ;
	  use_mem = 0;
   end
      
endmodule

