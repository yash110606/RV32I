module PC(
    input pc_src,
    input [31:0]pc_adder,
    input [31:0]pc_alu,
    input clk,
    output reg[31:0] pc
);

    always @(posedge clk) begin
        if(pc_src) begin
            pc <= pc_alu;
        end
        else if (pc_src == 0) begin
            pc <= pc_adder;
        end
    end
endmodule