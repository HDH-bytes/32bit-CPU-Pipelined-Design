module alu_arithmetic(z, cout, a, b, ctrl);
output [31:0] z;
output cout;
input [31:0] a, b;
input ctrl;
wire[31:0] notB, tmp;
wire cin;

assign cin = ctrl;
not myNot[31:0](notB, b);
mux2 #(32) mymux(tmp, b, notB, cin);
adder32 myadder(z, cout, a ,tmp , cin);

endmodule
