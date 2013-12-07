/*********** FsDCT module *************************************/
module FsDCT(clk,rst,x,y);
parameter W = 15;
parameter SH= 7;
input clk,rst;
input [7:0] x[0:7][0:7];
output [W:0] y[0:7][0:7];

wire	[W:0] ex[8][8];
wire [W:0] m[0:7][0:7];
wire clk_bar;
assign clk_bar = ~clk;
// extend input
genvar i,j;
generate
	for (i=0;i<8;i=i+1) begin: loop_fdct_i
	for (j=0;j<8;j=j+1) begin: loop_fdct_j
		assign ex[i][j][W:8] = 8'b0;
		assign ex[i][j][7:0] = x[i][j];
	end
	end
endgenerate
// Transform rows
FsDCT_Row U0(clk,rst,ex,m);
// Transform column
FsDCT_Column U1(clk_bar,rst,m,y);

endmodule

module FsDCT_Row(clk,rst,x,m);
parameter W = 15;
parameter SH= 7;
input clk,rst;
input [W:0] x[0:7][0:7];
output [W:0] m[0:7][0:7];
FsDCT_line UR0(clk,rst,x[0][0],x[0][1],x[0][2],x[0][3],x[0][4],x[0][5],x[0][6],x[0][7],m[0][0],m[0][1],m[0][2],m[0][3],m[0][4],m[0][5],m[0][6],m[0][7]);
FsDCT_line UR1(clk,rst,x[1][0],x[1][1],x[1][2],x[1][3],x[1][4],x[1][5],x[1][6],x[1][7],m[1][0],m[1][1],m[1][2],m[1][3],m[1][4],m[1][5],m[1][6],m[1][7]);
FsDCT_line UR2(clk,rst,x[2][0],x[2][1],x[2][2],x[2][3],x[2][4],x[2][5],x[2][6],x[2][7],m[2][0],m[2][1],m[2][2],m[2][3],m[2][4],m[2][5],m[2][6],m[2][7]);
FsDCT_line UR3(clk,rst,x[3][0],x[3][1],x[3][2],x[3][3],x[3][4],x[3][5],x[3][6],x[3][7],m[3][0],m[3][1],m[3][2],m[3][3],m[3][4],m[3][5],m[3][6],m[3][7]);
FsDCT_line UR4(clk,rst,x[4][0],x[4][1],x[4][2],x[4][3],x[4][4],x[4][5],x[4][6],x[4][7],m[4][0],m[4][1],m[4][2],m[4][3],m[4][4],m[4][5],m[4][6],m[4][7]);
FsDCT_line UR5(clk,rst,x[5][0],x[5][1],x[5][2],x[5][3],x[5][4],x[5][5],x[5][6],x[5][7],m[5][0],m[5][1],m[5][2],m[5][3],m[5][4],m[5][5],m[5][6],m[5][7]);
FsDCT_line UR6(clk,rst,x[6][0],x[6][1],x[6][2],x[6][3],x[6][4],x[6][5],x[6][6],x[6][7],m[6][0],m[6][1],m[6][2],m[6][3],m[6][4],m[6][5],m[6][6],m[6][7]);
FsDCT_line UR7(clk,rst,x[7][0],x[7][1],x[7][2],x[7][3],x[7][4],x[7][5],x[7][6],x[7][7],m[7][0],m[7][1],m[7][2],m[7][3],m[7][4],m[7][5],m[7][6],m[7][7]);
endmodule

module FsDCT_Column(clk,rst,m,y);
parameter W = 15;
parameter SH= 7;
input clk,rst;
input [W:0] m[0:7][0:7];
output [W:0] y[0:7][0:7];
FsDCT_line UC0(clk,rst,m[0][0],m[1][0],m[2][0],m[3][0],m[4][0],m[5][0],m[6][0],m[7][0],y[0][0],y[1][0],y[2][0],y[3][0],y[4][0],y[5][0],y[6][0],y[7][0]);
FsDCT_line UC1(clk,rst,m[0][1],m[1][1],m[2][1],m[3][1],m[4][1],m[5][1],m[6][1],m[7][1],y[0][1],y[1][1],y[2][1],y[3][1],y[4][1],y[5][1],y[6][1],y[7][1]);
FsDCT_line UC2(clk,rst,m[0][2],m[1][2],m[2][2],m[3][2],m[4][2],m[5][2],m[6][2],m[7][2],y[0][2],y[1][2],y[2][2],y[3][2],y[4][2],y[5][2],y[6][2],y[7][2]);
FsDCT_line UC3(clk,rst,m[0][3],m[1][3],m[2][3],m[3][3],m[4][3],m[5][3],m[6][3],m[7][3],y[0][3],y[1][3],y[2][3],y[3][3],y[4][3],y[5][3],y[6][3],y[7][3]);
FsDCT_line UC4(clk,rst,m[0][4],m[1][4],m[2][4],m[3][4],m[4][4],m[5][4],m[6][4],m[7][4],y[0][4],y[1][4],y[2][4],y[3][4],y[4][4],y[5][4],y[6][4],y[7][4]);
FsDCT_line UC5(clk,rst,m[0][5],m[1][5],m[2][5],m[3][5],m[4][5],m[5][5],m[6][5],m[7][5],y[0][5],y[1][5],y[2][5],y[3][5],y[4][5],y[5][5],y[6][5],y[7][5]);
FsDCT_line UC6(clk,rst,m[0][6],m[1][6],m[2][6],m[3][6],m[4][6],m[5][6],m[6][6],m[7][6],y[0][6],y[1][6],y[2][6],y[3][6],y[4][6],y[5][6],y[6][6],y[7][6]);
FsDCT_line UC7(clk,rst,m[0][7],m[1][7],m[2][7],m[3][7],m[4][7],m[5][7],m[6][7],m[7][7],y[0][7],y[1][7],y[2][7],y[3][7],y[4][7],y[5][7],y[6][7],y[7][7]);
endmodule
/**********************************************************
	End of file
***********************************************************/

