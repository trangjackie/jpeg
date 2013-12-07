/*********************************************
	Controller.sv
**********************************************/
module Controller(clk,rst,comp_en,conf_en,iR,iG,iB,read_clk,dct_clk,encode_clk);
input clk,rst,comp_en,conf_en;
input [7:0] iR,iG,iB;
output read_clk,dct_clk,encode_clk;

wire clk,rst,conf_en,comp_en;
wire [7:0] iR,iG,iB;
// one hotcode state machine:
// State codes definitions:
parameter 	IDLE =  	8'b00000001;
parameter	CONF =	8'b00000010;
parameter	READ = 	8'b00000100;
parameter	FDCT = 	8'b00010000;
parameter	ENCO = 	8'b01000000;
reg [7:0] 	curr_state_reg, next_state_reg;
reg 			read_clk,dct_clk,encode_clk,next_read_en,next_dct_en,next_encode_en;
// register to save config infomation
reg [23:0] number_block;
// count clock
reg [5:0] i;
// Next state logic (combination)
always
begin:reg_NextState
	next_state_reg <= curr_state_reg;
	next_read_en <= read_clk;
	next_dct_en <= dct_clk;
	next_encode_en <= encode_clk;
	case(curr_state_reg)
	IDLE:
	begin
		next_read_en <= 1'b0;
		next_dct_en <= 1'b0;
		next_encode_en <= 1'b0;
		i = 6'b0;
		if (conf_en)
		begin
			next_state_reg <= CONF;
			next_dct_en <= 1'b0;
			next_read_en <= 1'b0;
			next_encode_en <= 1'b0;
		end
		else if (comp_en) begin
			next_state_reg <= READ;
			next_dct_en <= 1'b0;
			next_read_en <= 1'b1;
			next_encode_en <= 1'b0;
		end else begin
			next_state_reg <= IDLE;
		end
	end
	CONF:
	begin
		number_block[23:16] <= iR;
		number_block[15:8] <= iG;
		number_block[7:0] <= iB;
		next_state_reg <= IDLE;
		next_read_en <= 1'b0;
		next_dct_en <= 1'b0;
		next_encode_en <= 1'b0;
	end
	READ:
	begin
		if (i>63) begin
			next_state_reg <= FDCT;
			next_read_en <= 1'b0;
			next_dct_en <= 1'b1;
			next_encode_en <= 1'b0;
			i = 0;
		end else begin
			next_state_reg <= READ;
			i = i+1;
			next_read_en <= 1'b1;
			next_dct_en <= 1'b0;
			next_encode_en <= 1'b0;
		end
	end
	FDCT:
	begin
		if (i>2) begin
			next_state_reg <= ENCO;
			next_read_en <= 1'b0;
			next_dct_en <= 1'b0;
			next_encode_en <= 1'b1;
			i = 0;
		end else begin
			next_state_reg <= FDCT;
			i = i+1;
			next_read_en <= 1'b0;
			next_dct_en <= 1'b1;
			next_encode_en <= 1'b0;
		end
	end
	ENCO:
	begin
		if (i>63) begin
			i = 0;
			if (number_block == 0) begin
				next_state_reg <= IDLE;
				next_read_en <= 1'b0;
				next_dct_en <= 1'b0;
				next_encode_en <= 1'b0;
			end else begin
				number_block = number_block - 1;
				next_state_reg <= READ;
				next_read_en <= 1'b1;
				next_dct_en <= 1'b0;
				next_encode_en <= 1'b0;
			end
		end else begin
			next_state_reg <= ENCO;
			i = i+1;
			next_read_en <= 1'b0;
			next_dct_en <= 1'b0;
			next_encode_en <= 1'b1;
		end
	end
	endcase
end
// Next state logic (sequential)	
always @ (posedge clk or negedge rst)
begin: Reg_current_state
	if (rst == 0)
		curr_state_reg <= IDLE;
	else
		curr_state_reg <= next_state_reg;
end

// Registered outputs logic
always @ (posedge clk or negedge rst)
begin: Reg_output
	if (rst == 0)
	begin 
		read_clk <= 1'b0;
		dct_clk <= 1'b0;
		encode_clk <= 1'b0;
	end else begin
		read_clk <= clk&next_read_en;
		dct_clk <= clk&next_dct_en;
		encode_clk <= clk&next_encode_en;
	end
end

endmodule
/*************************************************
	End of file
*************************************************/
