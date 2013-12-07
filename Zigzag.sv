/**************************************************
	assign z.sv
	assign z address decoder
**************************************************/
module Zigzag(x,z);
input [7:0]x[0:7][0:7];
output[7:0]z[0:63];
//parameter ZZ = { 0,1,8,16,9,2,3,10,\
//           17,24,32,25,18,11,4,5,\
//           12,19,26,33,40,48,41,34,\
//           27,20,13,6,7,14,21,28,\
//           35,42,49,56,57,50,43,36,\
//           29,22,15,23,30,37,44,51,\
//           58,59,52,45,38,31,39,46,\
//           53,60,61,54,47,55,62,63};

	assign z[0] = x[0][0];
	assign z[1] = x[0][1];
	assign z[2] = x[1][0];
	assign z[3] = x[2][0];
	assign z[4] = x[1][1];
	assign z[5] = x[0][2];
	assign z[6] = x[0][3];
	assign z[7] = x[1][2];
	
	assign z[8] = x[2][1];
	assign z[9] = x[3][0];
	assign z[10] = x[4][0];
	assign z[11] = x[3][1];
	assign z[12] = x[2][2];
	assign z[13] = x[1][3];
	assign z[14] = x[0][4];
	assign z[15] = x[0][5];
	
	assign z[16] = x[1][4];
	assign z[17] = x[2][3];
	assign z[18] = x[3][2];
	assign z[19] = x[4][1];
	assign z[20] = x[5][0];
	assign z[21] = x[6][0];
	assign z[22] = x[5][1];
	assign z[23] = x[4][2];
	
	assign z[24] = x[3][3];
	assign z[25] = x[2][4];
	assign z[26] = x[1][5];
	assign z[27] = x[0][6];
	assign z[28] = x[0][7];
	assign z[29] = x[1][6];
	assign z[30] = x[2][5];
	assign z[31] = x[3][4];
	
	assign z[32] = x[4][3];
	assign z[33] = x[5][2];
	assign z[34] = x[6][1];
	assign z[35] = x[7][0];
	assign z[36] = x[7][1];
	assign z[37] = x[6][2];
	assign z[38] = x[5][3];
	assign z[39] = x[4][4];
	
	assign z[40] = x[3][5];
	assign z[41] = x[2][6];
	assign z[42] = x[1][7];
	assign z[43] = x[2][7];
	assign z[44] = x[3][6];
	assign z[45] = x[4][5];
	assign z[46] = x[5][4];
	assign z[47] = x[6][3];
	
	assign z[48] = x[7][2];
	assign z[49] = x[7][3];
	assign z[50] = x[6][4];
	assign z[51] = x[5][5];
	assign z[52] = x[4][6];
	assign z[53] = x[3][7];
	assign z[54] = x[4][7];
	assign z[55] = x[5][6];
	
	assign z[56] = x[6][5];
	assign z[57] = x[7][4];
	assign z[58] = x[7][5];
	assign z[59] = x[6][6];
	assign z[60] = x[5][7];
	assign z[61] = x[6][7];
	assign z[62] = x[7][6];
	assign z[63] = x[7][7];

endmodule
/*****************************************************
	End of file
*****************************************************/
