

//(verilog-fp_add 'shit 'merd 'ungo 15 14 10 9 0)
module fp16_add(
  input [15:0] shit, merd, 
  output [15:0] ungo
);

//verilog-fp_add start
wire sign_shit = shit[15];
wire [4:0] expt_shit = shit[14:10];
wire sign_expt_shit = (expt_shit < 15) ? 1 : 0;
wire [3:0] mant_expt_shit = sign_expt_shit ? 15 - expt_shit : expt_shit - 15;
wire sign_merd = merd[15];
wire [4:0] expt_merd = merd[14:10];
wire sign_expt_merd = (expt_merd < 15) ? 1 : 0;
wire [3:0] mant_expt_merd = sign_expt_merd ? 15 - expt_merd : expt_merd - 15;
wire sign_diff_expt_shit_merd = 
	({sign_expt_shit,sign_expt_merd}==2'b10) ? 1 : 
(({sign_expt_shit,sign_expt_merd}==2'b00) & (mant_expt_shit < mant_expt_merd)) ? 1 : 
(({sign_expt_shit,sign_expt_merd}==2'b11) & (mant_expt_shit > mant_expt_merd)) ? 1 : 
	0;
wire [4:0] mant_diff_expt_shit_merd =
	({sign_expt_shit,sign_expt_merd}==2'b00) ? ((mant_expt_shit < mant_expt_merd) ? mant_expt_merd - mant_expt_shit : mant_expt_shit - mant_expt_merd) : 
	({sign_expt_shit,sign_expt_merd}==2'b01) ? mant_expt_shit + mant_expt_merd : 
	({sign_expt_shit,sign_expt_merd}==2'b10) ? mant_expt_shit + mant_expt_merd : 
	({sign_expt_shit,sign_expt_merd}==2'b11) ? ((mant_expt_shit < mant_expt_merd) ? mant_expt_merd - mant_expt_shit : mant_expt_shit - mant_expt_merd) : 
	0;
wire [26:0] frac_shit = {2'b01,shit[9:0],15'd0};
wire [26:0] frac_merd = {2'b01,merd[9:0],15'd0};
wire sign_1a_ungo = sign_diff_expt_shit_merd ? sign_merd : sign_shit;
wire sign_1b_ungo = sign_diff_expt_shit_merd ? sign_shit : sign_merd;
wire [26:0] frac_1a_ungo = sign_diff_expt_shit_merd ? frac_merd : frac_shit;
wire [26:0] frac_1b_ungo = sign_diff_expt_shit_merd ? frac_shit : frac_merd;
wire sign_2a_ungo = sign_1a_ungo;
wire sign_2b_ungo = sign_1b_ungo;
wire [26:0] frac_2a_ungo = frac_1a_ungo;
wire [26:0] frac_2b_ungo = frac_1b_ungo >> mant_diff_expt_shit_merd;
wire sign_2_ungo =
	({sign_2a_ungo,sign_2b_ungo}==2'b11) ? 1 : 
	(({sign_2a_ungo,sign_2b_ungo}==2'b10) & (frac_2a_ungo > frac_2b_ungo)) ? 1 : 
	(({sign_2a_ungo,sign_2b_ungo}==2'b01) & (frac_2a_ungo < frac_2b_ungo)) ? 1 : 
	0;
wire [26:0] frac_2_ungo =
	({sign_2a_ungo,sign_2b_ungo}==2'b00) ? frac_2a_ungo + frac_2b_ungo : 
	({sign_2a_ungo,sign_2b_ungo}==2'b01) ? ((frac_2a_ungo < frac_2b_ungo) ? frac_2b_ungo - frac_2a_ungo : frac_2a_ungo - frac_2b_ungo) : 
	({sign_2a_ungo,sign_2b_ungo}==2'b10) ? ((frac_2a_ungo > frac_2b_ungo) ? frac_2a_ungo - frac_2b_ungo : frac_2b_ungo - frac_2a_ungo) : 
	({sign_2a_ungo,sign_2b_ungo}==2'b11) ? frac_2a_ungo + frac_2b_ungo : 
	0;
wire [11:0] check_2_ungo;
assign check_2_ungo[11] = frac_2_ungo[26];
assign check_2_ungo[10] = frac_2_ungo[25] & ~check_2_ungo[11];
assign check_2_ungo[9] = frac_2_ungo[24] & ~check_2_ungo[10];
assign check_2_ungo[8] = frac_2_ungo[23] & ~check_2_ungo[9];
assign check_2_ungo[7] = frac_2_ungo[22] & ~check_2_ungo[8];
assign check_2_ungo[6] = frac_2_ungo[21] & ~check_2_ungo[7];
assign check_2_ungo[5] = frac_2_ungo[20] & ~check_2_ungo[6];
assign check_2_ungo[4] = frac_2_ungo[19] & ~check_2_ungo[5];
assign check_2_ungo[3] = frac_2_ungo[18] & ~check_2_ungo[4];
assign check_2_ungo[2] = frac_2_ungo[17] & ~check_2_ungo[3];
assign check_2_ungo[1] = frac_2_ungo[16] & ~check_2_ungo[2];
assign check_2_ungo[0] = frac_2_ungo[15] & ~check_2_ungo[1];
wire sign_incr_expt_ungo = 
	check_2_ungo[11] ? 0 : 
	check_2_ungo[10] ? 0 : 
	1;
wire [4:0] mant_incr_expt_ungo = 
	check_2_ungo[11] ? 1 : 
	check_2_ungo[10] ? 0 : 
	check_2_ungo[9] ? 1 : 
	check_2_ungo[8] ? 2 : 
	check_2_ungo[7] ? 3 : 
	check_2_ungo[6] ? 4 : 
	check_2_ungo[5] ? 5 : 
	check_2_ungo[4] ? 6 : 
	check_2_ungo[3] ? 7 : 
	check_2_ungo[2] ? 8 : 
	check_2_ungo[1] ? 9 : 
	check_2_ungo[0] ? 10 : 
	0;
wire sign_ungo = sign_2_ungo;
wire [5:0] expt_ungo = 
	sign_diff_expt_shit_merd ? 
	(sign_incr_expt_ungo ? expt_merd - mant_incr_expt_ungo : expt_merd + mant_incr_expt_ungo) : 
	(sign_incr_expt_ungo ? expt_shit - mant_incr_expt_ungo : expt_shit + mant_incr_expt_ungo); 
wire [9:0] frac_ungo = 
	check_2_ungo[11] ? frac_2_ungo[25:16] : 
	check_2_ungo[10] ? frac_2_ungo[24:15] : 
	check_2_ungo[9] ? frac_2_ungo[23:14] : 
	check_2_ungo[8] ? frac_2_ungo[22:13] : 
	check_2_ungo[7] ? frac_2_ungo[21:12] : 
	check_2_ungo[6] ? frac_2_ungo[20:11] : 
	check_2_ungo[5] ? frac_2_ungo[19:10] : 
	check_2_ungo[4] ? frac_2_ungo[18:9] : 
	check_2_ungo[3] ? frac_2_ungo[17:8] : 
	check_2_ungo[2] ? frac_2_ungo[16:7] : 
	check_2_ungo[1] ? frac_2_ungo[15:6] : 
	check_2_ungo[0] ? frac_2_ungo[14:5] : 
	0;
assign ungo = {sign_ungo,expt_ungo,frac_ungo};
//verilog-fp_add end

endmodule

//(verilog-fp_mul 'shit 'merd 'mist 15 14 10 9 0)
module fp16_mul(
  input [15:0] shit, merd, 
  output [15:0] mist
);

//verilog-fp_mul start
wire sign_shit = shit[15];
wire sign_merd = merd[15];
wire sign_mist = sign_shit ^ sign_merd;
wire [4:0] expt_shit = shit[14:10];
wire [4:0] expt_merd = merd[14:10];
wire [4:0] expt_1_mist = expt_shit + expt_merd - 15;
wire [10:0] frac_shit = {1'b1,shit[9:0]};
wire [10:0] frac_merd = {1'b1,merd[9:0]};
wire [21:0] frac_1_mist = frac_shit * frac_merd;
wire check_frac_1_mist = frac_1_mist[21];
wire [4:0] expt_mist = check_frac_1_mist ? expt_1_mist + 1 : expt_1_mist;
wire [9:0] frac_mist = check_frac_1_mist ? frac_1_mist[20:11] : frac_1_mist[19:10];
assign mist = {sign_mist,expt_mist,frac_mist};
//verilog-fp_mul end

endmodule


//(verilog-fp_mac 'shit 'merd 'mist 'ungo 15 14 10 9 0)
module fp16_mac(
  input [15:0] shit, merd, mist, 
  output [15:0] ungo
);

//verilog-fp_mac start
wire [15:0] z0_shit_merd, z1_shit_merd;

//verilog-fp_mul start
wire sign_shit = shit[15];
wire sign_merd = merd[15];
wire sign_z0_shit_merd = sign_shit ^ sign_merd;
wire [4:0] expt_shit = shit[14:10];
wire [4:0] expt_merd = merd[14:10];
wire [4:0] expt_1_z0_shit_merd = expt_shit + expt_merd - 15;
wire [10:0] frac_shit = {1'b1,shit[9:0]};
wire [10:0] frac_merd = {1'b1,merd[9:0]};
wire [21:0] frac_1_z0_shit_merd = frac_shit * frac_merd;
wire check_frac_1_z0_shit_merd = frac_1_z0_shit_merd[21];
wire [4:0] expt_z0_shit_merd = check_frac_1_z0_shit_merd ? expt_1_z0_shit_merd + 1 : expt_1_z0_shit_merd;
wire [9:0] frac_z0_shit_merd = check_frac_1_z0_shit_merd ? frac_1_z0_shit_merd[20:11] : frac_1_z0_shit_merd[19:10];
assign z0_shit_merd = {sign_z0_shit_merd,expt_z0_shit_merd,frac_z0_shit_merd};
//verilog-fp_mul end

//verilog-fp_add start
wire sign_z1_shit_merd = z1_shit_merd[15];
wire [4:0] expt_z1_shit_merd = z1_shit_merd[14:10];
wire sign_expt_z1_shit_merd = (expt_z1_shit_merd < 15) ? 1 : 0;
wire [3:0] mant_expt_z1_shit_merd = sign_expt_z1_shit_merd ? 15 - expt_z1_shit_merd : expt_z1_shit_merd - 15;
wire sign_mist = mist[15];
wire [4:0] expt_mist = mist[14:10];
wire sign_expt_mist = (expt_mist < 15) ? 1 : 0;
wire [3:0] mant_expt_mist = sign_expt_mist ? 15 - expt_mist : expt_mist - 15;
wire sign_diff_expt_z1_shit_merd_mist = 
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b10) ? 1 : 
(({sign_expt_z1_shit_merd,sign_expt_mist}==2'b00) & (mant_expt_z1_shit_merd < mant_expt_mist)) ? 1 : 
(({sign_expt_z1_shit_merd,sign_expt_mist}==2'b11) & (mant_expt_z1_shit_merd > mant_expt_mist)) ? 1 : 
	0;
wire [4:0] mant_diff_expt_z1_shit_merd_mist =
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b00) ? ((mant_expt_z1_shit_merd < mant_expt_mist) ? mant_expt_mist - mant_expt_z1_shit_merd : mant_expt_z1_shit_merd - mant_expt_mist) : 
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b01) ? mant_expt_z1_shit_merd + mant_expt_mist : 
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b10) ? mant_expt_z1_shit_merd + mant_expt_mist : 
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b11) ? ((mant_expt_z1_shit_merd < mant_expt_mist) ? mant_expt_mist - mant_expt_z1_shit_merd : mant_expt_z1_shit_merd - mant_expt_mist) : 
	0;
wire [26:0] frac_z1_shit_merd = {2'b01,z1_shit_merd[9:0],15'd0};
wire [26:0] frac_mist = {2'b01,mist[9:0],15'd0};
wire sign_1a_ungo = sign_diff_expt_z1_shit_merd_mist ? sign_mist : sign_z1_shit_merd;
wire sign_1b_ungo = sign_diff_expt_z1_shit_merd_mist ? sign_z1_shit_merd : sign_mist;
wire [26:0] frac_1a_ungo = sign_diff_expt_z1_shit_merd_mist ? frac_mist : frac_z1_shit_merd;
wire [26:0] frac_1b_ungo = sign_diff_expt_z1_shit_merd_mist ? frac_z1_shit_merd : frac_mist;
wire sign_2a_ungo = sign_1a_ungo;
wire sign_2b_ungo = sign_1b_ungo;
wire [26:0] frac_2a_ungo = frac_1a_ungo;
wire [26:0] frac_2b_ungo = frac_1b_ungo >> mant_diff_expt_z1_shit_merd_mist;
wire sign_2_ungo =
	({sign_2a_ungo,sign_2b_ungo}==2'b11) ? 1 : 
	(({sign_2a_ungo,sign_2b_ungo}==2'b10) & (frac_2a_ungo > frac_2b_ungo)) ? 1 : 
	(({sign_2a_ungo,sign_2b_ungo}==2'b01) & (frac_2a_ungo < frac_2b_ungo)) ? 1 : 
	0;
wire [26:0] frac_2_ungo =
	({sign_2a_ungo,sign_2b_ungo}==2'b00) ? frac_2a_ungo + frac_2b_ungo : 
	({sign_2a_ungo,sign_2b_ungo}==2'b01) ? ((frac_2a_ungo < frac_2b_ungo) ? frac_2b_ungo - frac_2a_ungo : frac_2a_ungo - frac_2b_ungo) : 
	({sign_2a_ungo,sign_2b_ungo}==2'b10) ? ((frac_2a_ungo > frac_2b_ungo) ? frac_2a_ungo - frac_2b_ungo : frac_2b_ungo - frac_2a_ungo) : 
	({sign_2a_ungo,sign_2b_ungo}==2'b11) ? frac_2a_ungo + frac_2b_ungo : 
	0;
wire [11:0] check_2_ungo;
assign check_2_ungo[11] = frac_2_ungo[26];
assign check_2_ungo[10] = frac_2_ungo[25] & ~check_2_ungo[11];
assign check_2_ungo[9] = frac_2_ungo[24] & ~check_2_ungo[10];
assign check_2_ungo[8] = frac_2_ungo[23] & ~check_2_ungo[9];
assign check_2_ungo[7] = frac_2_ungo[22] & ~check_2_ungo[8];
assign check_2_ungo[6] = frac_2_ungo[21] & ~check_2_ungo[7];
assign check_2_ungo[5] = frac_2_ungo[20] & ~check_2_ungo[6];
assign check_2_ungo[4] = frac_2_ungo[19] & ~check_2_ungo[5];
assign check_2_ungo[3] = frac_2_ungo[18] & ~check_2_ungo[4];
assign check_2_ungo[2] = frac_2_ungo[17] & ~check_2_ungo[3];
assign check_2_ungo[1] = frac_2_ungo[16] & ~check_2_ungo[2];
assign check_2_ungo[0] = frac_2_ungo[15] & ~check_2_ungo[1];
wire sign_incr_expt_ungo = 
	check_2_ungo[11] ? 0 : 
	check_2_ungo[10] ? 0 : 
	1;
wire [4:0] mant_incr_expt_ungo = 
	check_2_ungo[11] ? 1 : 
	check_2_ungo[10] ? 0 : 
	check_2_ungo[9] ? 1 : 
	check_2_ungo[8] ? 2 : 
	check_2_ungo[7] ? 3 : 
	check_2_ungo[6] ? 4 : 
	check_2_ungo[5] ? 5 : 
	check_2_ungo[4] ? 6 : 
	check_2_ungo[3] ? 7 : 
	check_2_ungo[2] ? 8 : 
	check_2_ungo[1] ? 9 : 
	check_2_ungo[0] ? 10 : 
	0;
wire sign_ungo = sign_2_ungo;
wire [5:0] expt_ungo = 
	sign_diff_expt_z1_shit_merd_mist ? 
	(sign_incr_expt_ungo ? expt_mist - mant_incr_expt_ungo : expt_mist + mant_incr_expt_ungo) : 
	(sign_incr_expt_ungo ? expt_z1_shit_merd - mant_incr_expt_ungo : expt_z1_shit_merd + mant_incr_expt_ungo); 
wire [9:0] frac_ungo = 
	check_2_ungo[11] ? frac_2_ungo[25:16] : 
	check_2_ungo[10] ? frac_2_ungo[24:15] : 
	check_2_ungo[9] ? frac_2_ungo[23:14] : 
	check_2_ungo[8] ? frac_2_ungo[22:13] : 
	check_2_ungo[7] ? frac_2_ungo[21:12] : 
	check_2_ungo[6] ? frac_2_ungo[20:11] : 
	check_2_ungo[5] ? frac_2_ungo[19:10] : 
	check_2_ungo[4] ? frac_2_ungo[18:9] : 
	check_2_ungo[3] ? frac_2_ungo[17:8] : 
	check_2_ungo[2] ? frac_2_ungo[16:7] : 
	check_2_ungo[1] ? frac_2_ungo[15:6] : 
	check_2_ungo[0] ? frac_2_ungo[14:5] : 
	0;
assign ungo = {sign_ungo,expt_ungo,frac_ungo};
//verilog-fp_add end
assign z1_shit_merd = z0_shit_merd;
//verilog-fp_mac end

endmodule

