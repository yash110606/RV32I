module ALU_reg(
    input clk,
    input mem_write_en_i,
    input [31:0] mem_addr_i,
    input mem_read_i,
    input mem_to_reg_i,
    input [4:0] rd_i,
    input [31:0] alu_val_i,
    input [2:0]funct3_i,
    output reg mem_write_en,
    output reg [31:0] mem_addr,
    output reg mem_read,
    output reg mem_to_reg,
    output reg [4:0] rd,
    output reg [31:0] alu_val,
    output reg [2:0] funct3
);

    always @(posedge clk) begin
        mem_write_en <= mem_write_en_i;
        mem_addr <= mem_addr_i;
        mem_to_reg <= mem_to_reg_i;
        mem_read <= mem_read_i;
        rd <= rd_i;
        alu_val <= alu_val_i;
        funct3 <= funct3_i;
    end
    
endmodule