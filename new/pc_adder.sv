`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2024 04:43:05 PM
// Design Name: 
// Module Name: pc_adder
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


module pc_adder #(
    parameter WIDTH = 32 // Default width is 32 bits
) (
    input logic [WIDTH-1:0] pc_in,  // Current program counter value
    output logic [WIDTH-1:0] pc_out // Next program counter value
);

    // Add 4 to the current PC value to get the next PC value
    assign pc_out = pc_in + 4;

endmodule

