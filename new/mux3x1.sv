module mux3x1(
    input logic [31:0] rdata,     // Input rdata
    input logic [31:0] alu_out,  // Input alu_out
    input logic [31:0] PC,       // Input PC
    input logic [1:0] wb_sel,   // Selection line
    output logic[31:0]out      // Output
);
always_comb begin
case (wb_sel)
           2'b00: out = rdata; 
           2'b01: out = alu_out; 
           2'b10: out = PC + 4; 
default: out= 32'b0;
           
endcase
end
endmodule