module testbench_dual();
	//inputs
	reg [7:0] d1, d2;
	reg [6:0] a1, a2;
	reg wr1, wr2, clk1, clk2;
	
	//outputs
	wire [7:0] q1, q2;
	
	//calling module
	dual_ram main(q1, q2, a1, a2, d1, d2, wr1, wr2, clk1, clk2);
	
	//generate clock
	always
	begin
		clk1 = 1; #50; clk1 = 0; #50; //total period is 100 : default in modelsim simulation
	end
	
	always
	begin
		clk2 = 1; #50; clk2 = 0; #50; //total period is 100 : default in modelsim simulation
	end
	
	initial
	begin
	
	//test 1
	$display("Test 1");
	d1 = 8'b11110000; a1 = 7'b0000000; 
	d2 = 8'b11110001; a2 = 7'b0000001; 
	wr1 = 1'b1; wr2 = 1'b1; #100;
	wr1 = 1'b0; wr2 = 1'b0; #100;
	
	if(q1 != d1) $display("Error: Port A Output = %b (Expected = %b)", q1, d1);
	else $display("Success: Port A Output = %b (Expected = %b)", q1, d1);
	
	if(q2 != d2) $display("Error: Port B Output = %b (Expected = %b)", q2, d2);
	else $display("Success: Port B Output = %b (Expected = %b)", q2, d2); 
	
	
	//test 2
	$display("Test 2");
	d1 = 8'b00110011; a1 = 7'b0000010; 
	d2 = 8'b11001100; a2 = 7'b0000011; 
	wr1 = 1'b1; wr2 = 1'b1; #100;
	wr1 = 1'b0; wr2 = 1'b0; #100;
	
	if(q1 != d1) $display("Error: Port A Output = %b (Expected = %b)", q1, d1);
	else $display("Success: Port A Output = %b (Expected = %b)", q1, d1);
	
	if(q2 != d2) $display("Error: Port B Output = %b (Expected = %b)", q2, d2);
	else $display("Success: Port B Output = %b (Expected = %b)", q2, d2); 
	
	//test 3
	$display("Test 3");
	d1 = 8'b11111111; a1 = 7'b0000100; 
	d2 = 8'b00000000; a2 = 7'b0000101; 
	wr1 = 1'b1; wr2 = 1'b1; #100;
	wr1 = 1'b0; wr2 = 1'b0; #100;
	
	if(q1 != d1) $display("Error: Port A Output = %b (Expected = %b)", q1, d1);
	else $display("Success: Port A Output = %b (Expected = %b)", q1, d1);
	
	if(q2 != d2) $display("Error: Port B Output = %b (Expected = %b)", q2, d2);
	else $display("Success: Port B Output = %b (Expected = %b)", q2, d2); 
	
	//test 4
	$display("Test 4: Dont Write");
	d1 = 8'b00000000; a1 = 7'b0000010; 
	d2 = 8'b11111111; a2 = 7'b0000011;
	wr1 = 1'b0; wr2 = 1'b0; #100;
	
	$display("Port A input: %b", d1);
	$display("Port B input: %b", d2);
	
	if(q1 != 8'b00110011) $display("Error: Port A Output = %b (Expected = 00110011)", q1);
	else $display("Success: Port A Output= %b (Expected = 00110011)", q1);
	
	if(q2 != 8'b11001100) $display("Error: Port B Output = %b (Expected = 11001100)", q2);
	else $display("Success: Port B Output = %b (Expected = 11001100)", q2); 
	
	
	//test 5
	$display("Test 5: Intentional Error");
	d1 = 8'b00000000; a1 = 7'b0000100; 
	d2 = 8'b11111111; a2 = 7'b0000101;
	wr1 = 1'b1; wr2 = 1'b1; #100;
	wr1 = 1'b0; wr2 = 1'b0; #100;
	
	$display("Port A input: %b", d1);
	$display("Port B input: %b", d2);
	
	if(q1 != 8'b11111111) $display("Error: Port A Output = %b (Expected = 11111111)", q1);
	else $display("Success: Port A Output= %b (Expected = 11111111)", q1);
	
	if(q2 != 8'b00000000) $display("Error: Port B Output = %b (Expected = 0000000)", q2);
	else $display("Success: Port B Output = %b (Expected = 00000000)", q2); 
	
	end
	
endmodule