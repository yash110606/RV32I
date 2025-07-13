module mem_access(
    input [2:0] funct3,
    input read_en,
    input [31:0] read_addr,
    input [7:0] read_port_1,
    input [7:0] read_port_2,
    output reg stall,
    output reg p1_read_en,
    output reg p2_read_en,
    output reg [31:0] p1_addr,
    output reg [31:0] p2_addr,
    output reg [31:0] read_val
);
    integer count = 0;
    
    always @(funct3 or read_en or read_addr) begin
        case(funct3)
            3'b000: begin
               stall <= 0;
               p1_read_en <= 1;
               p2_read_en <= 0;
               p1_addr <= read_addr;
            end
            3'b010: begin
                stall <= 1;
                count = 0;
                p1_read_en <= 1;
                p2_read_en <= 1;
                p1_addr <= read_addr;
                p2_addr <= read_addr+2;
            end
            3'b001: begin
                stall <= 0;
                p1_read_en <= 1;
                p2_read_en <= 1;
                count <= 0;
                p1_addr <= read_addr;
                p2_addr <= read_addr+1;
            end
            3'b100: begin
               stall <= 0;
               p1_read_en <= 1;
               p2_read_en <= 0;
               p1_addr <= read_addr;
            end
            3'b101: begin
               stall <= 0;
               count <= 0;
               p1_read_en <= 1;
               p2_read_en <= 1;
               p1_addr <= read_addr;
               p2_addr <= read_addr+1;
            end
        endcase
    end
    
    always @(read_port_1 or read_port_2) begin
        case(funct3)
            3'b000: begin
                read_val[7:0] <= $signed(read_port_1);
            end
            3'b001: begin
                read_val[7:0] <= read_port_1;
                read_val[15:8] <= read_port_2;
                read_val <= $signed(read_val);
            end
            
            3'b010: begin
                if(count==0) begin
                    read_val[7:0] <= read_port_1;
                    read_val[23:16] <= read_port_2;
                    p1_addr <= read_addr+1;
                    p2_addr <= read_addr+3;
                    count = count+1;
                end
                else if(count==1) begin
                    read_val[15:8] <= read_port_1;
                    read_val[31:24] <= read_port_2;
                    read_val = $signed(read_val);
                    stall <= 0;
                end
            end
            3'b100: begin
                read_val <= read_port_1;
            end
            3'b101: begin
                read_val[7:0] <= read_port_1;
                read_val[15:8] <= read_port_2;
            end
        endcase
    end
    
endmodule