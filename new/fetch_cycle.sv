`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2024 10:39:14 PM
// Design Name: 
// Module Name: fetch_cycle
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fetch_cycle(clk, rst, br_taken, alu_output, InstrF2D, PCF2D);
  input clk, rst;
  input br_taken;
  input [31:0] alu_output;
  output [31:0] InstrF2D;
  output [31:0] PCF2D;
endmodule
mux mux_pc (.a(PCPlus4F),
                .b(PCTargetE),
                .select_b(PCSrcE),
                .out(PC_F)
                );