module d_flipflop_32(input  logic [31:0] D, 
input logic clk, rst,
  output logic[31:0] Q
);
  always_ff @(posedge clk, negedge rst) begin
    if (!rst) begin
      Q  <= 0;
    end else begin
      Q  <= D;
    end
end
endmodule