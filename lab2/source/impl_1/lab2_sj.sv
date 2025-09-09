/*
Shreya Jampana
Email: sjampana@hmc.edu
9/6/25
This is the top-level module for lab 2 to control a time multiplexed dual 7-segment display and LEDs. It contains a high speed 
oscillator and controls five LEDs to display combinational summing logic. It also points to two submodules, one that controls a 
dual seven segment display, and another that implements a time multiplexing scheme to drive two seven-segment displays.
*/

module lab2_sj(input logic reset,
	input logic [3:0] s1, s2,
	output logic [1:0] enable,
	output logic [6:0] seg,
	output logic [4:0] led);
	
	logic clk;
	logic [3:0] s;
	
	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
		
	// LED sum combinational logic
	assign led[4:0] = s1[3:0] + s2[3:0];
	
	// Calling the seven segment module	
	seven_seg_sj seven_seg(s, seg);
	
	// Calling the multiplexer module
	multiplexer_sj mux(clk, reset, s1, s2, enable, s); 
		
endmodule