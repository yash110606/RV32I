
module ram(
  input [7:0] data_in_a,
  input [7:0] data_in_b,
  input [22:0] addr_a,
  input [22:0] addr_b,
  input clk_a,
  input clk_b,
  input en_a,
  input en_b,
  input w_en_a,
  input w_en_b,
  output reg [7:0] data_out_a,
  output reg [7:0] data_out_b
);
  
  reg [7:0] ram_mem [4194303:0];
  
//   always @(posedge clk_a or posedge clk_b) begin
//     if(en_a && addr_a && !w_en_a) data_out_a <= ram_mem[addr_a];
//     else if (en_b && addr_b && !w_en_n) data_out_b <= ram_mem[addr_b];
//     else if (en_a && en_b && addr_a && addr_b && (w_en_a || w_en_b)) begin
//       if (addr_a != addr_b) begin
//         if (w_en_a) ram_mem[addr_a] <= data_in_a;
//         else if (w_en_b) ram_mem[addr_b] <= data_in_b;
//       end
//       else if(addr_a == addr_b) ram_mem[addr_a] = 8'bx;
//     end
//   end
// endmodule
  
  always @(posedge clk_a) begin
    if (en_a) begin
      if (w_en_a) ram_mem[addr_a] <= data_in_a;
      else data_out_a <= ram_mem[addr_a];
    end
  end
  
  always @(posedge clk_b) begin
    if (en_b) begin
      if (w_en_b) ram_mem[addr_b] <= data_in_b;
      else data_out_b <= ram_mem[addr_b];
    end
  end
  
  always @(*) begin
    if (w_en_a && w_en_b && (addr_a == addr_b)) ram_mem[addr_a] <= 8'bx;
  end
endmodule


