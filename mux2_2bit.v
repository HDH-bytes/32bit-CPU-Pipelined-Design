module mux2_2bit(z, a, b, c);
	output [1:0] z;
	input [1:0] a, b;
	input c;
	mux1 upper(z[0], a[0], b[0], c);
	mux1 lower(z[1], a[1], b[1], c);
	
endmodule

