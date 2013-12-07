/*****************************************************************
	FsDCT_line.v
	Fast integer FDCT and IDCT function for 8x8 block
*****************************************************************/

/************ FsDCT row/column **************************/
module FsDCT_line(clk,rst,x0,x1,x2,x3,x4,x5,x6,x7,y0,y1,y2,y3,y4,y5,y6,y7);
parameter W = 15;
parameter SH= 7;
input clk, rst;
input [W:0] x0,x1,x2,x3,x4,x5,x6,x7;
output [W:0] y0,y1,y2,y3,y4,y5,y6,y7;
reg [W:0] y0,y1,y2,y3,y4,y5,y6,y7;
wire [W:0] x10,x11,x12,x13,x14,x15,x16,x17;
wire [W:0] x20,x21,x22,x23,x24,x25,x26,x27;
wire [W:0] x30,x31,x32,x33,x34,x35,x36,x37;
wire [W:0] x44,x45,x46,x47;
wire [W:0] rx25,rx26;
wire [W:0] ry0,ry1,ry2,ry3,ry4,ry5,ry6,ry7;
/************ DCT constanct ***********************************/
parameter c0 = 16'b01011011;
parameter c1 = 16'b00111111;
parameter c2 = 16'b00111011;
parameter c3 = 16'b00110101;
parameter c4 = 16'b00101101;
parameter c5 = 16'b00100100;
parameter c6 = 16'b00011000;
parameter c7 = 16'b00001100;
// Because mutiflier will take a long delay than adder
// And multi-Ripple-cary adder will better than sigle adder
// All multi-RC-adder is grouped in this block.
	// first stage transform 
assign	x10 = x0 + x7;
assign	x11 = x1 + x6;
assign	x12 = x2 + x5;
assign	x13 = x3 + x4;
assign	x14 = x3 - x4;
assign	x15 = x2 - x5;
assign	x16 = x1 - x6;
assign	x17 = x0 - x7;
	// second stage
assign	x20 = x10 + x13;
assign	x21 = x11 + x12;
assign	x22 = x11 - x12;
assign	x23 = x10 - x13;
assign	x24 = x14;
assign	x25 = (x16 - x15)*c0;
assign	x26 = (x15 + x16)*c0;
assign	rx25[W-SH:0] = x25[W:SH]; // >> shift
assign	rx25[W:W-SH+1] = sign(x25[W]);    
assign	rx26[W-SH:0] = x26[W:SH]; // >> shift
assign	rx26[W:W-SH+1] = sign(x26[W]);
assign	x27 = x17;
	// third stage
assign	x30 = (x20 + x21)*c4;
assign	x31 = (x20 - x21)*c4;
assign	x32 = x22*c6 + x23*c2;
assign	x33 = x23*c6 - x22*c2;
assign	x34 = x24 + rx25;
assign	x35 = x24 - rx25;
assign	x36 = x27 - rx26;
assign	x37 = x27 + rx26;
	// fourth stage
assign	x44 = x34*c7 + x37*c1;
assign	x45 = x35*c3 + x36*c5;
assign	x46 = x36*c3 - x35*c5;
assign	x47 = x37*c7 - x34*c1;
	// rescale >> shift
assign	ry0[W-SH:0] = x30[W:SH];
assign 	ry0[W:W-SH+1] = sign(x30[W]);
assign	ry4[W-SH:0] = x31[W:SH];
assign 	ry4[W:W-SH+1] = sign(x31[W]);
assign	ry2[W-SH:0] = x32[W:SH];
assign 	ry2[W:W-SH+1] = sign(x32[W]);
assign	ry6[W-SH:0] = x33[W:SH];
assign	ry6[W:W-SH+1] = sign(x33[W]);
assign	ry1[W-SH:0] = x44[W:SH];
assign	ry1[W:W-SH+1] = sign(x44[W]);
assign	ry5[W-SH:0] = x45[W:SH];
assign	ry5[W:W-SH+1] = sign(x45[W]);
assign	ry3[W-SH:0] = x46[W:SH];
assign	ry3[W:W-SH+1] = sign(x46[W]);
assign	ry7[W-SH:0] = x47[W:SH];
assign	ry7[W:W-SH+1] = sign(x47[W]);
	
// update output
always @(posedge clk or posedge rst)
begin: DCT_line_regoutput
	if (rst)
	begin
		y0 <= 16'b0;
		y1 <= 16'b0;
		y2 <= 16'b0;
		y3 <= 16'b0;
		y4 <= 16'b0;
		y5 <= 16'b0;
		y6 <= 16'b0;
		y7 <= 16'b0;
	end
	else
	begin
		y0 <= ry0;
		y1 <= ry1;
		y2 <= ry2;
		y3 <= ry3;
		y4 <= ry4;
		y5 <= ry5;
		y6 <= ry6;
		y7 <= ry7;
	end
end

function [SH-1:0]sign;
input sign_bit;
begin

	sign[0] = sign_bit;
	 sign[1] = sign_bit;
	 sign[2] = sign_bit;
	 sign[3] = sign_bit;
	 sign[4] = sign_bit;
	 sign[5] = sign_bit;
	 sign[6] = sign_bit;

end

endfunction		
endmodule

/****************************************************************
	End of file
****************************************************************/
