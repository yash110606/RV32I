module control_unit(
    input [31:0] instruction, //instruction
    input [31:0] pc_i, //program counter value input
    output reg[31:0] pc, // program counter value output
    output reg mem_write, //memory write enable
    output reg[31:0] mem_addr, //memory address to write to 
    output reg[4:0] rs1, //rs1 value
    output reg[31:0] imm, //immediate value
    output reg[4:0] rs2, //rs2 value
    output reg mem_read, //memory read enable
    output reg mem_to_reg, //memory to register load enable
    output reg[2:0] funct3, //funct3 value
    output reg[4:0] rd, //destination register
    output reg[3:0] alu_op, //alu operation code
    output reg alu_src, //alu source(rs2 or immideate value)
    output reg read_en, //register read enable
    output reg reg_write_en, //register write enable
    output reg flush,
    output reg is_branch,
    output reg pc_op,
    output reg [1:0] branching_type
);
        
    always @(instruction) begin
        read_en <= 0;
        case(instruction[6:0])
            7'b1100011: begin
                imm <= {instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};    
                rs1 <= instruction[19:15];
                rs2 <= instruction[24:20];
                funct3 <= instruction[14:12];
                alu_src <= 1;
                read_en <= 1;
                flush <= 1;
                case(instruction[14:12])
                    3'b000: alu_op <= 4'b0001;
                    3'b001: alu_op <= 4'b0001;
                    3'b100: alu_op <= 4'b0010;
                    3'b101: alu_op <= 4'b0010;
                    3'b110: alu_op <= 4'b0011;
                    3'b111: alu_op <= 4'b0011;
                endcase
                is_branch <= 1;
                branching_type <= 2'b00;
            end
            7'b0000011: begin
               mem_read <= 1;
               mem_to_reg <= 1;
               imm <= instruction[31:20];
               alu_src <= 0;
               rs1 <=  instruction[19:15];
               read_en <= 1;
               rd <= instruction[11:7];
               funct3 <= instruction[14:12];
               alu_op <= 4'b0000;
            end
            7'b0100011: begin
                rs1 <= instruction[19:15];
                imm <= {instruction[31:25],instruction[11:7]};
                alu_src <= 0;
                read_en <=1;
                rd <= instruction[24:20];
                mem_write <= 1;
                alu_op <= 4'b0000;
            end
            7'b0110011: begin
                reg_write_en <= 1;
                rd <= instruction[11:7];
                rs1 <= instruction[19:15];
                alu_src <= 1;
                read_en <= 1;
                rs2 <= instruction[24:20];
                case(instruction[31:25])
                    7'b0000000: begin
                        case(instruction[14:12])
                            3'b000: begin
                                alu_op <= 4'b0000;
                            end
                            3'b001: begin
                                alu_op <= 4'b0111;
                            end
                            3'b010: begin
                                alu_op <= 4'b0010;
                            end
                            3'b011: begin
                                alu_op <= 4'b0011;
                            end
                            3'b100: begin
                                alu_op <= 4'b0110;
                            end
                            3'b101: begin
                                alu_op <= 4'b1000;
                            end
                            3'b110: begin
                                alu_op <= 4'b0101;
                            end
                            3'b111: begin
                                alu_op <= 4'b0100;
                            end
                        endcase
                    end
                    7'b0100000: begin
                        case(instruction[14:12])
                            3'b000: begin
                                alu_op <= 4'b0001;
                            end
                            3'b101: begin
                                alu_op <= 4'b1001;
                            end
                        endcase
                    end                    
                endcase
            end
            7'b0010011: begin
                reg_write_en <= 1; 
                rd <= instruction[11:7];
                rs1 <= instruction[19:15];
                alu_src <= 0;
                read_en <= 1;
                case(instruction[14:12])
                    3'b000: begin
                        alu_op <= 4'b0000;
                        imm <= instruction[31:20];
                    end
                    3'b001: begin
                        alu_op <= 4'b0111;
                    end
                    3'b010: begin
                        alu_op <= 4'b0010;
                        imm <= instruction[31:20];
                    end
                    3'b011: begin
                        alu_op <= 4'b0011;
                        imm <= instruction[31:20];
                    end
                    3'b100: begin
                        alu_op <= 4'b0110;
                        imm <= instruction[31:20];
                    end
                    3'b101: begin
                        case(instruction[31:25])
                            7'b0000000: begin
                                alu_op <= 4'b1000; 
                                imm <= instruction[24:20];
                            end
                            7'b0100000: begin
                                alu_op <= 4'b1001;
                                imm <= instruction[24:20];
                            end
                        endcase
                    end
                    3'b110: begin
                        alu_op <= 4'b0101;
                        imm <= instruction[31:20];
                    end
                    3'b111: begin
                        alu_op <= 4'b0100;
                        imm <= instruction[31:20];
                    end
                endcase 
            end
            7'b0110111: begin
                rs1 <= instruction[31:12];
                imm <= 12;
                rd <= instruction[11:7];
                read_en <= 1;
                alu_op <= 4'b0111;
                alu_src <= 0;
            end
            7'b1101111: begin
                alu_src <= 0;
                read_en <= 0;
                mem_read <= 1;
                imm <= {instruction[31],instruction[19:12],instruction[20],instruction[30:21],1'b0};
                pc_op <= 1;
                rd <= instruction[11:7];
                alu_op <= 4'b0000;
                is_branch <= 1;
                branching_type <= 2'b01;
                reg_write_en <= 1;
                flush<=1;
            end
            7'b1100111: begin
                alu_src <= 0;
                read_en <= 1;
                rd <= instruction[11:7];
                rs1 <= instruction[19:15];
                imm <= instruction[31:20];
                alu_op <= 4'b0000;
                is_branch <= 1;
                branching_type <= 2'b10;
                flush <= 1;
            end
        endcase
    end
endmodule