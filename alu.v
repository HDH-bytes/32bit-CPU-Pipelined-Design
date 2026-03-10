module alu(z, ex, a, b, op);

input [31:0] a, b, slt;
input condition;
input ONE;
input [2:0] op;
output [31:0] z;
output zero; 

assign zero = 0; 
assign slt[31:1] = 0;

wire cout;
wire[31:0] andOP, orOP, add_sub, add_sub2; 

assign ONE = 1;
alu_arithmetic #(32) finalArith(add_sub2, cout, a, b, ONE);
xor #(1) my_xor(condition, a[31], b[31]);
mux2 #(1) slt_mux(slt[0], add_sub2[31], a[31], condition);
or or16[15:0] (z16, z[15: 0], z[31:16]);
or or8[7:0] (z8, z16[7: 0], z16[15:8]);
or or4[3:0] (z4, z8[3: 0], z8[7:4]);
or or2[1:0] (z2, z4[1:0], z4[3:2]);
or or1[15:0] (z1, z2[1], z2[0]);
not m_not (z0, z1);
assign ex = z0;
and my_and[31:0] (andOP, a, b);
or my_or[31:0] (orOP, a, b);
alu_arithmetic #(32) myArith(add_sub, null, a, b, op[2]);
mux4 #(32) my_Mux(z, andOP, orOP, add_sub, slt, op[1:0]);

endmodule
