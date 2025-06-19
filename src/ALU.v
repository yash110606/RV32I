module ALU(
    input [31:0] rs1,
    input [31:0] rs2,
    input clk,
    input [3:0] sel,
    output reg[31:0] out
);
 
    always @(posedge clk) begin
        case(sel)
            4'b0000: begin
                out = rs1+rs2;
            end
            4'b0001: begin
                out = rs1-rs2;
            end
            4'b0010: begin
                if($signed(rs1)<$signed(rs2)) begin
                    out = 1;
                end                                                    
            end    
            4'b0011: begin
                if(rs1<rs2) begin
                    out = 1;
                end
            end
            4'b0100: begin
                out = rs1 & rs2;
            end
            4'b0101: begin
                out = rs1 | rs2;
            end
            4'b0110: begin
               out = rs1 ^ rs2;
            end
            4'b0111: begin
                out = rs1<<rs2[4:0];
            end
            4'b1000: begin
                out = rs1>>rs2[4:0];
            end
            4'b1001: begin
                out = $signed(rs1)>>>rs2[4:0];
            end
        endcase
    end

endmodule