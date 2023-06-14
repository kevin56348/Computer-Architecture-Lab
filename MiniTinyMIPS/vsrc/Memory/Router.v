module Router(
    // from cpu
    input wire [31:0] data_addr,
    input wire data_ren,
    output wire [31:0] data_rd,
    input wire data_wen,
    input wire [31:0] data_wr,
    input wire [3:0] data_wstrb,
    // to memory
    // data, data use the common data bus, these are control signals
    output wire datamem_ren,
    input wire [31:0] datamem_rdata,
    output wire datamem_wen,
    // to device
    output wire device_ren,
    output wire device_wen,
    input wire [31:0] device_rdata,
    // common databus
    output wire [31:0] common_addr,
    output wire [31:0] common_wdata,
    output wire [3:0] common_wstrb
);
    wire to_devide;
    wire to_memory;
    assign to_device = (data_addr[31:28] == 4'ha || data_addr[31:28] == 4'hb) ? 1:0;
    assign to_memory = (data_addr[31:28] == 4'ha || data_addr[31:28] == 4'hb) ? 0:1;

    assign common_addr = data_addr;
    assign common_wdata = data_wr;
    assign common_wstrb = data_wstrb;
    assign data_rd = datamem_rdata;

    assign datamem_ren = to_memory ? data_ren : 0;
    assign datamem_wen = to_memory ? data_wen : 0;
    assign device_ren = to_device ? data_ren : 0;
    assign device_wen = to_device ? data_wen : 0;

endmodule