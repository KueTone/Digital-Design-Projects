module dual_ram(q1, q2, a1, a2, d1, d2, wr1, wr2, clk1, clk2); 
	output[7:0] q1, q2;
	input [7:0] d1, d2;
	input [6:0] a1, a2;
	input wr1, wr2, clk1, clk2;

	reg [7:0] mem1 [127:0];
	reg [7:0] mem2 [127:0];

	assign q1 = mem1[a1];
	assign q2 = mem2[a2];

	always @(posedge clk1) begin
		if (wr1) begin
		mem1[a1] <= d1;
		q2<=d1;
		end
		else begin
		q1<= mem1[a1];
		end
	end
	
	always @(posedge clk2) begin
		if (wr2) begin
		mem2[a2] <= d2;
		q2 <= d2;
		end
		else begin
		q2<= mem1[a2];
		end
	end
endmodule