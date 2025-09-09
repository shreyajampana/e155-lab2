/*
Shreya Jampana
Email: sjampana@hmc.edu
9/6/25
This is the testbench for the multiplexer module. It checks that on a specific enable signal, the correct 
corresponding four input bits are sent to the seven segment module. 
*/

`timescale 1ns/1ns

module multiplexer_sj_testbench();
	
	// Defining variables
	logic clk, reset;
	logic [1:0] enable;
	logic [3:0] s;
	logic [7:0] s_counter;
	
	//Instantiating the multiplexer module, which is the dut
	multiplexer_sj mux(clk, reset, s_counter[3:0], s_counter[7:4], enable, s);
	
	//Generate clock
	always
		begin
		//Create clock with period of 10 time units. 
		//Set the clk signal HIGH(1) for 5 units, LOW(0) for 5 units 
			clk=1; #5; 
			clk=0; #5;
		end
		
	//Start of test
	initial
		begin
			// Pulse reset for 22 time units(2.2 cycles) so the reset signal falls after a clk edge.
			// The signal starts HIGH(0) for 22 time units then remains LOW(1) for the rest of the test
			reset=0; #22; 
			reset=1;
		end
		
		//Doing the reset case and incrementing s_counter
		always_ff @(posedge clk)
			begin
				if (reset == 0) s_counter <= 0; 
				else s_counter <= s_counter + 1;
			end
		
		// Checking enables on positive edge of the clk
		always_ff @(posedge clk)
			begin
				if (enable[0])
					begin
						assert (s == s_counter[3:0]) else $error("Error in seven segment with s1");
					end
				else if (enable[1]) 
					begin
						assert (s == s_counter[7:4]) else $error("Error in seven segment with s2");
					end
			end

endmodule

	
	
   
