module ALU #(parameter N = 32) (A, B, f, y, o, z);

	input [N-1 : 0] A, B;
	input [2:0] f;
	output reg [N-1 : 0] y;
	output reg o;
	output z;
	wire [N-1: 0] sum, w;
	wire n;
	
	assign n= N-1;
	assign w=f[2] ? ~B : B;
	assign sum = A ^ w ^ f[2];
	
	always @ (*)
	begin
		case(f[1:0])
			2'b00 : y <= A & w;
			2'b01 : y <= A | w;
			2'b10 : y <= sum;
			2'b11 : y <= sum[n];
		endcase
		
		case (f[2])
			1'b0 : o <= (A[n] & B[n] & ~sum[n]) | (~A[n] & ~B[n] & sum[n]);
			1'b1 : o <= (~A[n] & B[n] & sum[n]) | (A[n] & ~B[n] & ~sum[n]);
			default : o <= 0;
		endcase
	end
	
	assign z = (y == 32'b0);
	
endmodule