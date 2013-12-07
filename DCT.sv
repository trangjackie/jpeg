/*************************************************************
	DCT.sv
	Original DCT for 8x8 block
	Y = RXR'
*************************************************************/
module DCT(clk,rst,x,y);
input clk,rst;
input [7:0] x[0:7][0:7];
output [7:0] y[0:7][0:7];
wire [7:0] m[0:7][0:7];
// DCT constant
wire [7:0] r[0:7][0:7]; // 2's complement number
assign r[0][0]=45,r[0][1]=45,r[0][2]=45,r[0][3]=45,r[0][4]=45,r[0][5]=45,r[0][6]=45,r[0][7]=45;
assign r[1][0]=63,r[1][1]=53,r[1][2]=36,r[1][3]=12,r[1][4]=-12,r[1][5]=-36,r[1][6]=-53,r[1][7]=-63;
assign r[2][0]=59,r[2][1]=24,r[2][2]=-24,r[2][3]=-59,r[2][4]=-59,r[2][5]=-24,r[2][6]=24,r[2][7]=59;
assign r[3][0]=53,r[3][1]=-12,r[3][2]=-63,r[3][3]=-36,r[3][4]=36,r[3][5]=63,r[3][6]=12,r[3][7]=-53;
assign r[4][0]=45,r[4][1]=-45,r[4][2]=-45,r[4][3]=45,r[4][4]=45,r[4][5]=-45,r[4][6]=-45,r[4][7]=45;
assign r[5][0]=36,r[5][1]=-63,r[5][2]=12,r[5][3]=53,r[5][4]=-53,r[5][5]=-12,r[5][6]=63,r[5][7]=-36;
assign r[6][0]=24,r[6][1]=-59,r[6][2]=59,r[6][3]=-24,r[6][4]=-24,r[6][5]=59,r[6][6]=-59,r[6][7]=24;
assign r[7][0]=12,r[7][1]=-36,r[7][2]=53,r[7][3]=-63,r[7][4]=63,r[7][5]=-53,r[7][6]=36,r[7][7]=-12;
wire [7:0] rt[0:7][0:7];
assign rt[0][0]=45,rt[1][0]=45,rt[2][0]=45,rt[3][0]=45,rt[4][0]=45,rt[5][0]=45,rt[6][0]=45,rt[7][0]=45;
assign rt[0][1]=63,rt[1][1]=53,rt[2][1]=36,rt[3][1]=12,rt[4][1]=-12,rt[5][1]=-36,rt[6][1]=-53,rt[7][1]=-63;
assign rt[0][2]=59,rt[1][2]=24,rt[2][2]=-24,rt[3][2]=-59,rt[4][2]=-59,rt[5][2]=-24,rt[6][2]=24,rt[7][2]=59;
assign rt[0][3]=53,rt[1][3]=-12,rt[2][3]=-63,rt[3][3]=-36,rt[4][3]=36,rt[5][3]=63,rt[6][3]=12,rt[7][3]=-53;
assign rt[0][4]=45,rt[1][4]=-45,rt[2][4]=-45,rt[3][4]=45,rt[4][4]=45,rt[5][4]=-45,rt[6][4]=-45,rt[7][4]=45;
assign rt[0][5]=36,rt[1][5]=-63,rt[2][5]=12,rt[3][5]=53,rt[4][5]=-53,rt[5][5]=-12,rt[6][5]=63,rt[7][5]=-36;
assign rt[0][6]=24,rt[1][6]=-59,rt[2][6]=59,rt[3][6]=-24,rt[4][6]=-24,rt[5][6]=59,rt[6][6]=-59,rt[7][6]=24;
assign rt[0][7]=12,rt[1][7]=-36,rt[2][7]=53,rt[3][7]=-63,rt[4][7]=63,rt[5][7]=-53,rt[6][7]=36,rt[7][7]=-12;
// combine logic to calculate matrix multiplication
// M = R*X
DCT_line_array U0(clk,rst,r[0][0:7],x,m[0][0:7]);
DCT_line_array U1(clk,rst,r[1][0:7],x,m[1][0:7]);
DCT_line_array U2(clk,rst,r[2][0:7],x,m[2][0:7]);
DCT_line_array U3(clk,rst,r[3][0:7],x,m[3][0:7]);
DCT_line_array U4(clk,rst,r[4][0:7],x,m[4][0:7]);
DCT_line_array U5(clk,rst,r[5][0:7],x,m[5][0:7]);
DCT_line_array U6(clk,rst,r[6][0:7],x,m[6][0:7]);
DCT_line_array U7(clk,rst,r[7][0:7],x,m[7][0:7]);
// Y = M*R'
DCT_line_array U8(clk,rst,m[0][0:7],rt,y[0][0:7]);
DCT_line_array U9(clk,rst,m[1][0:7],rt,y[1][0:7]);
DCT_line_array U10(clk,rst,m[2][0:7],rt,y[2][0:7]);
DCT_line_array U11(clk,rst,m[3][0:7],rt,y[3][0:7]);
DCT_line_array U12(clk,rst,m[4][0:7],rt,y[4][0:7]);
DCT_line_array U13(clk,rst,m[5][0:7],rt,y[5][0:7]);
DCT_line_array U14(clk,rst,m[6][0:7],rt,y[6][0:7]);
DCT_line_array U15(clk,rst,m[7][0:7],rt,y[7][0:7]);


