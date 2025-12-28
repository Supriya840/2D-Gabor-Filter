`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:52:02 11/26/2025 
// Design Name: 
// Module Name:    memory 
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
module memory(
    output reg [0:31]read_data,
    input [31:0]write_data,
    input [7:0]read_address,
    input [7:0]write_address,
    input en,
    input clk
    );
	reg [0:31] mem_array[0:255];
	
	initial begin
    $readmemh("image_fingerprint.txt", mem_array); 
	end

	always @(posedge clk) begin
		if (en)
			mem_array[write_address]<=write_data;
	end

	always @(*) begin 
		read_data = mem_array[read_address];
	end

endmodule
