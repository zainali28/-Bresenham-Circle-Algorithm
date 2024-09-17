module m_test2(input clk,
					input rst,
					input en,
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


m_circleDrawer draw(7'd80, 6'd60, 6'd20, clk,rst,en, x, y, plot, done);
vga_adapter VGA(rst,clk,3'd6,x,y,plot,
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