module IFU(
    input wire clk, rst_n,
    input wire alu_zero, ct_jump,
    input wire [1:0] ct_branch,
    output reg [31:0] pc,
    input wire [31:0] inst,
    input wire [31:0] alu_res
);

    reg [31:0] npc;

    wire [31:0] jump_addr, branch_addr, linear_addr;
    assign linear_addr = pc+4;
    assign jump_addr = alu_res;
    assign branch_addr = pc+4+{{14{inst[15]}},inst[15:0],2'b0};

    always @(*) begin
        if (ct_jump) begin
            npc = jump_addr;
        end else if (ct_branch[1] && alu_zero) begin
            npc = branch_addr;
        end else if (ct_branch[0] && !alu_zero) begin
            npc = branch_addr;
        end else begin
            npc = pc+4;
        end
    end
    always @(posedge clk)begin
        if (!rst_n) begin
            pc <= 0;
        end else begin
            pc <= npc;
        end
    end
endmodule
