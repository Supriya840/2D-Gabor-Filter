`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:39:44 11/28/2025 
// Design Name: 
// Module Name:    CLU 
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
module CLU(
    input clk,
    input reset,
    input conv,
    output reg [7:0]read_address,
    output reg [7:0]write_address,
    output reg [3:0]kernel_addr,
    output reg mem_en,
    output reg pixel_valid,
    output reg done,
	 output reg [7:0] center_cnt
    );
localparam s_write = 2'b00;
localparam s_conv = 2'b01;
localparam s_done = 2'b10;

reg [1:0]state;

reg [7:0]pix_cnt;
reg [3:0]kernel_cnt;

reg [4:0]row;
reg [4:0]column;

reg signed [15:0] base_addr;
reg signed [15:0] offset;
reg signed [15:0] tmp_addr;

always @(posedge clk) begin
	if (reset) begin
		state <= s_write;
		pix_cnt <=8'd0;
	   center_cnt <= 8'd0;
      kernel_cnt <= 4'd0;
      mem_en  <= 1'b0;
      write_address <= 8'd0;
      read_address  <= 8'd0;
      kernel_addr   <= 4'd0;
      pixel_valid   <= 1'b0;
      done          <= 1'b0;
		
	end
	else begin
		case (state)
		
		s_write: begin
			if (!conv) begin 
				mem_en <= 1'b1;
				write_address <=pix_cnt;
							
				if (pix_cnt == 8'd255) begin
					state <= s_conv;
				end else begin 
					pix_cnt <= pix_cnt +1'b1;
				end
			end
		end
		s_conv: begin
			mem_en <=1'b0;
			done <= 1'b0;
			row <= center_cnt/8'd16;
			column <=center_cnt%8'd16;
						
			base_addr <= (row*16);
						
			case (kernel_addr)
				4'd0: offset <= -17;
				4'd1: offset <= -16;
				4'd2: offset <= -15;
				4'd3: offset <= -1;
				4'd4: offset <= 0;
				4'd5: offset <= 1;
				4'd6: offset <= 15;
				4'd7: offset <= 16;
				4'd8: offset <= 17;
				default : offset <=0;
			endcase 
						
			tmp_addr = base_addr + offset + column;
			if ((tmp_addr<0)||(tmp_addr>255)) begin
				read_address <= 8'd0;
			end else begin
				read_address <= tmp_addr[7:0];
         end
						  
			kernel_addr <= kernel_cnt;
			pixel_valid <=(kernel_cnt == 4'd8);
						
			if (kernel_cnt==4'd8) begin
				kernel_cnt<=4'd0;
				if (center_cnt ==8'd255) 
					state <= s_done;
				else 
					center_cnt <= center_cnt + 1'b1;
			end else begin
				kernel_cnt <= kernel_cnt +1'b1;
			end
		end
					
		s_done: begin 
			mem_en <=1'b0;
			pixel_valid<=1'b0;
			done <= 1'b1;
		end
		default: state <= s_write; 
		endcase
	end 
end 
						
endmodule


