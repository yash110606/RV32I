module reg_bank(
  input clock,
  input write_enable,
  input read_enable,
  input [4:0] rs1_addr,
  input [4:0] rs2_addr,
  input [4:0] rd_addr,
  input [31:0] write_data,
  output reg[31:0] rs1_data,
  output reg[31:0] rs2_data
);
  
  reg [31:0] regfile [31:0];
  
  integer i;
  initial begin
    for (i = 0;i < 32; i=i+1)
      regfile[i] = 32'b0;
  end
  
  always @(*) begin
    if(read_enable) begin
        rs1_data = (rs1_addr == 5'd0) ? 32'd0 : regfile[rs1_addr];
        rs2_data = (rs2_addr == 5'd0) ? 32'd0 : regfile[rs2_addr];
    end
  end
  
  always @(posedge clock) begin
    if (write_enable && (rd_addr != 5'd0)) begin
      regfile[rd_addr] <= write_data;
    end
  end
  
endmodule
