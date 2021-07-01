module ALU(
	input [7:0] AC,
	input [7:0] DR,
	input [2:0] selector,

	output reg [7:0] result,
	output E
	);

always @(*)
begin
	case(selector)
	3'b000: result = AC + DR; //add
	//eightbit_fulladder(result, zero, AC, DR, 0);
	3'b001: result = AC - DR; //sub
	//eightbit_fulladder(result, zero, AC, DR, 1);
	3'b010: result = AC ^ DR; //xor
	3'b011: result = AC + AC; //multiply by 2
	//eightbit_fulladder(result, zero, AC, AC, 0);
	3'b110: result = ~AC; //cmp
	default: result = 8'd0;
	endcase
end
endmodule

module adder(AC, DR, Result, E, mode);
	input[7:0] AC;
	input[7:0] DR;
	input mode; //0 if add, 1 if sub

	output reg[7:0] Result;
	output reg E;

	wire[7:0] AC;
	wire[7:0] DR;
	wire mode; //0 if add, 1 if sub

	always @(AC,DR) begin
    		if (mode == 0'b1)
        		{E, Result} = AC - DR;
    		else if (mode == 1'b0)
        		{E, Result} = AC + DR;
    	end
endmodule

	