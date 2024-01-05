module vendingMachine (input clk, reset, N, D, Q, output Dispense, ReturnNickel, ReturnDime, ReturnTwoDimes);

	reg [3:0] currentState, nextState;
	parameter S0 	= 5'b0000;
	parameter S5 	= 5'b0001;
	parameter S10 	= 5'b0010;
	parameter S15	= 5'b0100;
	parameter S20 	= 5'b1000;
	
	always @ (posedge clk, posedge reset)
		if (reset) currentState <= S0;
		else currentState <= nextState;
		
	always @(*)
		case (currentState)
			S0:	if (N) nextState 			<= S5;
					else if (D) nextState 	<= S10;
					else if (Q) nextState 	<= S0;
					else 			nextState	<= S0;
					
 			S5:	if (N) nextState 			<= S10;
					else if (D) nextState 	<= S15;
					else if (Q) nextState 	<= S0;
					else 			nextState	<= S5;
					
 			S10:	if (N) nextState 			<= S15;
					else if (D) nextState 	<= S20;
					else if (Q) nextState 	<= S0;
					else 			nextState	<= S10;
					
 			S15:	if (N) nextState 			<= S20;
					else if (D) nextState 	<= S0;
					else if (Q) nextState 	<= S0;
					else 			nextState	<= S15;
					
 			S20:	if (N) nextState 			<= S0;
					else if (D) nextState 	<= S0;
					else if (Q) nextState 	<= S0;
					else 			nextState	<= S20;
			default:				nextState 	<= S0;
		endcase
		
	assign Dispense = 
				(Q & currentState == S0) |
				(Q & currentState == S5) |
				(Q & currentState == S10) |
				(D & currentState == S15) |
				(Q & currentState == S15) |
				(N & currentState == S20) |
				(D & currentState == S20) |
				(Q & currentState == S20);
	assign ReturnNickel =
				(Q & currentState == S5)  |
				(Q & currentState == S15) |
				(D & currentState == S20);
				
	assign ReturnDime = 
				(Q & currentState == S10) |
				(Q & currentState == S15);
				
	assign ReturnTwoDimes = (Q & currentState == S20);
	
endmodule


 