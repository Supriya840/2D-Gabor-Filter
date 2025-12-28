`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:12:54 11/28/2025 
// Design Name: 
// Module Name:    output 
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
module output_ram(
    input clk,
    input we,	 
    input [7:0] addr,
    input [31:0] data_in,
	 input [31:0] write_data,
    output reg [31:0] data_out
);

    reg [31:0] mem [0:255];

    always @(posedge clk) begin
        if (we)
            mem[addr] <= data_in;

        data_out <= mem[addr];   
    end
	 
	 integer f;

    initial begin
		f = $fopen("output.txt", "w");
	 end

	 always @(posedge clk) begin
		if (we) begin
        $fwrite(f, "%0d\n", write_data);
    end
end


endmodule

