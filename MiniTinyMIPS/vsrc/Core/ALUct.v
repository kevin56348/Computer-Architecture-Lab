`timescale 1ns / 1ps
module ALUCt(
    input wire [5:0] funct,
    input wire [4:0] alu_ct_op,
    output reg [3:0] alu_ct
);
    always @(*) begin
        case (alu_ct_op)
            5'b00000:
                alu_ct = 4'b0010;
            5'b01000:
                alu_ct = 4'b0110;
            5'b10000:
                case (funct)
                    6'b100001: alu_ct = 4'b0010;
                    6'b001000: alu_ct = 4'b1010;
                    default: begin
                        alu_ct = 4'b0010;
                    end
                endcase
            5'b00100:
                alu_ct = 4'b1000;
            5'b00010:
                alu_ct = 4'b1001;
            5'b10001:
                alu_ct = 4'b1011;
            default: begin end
        endcase
    end
endmodule
