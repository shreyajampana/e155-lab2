/*
Shreya Jampana
Email: sjampana@hmc.edu
9/6/25
This is the testbench for the top level module of lab 2. It primarily checks the combinational 
logic of the five LEDs. 
*/

`timescale 1ns/1ns

module lab2_sj_testbench();
	
	//Defining the variables
	logic clk, reset;
	logic [7:0] s_count_top;
	logic [1:0] enable;
	logic [6:0] seg;
	logic [4:0] led;
	
	//Instantiating the top level module, which is the dut
	lab2_sj dut(reset, s_count_top[3:0], s_count_top[7:4], enable, seg, led);
	
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
			
			// Checking that the combinational logic functions as expected
			for(s_count_top = 0; s_count_top < 'd255; s_count_top++)
				begin
					assert (led[4:0] == s_count_top[3:0] + s_count_top[7:4]) else $error("Error in LED combinational logic"); #20;
				end
		end
	
	
	
endmodule

