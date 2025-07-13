module ID_reg(
    input [31:0] pc_i, // program counter value output
    input mem_write_i, //memory write enable
    input [31:0] mem_addr_i, //memory address to write to or read from 
    input [31:0] rs1_i, //rs1 value
    input [31:0] imm_i, //immediate value
    input [31:0] rs2_i, //rs2 value
    input mem_read_i, //memory read enable
    input mem_to_reg_i, //memory to register load enable
    input [2:0] funct3_i, //funct3 value
    input [4:0] rd_i, //destination register
    input [3:0] alu_op_i, //alu operation code
    input alu_src_i, //alu source(rs2 or immideate value)
    input is_branch_i,
    input pc_op,
    input clk,
    output reg[31:0] pc, // program counter value output
    output reg mem_write, //memory write enable
    output reg[31:0] mem_addr, //memory address to write to 
    output reg[5:0] rs1, //rs1 value
    output reg[5:0] imm, //immediate value
    output reg[5:0] rs2, //rs2 value
    output reg mem_read, //memory read enable
    output reg[2:0] funct3, //funct3 value
    output reg[31:0] rd, //destination register
    output reg[3:0] alu_op, //alu operation code
    output reg is_branch
);

    always @(posedge clk) begin
        if(alu_src_i) begin
            rs2 <= rs2_i;
        end
        else begin
            rs2 <= imm;
        end
        if(pc_op) begin
            rs1 <= pc_i;
        end
        else begin
            rs1 <= rs1_i;
        end
        pc <= pc_i;
        mem_write <= mem_write_i;
        mem_addr <= mem_addr_i;
        mem_read <= mem_read_i;
        funct3 <= funct3_i;
        rd <= rd_i;
        alu_op <= alu_op_i;
        imm <= imm_i;
        is_branch <= is_branch_i;
    end
endmodule