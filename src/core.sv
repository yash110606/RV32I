module CPU_core(
    input clk,
    input power
);


typedef enum logic[1:0]
{
    OFF = 2'b00,
    ON = 2'b01,
    STALL = 2'b10,
    FLUSH = 2'b11
}state_t;

state_t current_state;

wire pc_src;
wire [31:0] pc_adder;
wire [31:0] pc;
wire read;
wire [31:0] instruction;
wire [31:0] pc_cu;
wire [31:0] instruction_cu;
wire flush_i;
wire [31:0] pc_1;
wire [31:0] imm;
wire mem_write;
wire [31:0] mem_addr;
wire [4:0] rs1;
wire [4:0] rs2;
wire mem_read;
wire mem_to_reg;
wire [2:0] funct3;
wire [4:0] rd;
wire [3:0] alu_op;
wire alu_src;
wire read_en;
wire reg_write_en;
wire is_branch;
wire flush_1;
wire [4:0] rs1_reg;
wire [4:0] rs2_reg;
wire [3:0] sel;
wire [4:0] rs1_to_reg;
wire [4:0] rs2_to_reg;
wire [31:0] alu_out;
wire [31:0] pc_addr;
wire [1:0] branching_type;
wire pc_op;
wire mem_write_alu_reg;
wire mem_read_alu_reg;
wire [31:0] mem_addr_alu_reg;
wire [4:0] rd_alu_reg;
wire mem_to_reg_alu_reg;
wire [2:0] funct3_alu_reg;

    PC mod1(
        .pc_src(pc_src),
        .pc_adder(pc_adder),
        .pc_alu(pc_addr),
        .pc(pc),
        .clk(clk)
    );
    
    pc_adder mod2(
        .pc_i(pc),
        .pc(pc_adder)
    );
    
    memory mod3(
        .addr(pc),
        .read(read),
        .data(instruction)
    );
    
    fetch mod4(
        .clk(clk),
        .instruction_i(instruction),
        .pc_i(pc),
        .pc(pc_cu),
        .instruction(instruction_cu),
        .flush(flush_i)
    );
    
    control_unit mod5(
        .pc_i(pc_cu),
        .instruction(instruction_cu),
        .flush(flush_i),
        .pc(pc_1),
        .mem_write(mem_write),
        .rs1(rs1_to_reg),
        .rs2(rs2_to_reg),
        .imm(imm),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .funct3(funct3),
        .rd(rd),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .read_en(read_en),
        .reg_write_en(reg_write_en),
        .is_branch(is_branch),
        .branching_type(branching_type),
        .pc_op(pc_op)       
    );
    
    ID_reg mod6(
        .pc_i(pc_1),
        .mem_write_i(mem_write),
        .mem_addr_i(mem_addr),
        .rs1_i(rs1),
        .rs2_i(rs2),
        .imm_i(imm),
        .mem_read_i(mem_read),
        .mem_to_reg_i(mem_to_reg),
        .funct3_i(funct3),
        .rd_i(rd),
        .alu_op_i(alu_op),
        .alu_src_i(alu_src),
        .is_branch_i(is_branch),
        .clk(clk),
        .rs1(rs1_reg),
        .rs2(rs2_reg),
        .alu_op(sel)
    );
    ALU mod7(
        .clk(clk),
        .rs1(rs1_reg),
        .rs2(rs2_reg),
        .sel(sel),
        .out(alu_out)
    );
    reg_bank mod8(
        .clock(clk),
        .read_enable(read_en),
        .rs1_addr(rs1_to_reg),
        .rs2_addr(rs2_to_reg),
        .rs1_data(rs1),
        .rs2_data(rs2)
    );
    branching_unit mod9(
        .is_branch(is_branch),
        .address(imm),
        .alu_val(alu_out),
        .funct3(funct3),
        .pc_addr(pc_addr),
        .pc_src(pc_src),
        .branching_type(branching_type)
    );
    
    ALU_reg mod10(
        .alu_val_i(alu_out),
        .clk(clk),
        .mem_write_en_i(mem_write_alu_reg),
        .mem_addr_i(mem_addr_alu_reg),
        .mem_read_i(mem_read_alu_reg),
        .mem_to_reg_i(mem_to_reg_alu_reg),
        .rd_i(rd_alu_reg),
        .funct3_i(funct3_alu_reg)
    );
    
    always @(power) begin
        if(power) begin
            case(current_state)
                OFF:begin
                    current_state <= ON;
                end
                ON:begin
                    
                end
            endcase
        end 
    end
endmodule