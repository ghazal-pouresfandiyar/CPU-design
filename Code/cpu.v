module CPU(PC, CLK, SC,AR, IR, opcode, I);
	input [3:0]PC;
	input CLK;
	input [2:0]SC;
	input [3:0]AR;
	input [7:0]IR;
	input [2:0]opcode;
	input I ; 
	assign write = 0;
	memory(CLK, AR, IR, DR, write); //inputash check she
	assign SC = 3'b000;
	always @ (posedge CLK)
	//SC = SC + 3b'001;
	begin 
		case(SC)
		3'b000: begin
			AR[3:0] = PC[3:0];
			//SC[2:0] = SC[2:0] + 3b'001`;
			end
		3'b001: begin
			PC[3:0] = PC[3:0] + 4b'0001;
			IR[7:0] = DR[7:0];
			//SC = SC + 3b'001`;
			end
		3'b010: begin
			I = IR[7];
			AR[3:0] = IR[3:0];
			opcode[2:0] = IR[6:4];
			//assign SC = SC + 3b'001`;
			end
		3'b011: if (I == 1)
				AR[3:0] = DR[3:0]; // inja bas 3 bite memoriyo joda konim berizim ar
		endcase
		SC[2:0] = SC[2:0] + 3b'001`;
	end
endmodule
	
module memory(CLK, AR, data_in, DR, write);

    input CLK;
    input [3:0]AR; //address
    input [7:0]data_in;
    input write;
    output [7:0]DR;
    reg [7:0]M[0:15];

    always @(posedge clk)
    begin
      if(write==1)
        M[AR] <= data_in;
      DR <= M[AR];
    end

  endmodule

module alu (opcode , AC , DR , enable , result);
	input [7:0] AC;
	input [7:0] DR;
	input [2:0] opcode;
	input enable;
	output [7:0] result; 
	reg [7:0] result ; 
	always @ ( enable)
	begin
		case (opcode)
		3'b000 : result = AC + DR;
		3'b001 : result = AC - DR;
		3'b010 : result = AC ^ DR; 
		3'b011 : result = AC + AC; 
		3'b110 : result = ~AC; 
		endcase
	end
endmodule
