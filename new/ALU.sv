module ALU #(parameter WIDTH = 32) (
    input logic [WIDTH-1:0] operand_a,
    input logic [WIDTH-1:0] operand_b,
    input logic [3:0] opselect,  // Expanded to 4 bits
    output logic  [WIDTH-1:0] result
);


    always @(*) begin
        case (opselect)
            4'b0000: result = operand_a + operand_b; // ADD
            4'b0001: result = operand_a - operand_b; // SUB
            4'b0010: result = operand_a << operand_b[4:0]; // SLL
            4'b0011: result = $signed(operand_a) < $signed(operand_b) ? 1 : 0; // SLT
            4'b0100: result = operand_a < operand_b ? 1 : 0; // SLTU
            4'b0101: result = operand_a ^ operand_b; // XOR
            4'b0110: result = operand_a >> operand_b[4:0]; // SRL
            4'b0111: result = $signed(operand_a) >>> operand_b[4:0]; // SRA
            4'b1000: result = operand_a | operand_b; // OR
            4'b1001: result = operand_a & operand_b; // AND
            default: result = {WIDTH{1'b0}};
        endcase
    end
endmodule
