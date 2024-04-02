`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2024 03:54:12 PM
// Design Name: 
// Module Name: 2x1mux
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


module mux(
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic select_b,   // Selection line
    output logic[31:0]out      // Output
);

// Ternary operator to select between a and b
assign out = select_b ? b : a;

endmodule

