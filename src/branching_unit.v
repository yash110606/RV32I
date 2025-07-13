module branching_unit(
    input is_branch,
    input [31:0] address,
    input [31:0] alu_val,
    input [2:0] funct3,
    input [1:0] branching_type,
    output reg [31:0] pc_addr,
    output reg pc_src,
    output reg branching
);

    always @(is_branch) begin
        if(is_branch) begin
            if(branching_type == 2'b00) begin
                case(funct3)
                    3'b000: begin
                        if(alu_val==0) begin
                            pc_src <=1;
                            branching = 1;
                            pc_addr <= address;
                        end
                        else begin
                            branching = 0;
                            pc_src <= 0;
                        end
                    end
                    3'b001: begin
                        if(alu_val != 0) begin
                            pc_src <= 1;
                            branching = 1;
                            pc_addr <= address;
                        end
                        else begin
                            branching = 0;
                            pc_src <= 0;
                        end
                    end
                    3'b100: begin
                        if(alu_val) begin
                            pc_src <= 1;
                            branching = 1;
                            pc_addr <= address;
                        end
                        else begin
                            branching = 0;
                            pc_src <= 0;
                        end
                    end
                    3'b101: begin
                        if(alu_val==0) begin
                            pc_src <= 1;
                            branching = 1;
                            pc_addr <= address;
                        end
                        else begin
                            branching = 0;
                            pc_src <= 0;
                        end
                    end                 
                    3'b110: begin
                        if(alu_val) begin
                            pc_src <= 1;
                            branching = 1;
                            pc_addr <= address;
                        end
                        else begin
                            branching = 0;
                            pc_src <= 0;
                        end
                    end
                    3'b111: begin
                        if(alu_val == 0) begin
                            pc_src <= 1;
                            branching = 1;
                            pc_addr <= address;
                        end
                        else begin
                            branching = 0;
                            pc_src <= 0;
                        end
                    end
                endcase
            end
            if(branching_type == 2'b01) begin
                pc_src <= 1;
                pc_addr <= alu_val;
                branching <= 1;
            end
            if(branching_type == 2'b10) begin
                pc_src <= 1;
                pc_addr <= alu_val;
                branching <= 1;
            end
        end  
        else if(~is_branch) begin
            pc_src <= 0;
            pc_addr <= 32'bx;
        end
    end

endmodule