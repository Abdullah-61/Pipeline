module instruction_decoder (
    input logic [31:0] instr,
    output logic [6:0] opcode,
    output logic [2:0] funct3,
    output logic [6:0] funct7,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [4:0] rd,
    output logic [31:0] immediate
);

    // Decode common fields
    assign opcode = instr[6:0];
    assign rd     = instr[11:7];
    assign funct3 = instr[14:12];
    assign rs1    = instr[19:15];
    assign rs2    = instr[24:20];
    assign funct7 = instr[31:25];

    // Determine instruction type and extract immediates
    always @(*) begin
     
        immediate = 32'b0; // Default immediate value

        case (opcode)
            7'b0110011: begin // R-type
             
                // R-type instructions do not have an immediate field
            end
            7'b0010011: begin // I-type
               
                immediate = {{20{instr[31]}}, instr[31:20]}; // Sign-extended immediate
            end
            7'b0100011: begin // S-type
                
                immediate = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // Sign-extended immediate
            end
            7'b1100011: begin // B-type
                
                immediate = {{19{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0}; // Sign-extended immediate with 0 at LSB
            end
            7'b0110111: begin // U-type
                
                immediate = {instr[31:12], 12'b0}; // Immediate with lower 12 bits zeroed
            end
            7'b1101111: begin // J-type
              
                immediate = {{11{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0}; // Sign-extended immediate with 0 at LSB
            end
            // Add more cases for other opcodes as needed
            default: begin
                // Handle default case if necessary
            end
        endcase
    end
endmodule
