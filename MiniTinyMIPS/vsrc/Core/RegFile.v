module RegFile(
    input wire clk,
    input wire rst_n,
    input wire rf_wen,
    input wire [4:0] rf_addr_r1,
    input wire [4:0] rf_addr_r2,
    input wire [4:0] rf_addr_w,
    input wire [31:0] rf_data_w,
    output wire [31:0] rf_data_r1,
    output wire [31:0] rf_data_r2
);

    reg [31:0] file [31:0];

    assign rf_data_r1 = file[rf_addr_r1];
    assign rf_data_r2 = file[rf_addr_r2];

    integer idx;
    initial begin
        for (idx = 0; idx < 32; idx = idx+1) file[idx] = 0;
    end
    genvar i;
    generate
        for (i = 0; i < 32; i = i+1) begin
            always @(posedge clk) begin
                if (!rst_n) begin
                    file[i] <= 32'b0;
                end else if (rf_wen) begin
                    file[rf_addr_w] <= rf_data_w;
                end

            end
        end
    endgenerate
endmodule  
