module testVector();
	reg clk, reset;
	reg Q, D, N, DISP, RN, RD, R2D;
	wire Dispense, ReturnNickel, ReturnDime, ReturnTwoDimes;
	reg [3:0] currentState, nextState, exp_state, exp_next;
	
	reg [31:0] vectornum, errors;
	reg [14:0] testVectors [10000:0];
	
	vendingMachine tester(clk, reset, N, D, Q, Dispense, ReturnNickel, ReturnDime, ReturnTwoDimes);
	
	
	always
		begin
			clk = 1; #10; clk = 0; #10;
		end
		
		initial
			begin
				$readmemb("C:/Intel Quartus Prime/VendingMachine/testVectors.tv", testVectors);
				vectornum = 0; errors = 0;
				reset = 1; #27; reset = 0;
			end
			
		always @ (posedge clk)
			begin
				#1; {exp_state[3:0], exp_next[3:0], N, D, Q, DISP, RN, RD, R2D} = testVectors[vectornum];
				currentState <= tester.currentState;
				nextState <= tester.nextState;
				$display("currentState=%4b, nextState=%4b", tester.currentState, tester.nextState);
            $display("N=%b, D=%b, Q=%b", N, D, Q);
            $display("disp=%b, Return Nickels = %b, Return Dime = %b, Return Two Dimes = %b", 
                DISP, RN, RD, R2D);
			end
			
		always @(negedge clk)
			if (~reset) 
			begin
			if (currentState !== exp_state)
			begin
				$display("Error: Current State %b (Expected: %b)", currentState, exp_state);
				errors = errors + 1;
			end
			if (nextState !== exp_next)
			begin
				$display("Error: Next State %b (Expected: %b)", nextState, exp_next);
				errors = errors + 1;
			end
			
			if (DISP !== Dispense) 
			begin
				$display("Error: Dispense %b (Expected: %b)", Dispense, DISP);
				errors = errors + 1;
				
			end
			
			if (RN !== ReturnNickel) 
			begin
				$display("Error: Nickel Return %b (Expected: %b)", ReturnNickel, RN);
				errors = errors + 1;
			end
			
			if (RD !== ReturnDime) 
			begin
				$display("Error: Dime Return %b (Expected: %b)", ReturnDime, RD);
				errors = errors + 1;	
			end
			
			if (R2D !== ReturnTwoDimes) 
			begin
				$display("Error: Two Dimes Return %b (Expected: %b)", ReturnTwoDimes, R2D);
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
		
			if (testVectors[vectornum] === 15'bx) 
			begin
				$display("%d tests completed with %d errors", vectornum, errors);
			$finish;
			end
			end
endmodule
	