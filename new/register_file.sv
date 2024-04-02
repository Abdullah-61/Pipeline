`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2024 01:04:47 AM
// Design Name: 
// Module Name: register_file
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


module register_file #(
    parameter DATA_WIDTH = 32, // Width of the data
    parameter ADDR_WIDTH = 5   // Number of address bits (for 32 registers)
) (
    input  logic                   clk,       // Clock signal
    input  logic                   reg_wr,    // Register write enable signal
    input  logic [ADDR_WIDTH-1:0]  raddr1,    // Address of the first register to read (rs1)
    input  logic [ADDR_WIDTH-1:0]  raddr2,    // Address of the second register to read (rs2)
    input  logic [ADDR_WIDTH-1:0]  waddr,     // Address of the register to write (rd)
    input  logic [DATA_WIDTH-1:0]  wdata,     // Data to write into the register (write data)
    output logic [DATA_WIDTH-1:0]  rdata1,    // Data read from the first register
    output logic [DATA_WIDTH-1:0]  rdata2     // Data read from the second register
);

    // Register array
    logic [DATA_WIDTH-1:0] registers[2**ADDR_WIDTH-1:0];

    // Asynchronous read
    assign rdata1 = (raddr1 != 0) ? registers[raddr1] : 0; // Register 0 is always 0
    assign rdata2 = (raddr2 != 0) ? registers[raddr2] : 0; // Register 0 is always 0

    // Synchronous write on the rising edge of the clock
    always_ff @(negedge clk) begin
        if (reg_wr && waddr != 0) begin
            // Write data to the register if write is enabled and the destination is not register 0
            registers[waddr] <= wdata;
        end
    end
    initial
    begin
        registers[1]=2;
        registers[2]=2;
        registers[10]=10;
        

    end


endmodule

