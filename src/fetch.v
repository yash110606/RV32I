module fetch(
    input [31:0] pc_i,
    input [31:0] instruction_i,
    input clk,
    input flush,
    output reg[31:0] pc,
    output reg[31:0] instruction
);

    always @(flush) begin
        if(flush) begin
            pc <= 32'bx;
            instruction  <= 32'bx;
        end 
    end
    
    always @(posedge clk) begin
        pc <= pc_i;
        instruction <= instruction_i;
    end

endmodule