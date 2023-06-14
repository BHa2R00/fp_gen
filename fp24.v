

//(verilog-fp_add 'shit 'merd 'ungo 23 22 17 16 0)
module fp24_add (
	input [23:0] shit, merd, 
	output [23:0] ungo
);

//verilog-fp_add start
wire sign_shit = shit[23];
wire [5:0] expt_shit = shit[22:17];
wire sign_expt_shit = (expt_shit < 31) ? 1 : 0;
wire [4:0] mant_expt_shit = sign_expt_shit ? 31 - expt_shit : expt_shit - 31;
wire sign_merd = merd[23];
wire [5:0] expt_merd = merd[22:17];
wire sign_expt_merd = (expt_merd < 31) ? 1 : 0;
wire [4:0] mant_expt_merd = sign_expt_merd ? 31 - expt_merd : expt_merd - 31;
wire sign_diff_expt_shit_merd = 
	({sign_expt_shit,sign_expt_merd}==2'b10) ? 1 : 
	(({sign_expt_shit,sign_expt_merd}==2'b00) & (mant_expt_shit < mant_expt_merd)) ? 1 : 
	(({sign_expt_shit,sign_expt_merd}==2'b11) & (mant_expt_shit > mant_expt_merd)) ? 1 : 
	0;
wire [5:0] mant_diff_expt_shit_merd =
	({sign_expt_shit,sign_expt_merd}==2'b00) ? ((mant_expt_shit < mant_expt_merd) ? mant_expt_merd - mant_expt_shit : mant_expt_shit - mant_expt_merd) : 
	({sign_expt_shit,sign_expt_merd}==2'b01) ? mant_expt_shit + mant_expt_merd : 
	({sign_expt_shit,sign_expt_merd}==2'b10) ? mant_expt_shit + mant_expt_merd : 
	({sign_expt_shit,sign_expt_merd}==2'b11) ? ((mant_expt_shit < mant_expt_merd) ? mant_expt_merd - mant_expt_shit : mant_expt_shit - mant_expt_merd) : 
	0;
wire [49:0] frac_shit = {2'b01,shit[16:0],31'd0};
wire [49:0] frac_merd = {2'b01,merd[16:0],31'd0};
wire sign_1a_ungo = sign_diff_expt_shit_merd ? sign_merd : sign_shit;
wire sign_1b_ungo = sign_diff_expt_shit_merd ? sign_shit : sign_merd;
wire [49:0] frac_1a_ungo = sign_diff_expt_shit_merd ? frac_merd : frac_shit;
wire [49:0] frac_1b_ungo = sign_diff_expt_shit_merd ? frac_shit : frac_merd;
wire sign_2a_ungo = sign_1a_ungo;
wire sign_2b_ungo = sign_1b_ungo;
wire [49:0] frac_2a_ungo = frac_1a_ungo;
wire [49:0] frac_2b_ungo = frac_1b_ungo >> mant_diff_expt_shit_merd;
wire sign_2_ungo =
	({sign_2a_ungo,sign_2b_ungo}==2'b11) ? 1 : 
	(({sign_2a_ungo,sign_2b_ungo}==2'b10) & (frac_2a_ungo > frac_2b_ungo)) ? 1 : 
	(({sign_2a_ungo,sign_2b_ungo}==2'b01) & (frac_2a_ungo < frac_2b_ungo)) ? 1 : 
	0;
wire [49:0] frac_2_ungo =
	({sign_2a_ungo,sign_2b_ungo}==2'b00) ? frac_2a_ungo + frac_2b_ungo : 
	({sign_2a_ungo,sign_2b_ungo}==2'b01) ? ((frac_2a_ungo < frac_2b_ungo) ? frac_2b_ungo - frac_2a_ungo : frac_2a_ungo - frac_2b_ungo) : 
	({sign_2a_ungo,sign_2b_ungo}==2'b10) ? ((frac_2a_ungo > frac_2b_ungo) ? frac_2a_ungo - frac_2b_ungo : frac_2b_ungo - frac_2a_ungo) : 
	({sign_2a_ungo,sign_2b_ungo}==2'b11) ? frac_2a_ungo + frac_2b_ungo : 
	0;
wire [18:0] check_2_ungo;
assign check_2_ungo[18] = frac_2_ungo[49];
assign check_2_ungo[17] = frac_2_ungo[48] & ~check_2_ungo[18];
assign check_2_ungo[16] = frac_2_ungo[47] & ~check_2_ungo[17];
assign check_2_ungo[15] = frac_2_ungo[46] & ~check_2_ungo[16];
assign check_2_ungo[14] = frac_2_ungo[45] & ~check_2_ungo[15];
assign check_2_ungo[13] = frac_2_ungo[44] & ~check_2_ungo[14];
assign check_2_ungo[12] = frac_2_ungo[43] & ~check_2_ungo[13];
assign check_2_ungo[11] = frac_2_ungo[42] & ~check_2_ungo[12];
assign check_2_ungo[10] = frac_2_ungo[41] & ~check_2_ungo[11];
assign check_2_ungo[9] = frac_2_ungo[40] & ~check_2_ungo[10];
assign check_2_ungo[8] = frac_2_ungo[39] & ~check_2_ungo[9];
assign check_2_ungo[7] = frac_2_ungo[38] & ~check_2_ungo[8];
assign check_2_ungo[6] = frac_2_ungo[37] & ~check_2_ungo[7];
assign check_2_ungo[5] = frac_2_ungo[36] & ~check_2_ungo[6];
assign check_2_ungo[4] = frac_2_ungo[35] & ~check_2_ungo[5];
assign check_2_ungo[3] = frac_2_ungo[34] & ~check_2_ungo[4];
assign check_2_ungo[2] = frac_2_ungo[33] & ~check_2_ungo[3];
assign check_2_ungo[1] = frac_2_ungo[32] & ~check_2_ungo[2];
assign check_2_ungo[0] = frac_2_ungo[31] & ~check_2_ungo[1];
wire sign_incr_expt_ungo = 
	check_2_ungo[18] ? 0 : 
	check_2_ungo[17] ? 0 : 
	1;
wire [5:0] mant_incr_expt_ungo = 
	check_2_ungo[18] ? 1 : 
	check_2_ungo[17] ? 0 : 
	check_2_ungo[16] ? 1 : 
	check_2_ungo[15] ? 2 : 
	check_2_ungo[14] ? 3 : 
	check_2_ungo[13] ? 4 : 
	check_2_ungo[12] ? 5 : 
	check_2_ungo[11] ? 6 : 
	check_2_ungo[10] ? 7 : 
	check_2_ungo[9] ? 8 : 
	check_2_ungo[8] ? 9 : 
	check_2_ungo[7] ? 10 : 
	check_2_ungo[6] ? 11 : 
	check_2_ungo[5] ? 12 : 
	check_2_ungo[4] ? 13 : 
	check_2_ungo[3] ? 14 : 
	check_2_ungo[2] ? 15 : 
	check_2_ungo[1] ? 16 : 
	check_2_ungo[0] ? 17 : 
	0;
wire sign_ungo = sign_2_ungo;
wire [6:0] expt_ungo = 
	sign_diff_expt_shit_merd ? 
	(sign_incr_expt_ungo ? expt_merd - mant_incr_expt_ungo : expt_merd + mant_incr_expt_ungo) : 
	(sign_incr_expt_ungo ? expt_shit - mant_incr_expt_ungo : expt_shit + mant_incr_expt_ungo); 
wire [16:0] frac_ungo = 
	check_2_ungo[18] ? frac_2_ungo[48:32] : 
	check_2_ungo[17] ? frac_2_ungo[47:31] : 
	check_2_ungo[16] ? frac_2_ungo[46:30] : 
	check_2_ungo[15] ? frac_2_ungo[45:29] : 
	check_2_ungo[14] ? frac_2_ungo[44:28] : 
	check_2_ungo[13] ? frac_2_ungo[43:27] : 
	check_2_ungo[12] ? frac_2_ungo[42:26] : 
	check_2_ungo[11] ? frac_2_ungo[41:25] : 
	check_2_ungo[10] ? frac_2_ungo[40:24] : 
	check_2_ungo[9] ? frac_2_ungo[39:23] : 
	check_2_ungo[8] ? frac_2_ungo[38:22] : 
	check_2_ungo[7] ? frac_2_ungo[37:21] : 
	check_2_ungo[6] ? frac_2_ungo[36:20] : 
	check_2_ungo[5] ? frac_2_ungo[35:19] : 
	check_2_ungo[4] ? frac_2_ungo[34:18] : 
	check_2_ungo[3] ? frac_2_ungo[33:17] : 
	check_2_ungo[2] ? frac_2_ungo[32:16] : 
	check_2_ungo[1] ? frac_2_ungo[31:15] : 
	check_2_ungo[0] ? frac_2_ungo[30:14] : 
	0;
assign ungo = {sign_ungo,expt_ungo,frac_ungo};
//verilog-fp_add end

endmodule


//(verilog-fp_mul 'shit 'merd 'mist 23 22 17 16 0)
module fp24_add (
	input [23:0] shit, merd, 
	output [23:0] mist
);

//verilog-fp_mul start
wire sign_shit = shit[23];
wire sign_merd = merd[23];
wire sign_mist = sign_shit ^ sign_merd;
wire [17:0] frac_shit = {1'b1,shit[16:0]};
wire [17:0] frac_merd = {1'b1,merd[16:0]};
wire [35:0] frac_1_mist = frac_shit * frac_merd;
wire check_frac_1_mist = frac_1_mist[35];
wire [16:0] frac_mist = check_frac_1_mist ? frac_1_mist[34:18] : frac_1_mist[33:17];
wire [5:0] expt_shit = shit[22:17];
wire [5:0] expt_merd = merd[22:17];
wire sign_expt_shit = expt_shit < 31;
wire sign_expt_merd = expt_merd < 31;
wire sign_1_mist = sign_expt_shit & sign_expt_merd;
wire [5:0] expt_1_mist = expt_shit + expt_merd - 31 + (check_frac_1_mist ? 1 : 0);
wire [6:0] expt_2_mist = expt_shit + expt_merd - 31 + (check_frac_1_mist ? 1 : 0);
wire [6:0] expt_2_max_mist = 63;
wire [6:0] expt_2_min_mist = ~expt_2_max_mist + 1;
wire [5:0] expt_mist = ((~sign_1_mist&(expt_2_mist >= expt_2_max_mist))|(sign_1_mist&(expt_2_mist >= expt_2_min_mist))) ? 63 : expt_1_mist;
assign mist = {sign_mist,expt_mist,frac_mist};
//verilog-fp_mul end

endmodule


//(verilog-fp_mac 'shit 'merd 'mist 'ungo 23 22 17 16 0)
module fp24_mac (
	input [23:0] shit, merd, mist, 
	output [23:0] ungo
);

//verilog-fp_mac start
wire [23:0] z0_shit_merd, z1_shit_merd;

//verilog-fp_mul start
wire sign_shit = shit[23];
wire sign_merd = merd[23];
wire sign_z0_shit_merd = sign_shit ^ sign_merd;
wire [5:0] expt_shit = shit[22:17];
wire [5:0] expt_merd = merd[22:17];
wire [5:0] expt_1_z0_shit_merd = expt_shit + expt_merd - 31;
wire [17:0] frac_shit = {1'b1,shit[16:0]};
wire [17:0] frac_merd = {1'b1,merd[16:0]};
wire [35:0] frac_1_z0_shit_merd = frac_shit * frac_merd;
wire check_frac_1_z0_shit_merd = frac_1_z0_shit_merd[35];
wire [5:0] expt_z0_shit_merd = check_frac_1_z0_shit_merd ? expt_1_z0_shit_merd + 1 : expt_1_z0_shit_merd;
wire [16:0] frac_z0_shit_merd = check_frac_1_z0_shit_merd ? frac_1_z0_shit_merd[34:18] : frac_1_z0_shit_merd[33:17];
assign z0_shit_merd = {sign_z0_shit_merd,expt_z0_shit_merd,frac_z0_shit_merd};
//verilog-fp_mul end

//verilog-fp_add start
wire sign_z1_shit_merd = z1_shit_merd[23];
wire [5:0] expt_z1_shit_merd = z1_shit_merd[22:17];
wire sign_expt_z1_shit_merd = (expt_z1_shit_merd < 31) ? 1 : 0;
wire [4:0] mant_expt_z1_shit_merd = sign_expt_z1_shit_merd ? 31 - expt_z1_shit_merd : expt_z1_shit_merd - 31;
wire sign_mist = mist[23];
wire [5:0] expt_mist = mist[22:17];
wire sign_expt_mist = (expt_mist < 31) ? 1 : 0;
wire [4:0] mant_expt_mist = sign_expt_mist ? 31 - expt_mist : expt_mist - 31;
wire sign_diff_expt_z1_shit_merd_mist = 
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b10) ? 1 : 
	(({sign_expt_z1_shit_merd,sign_expt_mist}==2'b00) & (mant_expt_z1_shit_merd < mant_expt_mist)) ? 1 : 
	(({sign_expt_z1_shit_merd,sign_expt_mist}==2'b11) & (mant_expt_z1_shit_merd > mant_expt_mist)) ? 1 : 
	0;
wire [5:0] mant_diff_expt_z1_shit_merd_mist =
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b00) ? ((mant_expt_z1_shit_merd < mant_expt_mist) ? mant_expt_mist - mant_expt_z1_shit_merd : mant_expt_z1_shit_merd - mant_expt_mist) : 
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b01) ? mant_expt_z1_shit_merd + mant_expt_mist : 
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b10) ? mant_expt_z1_shit_merd + mant_expt_mist : 
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b11) ? ((mant_expt_z1_shit_merd < mant_expt_mist) ? mant_expt_mist - mant_expt_z1_shit_merd : mant_expt_z1_shit_merd - mant_expt_mist) : 
	0;
wire [49:0] frac_z1_shit_merd = {2'b01,z1_shit_merd[16:0],31'd0};
wire [49:0] frac_mist = {2'b01,mist[16:0],31'd0};
wire sign_1a_ungo = sign_diff_expt_z1_shit_merd_mist ? sign_mist : sign_z1_shit_merd;
wire sign_1b_ungo = sign_diff_expt_z1_shit_merd_mist ? sign_z1_shit_merd : sign_mist;
wire [49:0] frac_1a_ungo = sign_diff_expt_z1_shit_merd_mist ? frac_mist : frac_z1_shit_merd;
wire [49:0] frac_1b_ungo = sign_diff_expt_z1_shit_merd_mist ? frac_z1_shit_merd : frac_mist;
wire sign_2a_ungo = sign_1a_ungo;
wire sign_2b_ungo = sign_1b_ungo;
wire [49:0] frac_2a_ungo = frac_1a_ungo;
wire [49:0] frac_2b_ungo = frac_1b_ungo >> mant_diff_expt_z1_shit_merd_mist;
wire sign_2_ungo =
	({sign_2a_ungo,sign_2b_ungo}==2'b11) ? 1 : 
	(({sign_2a_ungo,sign_2b_ungo}==2'b10) & (frac_2a_ungo > frac_2b_ungo)) ? 1 : 
	(({sign_2a_ungo,sign_2b_ungo}==2'b01) & (frac_2a_ungo < frac_2b_ungo)) ? 1 : 
	0;
wire [49:0] frac_2_ungo =
	({sign_2a_ungo,sign_2b_ungo}==2'b00) ? frac_2a_ungo + frac_2b_ungo : 
	({sign_2a_ungo,sign_2b_ungo}==2'b01) ? ((frac_2a_ungo < frac_2b_ungo) ? frac_2b_ungo - frac_2a_ungo : frac_2a_ungo - frac_2b_ungo) : 
	({sign_2a_ungo,sign_2b_ungo}==2'b10) ? ((frac_2a_ungo > frac_2b_ungo) ? frac_2a_ungo - frac_2b_ungo : frac_2b_ungo - frac_2a_ungo) : 
	({sign_2a_ungo,sign_2b_ungo}==2'b11) ? frac_2a_ungo + frac_2b_ungo : 
	0;
wire [18:0] check_2_ungo;
assign check_2_ungo[18] = frac_2_ungo[49];
assign check_2_ungo[17] = frac_2_ungo[48] & ~check_2_ungo[18];
assign check_2_ungo[16] = frac_2_ungo[47] & ~check_2_ungo[17];
assign check_2_ungo[15] = frac_2_ungo[46] & ~check_2_ungo[16];
assign check_2_ungo[14] = frac_2_ungo[45] & ~check_2_ungo[15];
assign check_2_ungo[13] = frac_2_ungo[44] & ~check_2_ungo[14];
assign check_2_ungo[12] = frac_2_ungo[43] & ~check_2_ungo[13];
assign check_2_ungo[11] = frac_2_ungo[42] & ~check_2_ungo[12];
assign check_2_ungo[10] = frac_2_ungo[41] & ~check_2_ungo[11];
assign check_2_ungo[9] = frac_2_ungo[40] & ~check_2_ungo[10];
assign check_2_ungo[8] = frac_2_ungo[39] & ~check_2_ungo[9];
assign check_2_ungo[7] = frac_2_ungo[38] & ~check_2_ungo[8];
assign check_2_ungo[6] = frac_2_ungo[37] & ~check_2_ungo[7];
assign check_2_ungo[5] = frac_2_ungo[36] & ~check_2_ungo[6];
assign check_2_ungo[4] = frac_2_ungo[35] & ~check_2_ungo[5];
assign check_2_ungo[3] = frac_2_ungo[34] & ~check_2_ungo[4];
assign check_2_ungo[2] = frac_2_ungo[33] & ~check_2_ungo[3];
assign check_2_ungo[1] = frac_2_ungo[32] & ~check_2_ungo[2];
assign check_2_ungo[0] = frac_2_ungo[31] & ~check_2_ungo[1];
wire sign_incr_expt_ungo = 
	check_2_ungo[18] ? 0 : 
	check_2_ungo[17] ? 0 : 
	1;
wire [5:0] mant_incr_expt_ungo = 
	check_2_ungo[18] ? 1 : 
	check_2_ungo[17] ? 0 : 
	check_2_ungo[16] ? 1 : 
	check_2_ungo[15] ? 2 : 
	check_2_ungo[14] ? 3 : 
	check_2_ungo[13] ? 4 : 
	check_2_ungo[12] ? 5 : 
	check_2_ungo[11] ? 6 : 
	check_2_ungo[10] ? 7 : 
	check_2_ungo[9] ? 8 : 
	check_2_ungo[8] ? 9 : 
	check_2_ungo[7] ? 10 : 
	check_2_ungo[6] ? 11 : 
	check_2_ungo[5] ? 12 : 
	check_2_ungo[4] ? 13 : 
	check_2_ungo[3] ? 14 : 
	check_2_ungo[2] ? 15 : 
	check_2_ungo[1] ? 16 : 
	check_2_ungo[0] ? 17 : 
	0;
wire sign_ungo = sign_2_ungo;
wire [6:0] expt_ungo = 
	sign_diff_expt_z1_shit_merd_mist ? 
	(sign_incr_expt_ungo ? expt_mist - mant_incr_expt_ungo : expt_mist + mant_incr_expt_ungo) : 
	(sign_incr_expt_ungo ? expt_z1_shit_merd - mant_incr_expt_ungo : expt_z1_shit_merd + mant_incr_expt_ungo); 
wire [16:0] frac_ungo = 
	check_2_ungo[18] ? frac_2_ungo[48:32] : 
	check_2_ungo[17] ? frac_2_ungo[47:31] : 
	check_2_ungo[16] ? frac_2_ungo[46:30] : 
	check_2_ungo[15] ? frac_2_ungo[45:29] : 
	check_2_ungo[14] ? frac_2_ungo[44:28] : 
	check_2_ungo[13] ? frac_2_ungo[43:27] : 
	check_2_ungo[12] ? frac_2_ungo[42:26] : 
	check_2_ungo[11] ? frac_2_ungo[41:25] : 
	check_2_ungo[10] ? frac_2_ungo[40:24] : 
	check_2_ungo[9] ? frac_2_ungo[39:23] : 
	check_2_ungo[8] ? frac_2_ungo[38:22] : 
	check_2_ungo[7] ? frac_2_ungo[37:21] : 
	check_2_ungo[6] ? frac_2_ungo[36:20] : 
	check_2_ungo[5] ? frac_2_ungo[35:19] : 
	check_2_ungo[4] ? frac_2_ungo[34:18] : 
	check_2_ungo[3] ? frac_2_ungo[33:17] : 
	check_2_ungo[2] ? frac_2_ungo[32:16] : 
	check_2_ungo[1] ? frac_2_ungo[31:15] : 
	check_2_ungo[0] ? frac_2_ungo[30:14] : 
	0;
assign ungo = {sign_ungo,expt_ungo,frac_ungo};
//verilog-fp_add end
assign z1_shit_merd = z0_shit_merd;
//verilog-fp_mac end

endmodule

//(verilog-fp_int 'shit 'merd 23 22 17 16 0)
module fp24_int (
	input [23:0] shit, 
	output [23:0] merd
);

//verilog-fp_int start
wire sign_shit = shit[23];
wire [5:0] expt_shit = shit[22:17];
wire [47:0] frac_shit = {30'd1,shit[16:0]};
wire sign_expt_shit = expt_shit < 31;
wire [4:0] mant_expt_shit = expt_shit - 31;
wire [47:0] frac_1_merd = frac_shit << mant_expt_shit;
assign merd = sign_expt_shit ? 0 : (mant_expt_shit > 30) ? 2**31-1 : {sign_shit,frac_1_merd[47:17]};
//verilog-fp_int end

endmodule

//(verilog-fp_num 'shit 'merd 23 22 17 16 0)
module fp24_num (
	input [23:0] shit, 
	output [23:0] merd
);

//verilog-fp_num start
wire sign_merd = shit[23];
wire [53:0] frac_shit = {shit[22:0],31'd0};
wire [22:0] check_frac_shit;
assign check_frac_shit[22] = frac_shit[53];
assign check_frac_shit[21] = ~check_frac_shit[22] & frac_shit[52];
assign check_frac_shit[20] = ~check_frac_shit[21] & frac_shit[51];
assign check_frac_shit[19] = ~check_frac_shit[20] & frac_shit[50];
assign check_frac_shit[18] = ~check_frac_shit[19] & frac_shit[49];
assign check_frac_shit[17] = ~check_frac_shit[18] & frac_shit[48];
assign check_frac_shit[16] = ~check_frac_shit[17] & frac_shit[47];
assign check_frac_shit[15] = ~check_frac_shit[16] & frac_shit[46];
assign check_frac_shit[14] = ~check_frac_shit[15] & frac_shit[45];
assign check_frac_shit[13] = ~check_frac_shit[14] & frac_shit[44];
assign check_frac_shit[12] = ~check_frac_shit[13] & frac_shit[43];
assign check_frac_shit[11] = ~check_frac_shit[12] & frac_shit[42];
assign check_frac_shit[10] = ~check_frac_shit[11] & frac_shit[41];
assign check_frac_shit[9] = ~check_frac_shit[10] & frac_shit[40];
assign check_frac_shit[8] = ~check_frac_shit[9] & frac_shit[39];
assign check_frac_shit[7] = ~check_frac_shit[8] & frac_shit[38];
assign check_frac_shit[6] = ~check_frac_shit[7] & frac_shit[37];
assign check_frac_shit[5] = ~check_frac_shit[6] & frac_shit[36];
assign check_frac_shit[4] = ~check_frac_shit[5] & frac_shit[35];
assign check_frac_shit[3] = ~check_frac_shit[4] & frac_shit[34];
assign check_frac_shit[2] = ~check_frac_shit[3] & frac_shit[33];
assign check_frac_shit[1] = ~check_frac_shit[2] & frac_shit[32];
assign check_frac_shit[0] = ~check_frac_shit[1] & frac_shit[31];
wire [16:0] frac_merd = 
	check_frac_shit[22] ? frac_shit[52:36] : 
	check_frac_shit[21] ? frac_shit[51:35] : 
	check_frac_shit[20] ? frac_shit[50:34] : 
	check_frac_shit[19] ? frac_shit[49:33] : 
	check_frac_shit[18] ? frac_shit[48:32] : 
	check_frac_shit[17] ? frac_shit[47:31] : 
	check_frac_shit[16] ? frac_shit[46:30] : 
	check_frac_shit[15] ? frac_shit[45:29] : 
	check_frac_shit[14] ? frac_shit[44:28] : 
	check_frac_shit[13] ? frac_shit[43:27] : 
	check_frac_shit[12] ? frac_shit[42:26] : 
	check_frac_shit[11] ? frac_shit[41:25] : 
	check_frac_shit[10] ? frac_shit[40:24] : 
	check_frac_shit[9] ? frac_shit[39:23] : 
	check_frac_shit[8] ? frac_shit[38:22] : 
	check_frac_shit[7] ? frac_shit[37:21] : 
	check_frac_shit[6] ? frac_shit[36:20] : 
	check_frac_shit[5] ? frac_shit[35:19] : 
	check_frac_shit[4] ? frac_shit[34:18] : 
	check_frac_shit[3] ? frac_shit[33:17] : 
	check_frac_shit[2] ? frac_shit[32:16] : 
	check_frac_shit[1] ? frac_shit[31:15] : 
	check_frac_shit[0] ? frac_shit[30:14] : 
	0;
wire [5:0] expt_merd = 
	check_frac_shit[22] ? 53 : 
	check_frac_shit[21] ? 52 : 
	check_frac_shit[20] ? 51 : 
	check_frac_shit[19] ? 50 : 
	check_frac_shit[18] ? 49 : 
	check_frac_shit[17] ? 48 : 
	check_frac_shit[16] ? 47 : 
	check_frac_shit[15] ? 46 : 
	check_frac_shit[14] ? 45 : 
	check_frac_shit[13] ? 44 : 
	check_frac_shit[12] ? 43 : 
	check_frac_shit[11] ? 42 : 
	check_frac_shit[10] ? 41 : 
	check_frac_shit[9] ? 40 : 
	check_frac_shit[8] ? 39 : 
	check_frac_shit[7] ? 38 : 
	check_frac_shit[6] ? 37 : 
	check_frac_shit[5] ? 36 : 
	check_frac_shit[4] ? 35 : 
	check_frac_shit[3] ? 34 : 
	check_frac_shit[2] ? 33 : 
	check_frac_shit[1] ? 32 : 
	check_frac_shit[0] ? 31 : 
	0;
assign merd = {sign_merd,expt_merd,frac_merd};
//verilog-fp_num end

endmodule

