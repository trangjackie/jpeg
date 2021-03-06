/******************************************************
	Quant.sv
	Quantization module
*******************************************************/
module Quant(x,y);
parameter W = 15;
parameter WN= 7;
input [W:0] x [0:7][0:7];
output [WN:0]y [0:7][0:7];
/*
parameter Q[0:7][0:7]={
{16,		8,		8,		16,	32,	32,	64,	64},
{8,		8,		16,	16,	32,	64,	64,	64},
{16,		16,	16,	32,	32,	64,	64,	64},
{16,		16,	16,	32,	64,	64,	64,	64},
{16,		16,	32,	64,	64,	128,	128,	64},
{16,		32,	64,	64,	64,	128,	128,	64},
{32,		64,	64,	128,	128,	128,	128,	128},
{64,		128,	128,	128,	128,	128,	128,	128}};
*/
// Row 0
assign y[0][0] = x[0][0][4+WN:4];
assign y[0][1] = x[0][1][3+WN:3];
assign y[0][2] = x[0][2][3+WN:3];
assign y[0][3] = x[0][3][4+WN:4];
assign y[0][4] = x[0][4][5+WN:5];
assign y[0][5] = x[0][5][5+WN:5];
assign y[0][6] = x[0][6][6+WN:6];
assign y[0][7] = x[0][7][6+WN:6];

// Row 1
assign y[1][0] = x[1][0][3+WN:3];
assign y[1][1] = x[1][1][3+WN:3];
assign y[1][2] = x[1][2][4+WN:4];
assign y[1][3] = x[1][3][4+WN:4];
assign y[1][4] = x[1][4][5+WN:5];
assign y[1][5] = x[1][5][6+WN:6];
assign y[1][6] = x[1][6][6+WN:6];
assign y[1][7] = x[1][7][6+WN:6];

// Row 2
assign y[2][0] = x[2][0][4+WN:4];
assign y[2][1] = x[2][1][4+WN:4];
assign y[2][2] = x[2][2][4+WN:4];
assign y[2][3] = x[2][3][5+WN:5];
assign y[2][4] = x[2][4][5+WN:5];
assign y[2][5] = x[2][5][6+WN:6];
assign y[2][6] = x[2][6][6+WN:6];
assign y[2][7] = x[2][7][6+WN:6];

// Row 3
assign y[3][0] = x[3][0][4+WN:4];
assign y[3][1] = x[3][1][4+WN:4];
assign y[3][2] = x[3][2][4+WN:4];
assign y[3][3] = x[3][3][5+WN:5];
assign y[3][4] = x[3][4][6+WN:6];
assign y[3][5] = x[3][5][6+WN:6];
assign y[3][6] = x[3][6][6+WN:6];
assign y[3][7] = x[3][7][6+WN:6];

// Row 4
assign y[4][0] = x[4][0][4+WN:4];
assign y[4][1] = x[4][1][4+WN:4];
assign y[4][2] = x[4][2][5+WN:5];
assign y[4][3] = x[4][3][6+WN:6];
assign y[4][4] = x[4][4][6+WN:6];
assign y[4][5] = x[4][5][7+WN:7];
assign y[4][6] = x[4][6][7+WN:7];
assign y[4][7] = x[4][7][6+WN:6];

// Row 5
assign y[5][0] = x[5][0][4+WN:4];
assign y[5][1] = x[5][1][5+WN:5];
assign y[5][2] = x[5][2][6+WN:6];
assign y[5][3] = x[5][3][6+WN:6];
assign y[5][4] = x[5][4][6+WN:6];
assign y[5][5] = x[5][5][7+WN:7];
assign y[5][6] = x[5][6][7+WN:7];
assign y[5][7] = x[5][7][6+WN:6];

// Row 6
assign y[6][0] = x[6][0][5+WN:5];
assign y[6][1] = x[6][1][6+WN:6];
assign y[6][2] = x[6][2][6+WN:6];
assign y[6][3] = x[6][3][7+WN:7];
assign y[6][4] = x[6][4][7+WN:7];
assign y[6][5] = x[6][5][7+WN:7];
assign y[6][6] = x[6][6][7+WN:7];
assign y[6][7] = x[6][7][7+WN:7];

// Row 7
assign y[7][0] = x[7][0][6+WN:6];
assign y[7][1] = x[7][1][7+WN:7];
assign y[7][2] = x[7][2][7+WN:7];
assign y[7][3] = x[7][3][7+WN:7];
assign y[7][4] = x[7][4][7+WN:7];
assign y[7][5] = x[7][5][7+WN:7];
assign y[7][6] = x[7][6][7+WN:7];
assign y[7][7] = x[7][7][7+WN:7];
/*
parameter Q[0:7][0:7]={
{16,		8,		8,		16,	32,	32,	64,	64}, //0
{8,		8,		16,	16,	32,	64,	64,	64}, //1
{16,		16,	16,	32,	32,	64,	64,	64}, //2
{16,		16,	16,	32,	64,	64,	64,	64}, //3
{16,		16,	32,	64,	64,	128,	128,	64}, //4
{16,		32,	64,	64,	64,	128,	128,	64}, //5
{32,		64,	64,	128,	128,	128,	128,	128}, //6
{64,		128,	128,	128,	128,	128,	128,	128}};//7
*/
endmodule
/******************************************************
	End of file
********************************************************/
