/*
Shreya Jampana
Email: sjampana@hmc.edu
9/6/25
This multiplexer module contains a clock divider that chooses the frequency at which the time multiplexing happens. It determines which set
of four inputs is sent to the seven segment module, and assigns power to the corresponding seven segment module at the same frequencyt using
the enable signals. 
*/

module multiplexer_sj(input logic clk, reset,
	input logic [3:0] s1, s2,
	output logic [1:0] enable,
	output logic [3:0] s);
	
	logic [31:0] counter;
	
	// Simple clock divider
	always_ff @(posedge clk, negedge reset)
		begin
			if (reset==0) 
				begin
					counter <= 0;
					s = 0;
				end
			else 
				begin
					s = counter[18] ? s2 : s1;
					counter <= counter +1;
				end
		end
		
	// Enable output
	assign enable[0] = counter[18]; 
	assign enable[1] = ~counter[18];
	
endmodule
