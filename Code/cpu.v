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

module FA_df2(sum, cout, A, B, cin);
	output sum, cout;
	input A, B, cin;
  	assign{cout, sum} = A + B + cin;
endmodule

module eightbit_fulladder(Sum, Cout, Cin, A, B, mode); //mode 1: sub, mode 0: add
	output [7:0]Sum;
	output Cout;
	input Cin;
	input mode;
	input[7:0] A, B;
	wire C1, C2, C3, C4, C5, C6, C7;

	//if(mode == 1)
  		//assign B = ~B +1 ;

	FA_df2 FA1(Sum[0], C1, A[0], B[0], Cin);
	FA_df2 FA2(Sum[1], C2, A[1], B[1], C1);
	FA_df2 FA3(Sum[2], C3, A[2], B[2], C2);
	FA_df2 FA4(Sum[3], C4, A[3], B[3], C3);
	FA_df2 FA5(Sum[4], C5, A[4], B[4], C4);
	FA_df2 FA6(Sum[5], C6, A[5], B[5], C5);
	FA_df2 FA7(Sum[6], C7, A[6], B[6], C6);
	FA_df2 FA8(Sum[7], Cout, A[7], B[7], C7);
endmodule

module adder_unit_test_bench;
	reg [7:0] a;
	reg [7:0] b;
	reg cin;
	
	wire [7:0] sum;
	wire cout;
	initial begin
		a = 0;
		b = 0;
		cin = 0;
		#100 a=8'b00110111; b=8'b00000101; cin=1'b0;
		#100 a=8'b00110000; b=8'b00000110; cin=1'b0;
		#100 a=8'b01011110; b=8'b00000100; cin=1'b0;
		#100 a=8'b01101110; b=8'b00000011; cin=1'b0;
		#100 a=8'b01101111; b=8'b00000111; cin=1'b0;
		#100 a=8'b01110000; b=8'b00001000; cin=1'b0;
		#100 a=8'b11111111; b=8'b00000000; cin=1'b1;
	end
endmodule
	