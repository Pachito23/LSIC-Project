`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:38:03 11/06/2022 
// Design Name: 
// Module Name:    clk_div 
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
module clk_div#(parameter WIDTH = 4,
                parameter MAX = 10)
  			   (input clk,input rst,input en, output div_clk);
  
  // you can use parameter in order to declare inputs/outputs/internal signal width
  // you can also declare "localparam" this is a type of parameter that can`t be change from outside of the module
  // you can use "localparam" for internal process of parameter value => the simulator will treat them as constants after the compilation phase
  // for details check: https://www.chipverify.com/verilog/verilog-parameters  
  
  localparam HALF_COUNT = (MAX-1)/2;
  
  reg [WIDTH-1:0] count_ff,count_next;
  reg drive_ff, drive_next;
  
  assign div_clk = drive_ff;
  
  // this always bloc will be synthesize as combinational logic
  always @* begin
    drive_next = drive_ff;
    count_next = count_ff;
    if(en) begin
      if(count_ff == (MAX-1)) begin
        drive_next = 1'b0;
        count_next = 'b0;
      end else begin
        count_next = count_ff+1'b1;
        if(count_ff < HALF_COUNT) begin
          drive_next = 1'b0;
        end else begin
          drive_next = 1'b1;
        end
      end
    end
  end
  
  // this always bloc will be synthesize as sequential logic
  always @(posedge clk or posedge rst) begin
    if(rst) begin
      drive_ff <= 1'b0;
      count_ff <= 'b0;  // if you don`t know the width use 'b0 and the compiler will insert 0 on all defined bits
    end else begin
      drive_ff <= drive_next;
      count_ff <= count_next;
    end
  end
endmodule 
