module stack_memory(
    input clk,
    input reset,
    input push_enable,
    input pop_enable,
    input [31:0] data_in,
    output reg [31:0] data_out,
    output reg [16:0] sp,
    output reg stack_full,
    output reg stack_empty,
    output reg valid_out
);
    
//parameters
parameter DEPTH = 256;
parameter WIDTH = 8;
parameter INITIAL_ADDR = 102300;

reg [31:0] stack_mem [0:DEPTH-1];                                                 //1 KB downwards growing stack, from 102300

reg [7:0] int_ptr;                                                                //internal stack pointer 

always @(posedge clk or posedge reset) begin
    //initial reset conditions
    if(reset) begin                                                              
        int_ptr <= 8'b0;
        sp <= INITIAL_ADDR;
        data_out <= 32'h0;
        stack_full <= 1'b0;
        stack_empty <= 1'b1;
        valid_out <= 1'b0;
    end 
    else begin
        valid_out <= 1'b0;
        //push operations
        if(push_enable && !stack_full && !pop_enable) begin
            stack_mem[int_ptr] <= data_in;
            int_ptr <= int_ptr + 1;
            sp <= sp-4;
            stack_empty <= 1'b0;
            //checking if stack if full
            if(int_ptr == DEPTH-2) begin
                stack_full <= 1'b1;
            end        
        end
        //pop operations
        else if (pop_enable && !stack_empty && !push_enable) begin
            if(int_ptr > 0) begin
                int_ptr <= int_ptr-1;
                data_out <= stack_mem[int_ptr-1];
                sp <= sp+4;
            end
            stack_full <= 1'b0;
            //checking if stack is empty
            if(int_ptr == 1) begin
                stack_empty <= 1'b1;
            end
        end
        //handling simultaneous push and pop conditions (conflicting instructions)
        else if (push_enable && pop_enable) begin
            //do nothing
            valid_out <= 1'b1;        
        end
    end
end

endmodule
