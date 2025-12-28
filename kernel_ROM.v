`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:28:20 11/25/2025 
// Design Name: 
// Module Name:    kernel_ROM 
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
module kernel_ROM(
    input [0:3]kernel_addr,
    output reg [0:31]kernel_val
    );
always @(*)begin
	case(kernel_addr)
		4'd0:kernel_val = 32'h3BA3D70A;
		4'd1:kernel_val = 32'h372A7EF9;
		4'd2:kernel_val = 32'hB2C2A8EB;
		4'd3:kernel_val = 32'h33B4C4DA;
		4'd4:kernel_val = 32'h32F5C28F;
		4'd5:kernel_val = 32'h2AB61E1A;
		4'd6:kernel_val = 32'hA9655C0E;
		4'd7:kernel_val = 32'h24B41C8F;
		4'd8:kernel_val = 32'h215EF96B;
		default: kernel_val = 32'h00000000;
	endcase
 end
endmodule
