module CPU(clk, AC_input, PC_input, IR_input);
	input clk;
	//input [7:0]M_input[0:15];
	input [7:0]AC_input; 
	input [3:0]PC_input;
	input [7:0]IR_input;
	//define regs for inputs
	reg [7:0]M[0:15];
	reg [7:0]AC; 
	reg [3:0]PC;
	reg [7:0]IR;
	//auxiliary regs
	reg [2:0]SC;
	reg [3:0]AR;
	reg [2:0]opcode;
	reg I; 
	reg IR0, IR1, IR2, IR3, IR4, IR5, IR6, IR7;
	//assignments
	assign SC = 3'b000;
	//assign M = M_input;
	assign AC = AC_input;
	assign PC = PC_input;
	assign IR = IR_input;

	always @ (posedge clk)
	begin 
		case(SC)
		3'b000: begin
			AR[3:0] = PC[3:0];
			SC = SC + 1;
			end
		3'b001: begin
			PC = PC + 1;
			assign {IR} = {M[AR]};
			SC = SC + 1;
			end
		3'b010: begin
			assign IR7 = IR[7];
			assign IR6 = IR[6];
			assign IR5 = IR[5];
			assign IR4 = IR[4];
			assign IR3 = IR[3];
			assign IR2 = IR[2];
			assign IR1 = IR[1];
			assign IR0 = IR[0];
			assign I = IR7;
			assign {opcode} = {IR6, IR5, IR4};
			assign {AR} = {IR3, IR2, IR1, IR0};
			SC = SC + 1;
			end
		3'b011: begin
                        if (I == 1)
				assign {AR} = {M[AR]};
                        SC = SC + 1;
                        end
		3'b100: begin
			case(opcode)
			3'b000: begin
				assign AC = AC + M[AR]; 
				SC = 0;
				end
			3'b001: begin
				assign AC = AC - M[AR];
				SC = 0;
				end
			3'b010: begin
				assign AC = AC ^ M[AR];
				SC = 0;
				end
			3'b011: begin
				M[AR] = M[AR] + M[AR]; 
				SC = 0;
				end
			3'b100: begin
				assign AC = M[AR];
				SC = 0;
				end
			3'b101: begin
				M[AR] = AC; 
				SC = 0;
				end
			3'b110: begin
				M[AR] = ~M[AR];
				SC = 0;
				end
			endcase
			end 
		endcase
	end
endmodule

`timescale 1ns / 1ps
`include "Parameter.v"
module test_bench;
	reg clk;
	reg [7:0] AC;
	reg [7:0] PC;
	reg [7:0] IR;


	initial
	begin
	clk <= 0;
	`simulation_time;
   	$finish;
	AC = 8'b00000000;
	PC = 8'b00000000;
	IR = 01100000; //cmp instruction, direct addressing in address 0000
	end
	
	CPU cpu(
		.clk(clk),
		.AC(AC),
		.PC(PC),
		.IR(IR));
	always
	begin
		#5 clk = ~clk;
	end
endmodule