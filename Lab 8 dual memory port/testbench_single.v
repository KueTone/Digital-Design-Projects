module testbench_single();
	//inputs
	reg [7:0] d;
	reg [6:0] a;
	reg we, clk;
	
	//outputs
	wire [7:0] q;
	
	//calling module
	ram_single main(q, a, d, we, clk);
	
	//generate clock
	always
	begin
		clk = 1; #50; clk = 0; #50; //total period is 100 : default in modelsim simulation
	end
	
	initial
	begin
		$display("Test 1");
		//test 1
		d = 8'b11110000; a = 7'b0000000; we = 1'b1; #100;
		we = 1'b0; #50;
		if(q != d) $display("Error: Output = %b (Expected = %b)", q, d);
		else $display("Success: Output = %b (Expected = %b)", q, d);
		
		$display("Test 2");
		//test 2
		d = 8'b10101010; a = 7'b0000001; we = 1'b1; #100;
		we = 1'b0; #50;
		if(q != d) $display("Error: Output = %b (Expected = %b)", q, d);
		else $display("Success: Output = %b (Expected = %b)", q, d);
		
		$display("Test 3");
		//test 3
		d = 8'b11001100; a = 7'b0000010; we = 1'b1; #100;
		we = 1'b0; #50;
		if(q != d) $display("Error: Output = %b (Expected = %b)", q, d);
		else $display("Success: Output = %b (Expected = %b)", q, d);
		
		$display("Test 4");
		//test 4
		d = 8'b00110011; a = 7'b0000011; we = 1'b1; #100;
		we = 1'b0; #50;
		if(q != d) $display("Error: Output = %b (Expected = %b)", q, d);
		else $display("Success: Output = %b (Expected = %b)", q, d);
		
		$display("Test 5: Don't Write");
		//test 4
		d = 8'b11111111; a = 7'b0000010; #100;
		if(q != 8'b11001100) $display("Error: Output = %b (Expected = 11001100)", q);
		else $display("Success: Output = %b (Expected = 11001100)", q);
		
	end
	
endmodule