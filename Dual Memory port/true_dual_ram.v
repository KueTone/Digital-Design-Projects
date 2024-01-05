module true_dual_ram(q1, q2, a1, a2, d1, d2, wr1, wr2, clk); 
	output[7:0] q1, q2;
	input [7:0] d1, d2;
	input [6:0] a1, a2;
	input wr1, wr2, clk;

	reg [7:0] mem [127:0];

	assign q1 = mem[a1];
	assign q2 = mem[a2];

	always @(posedge clk) begin
		if (wr1) mem[a1] <= d1;
		if (wr2) mem[a2] <= d2;
	end
	
endmodule