module d_flipflop_32_sync(input  logic [31:0] D, 
input logic clk, rst,
  output logic[31:0] Q
);
  always_ff @(posedge clk) begin
    if (!rst) begin
      Q  <= 0;
    end else begin
      Q  <= D;
    end
end
endmodule