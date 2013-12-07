/**************************************************
	RLCode.sv
	Run length code
***************************************************/
module RLEncode(clk,rst,enable,x,b,y);
input clk,rst;
input enable;
input [7:0]x;
output [14:0] y;
output [14:0]b[64];

reg [5:0]run = 6'b0;
reg last = 1'b0;
reg [14:0]B[64]; // buffer
reg [14:0]B2[64]; // buffer
reg [5:0]pB;
reg [5:0]pB2;
reg [5:0]pB3;
reg read_en;
reg [14:0]y_reg;
reg [1:0] initial_counter;
reg [1:0] initial_counter2;
wire initial_end;
wire start_run;

always @(posedge clk or posedge rst)
begin
	if (rst) begin
		run = 6'b0;
		last = 1'b0;
		pB = 6'b0;
		pB2 = 6'b0;
		pB3 = 6'b0;
		read_en = 1'b0;
		y_reg = 15'b0;
		initial_counter = 2'b0;
		initial_counter2 = 2'b0;
	end else begin // active clock and the initial end
		// check run length data
		if (start_run) begin
		if (x==0) begin
			run <= run + 6'b000001;
		end else begin
			B[pB][14:7] = x;
			B[pB][6:1] = run;
			B[pB][0] = last;
			pB <= pB + 1;
		end
		end
		// buffer allow reading
		
		if (read_en) begin
			if (pB3 == pB2) begin
				y_reg[14:1] <= B[pB3][14:1];
				y_reg[0] <= 1'b1;
				read_en <= 1'b0;
			end else begin
				y_reg <= B[pB3];
				pB3 <= pB3 + 6'b000001;
			end
		end 	
	end

end
assign b = B;
assign initial_end = initial_counter[0]&initial_counter[1];
assign start_run = initial_counter2[0]&initial_counter2[1];
always @(negedge enable)
begin
	
	if (start_run) begin
	end else begin
		initial_counter2 <= initial_counter2 + 2'b01;
	end
	pB2 <= pB-6'b000001;
	read_en <= initial_end;
	pB <= 6'b0;
	B2 <= B;
	pB3 <= 6'b0;
end
always @(posedge enable)
begin
	if (initial_end) begin
	end else begin
		initial_counter <= initial_counter + 2'b01;
	end
end
assign y = y_reg;
endmodule

/**************************************************
	End of file
****************************************************/
