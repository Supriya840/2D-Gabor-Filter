`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:49:29 11/28/2025 
// Design Name: 
// Module Name:    gabor_filter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module gabor_filter(input clk,
    input reset,
    input conv,
    input [31:0] write_data,   
    output done,
    output [31:0] result,
    output result_valid
    );
	 wire mem_en;
    wire [7:0] write_address;
    wire [7:0] read_address;
    wire [3:0] kernel_addr;
    wire pixel_valid;

    wire [31:0] read_data;     
    wire [31:0] kernel_val; 
	 
	 CLU clu_inst (
        .clk(clk),
        .reset(reset),
        .conv(conv),
        .mem_en(mem_en),
        .write_address(write_address),
        .read_address(read_address),
        .kernel_addr(kernel_addr),
        .pixel_valid(pixel_valid),
        .done(done)
        );
	 
	  memory ram (
        .clk(clk),
        .en(en),
        .write_address(write_address),
        .write_data(write_data),
        .read_address(read_address),
        .read_data(read_data)
        );
    
	  kernel_ROM rom_inst (
        .kernel_addr(kernel_addr),
        .kernel_val(kernel_val)
        );
	 
	  ALU alu_inst (
        .clk(clk),
        .reset(reset),
        .read_data(read_data),
        .kernel_val(kernel_val),
        .pixel_valid(pixel_valid),
        .result(result),
        .result_valid(result_valid)
        );
		  
	  output_ram out_ram_inst (
        .clk(clk),
        .we(result_valid),
        .addr(center_cnt),
        .data_in(result),
        .data_out(out_pixel)
    );

endmodule