endmodule

module DCT_line_array(clk,rst,r,x,m);
input clk,rst;
input [7:0] r[0:7];
input [7:0] x[0:7][0:7];
output [7:0]m[0:7];
DCT_line U00(clk,rst,r[0:7],x[0][0],x[1][0],x[2][0],x[3][0],x[4][0],x[5][0],x[6][0],x[7][0],m[0]);
DCT_line U01(clk,rst,r[0:7],x[0][1],x[1][1],x[2][1],x[3][1],x[4][1],x[5][1],x[6][1],x[7][1],m[1]);
DCT_line U02(clk,rst,r[0:7],x[0][2],x[1][2],x[2][2],x[3][2],x[4][2],x[5][2],x[6][2],x[7][2],m[2]);
DCT_line U03(clk,rst,r[0:7],x[0][3],x[1][3],x[2][3],x[3][3],x[4][3],x[5][3],x[6][3],x[7][3],m[3]);
DCT_line U04(clk,rst,r[0:7],x[0][4],x[1][4],x[2][4],x[3][4],x[4][4],x[5][4],x[6][4],x[7][4],m[4]);
DCT_line U05(clk,rst,r[0:7],x[0][5],x[1][5],x[2][5],x[3][5],x[4][5],x[5][5],x[6][5],x[7][5],m[5]);
DCT_line U06(clk,rst,r[0:7],x[0][6],x[1][6],x[2][6],x[3][6],x[4][6],x[5][6],x[6][6],x[7][6],m[6]);
DCT_line U07(clk,rst,r[0:7],x[0][7],x[1][7],x[2][7],x[3][7],x[4][7],x[5][7],x[6][7],x[7][7],m[7]);
endmodule

module DCT_line(clk,rst,a,b0,b1,b2,b3,b4,b5,b6,b7,c);
input clk,rst;
input [7:0] a[0:7];
input [7:0] b0,b1,b2,b3,b4,b5,b6,b7;
output [7:0] c;

reg[7:0]c;
always @(posedge clk or negedge rst)
begin
	if (rst==0)
	begin
		c <= 8'b0;
	end
	else
	begin
		c <= (a[0]*b0+a[1]*b1+a[2]*b2+a[3]*b3+a[4]*b4+a[5]*b5+a[6]*b6+a[7]*b7)/128;
	end
end

endmodule

/*************************************************************
	End of file
************************************************************/
