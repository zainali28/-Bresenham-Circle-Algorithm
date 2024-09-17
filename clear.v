module clear(
				input clk,
				input rst,
				input en,
				output reg[7:0] x,
				output reg[6:0] y,
				output reg plt,
				output reg done
				);
				
parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

reg [2:0]present_state;
reg [2:0]next_state;

//sequential block (next state update)
always@(posedge clk, negedge rst)
begin

	if(~rst) present_state <= A;
	else present_state <= next_state;
	

end	

//next state logic
always@(*)
begin

	case(present_state)
	
	A: begin
			if(en) next_state = B;
			else next_state = A;
		end
	B: begin
			if(x > 8'd159) next_state = F;
			else next_state = C;
		end
	C: begin
			if (y > 7'd119) next_state = E;
			else next_state = D;
		end
	D: next_state = C;
	E: next_state = B;
	F: next_state = A;
	
	endcase

end

//output logic
always@(posedge clk)
begin

	case(present_state)
		
		A: begin
				done = 0;
				x = 8'd0;
				y = 7'd0;
				plt = 1'd0;
			end
		D: begin
				plt = 1'd1;
				y = y + 7'd1;
			end
		E: begin
				x = x + 8'd1;
				y = 7'd0;
				plt = 1'd0;
			end
		F: done = 1;
	
	endcase

end

				
endmodule