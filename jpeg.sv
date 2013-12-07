/************************************************************
	jpeg.sv
************************************************************/
module jpeg(clk,rst,comp_en,conf_en,iR,iG,iB,addr_in,data_out,addr_out);
input clk,rst,comp_en,conf_en;
input [7:0]iR,iG,iB;
output [31:0] addr_in,addr_out;
output [14:0] data_out;


wire [23:0]iblock[0:7][0:7];
wire [23:0]dct_block[0:7][0:7];
wire [7:0]dct_block_q[0:7][0:7];
wire [7:0]data;
wire [5:0]addr_1d;
wire read_clk,dct_clk,encode_clk;
// Controller
Controller U0(.clk(clk),.rst(rst),.comp_en(comp_en),.conf_en(conf_en),.iR(iR),.iG(iG),.iB(iB),.read_clk(read_clk),.dct_clk(dct_clk),.encode_clk(encode_clk));
// RGB
RGB2YCbCr U1(.clk(read_clk),.rst(rst),.iR(iR),.iG(iG),.iB(iB),.addr_in(addr_in),.x(iblock));

// DCT
FsDCT		U2(.clk(dct_clk),.rst(rst),.x(iblock),.y(dct_block));
// Quantization
Quant		U3(.x(dct_block),.y(dct_block_q));
// Zigzag
Zigzag	U4(.clk(encode_clk),.rst(rst),.x(dct_block_q),.addr_in(addr_1d),.data(data));
// RLEncode
RLEncode U5(.clk(encode_clk),.rst(rst),.data_in(data),.addr_in(addr_1d),.data_out(data_out),.addr_out(addr_out));


endmodule
/*********************************************************
	End of file
*************************************************************/
