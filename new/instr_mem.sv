`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2024 05:17:08 PM
// Design Name: 
// Module Name: instr_mem
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


module instr_mem(
    input logic  [31:0] Addr,
    output logic [31:0] Inst
);

logic [31:0] inst_memory [0:9]; 

initial begin
    $readmemh("inst.mem", inst_memory);  

end
assign Inst = inst_memory [Addr>>2];//Word Addressable 

endmodule
