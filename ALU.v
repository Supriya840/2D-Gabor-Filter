`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:29:07 11/28/2025 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input clk,
    input reset,
	 input [31:0]kernel_val,
	 input pixel_valid,
	 input [31:0]read_data,
	 output reg [31:0]result,
	 output reg result_valid
    );
reg signed [63:0] accum;
reg signed [63:0] prdt;

always @(*) begin
	prdt = $signed(read_data)*$signed(kernel_val);
end

always @(posedge clk or posedge reset) begin
	if (reset) begin
	accum<=0;
	result<=0;
	result_valid<=0;
end
else begin 
	accum <= accum + prdt;
	if (pixel_valid) begin
		result <= accum + prdt;
		result_valid <=1;
		
		accum<=0;
	end 
	else begin
		result_valid <=0;
	end
end
end
endmodule
