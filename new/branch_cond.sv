module branch_cond (
    input logic [1:0]br_type,             // Control signal to indicate branch type instruction
    input logic [2:0] funct3,
    input logic [6:0] opcode,        // The funct3 field from the instruction
    input logic [31:0] rs1_data,     // Data from source register 1
    input logic [31:0] rs2_data,     // Data from source register 2
    output logic br_taken         // Output signal to indicate if branch is taken
);

    always_comb begin
        if (br_type==2'b01) begin
            // Only evaluate branch condition if it is a branch type instruction
            case (funct3)
                3'b000: br_taken= (rs1_data == rs2_data);    // BEQ
                3'b001: br_taken= (rs1_data != rs2_data);    // BNE
                3'b100: br_taken= ($signed(rs1_data) < $signed(rs2_data)); // BLT
                3'b101: br_taken= ($signed(rs1_data) >= $signed(rs2_data)); // BGE
                3'b110: br_taken= (rs1_data < rs2_data);    // BLTU
                3'b111: br_taken= (rs1_data >= rs2_data);    // BGEU
                default:br_taken = 0; // Invalid branch condition
            endcase
        end else if (br_type == 2'b10) begin
            br_taken = 1;
        end
        else begin
            // If not a branch type instruction, do not take branch
            br_taken= 0;
        end
         

    end
endmodule
