`timescale 1ns / 1ps
module Control(
    input wire [5:0] ct_inst,
    input wire [5:0] aluct_inst,
    output wire[2:0] ct_rf_dst,
    output wire ct_rf_wen,
    output wire ct_alu_src,
    output wire [3:0] ct_alu,
    output wire ct_mem_wen,
    output wire ct_mem_ren,
    output wire [3:0] ct_mem_wstrb,
    output wire ct_data_rf,
    output wire [1:0] ct_branch,
    output wire ct_jump,
    output wire ct_zero_ext,
    output wire ct_jump_ext,
    output wire ct_special_ext
);
    wire inst_r, inst_lw, inst_sw, inst_beq, inst_j, inst_addiu, inst_lui, inst_ori, inst_jal, inst_jr, inst_bne, inst_slti, inst_sltiu;
    wire [4:0] ct_alu_op;
    ALUCt aluct0(
        .funct(aluct_inst),
        .alu_ct_op(ct_alu_op),
        .alu_ct(ct_alu)
    );

    assign inst_r = (!ct_inst[5]) && (!ct_inst[4]) && (!ct_inst[3]) && (!ct_inst[2]) && (!ct_inst[1]) && (!ct_inst[0]);
    assign inst_lw = (ct_inst[5]) && (!ct_inst[4]) && (!ct_inst[3]) && (!ct_inst[2]) && (ct_inst[1]) && (ct_inst[0]);
    assign inst_sw = (ct_inst[5]) && (!ct_inst[4]) && (ct_inst[3]) && (!ct_inst[2]) && (ct_inst[1]) && (ct_inst[0]);
    assign inst_beq = (!ct_inst[5]) && (!ct_inst[4]) && (!ct_inst[3]) && (ct_inst[2]) && (!ct_inst[1]) && (!ct_inst[0]);
    assign inst_j = (!ct_inst[5]) && (!ct_inst[4]) && (!ct_inst[3]) && (!ct_inst[2]) && (ct_inst[1]) && (!ct_inst[0]);
    assign inst_addiu = (!ct_inst[5]) && (!ct_inst[4]) && (ct_inst[3]) && (!ct_inst[2]) && (!ct_inst[1]) && (ct_inst[0]);
    assign inst_lui = (!ct_inst[5]) && (!ct_inst[4]) && (ct_inst[3]) && (ct_inst[2]) && (ct_inst[1]) && (ct_inst[0]);
    assign inst_ori = (!ct_inst[5]) && (!ct_inst[4]) && (ct_inst[3]) && (ct_inst[2]) && (!ct_inst[1]) && (ct_inst[0]);
    assign inst_jal = (!ct_inst[5]) && (!ct_inst[4]) && (!ct_inst[3]) && (!ct_inst[2]) && (ct_inst[1]) && (ct_inst[0]);
    assign inst_jr = inst_r && (!aluct_inst[5]) && (!aluct_inst[4]) && (aluct_inst[3]) && (!aluct_inst[2]) && (!aluct_inst[1]) && (!aluct_inst[0]);
    assign inst_bne = (!ct_inst[5]) && (!ct_inst[4]) && (!ct_inst[3]) && (ct_inst[2]) && (!ct_inst[1]) && (ct_inst[0]);
    assign inst_slti = (!ct_inst[5]) && (!ct_inst[4]) && (ct_inst[3]) && (!ct_inst[2]) && (ct_inst[1]) && (!ct_inst[0]);
    assign inst_sltiu = (!ct_inst[5]) && (!ct_inst[4]) && (ct_inst[3]) && (!ct_inst[2]) && (ct_inst[1]) && (ct_inst[0]);
    
    assign ct_rf_dst = {inst_r,inst_jal, inst_slti || inst_sltiu};
    assign ct_rf_wen = (inst_r && !inst_jr) || inst_lw || inst_addiu || inst_ori || inst_lui || inst_jal|| inst_slti || inst_sltiu;
    assign ct_alu_src = inst_lw || inst_sw || inst_addiu || inst_ori || inst_lui || inst_jr  || inst_jal || inst_slti || inst_sltiu;
    assign ct_alu_op = {inst_r , inst_beq || inst_bne || inst_slti || inst_sltiu, inst_ori, inst_lui, inst_jal};
    // Only inst_sw is implemented, thus, every bit of wstrb is 1. However, how to write it if inst_sb and inst_sh are added?
    assign ct_mem_wstrb = 4'b1111;
    assign ct_branch =  {inst_beq, inst_bne};
    assign ct_mem_ren = inst_lw;
    assign ct_mem_wen =  inst_sw;
    assign ct_data_rf =  inst_lw;
    assign ct_jump = inst_j || inst_jal || inst_jr;
    assign ct_zero_ext = inst_ori || inst_sltiu;
    assign ct_jump_ext = inst_jal;
    assign ct_special_ext = inst_sltiu;
    
endmodule
