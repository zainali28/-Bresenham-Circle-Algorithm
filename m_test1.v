module m_test1(input clk,
					input rst,
					input clear,
					output[7:0]VGA_R,
					output[7:0]VGA_G,
					output[7:0]VGA_B,
					output VGA_HS,
					output VGA_VS,
					output VGA_BLANK,
					output VGA_SYNC,
					output VGA_CLK);
					
wire[7:0] x;
wire[6:0] y;
wire plot;
wire done;
reg[2:0]color;


always color = x % 8;


clear C1(clk,rst,~clr, x, y, plot, done);
vga_adapter VGA(rst,clk,color,x,y,plot,
			VGA_R,
			VGA_G,
			VGA_B,
			VGA_HS,
			VGA_VS,
			VGA_BLANK,
			VGA_SYNC,
			VGA_CLK);
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.USING_DE1 = "TRUE";




endmodule