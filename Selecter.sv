/*****************************************************
	Selecter.v
******************************************************/
module Selecter(clk,rst,enable,x,y,read_end);
input clk,rst,enable;
input [7:0]x[0:63];
output [7:0]y;
output read_end;

reg[64:0]sel;
wire [7:0]xs[64];
wire [7:0]xs1[32];
wire [7:0]xs2[16];
wire [7:0]xs3[8];
wire [7:0]xs4[4];
wire [7:0]xs5[2];
wire [7:0]xs6;
wire m_one; // minus one detecter

integer i;
genvar j,k;
always @(negedge enable)
begin
	sel[63:0] = 64'b0;
	sel[64] = 1'b1;
end

always @(posedge clk or posedge rst)
begin
	if (rst) begin
		sel[63:0] = 64'b0;
		sel[64] = 1'b1;
	end else 
	begin
		for (i=1;i<65;i=i+1)
			sel[i] <= sel[i-1];
		sel[0] <= sel[64];
	end		
end

generate
for(j=0;j<64;j=j+1) begin: loop_j
	for (k=0;k<8;k=k+1) begin: loop_k
	assign xs[j][k] = x[j][k]&sel[j];  
	end
end
for (k=0;k<8;k=k+1) begin: loop_kb
	for(j=0;j<64;j=j+2) begin: loop_j1
		assign xs1[j/2][k] = xs[j][k]|xs[j+1][k];
	end
	for(j=0;j<32;j=j+2) begin:loop_j2
		assign xs2[j/2][k] = xs1[j][k]|xs1[j+1][k];
	end
	for(j=0;j<16;j=j+2) begin:loop_j3
		assign xs3[j/2][k] = xs2[j][k]|xs2[j+1][k];
	end
	for(j=0;j<8;j=j+2) begin:loop_j4
		assign xs4[j/2][k] = xs3[j][k]|xs3[j+1][k];
	end
	for(j=0;j<4;j=j+2) begin:loop_j5
		assign xs5[j/2][k] = xs4[j][k]|xs4[j+1][k];
	end
	assign xs6[k] = xs5[0][k]|xs5[1][k];
end
assign m_one = ~(((xs6[7]&xs6[6])&(xs6[5]&xs6[4]))&((xs6[3]&xs6[2])&(xs6[1]&xs6[0])));
for (k=0;k<8;k=k+1) begin: loop_ky
	assign y[k] = m_one&xs6[k]; 
end
endgenerate

assign read_end = sel[64];
endmodule
/*****************************************************
	End of file
*****************************************************/
