/****************************************************
	RGB2YCbCr.sv
****************************************************/
module RGB2YCbCr(clk,iR,iG,iB,x);
input clk;
input [7:0]iR[64],iG[64],iB[64];
output [7:0]x[8][8];

reg [7:0]R[64];
reg [7:0]G[64];
reg [7:0]B[64];
wire [7:0]xwire[8][8];
reg [7:0]xreg[8][8];

genvar i,j;
// Get input data
always @(posedge clk)
begin
	R = iR;
	G = iG;
	B = iB;
end
// Converting
generate
		for (i=0;i<8;i=i+1) begin:loop_i
			for (j=0;j<8;j=j+1) begin:loop_j
			RGB2Y U(R[i*8+j],G[i*8+j],B[i*8+j],xwire[i][j]);
			end
		end
endgenerate	
// Update results of convertion 
always @(negedge clk)
begin
		xreg = xwire;
end
// Assign output
generate
	for (i=0;i<8;i=i+1) begin:loop_ia
		for (j=0;j<8;j=j+1) begin:loop_ja
		assign x[i][j] = xreg[i][j]; 
		end
	end
endgenerate	
endmodule

module RGB2Y(iR,iG,iB,luma);
	input [7:0]iR,iG,iB;
	output [7:0] luma;
	
	wire [15:0]bu1,bu2,bu3;
	wire [16:0]bu4;
	assign bu1[15] = 1'b0;
	assign bu1[14:7] = iR;
	assign bu1[6:0] = 7'b0;
	assign bu2[15:8] = iG;
	assign bu2[7:0] = 8'b0;
	assign bu3[15] = 1'b0;
	assign bu3[14:7] = iB;
	assign bu3[6:0] = 7'b0;
	assign bu4 = bu1+bu2+bu3;
	assign luma = bu4[16:9];
endmodule
/*************************************************
	End of file
**************************************************/
