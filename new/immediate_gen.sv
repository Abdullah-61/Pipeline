`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2024 03:40:45 PM
// Design Name: 
// Module Name: immediate_gen
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


module immediate_gen(
    input logic [31:0] In,
    output logic [31:0] Out
);
    always @(*) begin
        case(In[6:0])
            7'b0000011 : Out <= {{20{In[31]}}, In[31:20]}; // Load-type instruction
            7'b0100011 : Out <= {{20{In[31]}}, In[31:25], In[11:7]}; // Store-type instruction
            7'b1100011 : Out <= {{19{In[31]}}, In[31], In[7], In[30:25], In[11:8], 1'b0}; // Branch-type instruction
            7'b0010011 : Out <= {{20{In[31]}}, In[31:20]}; // Immediate-type instruction
            7'b1100111 : Out <= {{20{In[31]}}, In[31:20]}; // Immediate Jump-type instruction
            7'b0010111, 7'b0110111: Out = {In[31:12], {12{1'b0}}}; // U-type -> (auipc, lui)
            7'b1101111 : Out <= {{12{In[31]}}, In[31], In[19:12], In[20], In[30:21]}; // Jump and link instruction
            default : Out <= 32'h00000000; // Default case
        endcase
    end
endmodule
