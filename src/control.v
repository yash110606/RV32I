module control_unit(
    input [31:0] instruction,
    output reg mem_write,
    output reg[31:0] mem_addr,
    output reg[5:0] rs1,
    output reg[5:0] rs2,
    output reg mem_read,
    output reg[31:0] data,
    output reg[3:0] sel
);

    reg[12:0] offset;
    always @(instruction) begin
        case(instruction[6:0])
            7'b1100011: begin
                offset = {instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
                                 
            end
            7'b0000011: begin
                
            end
            7'b0100011: begin
                rs1 = instruction[19:15];
                rs2 = {instruction[31:25],instruction[11:7]};
                data = instruction[24:20];
                mem_write = 1;
            end
            7'b0110011: begin
                mem_write = 1;
                mem_addr = instruction[11:7];
                rs1 = instruction[19:15];
                rs2 = instruction[24:20];
            end
            7'b0010011: begin
                mem_write = 1;
                mem_addr = instruction[11:7];
                rs1 = instruction[19:15];
                rs2 = instruction[31:20];
            end
        endcase
    end
endmodule
