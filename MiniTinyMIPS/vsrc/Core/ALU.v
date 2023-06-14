`timescale 1ns / 1ps
module ALU(
    input wire [3:0] alu_ct,
    input wire [31:0] alu_src1, alu_src2,
    output wire alu_zero,
    output reg [31:0] alu_res
);
    assign alu_zero = (alu_res == 0) ? 1:0;
    always @(*)
        case (alu_ct)
            4'b0010: begin
                alu_res <= alu_src1+alu_src2;
            end
            4'b0110: begin
                alu_res <= alu_src1-alu_src2;
            end
            4'b1000:begin
                alu_res <= alu_src1|alu_src2;
            end
            4'b1001:begin
                alu_res <={alu_src2[15:0],16'h0000};
            end
            4'b1010:begin
                alu_res <= alu_src1;
            end
            4'b1011:begin
                alu_res <= alu_src2;
            end
            default: begin end
        endcase
endmodule
