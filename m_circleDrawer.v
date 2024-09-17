module m_circleDrawer(input[6:0] xc ,input[5:0] yc ,input[5:0] r ,input clk ,input rst, input enable,
					  output reg[7:0] x_coord , output reg[6:0] y_coord , output reg plot, output reg done);


					  
parameter  A = 4'b0000, B = 4'b0001,C = 4'b0010 , D = 4'b0011,
			  E = 4'b0100, F = 4'b0101,G = 4'b0110 , H = 4'b0111,
			  I = 4'b1000, J = 4'b1001,K = 4'b1010 , L = 4'b1011,
			  M = 4'b1100;
		  

		  
reg[3:0] present_state = B;
reg[3:0] next_state;

reg[7:0]x;
reg[6:0]y;
reg signed [8:0]d;




//next state logic
always@( * )begin
	
	case(present_state)
	
		A:	begin
		
			if(x>y) next_state = M; 
			else next_state = C;
		
			end
			
		B:  begin
		
			 if(enable ==1) next_state=A;
			 else next_state=B;
			 
			 end
						
		C:  begin	
			 next_state = D;
			end
			
		D:  begin
			 next_state = E;
			end
			
		E:	begin
			 next_state = F;
			end
			
		F:	begin
		    next_state = G;
			end
			
		G:	begin
		    next_state = H;
			end
			
		H: 	begin
		    next_state = I;
			end
			
		I:	begin
		    next_state = J;
			end
			
		J:	begin
				if(d<0) next_state = K;
				else 	next_state = L;
			end
			
		K:	begin
				 next_state = A;
			end
			
		L:	begin
				 next_state = A;
			end
			
		default: next_state = B;

	endcase
	

	end
	
	
	//state register logic
always@(posedge clk , negedge rst)begin
	
	 if(~rst) present_state <= B;
	 else present_state <= next_state;

	
end

	//output logic
always@(posedge clk) begin
	
	 case(present_state)
	 
	 A: begin
		 plot = 0;
		 end
	 
	 B: begin
		 plot = 0;
		 x = 0;
		 if (r > 59) y = 7'd59;
		 else y = r;
		 d = 3 - 2*r;
		 done = 0;
		 end
	 
	 C:begin
		 x_coord = xc + x;
		 y_coord = yc + y;
		 plot = 1;
		end
		
	 D:begin
		x_coord = xc - x;
		y_coord = yc + y;
		plot = 1;
		end
		
		
	 E:begin
		x_coord = xc + x;
		y_coord = yc - y;
		plot = 1;
		end
		
		
	 F:begin
		x_coord = xc - x;
		y_coord = yc - y;
		plot = 1;
		end
		
	 G:begin
	   x_coord = xc + y;
		y_coord = yc + x;
		plot = 1;
		end
		
	 H:begin
		x_coord = xc - y;
		y_coord = yc + x;
		plot = 1;
		end
		
	 I:begin
		x_coord = xc + y;
		y_coord = yc - x;
		plot = 1;
		end
		
	 J: begin
		x_coord = xc - y;
		y_coord = yc - x;
		plot = 1;
		
		
		x=x+1;
		end
		
		
	 K:begin
		plot=0;	
		d = d + (4 * x) +6;
		end
		
		
	 L:begin
		plot = 0 ;
		d = d + 4 * (x-y) + 10;
		y = y-1;
		end
		
	 M:begin
		done = 1;
		end
		
	 endcase

end

endmodule