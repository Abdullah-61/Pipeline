`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2024 04:03:04 PM
// Design Name: 
// Module Name: pc
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


module pc #(
    parameter WIDTH = 32 // Default width is 32 bits
) (
    input logic clk,                   // Clock signal
    input logic rst,                   // Asynchronous reset signal               // Enable signal for the PC
    input logic [WIDTH-1:0] pc_next,   // Next value of the PC
    output logic [WIDTH-1:0] pc_current // Current value of the PC
);


    // At every positive edge of the clock, update the PC register
    always_ff @(posedge clk, negedge rst ) begin
        if (!rst) begin
            //synchronously reset the PC to 0
            pc_current <= 0;
        end
        else begin
            // Update the PC with the next value if enabled
            pc_current <= pc_next;
        end
    end

endmodule
