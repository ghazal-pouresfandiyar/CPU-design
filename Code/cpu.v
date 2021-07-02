module CPU(CLK);
	reg [3:0]PC;
	input CLK;
	reg [2:0]SC;
	reg [3:0]AR;
	reg [7:0]IR;
	reg [2:0]opcode;
	reg I; 
	wire IR0, IR1, IR2, IR3, IR4, IR5, IR6, IR7;
	assign IR7 = IR[7];
	assign IR6 = IR[6];
	assign IR5 = IR[5];
	assign IR4 = IR[4];
	assign IR3 = IR[3];
	assign IR2 = IR[2];
	assign IR1 = IR[1];
	assign IR0 = IR[0];
	wire DR3, DR2, DR1, DR0;
	assign write = 0;
	memory(CLK, AR, IR, DR, write); //inputash check she
	assign SC = 3'b000;
	always @ (posedge CLK)
	begin 
		case(SC)
		3'b000: begin
			AR[3:0] = PC[3:0];
			SC= SC+1;
			end
		3'b001: begin
			PC = PC + 1;
			assign {IR} = {DR};
			SC=SC+1;
			end
		3'b010: begin
			//assign {I, opcode, AR} = {IR[7], IR[6:4], IR[3:0]};
			//I = IR[7];
			assign I = IR7;
			assign {AR} = {IR3, IR2, IR1, IR0};
			assign {opcode} = {IR6, IR5, IR4};
			//opcode[2:0] = IR[6:4];
			SC=SC+1;
			end
		3'b011: begin
                        if (I == 1)
				assign {AR} = {DR3, DR2, DR1, DR0};
				//AR[3:0] = DR[3:0]; // inja bas 3 bite memoriyo joda konim berizim ar
                        SC=SC+1;
                        end
		endcase
	end
endmodule
	
module memory(CLK, AR, data_in, DR, write);
    input CLK;
    input [3:0]AR; //address
    input [7:0]data_in;
    input write;
    output [7:0]DR;
    reg [7:0]M[0:15];

    always @(posedge CLK)
    begin
      if(write==1)
        M[AR] = data_in;
      DR = M[AR];
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