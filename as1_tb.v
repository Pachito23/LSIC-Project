`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:59:50 11/07/2022
// Design Name:   top_module
// Module Name:   C:/Cristina/Year 3/Sem 1/Large Scale Integrated Circuits/as1/as1_tb.v
// Project Name:  as1
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

module as1_tb;

	parameter CLK_DIV_WIDTH=22;
	parameter CLK_DIV_MAX=2_500_000;
	
	parameter COUNTER_WIDTH=4;
	parameter COUNTER_MAX=2**COUNTER_WIDTH;
	
	parameter HALF_PERIOD=200;

	// Inputs
	reg clk;
	reg rst;
	//reg i;

	// Outputs
	wire [3:0] leds;

	// Instantiate the Unit Under Test (UUT)
	top_module #(
	
	 .CLK_DIV_WIDTH (CLK_DIV_WIDTH),
	 .CLK_DIV_MAX   (CLK_DIV_MAX),
	 .COUNTER_WIDTH (COUNTER_WIDTH),
	 .COUNTER_MAX   (COUNTER_MAX)
	
	) uut (
		.clk(clk), 
		.rst(rst), 
		.leds(leds)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
      
		rst = 0;
		// Add stimulus here
		
		repeat (10_000) @ (posedge clk);
		
	end
	
	initial begin
		forever #HALF_PERIOD 
			clk=~clk;
		$finish();
	end


endmodule

