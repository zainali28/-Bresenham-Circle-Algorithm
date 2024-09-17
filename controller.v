module controller(
						input clk,
						input rst,
						input plt,
						input clr,
						input [2:0]color,
						input [5:0]radius,
						output reg [2:0]colour,
						output reg [7:0]x,
						output reg [6:0]y,
						output reg draw						
						);
						
parameter A = 2'd0, B = 2'd1, C = 2'd2;


reg [6:0]xc = 7'd80;
reg [5:0]yc = 6'd60;
reg [1:0]present_state, next_state;
wire plt_done, clr_done;
reg plt_en, clr_en;
wire [7:0]x_plt, x_clr;
wire [6:0]y_plt, y_clr;
wire draw_plt, draw_clr;

						
//sequential block						
always@(posedge clk, negedge rst)
begin
	
	if(~rst) present_state <= A;
	else present_state <= next_state;

end			

//next state logic block
always@(*)
begin

	case(present_state)
	 
	A: begin
			if (clr) next_state = C;
			else if (~clr && plt) next_state = B;
			else next_state = A;
		end
	B: begin
			if (clr) next_state = C;
			else if (~clr && ~plt_done) next_state = B;
			else if (~clr && plt_done) next_state = A;
			else next_state = B;
		end
	C: begin
			if (~clr_done) next_state = C;
			else next_state = A;
		end
	default: next_state = A;
	
	endcase


end

//output logic block
always@(posedge clk)
begin

	case(present_state)
	
	A: begin
			plt_en = 0;
			clr_en = 0;
		end
	
	B: begin
			x = x_plt;
			y = y_plt;
			plt_en = 1;
			draw = draw_plt;
			clr_en = 0;
			colour = color;
		end
		
	C: begin
			x = x_clr;
			y = y_clr;
			clr_en = 1;
			draw = draw_clr;
			plt_en = 0;
			colour = 3'd0;
		end
	
	endcase

end

clear clearer(
				clk,
				rst,
				clr_en,
				x_clr,
				y_clr,
				draw_clr,
				clr_done
				);
				
m_circleDrawer algo(
						xc,
						yc,
						radius,
						clk,
						rst,
						plt_en,
						x_plt,
						y_plt,
						draw_plt,
						plt_done
						);
						
endmodule