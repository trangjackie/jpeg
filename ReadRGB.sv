/****************************************************
	ReadRGB.sv
	Read data from external memory
****************************************************/
module ReadRGB(clk,rst,iR,iG,iB,sx,sy,R,G,B,i_end);
input clk, rst;
input [7:0] iR, iG, iB;
input [15:0]sx,sy;
output [7:0]R[64];
output [7:0]G[64];
output [7:0]B[64];
output i_end;
// Memory to store a block 8x8 pixel input
reg [7:0]Rreg[64];
reg [7:0]Greg[64];
reg [7:0]Breg[64];
reg [5:0]addr_RGB;

// counter used for design
genvar i;

// pixel counter
reg [15:0] pcx,pcy;
reg image_end;
always @(posedge clk or posedge rst)
begin
	if (rst)
	begin
		addr_RGB = 6'b0;
		pcx[15:3] = sx[15:3];
		pcx[2:0] = 3'b000;
		pcy[15:3]= sy[15:3];
		pcy[2:0] = 3'b000;
		image_end <= 1'b0;
	end
	else
	begin
		Rreg[addr_RGB] <= iR;
		Greg[addr_RGB] <= iG;
		Breg[addr_RGB] <= iB;
		addr_RGB <= addr_RGB + 6'b000001;
		pcy <= pcy - 16'b0000000000000001;
		if (pcy == 16'b0) begin
			if (pcx == 16'b0) begin
				image_end <= 1'b1;
			end else begin
			pcx <= pcx - 16'b0000000000000001;
			pcy <= sy;
			end
		end
	end
end
generate
for (i=0;i<64;i=i+1)
begin: gen_loop
	assign R[i] = Rreg[i];
	assign G[i] = Greg[i];
	assign B[i] = Breg[i];
end
endgenerate
assign i_end = image_end;
endmodule

/**************************************************
	End of file
****************************************************/
