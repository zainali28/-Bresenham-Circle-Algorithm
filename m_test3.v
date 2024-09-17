module m_test3(input clk,
					input rst,
					input draw,
					input clear,
					input [5:0]radius,
					input [2:0]color,
					output[7:0]VGA_R,
					output[7:0]VGA_G,
					output[7:0]VGA_B,
					output VGA_HS,
					output VGA_VS,
					output VGA_BLANK_N,
					output VGA_SYNC_N,
					output VGA_CLK);
					
wire[7:0] x;
wire[6:0] y;
wire plot;
wire[2:0] col;

controller1 c1(
				clk,
				rst,
				~draw,
				~clear,
				color,
				radius,
				col,
				x,
				y,
				plot						
				);
						
vga_adapter VGA(rst,clk,col,x,y,plot,
			VGA_R,
			VGA_G,
			VGA_B,
			VGA_HS,
			VGA_VS,
			VGA_BLANK_N,
			VGA_SYNC_N,
			VGA_CLK);
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.USING_DE1 = "TRUE";




endmodule