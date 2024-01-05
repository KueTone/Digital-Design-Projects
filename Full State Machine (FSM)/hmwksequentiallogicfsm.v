
module jk_ff (input  [1:0]jk, output reg q);   
	
	reg clk;
	
	
	parameter S0= 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	parameter S3 = 2'b11;
	
	initial begin
		q=0; 
		end
		
  always begin
		clk=0; #50; clk = 1; #50;
	end
   always @ (posedge clk)  
      case (jk)  
         S0 :  q <= q;  
         S1 :  q <= 0;  
         S2 :  q <= 1;  
         S3 :  q <= ~q;  
      endcase  
endmodule  
