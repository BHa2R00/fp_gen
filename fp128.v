

//(verilog-fp_add 'shit 'merd 'ungo 127 126 112 111 0)
module fp128_add (
	input [127:0] shit, merd, 
	output [127:0] ungo
);

//verilog-fp_add start
wire sign_shit = shit[127];
wire [14:0] expt_shit = shit[126:112];
wire sign_expt_shit = (expt_shit < 16383) ? 1 : 0;
wire [13:0] mant_expt_shit = sign_expt_shit ? 16383 - expt_shit : expt_shit - 16383;
wire sign_merd = merd[127];
wire [14:0] expt_merd = merd[126:112];
wire sign_expt_merd = (expt_merd < 16383) ? 1 : 0;
wire [13:0] mant_expt_merd = sign_expt_merd ? 16383 - expt_merd : expt_merd - 16383;
wire sign_diff_expt_shit_merd = 
	({sign_expt_shit,sign_expt_merd}==2'b10) ? 1 : 
	(({sign_expt_shit,sign_expt_merd}==2'b00) & (mant_expt_shit < mant_expt_merd)) ? 1 : 
	(({sign_expt_shit,sign_expt_merd}==2'b11) & (mant_expt_shit > mant_expt_merd)) ? 1 : 
	0;
wire [14:0] mant_diff_expt_shit_merd =
	({sign_expt_shit,sign_expt_merd}==2'b00) ? ((mant_expt_shit < mant_expt_merd) ? mant_expt_merd - mant_expt_shit : mant_expt_shit - mant_expt_merd) : 
	({sign_expt_shit,sign_expt_merd}==2'b01) ? mant_expt_shit + mant_expt_merd : 
	({sign_expt_shit,sign_expt_merd}==2'b10) ? mant_expt_shit + mant_expt_merd : 
	({sign_expt_shit,sign_expt_merd}==2'b11) ? ((mant_expt_shit < mant_expt_merd) ? mant_expt_merd - mant_expt_shit : mant_expt_shit - mant_expt_merd) : 
	0;
wire [16496:0] frac_shit = {2'b01,shit[111:0],16383'd0};
wire [16496:0] frac_merd = {2'b01,merd[111:0],16383'd0};
wire sign_1a_ungo = sign_diff_expt_shit_merd ? sign_merd : sign_shit;
wire sign_1b_ungo = sign_diff_expt_shit_merd ? sign_shit : sign_merd;
wire [16496:0] frac_1a_ungo = sign_diff_expt_shit_merd ? frac_merd : frac_shit;
wire [16496:0] frac_1b_ungo = sign_diff_expt_shit_merd ? frac_shit : frac_merd;
wire sign_2a_ungo = sign_1a_ungo;
wire sign_2b_ungo = sign_1b_ungo;
wire [16496:0] frac_2a_ungo = frac_1a_ungo;
wire [16496:0] frac_2b_ungo = frac_1b_ungo >> mant_diff_expt_shit_merd;
wire sign_2_ungo =
	({sign_2a_ungo,sign_2b_ungo}==2'b11) ? 1 : 
	(({sign_2a_ungo,sign_2b_ungo}==2'b10) & (frac_2a_ungo > frac_2b_ungo)) ? 1 : 
	(({sign_2a_ungo,sign_2b_ungo}==2'b01) & (frac_2a_ungo < frac_2b_ungo)) ? 1 : 
	0;
wire [16496:0] frac_2_ungo =
	({sign_2a_ungo,sign_2b_ungo}==2'b00) ? frac_2a_ungo + frac_2b_ungo : 
	({sign_2a_ungo,sign_2b_ungo}==2'b01) ? ((frac_2a_ungo < frac_2b_ungo) ? frac_2b_ungo - frac_2a_ungo : frac_2a_ungo - frac_2b_ungo) : 
	({sign_2a_ungo,sign_2b_ungo}==2'b10) ? ((frac_2a_ungo > frac_2b_ungo) ? frac_2a_ungo - frac_2b_ungo : frac_2b_ungo - frac_2a_ungo) : 
	({sign_2a_ungo,sign_2b_ungo}==2'b11) ? frac_2a_ungo + frac_2b_ungo : 
	0;
wire [113:0] check_2_ungo;
assign check_2_ungo[113] = frac_2_ungo[16496];
assign check_2_ungo[112] = frac_2_ungo[16495] & ~check_2_ungo[113];
assign check_2_ungo[111] = frac_2_ungo[16494] & ~check_2_ungo[112];
assign check_2_ungo[110] = frac_2_ungo[16493] & ~check_2_ungo[111];
assign check_2_ungo[109] = frac_2_ungo[16492] & ~check_2_ungo[110];
assign check_2_ungo[108] = frac_2_ungo[16491] & ~check_2_ungo[109];
assign check_2_ungo[107] = frac_2_ungo[16490] & ~check_2_ungo[108];
assign check_2_ungo[106] = frac_2_ungo[16489] & ~check_2_ungo[107];
assign check_2_ungo[105] = frac_2_ungo[16488] & ~check_2_ungo[106];
assign check_2_ungo[104] = frac_2_ungo[16487] & ~check_2_ungo[105];
assign check_2_ungo[103] = frac_2_ungo[16486] & ~check_2_ungo[104];
assign check_2_ungo[102] = frac_2_ungo[16485] & ~check_2_ungo[103];
assign check_2_ungo[101] = frac_2_ungo[16484] & ~check_2_ungo[102];
assign check_2_ungo[100] = frac_2_ungo[16483] & ~check_2_ungo[101];
assign check_2_ungo[99] = frac_2_ungo[16482] & ~check_2_ungo[100];
assign check_2_ungo[98] = frac_2_ungo[16481] & ~check_2_ungo[99];
assign check_2_ungo[97] = frac_2_ungo[16480] & ~check_2_ungo[98];
assign check_2_ungo[96] = frac_2_ungo[16479] & ~check_2_ungo[97];
assign check_2_ungo[95] = frac_2_ungo[16478] & ~check_2_ungo[96];
assign check_2_ungo[94] = frac_2_ungo[16477] & ~check_2_ungo[95];
assign check_2_ungo[93] = frac_2_ungo[16476] & ~check_2_ungo[94];
assign check_2_ungo[92] = frac_2_ungo[16475] & ~check_2_ungo[93];
assign check_2_ungo[91] = frac_2_ungo[16474] & ~check_2_ungo[92];
assign check_2_ungo[90] = frac_2_ungo[16473] & ~check_2_ungo[91];
assign check_2_ungo[89] = frac_2_ungo[16472] & ~check_2_ungo[90];
assign check_2_ungo[88] = frac_2_ungo[16471] & ~check_2_ungo[89];
assign check_2_ungo[87] = frac_2_ungo[16470] & ~check_2_ungo[88];
assign check_2_ungo[86] = frac_2_ungo[16469] & ~check_2_ungo[87];
assign check_2_ungo[85] = frac_2_ungo[16468] & ~check_2_ungo[86];
assign check_2_ungo[84] = frac_2_ungo[16467] & ~check_2_ungo[85];
assign check_2_ungo[83] = frac_2_ungo[16466] & ~check_2_ungo[84];
assign check_2_ungo[82] = frac_2_ungo[16465] & ~check_2_ungo[83];
assign check_2_ungo[81] = frac_2_ungo[16464] & ~check_2_ungo[82];
assign check_2_ungo[80] = frac_2_ungo[16463] & ~check_2_ungo[81];
assign check_2_ungo[79] = frac_2_ungo[16462] & ~check_2_ungo[80];
assign check_2_ungo[78] = frac_2_ungo[16461] & ~check_2_ungo[79];
assign check_2_ungo[77] = frac_2_ungo[16460] & ~check_2_ungo[78];
assign check_2_ungo[76] = frac_2_ungo[16459] & ~check_2_ungo[77];
assign check_2_ungo[75] = frac_2_ungo[16458] & ~check_2_ungo[76];
assign check_2_ungo[74] = frac_2_ungo[16457] & ~check_2_ungo[75];
assign check_2_ungo[73] = frac_2_ungo[16456] & ~check_2_ungo[74];
assign check_2_ungo[72] = frac_2_ungo[16455] & ~check_2_ungo[73];
assign check_2_ungo[71] = frac_2_ungo[16454] & ~check_2_ungo[72];
assign check_2_ungo[70] = frac_2_ungo[16453] & ~check_2_ungo[71];
assign check_2_ungo[69] = frac_2_ungo[16452] & ~check_2_ungo[70];
assign check_2_ungo[68] = frac_2_ungo[16451] & ~check_2_ungo[69];
assign check_2_ungo[67] = frac_2_ungo[16450] & ~check_2_ungo[68];
assign check_2_ungo[66] = frac_2_ungo[16449] & ~check_2_ungo[67];
assign check_2_ungo[65] = frac_2_ungo[16448] & ~check_2_ungo[66];
assign check_2_ungo[64] = frac_2_ungo[16447] & ~check_2_ungo[65];
assign check_2_ungo[63] = frac_2_ungo[16446] & ~check_2_ungo[64];
assign check_2_ungo[62] = frac_2_ungo[16445] & ~check_2_ungo[63];
assign check_2_ungo[61] = frac_2_ungo[16444] & ~check_2_ungo[62];
assign check_2_ungo[60] = frac_2_ungo[16443] & ~check_2_ungo[61];
assign check_2_ungo[59] = frac_2_ungo[16442] & ~check_2_ungo[60];
assign check_2_ungo[58] = frac_2_ungo[16441] & ~check_2_ungo[59];
assign check_2_ungo[57] = frac_2_ungo[16440] & ~check_2_ungo[58];
assign check_2_ungo[56] = frac_2_ungo[16439] & ~check_2_ungo[57];
assign check_2_ungo[55] = frac_2_ungo[16438] & ~check_2_ungo[56];
assign check_2_ungo[54] = frac_2_ungo[16437] & ~check_2_ungo[55];
assign check_2_ungo[53] = frac_2_ungo[16436] & ~check_2_ungo[54];
assign check_2_ungo[52] = frac_2_ungo[16435] & ~check_2_ungo[53];
assign check_2_ungo[51] = frac_2_ungo[16434] & ~check_2_ungo[52];
assign check_2_ungo[50] = frac_2_ungo[16433] & ~check_2_ungo[51];
assign check_2_ungo[49] = frac_2_ungo[16432] & ~check_2_ungo[50];
assign check_2_ungo[48] = frac_2_ungo[16431] & ~check_2_ungo[49];
assign check_2_ungo[47] = frac_2_ungo[16430] & ~check_2_ungo[48];
assign check_2_ungo[46] = frac_2_ungo[16429] & ~check_2_ungo[47];
assign check_2_ungo[45] = frac_2_ungo[16428] & ~check_2_ungo[46];
assign check_2_ungo[44] = frac_2_ungo[16427] & ~check_2_ungo[45];
assign check_2_ungo[43] = frac_2_ungo[16426] & ~check_2_ungo[44];
assign check_2_ungo[42] = frac_2_ungo[16425] & ~check_2_ungo[43];
assign check_2_ungo[41] = frac_2_ungo[16424] & ~check_2_ungo[42];
assign check_2_ungo[40] = frac_2_ungo[16423] & ~check_2_ungo[41];
assign check_2_ungo[39] = frac_2_ungo[16422] & ~check_2_ungo[40];
assign check_2_ungo[38] = frac_2_ungo[16421] & ~check_2_ungo[39];
assign check_2_ungo[37] = frac_2_ungo[16420] & ~check_2_ungo[38];
assign check_2_ungo[36] = frac_2_ungo[16419] & ~check_2_ungo[37];
assign check_2_ungo[35] = frac_2_ungo[16418] & ~check_2_ungo[36];
assign check_2_ungo[34] = frac_2_ungo[16417] & ~check_2_ungo[35];
assign check_2_ungo[33] = frac_2_ungo[16416] & ~check_2_ungo[34];
assign check_2_ungo[32] = frac_2_ungo[16415] & ~check_2_ungo[33];
assign check_2_ungo[31] = frac_2_ungo[16414] & ~check_2_ungo[32];
assign check_2_ungo[30] = frac_2_ungo[16413] & ~check_2_ungo[31];
assign check_2_ungo[29] = frac_2_ungo[16412] & ~check_2_ungo[30];
assign check_2_ungo[28] = frac_2_ungo[16411] & ~check_2_ungo[29];
assign check_2_ungo[27] = frac_2_ungo[16410] & ~check_2_ungo[28];
assign check_2_ungo[26] = frac_2_ungo[16409] & ~check_2_ungo[27];
assign check_2_ungo[25] = frac_2_ungo[16408] & ~check_2_ungo[26];
assign check_2_ungo[24] = frac_2_ungo[16407] & ~check_2_ungo[25];
assign check_2_ungo[23] = frac_2_ungo[16406] & ~check_2_ungo[24];
assign check_2_ungo[22] = frac_2_ungo[16405] & ~check_2_ungo[23];
assign check_2_ungo[21] = frac_2_ungo[16404] & ~check_2_ungo[22];
assign check_2_ungo[20] = frac_2_ungo[16403] & ~check_2_ungo[21];
assign check_2_ungo[19] = frac_2_ungo[16402] & ~check_2_ungo[20];
assign check_2_ungo[18] = frac_2_ungo[16401] & ~check_2_ungo[19];
assign check_2_ungo[17] = frac_2_ungo[16400] & ~check_2_ungo[18];
assign check_2_ungo[16] = frac_2_ungo[16399] & ~check_2_ungo[17];
assign check_2_ungo[15] = frac_2_ungo[16398] & ~check_2_ungo[16];
assign check_2_ungo[14] = frac_2_ungo[16397] & ~check_2_ungo[15];
assign check_2_ungo[13] = frac_2_ungo[16396] & ~check_2_ungo[14];
assign check_2_ungo[12] = frac_2_ungo[16395] & ~check_2_ungo[13];
assign check_2_ungo[11] = frac_2_ungo[16394] & ~check_2_ungo[12];
assign check_2_ungo[10] = frac_2_ungo[16393] & ~check_2_ungo[11];
assign check_2_ungo[9] = frac_2_ungo[16392] & ~check_2_ungo[10];
assign check_2_ungo[8] = frac_2_ungo[16391] & ~check_2_ungo[9];
assign check_2_ungo[7] = frac_2_ungo[16390] & ~check_2_ungo[8];
assign check_2_ungo[6] = frac_2_ungo[16389] & ~check_2_ungo[7];
assign check_2_ungo[5] = frac_2_ungo[16388] & ~check_2_ungo[6];
assign check_2_ungo[4] = frac_2_ungo[16387] & ~check_2_ungo[5];
assign check_2_ungo[3] = frac_2_ungo[16386] & ~check_2_ungo[4];
assign check_2_ungo[2] = frac_2_ungo[16385] & ~check_2_ungo[3];
assign check_2_ungo[1] = frac_2_ungo[16384] & ~check_2_ungo[2];
assign check_2_ungo[0] = frac_2_ungo[16383] & ~check_2_ungo[1];
wire sign_incr_expt_ungo = 
	check_2_ungo[113] ? 0 : 
	check_2_ungo[112] ? 0 : 
	1;
wire [14:0] mant_incr_expt_ungo = 
	check_2_ungo[113] ? 1 : 
	check_2_ungo[112] ? 0 : 
	check_2_ungo[111] ? 1 : 
	check_2_ungo[110] ? 2 : 
	check_2_ungo[109] ? 3 : 
	check_2_ungo[108] ? 4 : 
	check_2_ungo[107] ? 5 : 
	check_2_ungo[106] ? 6 : 
	check_2_ungo[105] ? 7 : 
	check_2_ungo[104] ? 8 : 
	check_2_ungo[103] ? 9 : 
	check_2_ungo[102] ? 10 : 
	check_2_ungo[101] ? 11 : 
	check_2_ungo[100] ? 12 : 
	check_2_ungo[99] ? 13 : 
	check_2_ungo[98] ? 14 : 
	check_2_ungo[97] ? 15 : 
	check_2_ungo[96] ? 16 : 
	check_2_ungo[95] ? 17 : 
	check_2_ungo[94] ? 18 : 
	check_2_ungo[93] ? 19 : 
	check_2_ungo[92] ? 20 : 
	check_2_ungo[91] ? 21 : 
	check_2_ungo[90] ? 22 : 
	check_2_ungo[89] ? 23 : 
	check_2_ungo[88] ? 24 : 
	check_2_ungo[87] ? 25 : 
	check_2_ungo[86] ? 26 : 
	check_2_ungo[85] ? 27 : 
	check_2_ungo[84] ? 28 : 
	check_2_ungo[83] ? 29 : 
	check_2_ungo[82] ? 30 : 
	check_2_ungo[81] ? 31 : 
	check_2_ungo[80] ? 32 : 
	check_2_ungo[79] ? 33 : 
	check_2_ungo[78] ? 34 : 
	check_2_ungo[77] ? 35 : 
	check_2_ungo[76] ? 36 : 
	check_2_ungo[75] ? 37 : 
	check_2_ungo[74] ? 38 : 
	check_2_ungo[73] ? 39 : 
	check_2_ungo[72] ? 40 : 
	check_2_ungo[71] ? 41 : 
	check_2_ungo[70] ? 42 : 
	check_2_ungo[69] ? 43 : 
	check_2_ungo[68] ? 44 : 
	check_2_ungo[67] ? 45 : 
	check_2_ungo[66] ? 46 : 
	check_2_ungo[65] ? 47 : 
	check_2_ungo[64] ? 48 : 
	check_2_ungo[63] ? 49 : 
	check_2_ungo[62] ? 50 : 
	check_2_ungo[61] ? 51 : 
	check_2_ungo[60] ? 52 : 
	check_2_ungo[59] ? 53 : 
	check_2_ungo[58] ? 54 : 
	check_2_ungo[57] ? 55 : 
	check_2_ungo[56] ? 56 : 
	check_2_ungo[55] ? 57 : 
	check_2_ungo[54] ? 58 : 
	check_2_ungo[53] ? 59 : 
	check_2_ungo[52] ? 60 : 
	check_2_ungo[51] ? 61 : 
	check_2_ungo[50] ? 62 : 
	check_2_ungo[49] ? 63 : 
	check_2_ungo[48] ? 64 : 
	check_2_ungo[47] ? 65 : 
	check_2_ungo[46] ? 66 : 
	check_2_ungo[45] ? 67 : 
	check_2_ungo[44] ? 68 : 
	check_2_ungo[43] ? 69 : 
	check_2_ungo[42] ? 70 : 
	check_2_ungo[41] ? 71 : 
	check_2_ungo[40] ? 72 : 
	check_2_ungo[39] ? 73 : 
	check_2_ungo[38] ? 74 : 
	check_2_ungo[37] ? 75 : 
	check_2_ungo[36] ? 76 : 
	check_2_ungo[35] ? 77 : 
	check_2_ungo[34] ? 78 : 
	check_2_ungo[33] ? 79 : 
	check_2_ungo[32] ? 80 : 
	check_2_ungo[31] ? 81 : 
	check_2_ungo[30] ? 82 : 
	check_2_ungo[29] ? 83 : 
	check_2_ungo[28] ? 84 : 
	check_2_ungo[27] ? 85 : 
	check_2_ungo[26] ? 86 : 
	check_2_ungo[25] ? 87 : 
	check_2_ungo[24] ? 88 : 
	check_2_ungo[23] ? 89 : 
	check_2_ungo[22] ? 90 : 
	check_2_ungo[21] ? 91 : 
	check_2_ungo[20] ? 92 : 
	check_2_ungo[19] ? 93 : 
	check_2_ungo[18] ? 94 : 
	check_2_ungo[17] ? 95 : 
	check_2_ungo[16] ? 96 : 
	check_2_ungo[15] ? 97 : 
	check_2_ungo[14] ? 98 : 
	check_2_ungo[13] ? 99 : 
	check_2_ungo[12] ? 100 : 
	check_2_ungo[11] ? 101 : 
	check_2_ungo[10] ? 102 : 
	check_2_ungo[9] ? 103 : 
	check_2_ungo[8] ? 104 : 
	check_2_ungo[7] ? 105 : 
	check_2_ungo[6] ? 106 : 
	check_2_ungo[5] ? 107 : 
	check_2_ungo[4] ? 108 : 
	check_2_ungo[3] ? 109 : 
	check_2_ungo[2] ? 110 : 
	check_2_ungo[1] ? 111 : 
	check_2_ungo[0] ? 112 : 
	0;
wire sign_ungo = sign_2_ungo;
wire [15:0] expt_ungo = 
	sign_diff_expt_shit_merd ? 
	(sign_incr_expt_ungo ? expt_merd - mant_incr_expt_ungo : expt_merd + mant_incr_expt_ungo) : 
	(sign_incr_expt_ungo ? expt_shit - mant_incr_expt_ungo : expt_shit + mant_incr_expt_ungo); 
wire [111:0] frac_ungo = 
	check_2_ungo[113] ? frac_2_ungo[16495:16384] : 
	check_2_ungo[112] ? frac_2_ungo[16494:16383] : 
	check_2_ungo[111] ? frac_2_ungo[16493:16382] : 
	check_2_ungo[110] ? frac_2_ungo[16492:16381] : 
	check_2_ungo[109] ? frac_2_ungo[16491:16380] : 
	check_2_ungo[108] ? frac_2_ungo[16490:16379] : 
	check_2_ungo[107] ? frac_2_ungo[16489:16378] : 
	check_2_ungo[106] ? frac_2_ungo[16488:16377] : 
	check_2_ungo[105] ? frac_2_ungo[16487:16376] : 
	check_2_ungo[104] ? frac_2_ungo[16486:16375] : 
	check_2_ungo[103] ? frac_2_ungo[16485:16374] : 
	check_2_ungo[102] ? frac_2_ungo[16484:16373] : 
	check_2_ungo[101] ? frac_2_ungo[16483:16372] : 
	check_2_ungo[100] ? frac_2_ungo[16482:16371] : 
	check_2_ungo[99] ? frac_2_ungo[16481:16370] : 
	check_2_ungo[98] ? frac_2_ungo[16480:16369] : 
	check_2_ungo[97] ? frac_2_ungo[16479:16368] : 
	check_2_ungo[96] ? frac_2_ungo[16478:16367] : 
	check_2_ungo[95] ? frac_2_ungo[16477:16366] : 
	check_2_ungo[94] ? frac_2_ungo[16476:16365] : 
	check_2_ungo[93] ? frac_2_ungo[16475:16364] : 
	check_2_ungo[92] ? frac_2_ungo[16474:16363] : 
	check_2_ungo[91] ? frac_2_ungo[16473:16362] : 
	check_2_ungo[90] ? frac_2_ungo[16472:16361] : 
	check_2_ungo[89] ? frac_2_ungo[16471:16360] : 
	check_2_ungo[88] ? frac_2_ungo[16470:16359] : 
	check_2_ungo[87] ? frac_2_ungo[16469:16358] : 
	check_2_ungo[86] ? frac_2_ungo[16468:16357] : 
	check_2_ungo[85] ? frac_2_ungo[16467:16356] : 
	check_2_ungo[84] ? frac_2_ungo[16466:16355] : 
	check_2_ungo[83] ? frac_2_ungo[16465:16354] : 
	check_2_ungo[82] ? frac_2_ungo[16464:16353] : 
	check_2_ungo[81] ? frac_2_ungo[16463:16352] : 
	check_2_ungo[80] ? frac_2_ungo[16462:16351] : 
	check_2_ungo[79] ? frac_2_ungo[16461:16350] : 
	check_2_ungo[78] ? frac_2_ungo[16460:16349] : 
	check_2_ungo[77] ? frac_2_ungo[16459:16348] : 
	check_2_ungo[76] ? frac_2_ungo[16458:16347] : 
	check_2_ungo[75] ? frac_2_ungo[16457:16346] : 
	check_2_ungo[74] ? frac_2_ungo[16456:16345] : 
	check_2_ungo[73] ? frac_2_ungo[16455:16344] : 
	check_2_ungo[72] ? frac_2_ungo[16454:16343] : 
	check_2_ungo[71] ? frac_2_ungo[16453:16342] : 
	check_2_ungo[70] ? frac_2_ungo[16452:16341] : 
	check_2_ungo[69] ? frac_2_ungo[16451:16340] : 
	check_2_ungo[68] ? frac_2_ungo[16450:16339] : 
	check_2_ungo[67] ? frac_2_ungo[16449:16338] : 
	check_2_ungo[66] ? frac_2_ungo[16448:16337] : 
	check_2_ungo[65] ? frac_2_ungo[16447:16336] : 
	check_2_ungo[64] ? frac_2_ungo[16446:16335] : 
	check_2_ungo[63] ? frac_2_ungo[16445:16334] : 
	check_2_ungo[62] ? frac_2_ungo[16444:16333] : 
	check_2_ungo[61] ? frac_2_ungo[16443:16332] : 
	check_2_ungo[60] ? frac_2_ungo[16442:16331] : 
	check_2_ungo[59] ? frac_2_ungo[16441:16330] : 
	check_2_ungo[58] ? frac_2_ungo[16440:16329] : 
	check_2_ungo[57] ? frac_2_ungo[16439:16328] : 
	check_2_ungo[56] ? frac_2_ungo[16438:16327] : 
	check_2_ungo[55] ? frac_2_ungo[16437:16326] : 
	check_2_ungo[54] ? frac_2_ungo[16436:16325] : 
	check_2_ungo[53] ? frac_2_ungo[16435:16324] : 
	check_2_ungo[52] ? frac_2_ungo[16434:16323] : 
	check_2_ungo[51] ? frac_2_ungo[16433:16322] : 
	check_2_ungo[50] ? frac_2_ungo[16432:16321] : 
	check_2_ungo[49] ? frac_2_ungo[16431:16320] : 
	check_2_ungo[48] ? frac_2_ungo[16430:16319] : 
	check_2_ungo[47] ? frac_2_ungo[16429:16318] : 
	check_2_ungo[46] ? frac_2_ungo[16428:16317] : 
	check_2_ungo[45] ? frac_2_ungo[16427:16316] : 
	check_2_ungo[44] ? frac_2_ungo[16426:16315] : 
	check_2_ungo[43] ? frac_2_ungo[16425:16314] : 
	check_2_ungo[42] ? frac_2_ungo[16424:16313] : 
	check_2_ungo[41] ? frac_2_ungo[16423:16312] : 
	check_2_ungo[40] ? frac_2_ungo[16422:16311] : 
	check_2_ungo[39] ? frac_2_ungo[16421:16310] : 
	check_2_ungo[38] ? frac_2_ungo[16420:16309] : 
	check_2_ungo[37] ? frac_2_ungo[16419:16308] : 
	check_2_ungo[36] ? frac_2_ungo[16418:16307] : 
	check_2_ungo[35] ? frac_2_ungo[16417:16306] : 
	check_2_ungo[34] ? frac_2_ungo[16416:16305] : 
	check_2_ungo[33] ? frac_2_ungo[16415:16304] : 
	check_2_ungo[32] ? frac_2_ungo[16414:16303] : 
	check_2_ungo[31] ? frac_2_ungo[16413:16302] : 
	check_2_ungo[30] ? frac_2_ungo[16412:16301] : 
	check_2_ungo[29] ? frac_2_ungo[16411:16300] : 
	check_2_ungo[28] ? frac_2_ungo[16410:16299] : 
	check_2_ungo[27] ? frac_2_ungo[16409:16298] : 
	check_2_ungo[26] ? frac_2_ungo[16408:16297] : 
	check_2_ungo[25] ? frac_2_ungo[16407:16296] : 
	check_2_ungo[24] ? frac_2_ungo[16406:16295] : 
	check_2_ungo[23] ? frac_2_ungo[16405:16294] : 
	check_2_ungo[22] ? frac_2_ungo[16404:16293] : 
	check_2_ungo[21] ? frac_2_ungo[16403:16292] : 
	check_2_ungo[20] ? frac_2_ungo[16402:16291] : 
	check_2_ungo[19] ? frac_2_ungo[16401:16290] : 
	check_2_ungo[18] ? frac_2_ungo[16400:16289] : 
	check_2_ungo[17] ? frac_2_ungo[16399:16288] : 
	check_2_ungo[16] ? frac_2_ungo[16398:16287] : 
	check_2_ungo[15] ? frac_2_ungo[16397:16286] : 
	check_2_ungo[14] ? frac_2_ungo[16396:16285] : 
	check_2_ungo[13] ? frac_2_ungo[16395:16284] : 
	check_2_ungo[12] ? frac_2_ungo[16394:16283] : 
	check_2_ungo[11] ? frac_2_ungo[16393:16282] : 
	check_2_ungo[10] ? frac_2_ungo[16392:16281] : 
	check_2_ungo[9] ? frac_2_ungo[16391:16280] : 
	check_2_ungo[8] ? frac_2_ungo[16390:16279] : 
	check_2_ungo[7] ? frac_2_ungo[16389:16278] : 
	check_2_ungo[6] ? frac_2_ungo[16388:16277] : 
	check_2_ungo[5] ? frac_2_ungo[16387:16276] : 
	check_2_ungo[4] ? frac_2_ungo[16386:16275] : 
	check_2_ungo[3] ? frac_2_ungo[16385:16274] : 
	check_2_ungo[2] ? frac_2_ungo[16384:16273] : 
	check_2_ungo[1] ? frac_2_ungo[16383:16272] : 
	check_2_ungo[0] ? frac_2_ungo[16382:16271] : 
	0;
assign ungo = {sign_ungo,expt_ungo,frac_ungo};
//verilog-fp_add end

endmodule


//(verilog-fp_mul 'shit 'merd 'mist 127 126 112 111 0)
module fp128_mul (
	input [127:0] shit, merd, 
	output [127:0] mist
);

//verilog-fp_mul start
wire sign_shit = shit[127];
wire sign_merd = merd[127];
wire sign_mist = sign_shit ^ sign_merd;
wire [112:0] frac_shit = {1'b1,shit[111:0]};
wire [112:0] frac_merd = {1'b1,merd[111:0]};
wire [225:0] frac_1_mist = frac_shit * frac_merd;
wire check_frac_1_mist = frac_1_mist[225];
wire [111:0] frac_mist = check_frac_1_mist ? frac_1_mist[224:113] : frac_1_mist[223:112];
wire [14:0] expt_shit = shit[126:112];
wire [14:0] expt_merd = merd[126:112];
wire sign_expt_shit = expt_shit < 16383;
wire sign_expt_merd = expt_merd < 16383;
wire sign_1_mist = sign_expt_shit & sign_expt_merd;
wire [14:0] expt_1_mist = expt_shit + expt_merd - 16383 + (check_frac_1_mist ? 1 : 0);
wire [15:0] expt_2_mist = expt_shit + expt_merd - 16383 + (check_frac_1_mist ? 1 : 0);
wire [15:0] expt_2_max_mist = 32767;
wire [15:0] expt_2_min_mist = ~expt_2_max_mist + 1;
wire [14:0] expt_mist = ((~sign_1_mist&(expt_2_mist >= expt_2_max_mist))|(sign_1_mist&(expt_2_mist >= expt_2_min_mist))) ? 32767 : expt_1_mist;
assign mist = {sign_mist,expt_mist,frac_mist};
//verilog-fp_mul end

endmodule


//(verilog-fp_mac 'shit 'merd 'mist 'ungo 127 126 112 111 0)
module fp128_mac (
	input [127:0] shit, merd, mist, 
	output [127:0] ungo
);

//verilog-fp_mul start
wire sign_shit = shit[127];
wire sign_merd = merd[127];
wire sign_mist = sign_shit ^ sign_merd;
wire [14:0] expt_shit = shit[126:112];
wire [14:0] expt_merd = merd[126:112];
wire [14:0] expt_1_mist = expt_shit + expt_merd - 16383;
wire [112:0] frac_shit = {1'b1,shit[111:0]};
wire [112:0] frac_merd = {1'b1,merd[111:0]};
wire [225:0] frac_1_mist = frac_shit * frac_merd;
wire check_frac_1_mist = frac_1_mist[225];
wire [14:0] expt_mist = check_frac_1_mist ? expt_1_mist + 1 : expt_1_mist;
wire [111:0] frac_mist = check_frac_1_mist ? frac_1_mist[224:113] : frac_1_mist[223:112];
assign mist = {sign_mist,expt_mist,frac_mist};
//verilog-fp_mul end

EA> (verilog-fp_mac 'shit 'merd 'mist 'ungo 127 126 112 111 0)

//verilog-fp_mac start
wire [127:0] z0_shit_merd, z1_shit_merd;

//verilog-fp_mul start
wire sign_shit = shit[127];
wire sign_merd = merd[127];
wire sign_z0_shit_merd = sign_shit ^ sign_merd;
wire [14:0] expt_shit = shit[126:112];
wire [14:0] expt_merd = merd[126:112];
wire [14:0] expt_1_z0_shit_merd = expt_shit + expt_merd - 16383;
wire [112:0] frac_shit = {1'b1,shit[111:0]};
wire [112:0] frac_merd = {1'b1,merd[111:0]};
wire [225:0] frac_1_z0_shit_merd = frac_shit * frac_merd;
wire check_frac_1_z0_shit_merd = frac_1_z0_shit_merd[225];
wire [14:0] expt_z0_shit_merd = check_frac_1_z0_shit_merd ? expt_1_z0_shit_merd + 1 : expt_1_z0_shit_merd;
wire [111:0] frac_z0_shit_merd = check_frac_1_z0_shit_merd ? frac_1_z0_shit_merd[224:113] : frac_1_z0_shit_merd[223:112];
assign z0_shit_merd = {sign_z0_shit_merd,expt_z0_shit_merd,frac_z0_shit_merd};
//verilog-fp_mul end

//verilog-fp_add start
wire sign_z1_shit_merd = z1_shit_merd[127];
wire [14:0] expt_z1_shit_merd = z1_shit_merd[126:112];
wire sign_expt_z1_shit_merd = (expt_z1_shit_merd < 16383) ? 1 : 0;
wire [13:0] mant_expt_z1_shit_merd = sign_expt_z1_shit_merd ? 16383 - expt_z1_shit_merd : expt_z1_shit_merd - 16383;
wire sign_mist = mist[127];
wire [14:0] expt_mist = mist[126:112];
wire sign_expt_mist = (expt_mist < 16383) ? 1 : 0;
wire [13:0] mant_expt_mist = sign_expt_mist ? 16383 - expt_mist : expt_mist - 16383;
wire sign_diff_expt_z1_shit_merd_mist = 
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b10) ? 1 : 
	(({sign_expt_z1_shit_merd,sign_expt_mist}==2'b00) & (mant_expt_z1_shit_merd < mant_expt_mist)) ? 1 : 
	(({sign_expt_z1_shit_merd,sign_expt_mist}==2'b11) & (mant_expt_z1_shit_merd > mant_expt_mist)) ? 1 : 
	0;
wire [14:0] mant_diff_expt_z1_shit_merd_mist =
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b00) ? ((mant_expt_z1_shit_merd < mant_expt_mist) ? mant_expt_mist - mant_expt_z1_shit_merd : mant_expt_z1_shit_merd - mant_expt_mist) : 
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b01) ? mant_expt_z1_shit_merd + mant_expt_mist : 
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b10) ? mant_expt_z1_shit_merd + mant_expt_mist : 
	({sign_expt_z1_shit_merd,sign_expt_mist}==2'b11) ? ((mant_expt_z1_shit_merd < mant_expt_mist) ? mant_expt_mist - mant_expt_z1_shit_merd : mant_expt_z1_shit_merd - mant_expt_mist) : 
	0;
wire [16496:0] frac_z1_shit_merd = {2'b01,z1_shit_merd[111:0],16383'd0};
wire [16496:0] frac_mist = {2'b01,mist[111:0],16383'd0};
wire sign_1a_ungo = sign_diff_expt_z1_shit_merd_mist ? sign_mist : sign_z1_shit_merd;
wire sign_1b_ungo = sign_diff_expt_z1_shit_merd_mist ? sign_z1_shit_merd : sign_mist;
wire [16496:0] frac_1a_ungo = sign_diff_expt_z1_shit_merd_mist ? frac_mist : frac_z1_shit_merd;
wire [16496:0] frac_1b_ungo = sign_diff_expt_z1_shit_merd_mist ? frac_z1_shit_merd : frac_mist;
wire sign_2a_ungo = sign_1a_ungo;
wire sign_2b_ungo = sign_1b_ungo;
wire [16496:0] frac_2a_ungo = frac_1a_ungo;
wire [16496:0] frac_2b_ungo = frac_1b_ungo >> mant_diff_expt_z1_shit_merd_mist;
wire sign_2_ungo =
	({sign_2a_ungo,sign_2b_ungo}==2'b11) ? 1 : 
	(({sign_2a_ungo,sign_2b_ungo}==2'b10) & (frac_2a_ungo > frac_2b_ungo)) ? 1 : 
	(({sign_2a_ungo,sign_2b_ungo}==2'b01) & (frac_2a_ungo < frac_2b_ungo)) ? 1 : 
	0;
wire [16496:0] frac_2_ungo =
	({sign_2a_ungo,sign_2b_ungo}==2'b00) ? frac_2a_ungo + frac_2b_ungo : 
	({sign_2a_ungo,sign_2b_ungo}==2'b01) ? ((frac_2a_ungo < frac_2b_ungo) ? frac_2b_ungo - frac_2a_ungo : frac_2a_ungo - frac_2b_ungo) : 
	({sign_2a_ungo,sign_2b_ungo}==2'b10) ? ((frac_2a_ungo > frac_2b_ungo) ? frac_2a_ungo - frac_2b_ungo : frac_2b_ungo - frac_2a_ungo) : 
	({sign_2a_ungo,sign_2b_ungo}==2'b11) ? frac_2a_ungo + frac_2b_ungo : 
	0;
wire [113:0] check_2_ungo;
assign check_2_ungo[113] = frac_2_ungo[16496];
assign check_2_ungo[112] = frac_2_ungo[16495] & ~check_2_ungo[113];
assign check_2_ungo[111] = frac_2_ungo[16494] & ~check_2_ungo[112];
assign check_2_ungo[110] = frac_2_ungo[16493] & ~check_2_ungo[111];
assign check_2_ungo[109] = frac_2_ungo[16492] & ~check_2_ungo[110];
assign check_2_ungo[108] = frac_2_ungo[16491] & ~check_2_ungo[109];
assign check_2_ungo[107] = frac_2_ungo[16490] & ~check_2_ungo[108];
assign check_2_ungo[106] = frac_2_ungo[16489] & ~check_2_ungo[107];
assign check_2_ungo[105] = frac_2_ungo[16488] & ~check_2_ungo[106];
assign check_2_ungo[104] = frac_2_ungo[16487] & ~check_2_ungo[105];
assign check_2_ungo[103] = frac_2_ungo[16486] & ~check_2_ungo[104];
assign check_2_ungo[102] = frac_2_ungo[16485] & ~check_2_ungo[103];
assign check_2_ungo[101] = frac_2_ungo[16484] & ~check_2_ungo[102];
assign check_2_ungo[100] = frac_2_ungo[16483] & ~check_2_ungo[101];
assign check_2_ungo[99] = frac_2_ungo[16482] & ~check_2_ungo[100];
assign check_2_ungo[98] = frac_2_ungo[16481] & ~check_2_ungo[99];
assign check_2_ungo[97] = frac_2_ungo[16480] & ~check_2_ungo[98];
assign check_2_ungo[96] = frac_2_ungo[16479] & ~check_2_ungo[97];
assign check_2_ungo[95] = frac_2_ungo[16478] & ~check_2_ungo[96];
assign check_2_ungo[94] = frac_2_ungo[16477] & ~check_2_ungo[95];
assign check_2_ungo[93] = frac_2_ungo[16476] & ~check_2_ungo[94];
assign check_2_ungo[92] = frac_2_ungo[16475] & ~check_2_ungo[93];
assign check_2_ungo[91] = frac_2_ungo[16474] & ~check_2_ungo[92];
assign check_2_ungo[90] = frac_2_ungo[16473] & ~check_2_ungo[91];
assign check_2_ungo[89] = frac_2_ungo[16472] & ~check_2_ungo[90];
assign check_2_ungo[88] = frac_2_ungo[16471] & ~check_2_ungo[89];
assign check_2_ungo[87] = frac_2_ungo[16470] & ~check_2_ungo[88];
assign check_2_ungo[86] = frac_2_ungo[16469] & ~check_2_ungo[87];
assign check_2_ungo[85] = frac_2_ungo[16468] & ~check_2_ungo[86];
assign check_2_ungo[84] = frac_2_ungo[16467] & ~check_2_ungo[85];
assign check_2_ungo[83] = frac_2_ungo[16466] & ~check_2_ungo[84];
assign check_2_ungo[82] = frac_2_ungo[16465] & ~check_2_ungo[83];
assign check_2_ungo[81] = frac_2_ungo[16464] & ~check_2_ungo[82];
assign check_2_ungo[80] = frac_2_ungo[16463] & ~check_2_ungo[81];
assign check_2_ungo[79] = frac_2_ungo[16462] & ~check_2_ungo[80];
assign check_2_ungo[78] = frac_2_ungo[16461] & ~check_2_ungo[79];
assign check_2_ungo[77] = frac_2_ungo[16460] & ~check_2_ungo[78];
assign check_2_ungo[76] = frac_2_ungo[16459] & ~check_2_ungo[77];
assign check_2_ungo[75] = frac_2_ungo[16458] & ~check_2_ungo[76];
assign check_2_ungo[74] = frac_2_ungo[16457] & ~check_2_ungo[75];
assign check_2_ungo[73] = frac_2_ungo[16456] & ~check_2_ungo[74];
assign check_2_ungo[72] = frac_2_ungo[16455] & ~check_2_ungo[73];
assign check_2_ungo[71] = frac_2_ungo[16454] & ~check_2_ungo[72];
assign check_2_ungo[70] = frac_2_ungo[16453] & ~check_2_ungo[71];
assign check_2_ungo[69] = frac_2_ungo[16452] & ~check_2_ungo[70];
assign check_2_ungo[68] = frac_2_ungo[16451] & ~check_2_ungo[69];
assign check_2_ungo[67] = frac_2_ungo[16450] & ~check_2_ungo[68];
assign check_2_ungo[66] = frac_2_ungo[16449] & ~check_2_ungo[67];
assign check_2_ungo[65] = frac_2_ungo[16448] & ~check_2_ungo[66];
assign check_2_ungo[64] = frac_2_ungo[16447] & ~check_2_ungo[65];
assign check_2_ungo[63] = frac_2_ungo[16446] & ~check_2_ungo[64];
assign check_2_ungo[62] = frac_2_ungo[16445] & ~check_2_ungo[63];
assign check_2_ungo[61] = frac_2_ungo[16444] & ~check_2_ungo[62];
assign check_2_ungo[60] = frac_2_ungo[16443] & ~check_2_ungo[61];
assign check_2_ungo[59] = frac_2_ungo[16442] & ~check_2_ungo[60];
assign check_2_ungo[58] = frac_2_ungo[16441] & ~check_2_ungo[59];
assign check_2_ungo[57] = frac_2_ungo[16440] & ~check_2_ungo[58];
assign check_2_ungo[56] = frac_2_ungo[16439] & ~check_2_ungo[57];
assign check_2_ungo[55] = frac_2_ungo[16438] & ~check_2_ungo[56];
assign check_2_ungo[54] = frac_2_ungo[16437] & ~check_2_ungo[55];
assign check_2_ungo[53] = frac_2_ungo[16436] & ~check_2_ungo[54];
assign check_2_ungo[52] = frac_2_ungo[16435] & ~check_2_ungo[53];
assign check_2_ungo[51] = frac_2_ungo[16434] & ~check_2_ungo[52];
assign check_2_ungo[50] = frac_2_ungo[16433] & ~check_2_ungo[51];
assign check_2_ungo[49] = frac_2_ungo[16432] & ~check_2_ungo[50];
assign check_2_ungo[48] = frac_2_ungo[16431] & ~check_2_ungo[49];
assign check_2_ungo[47] = frac_2_ungo[16430] & ~check_2_ungo[48];
assign check_2_ungo[46] = frac_2_ungo[16429] & ~check_2_ungo[47];
assign check_2_ungo[45] = frac_2_ungo[16428] & ~check_2_ungo[46];
assign check_2_ungo[44] = frac_2_ungo[16427] & ~check_2_ungo[45];
assign check_2_ungo[43] = frac_2_ungo[16426] & ~check_2_ungo[44];
assign check_2_ungo[42] = frac_2_ungo[16425] & ~check_2_ungo[43];
assign check_2_ungo[41] = frac_2_ungo[16424] & ~check_2_ungo[42];
assign check_2_ungo[40] = frac_2_ungo[16423] & ~check_2_ungo[41];
assign check_2_ungo[39] = frac_2_ungo[16422] & ~check_2_ungo[40];
assign check_2_ungo[38] = frac_2_ungo[16421] & ~check_2_ungo[39];
assign check_2_ungo[37] = frac_2_ungo[16420] & ~check_2_ungo[38];
assign check_2_ungo[36] = frac_2_ungo[16419] & ~check_2_ungo[37];
assign check_2_ungo[35] = frac_2_ungo[16418] & ~check_2_ungo[36];
assign check_2_ungo[34] = frac_2_ungo[16417] & ~check_2_ungo[35];
assign check_2_ungo[33] = frac_2_ungo[16416] & ~check_2_ungo[34];
assign check_2_ungo[32] = frac_2_ungo[16415] & ~check_2_ungo[33];
assign check_2_ungo[31] = frac_2_ungo[16414] & ~check_2_ungo[32];
assign check_2_ungo[30] = frac_2_ungo[16413] & ~check_2_ungo[31];
assign check_2_ungo[29] = frac_2_ungo[16412] & ~check_2_ungo[30];
assign check_2_ungo[28] = frac_2_ungo[16411] & ~check_2_ungo[29];
assign check_2_ungo[27] = frac_2_ungo[16410] & ~check_2_ungo[28];
assign check_2_ungo[26] = frac_2_ungo[16409] & ~check_2_ungo[27];
assign check_2_ungo[25] = frac_2_ungo[16408] & ~check_2_ungo[26];
assign check_2_ungo[24] = frac_2_ungo[16407] & ~check_2_ungo[25];
assign check_2_ungo[23] = frac_2_ungo[16406] & ~check_2_ungo[24];
assign check_2_ungo[22] = frac_2_ungo[16405] & ~check_2_ungo[23];
assign check_2_ungo[21] = frac_2_ungo[16404] & ~check_2_ungo[22];
assign check_2_ungo[20] = frac_2_ungo[16403] & ~check_2_ungo[21];
assign check_2_ungo[19] = frac_2_ungo[16402] & ~check_2_ungo[20];
assign check_2_ungo[18] = frac_2_ungo[16401] & ~check_2_ungo[19];
assign check_2_ungo[17] = frac_2_ungo[16400] & ~check_2_ungo[18];
assign check_2_ungo[16] = frac_2_ungo[16399] & ~check_2_ungo[17];
assign check_2_ungo[15] = frac_2_ungo[16398] & ~check_2_ungo[16];
assign check_2_ungo[14] = frac_2_ungo[16397] & ~check_2_ungo[15];
assign check_2_ungo[13] = frac_2_ungo[16396] & ~check_2_ungo[14];
assign check_2_ungo[12] = frac_2_ungo[16395] & ~check_2_ungo[13];
assign check_2_ungo[11] = frac_2_ungo[16394] & ~check_2_ungo[12];
assign check_2_ungo[10] = frac_2_ungo[16393] & ~check_2_ungo[11];
assign check_2_ungo[9] = frac_2_ungo[16392] & ~check_2_ungo[10];
assign check_2_ungo[8] = frac_2_ungo[16391] & ~check_2_ungo[9];
assign check_2_ungo[7] = frac_2_ungo[16390] & ~check_2_ungo[8];
assign check_2_ungo[6] = frac_2_ungo[16389] & ~check_2_ungo[7];
assign check_2_ungo[5] = frac_2_ungo[16388] & ~check_2_ungo[6];
assign check_2_ungo[4] = frac_2_ungo[16387] & ~check_2_ungo[5];
assign check_2_ungo[3] = frac_2_ungo[16386] & ~check_2_ungo[4];
assign check_2_ungo[2] = frac_2_ungo[16385] & ~check_2_ungo[3];
assign check_2_ungo[1] = frac_2_ungo[16384] & ~check_2_ungo[2];
assign check_2_ungo[0] = frac_2_ungo[16383] & ~check_2_ungo[1];
wire sign_incr_expt_ungo = 
	check_2_ungo[113] ? 0 : 
	check_2_ungo[112] ? 0 : 
	1;
wire [14:0] mant_incr_expt_ungo = 
	check_2_ungo[113] ? 1 : 
	check_2_ungo[112] ? 0 : 
	check_2_ungo[111] ? 1 : 
	check_2_ungo[110] ? 2 : 
	check_2_ungo[109] ? 3 : 
	check_2_ungo[108] ? 4 : 
	check_2_ungo[107] ? 5 : 
	check_2_ungo[106] ? 6 : 
	check_2_ungo[105] ? 7 : 
	check_2_ungo[104] ? 8 : 
	check_2_ungo[103] ? 9 : 
	check_2_ungo[102] ? 10 : 
	check_2_ungo[101] ? 11 : 
	check_2_ungo[100] ? 12 : 
	check_2_ungo[99] ? 13 : 
	check_2_ungo[98] ? 14 : 
	check_2_ungo[97] ? 15 : 
	check_2_ungo[96] ? 16 : 
	check_2_ungo[95] ? 17 : 
	check_2_ungo[94] ? 18 : 
	check_2_ungo[93] ? 19 : 
	check_2_ungo[92] ? 20 : 
	check_2_ungo[91] ? 21 : 
	check_2_ungo[90] ? 22 : 
	check_2_ungo[89] ? 23 : 
	check_2_ungo[88] ? 24 : 
	check_2_ungo[87] ? 25 : 
	check_2_ungo[86] ? 26 : 
	check_2_ungo[85] ? 27 : 
	check_2_ungo[84] ? 28 : 
	check_2_ungo[83] ? 29 : 
	check_2_ungo[82] ? 30 : 
	check_2_ungo[81] ? 31 : 
	check_2_ungo[80] ? 32 : 
	check_2_ungo[79] ? 33 : 
	check_2_ungo[78] ? 34 : 
	check_2_ungo[77] ? 35 : 
	check_2_ungo[76] ? 36 : 
	check_2_ungo[75] ? 37 : 
	check_2_ungo[74] ? 38 : 
	check_2_ungo[73] ? 39 : 
	check_2_ungo[72] ? 40 : 
	check_2_ungo[71] ? 41 : 
	check_2_ungo[70] ? 42 : 
	check_2_ungo[69] ? 43 : 
	check_2_ungo[68] ? 44 : 
	check_2_ungo[67] ? 45 : 
	check_2_ungo[66] ? 46 : 
	check_2_ungo[65] ? 47 : 
	check_2_ungo[64] ? 48 : 
	check_2_ungo[63] ? 49 : 
	check_2_ungo[62] ? 50 : 
	check_2_ungo[61] ? 51 : 
	check_2_ungo[60] ? 52 : 
	check_2_ungo[59] ? 53 : 
	check_2_ungo[58] ? 54 : 
	check_2_ungo[57] ? 55 : 
	check_2_ungo[56] ? 56 : 
	check_2_ungo[55] ? 57 : 
	check_2_ungo[54] ? 58 : 
	check_2_ungo[53] ? 59 : 
	check_2_ungo[52] ? 60 : 
	check_2_ungo[51] ? 61 : 
	check_2_ungo[50] ? 62 : 
	check_2_ungo[49] ? 63 : 
	check_2_ungo[48] ? 64 : 
	check_2_ungo[47] ? 65 : 
	check_2_ungo[46] ? 66 : 
	check_2_ungo[45] ? 67 : 
	check_2_ungo[44] ? 68 : 
	check_2_ungo[43] ? 69 : 
	check_2_ungo[42] ? 70 : 
	check_2_ungo[41] ? 71 : 
	check_2_ungo[40] ? 72 : 
	check_2_ungo[39] ? 73 : 
	check_2_ungo[38] ? 74 : 
	check_2_ungo[37] ? 75 : 
	check_2_ungo[36] ? 76 : 
	check_2_ungo[35] ? 77 : 
	check_2_ungo[34] ? 78 : 
	check_2_ungo[33] ? 79 : 
	check_2_ungo[32] ? 80 : 
	check_2_ungo[31] ? 81 : 
	check_2_ungo[30] ? 82 : 
	check_2_ungo[29] ? 83 : 
	check_2_ungo[28] ? 84 : 
	check_2_ungo[27] ? 85 : 
	check_2_ungo[26] ? 86 : 
	check_2_ungo[25] ? 87 : 
	check_2_ungo[24] ? 88 : 
	check_2_ungo[23] ? 89 : 
	check_2_ungo[22] ? 90 : 
	check_2_ungo[21] ? 91 : 
	check_2_ungo[20] ? 92 : 
	check_2_ungo[19] ? 93 : 
	check_2_ungo[18] ? 94 : 
	check_2_ungo[17] ? 95 : 
	check_2_ungo[16] ? 96 : 
	check_2_ungo[15] ? 97 : 
	check_2_ungo[14] ? 98 : 
	check_2_ungo[13] ? 99 : 
	check_2_ungo[12] ? 100 : 
	check_2_ungo[11] ? 101 : 
	check_2_ungo[10] ? 102 : 
	check_2_ungo[9] ? 103 : 
	check_2_ungo[8] ? 104 : 
	check_2_ungo[7] ? 105 : 
	check_2_ungo[6] ? 106 : 
	check_2_ungo[5] ? 107 : 
	check_2_ungo[4] ? 108 : 
	check_2_ungo[3] ? 109 : 
	check_2_ungo[2] ? 110 : 
	check_2_ungo[1] ? 111 : 
	check_2_ungo[0] ? 112 : 
	0;
wire sign_ungo = sign_2_ungo;
wire [15:0] expt_ungo = 
	sign_diff_expt_z1_shit_merd_mist ? 
	(sign_incr_expt_ungo ? expt_mist - mant_incr_expt_ungo : expt_mist + mant_incr_expt_ungo) : 
	(sign_incr_expt_ungo ? expt_z1_shit_merd - mant_incr_expt_ungo : expt_z1_shit_merd + mant_incr_expt_ungo); 
wire [111:0] frac_ungo = 
	check_2_ungo[113] ? frac_2_ungo[16495:16384] : 
	check_2_ungo[112] ? frac_2_ungo[16494:16383] : 
	check_2_ungo[111] ? frac_2_ungo[16493:16382] : 
	check_2_ungo[110] ? frac_2_ungo[16492:16381] : 
	check_2_ungo[109] ? frac_2_ungo[16491:16380] : 
	check_2_ungo[108] ? frac_2_ungo[16490:16379] : 
	check_2_ungo[107] ? frac_2_ungo[16489:16378] : 
	check_2_ungo[106] ? frac_2_ungo[16488:16377] : 
	check_2_ungo[105] ? frac_2_ungo[16487:16376] : 
	check_2_ungo[104] ? frac_2_ungo[16486:16375] : 
	check_2_ungo[103] ? frac_2_ungo[16485:16374] : 
	check_2_ungo[102] ? frac_2_ungo[16484:16373] : 
	check_2_ungo[101] ? frac_2_ungo[16483:16372] : 
	check_2_ungo[100] ? frac_2_ungo[16482:16371] : 
	check_2_ungo[99] ? frac_2_ungo[16481:16370] : 
	check_2_ungo[98] ? frac_2_ungo[16480:16369] : 
	check_2_ungo[97] ? frac_2_ungo[16479:16368] : 
	check_2_ungo[96] ? frac_2_ungo[16478:16367] : 
	check_2_ungo[95] ? frac_2_ungo[16477:16366] : 
	check_2_ungo[94] ? frac_2_ungo[16476:16365] : 
	check_2_ungo[93] ? frac_2_ungo[16475:16364] : 
	check_2_ungo[92] ? frac_2_ungo[16474:16363] : 
	check_2_ungo[91] ? frac_2_ungo[16473:16362] : 
	check_2_ungo[90] ? frac_2_ungo[16472:16361] : 
	check_2_ungo[89] ? frac_2_ungo[16471:16360] : 
	check_2_ungo[88] ? frac_2_ungo[16470:16359] : 
	check_2_ungo[87] ? frac_2_ungo[16469:16358] : 
	check_2_ungo[86] ? frac_2_ungo[16468:16357] : 
	check_2_ungo[85] ? frac_2_ungo[16467:16356] : 
	check_2_ungo[84] ? frac_2_ungo[16466:16355] : 
	check_2_ungo[83] ? frac_2_ungo[16465:16354] : 
	check_2_ungo[82] ? frac_2_ungo[16464:16353] : 
	check_2_ungo[81] ? frac_2_ungo[16463:16352] : 
	check_2_ungo[80] ? frac_2_ungo[16462:16351] : 
	check_2_ungo[79] ? frac_2_ungo[16461:16350] : 
	check_2_ungo[78] ? frac_2_ungo[16460:16349] : 
	check_2_ungo[77] ? frac_2_ungo[16459:16348] : 
	check_2_ungo[76] ? frac_2_ungo[16458:16347] : 
	check_2_ungo[75] ? frac_2_ungo[16457:16346] : 
	check_2_ungo[74] ? frac_2_ungo[16456:16345] : 
	check_2_ungo[73] ? frac_2_ungo[16455:16344] : 
	check_2_ungo[72] ? frac_2_ungo[16454:16343] : 
	check_2_ungo[71] ? frac_2_ungo[16453:16342] : 
	check_2_ungo[70] ? frac_2_ungo[16452:16341] : 
	check_2_ungo[69] ? frac_2_ungo[16451:16340] : 
	check_2_ungo[68] ? frac_2_ungo[16450:16339] : 
	check_2_ungo[67] ? frac_2_ungo[16449:16338] : 
	check_2_ungo[66] ? frac_2_ungo[16448:16337] : 
	check_2_ungo[65] ? frac_2_ungo[16447:16336] : 
	check_2_ungo[64] ? frac_2_ungo[16446:16335] : 
	check_2_ungo[63] ? frac_2_ungo[16445:16334] : 
	check_2_ungo[62] ? frac_2_ungo[16444:16333] : 
	check_2_ungo[61] ? frac_2_ungo[16443:16332] : 
	check_2_ungo[60] ? frac_2_ungo[16442:16331] : 
	check_2_ungo[59] ? frac_2_ungo[16441:16330] : 
	check_2_ungo[58] ? frac_2_ungo[16440:16329] : 
	check_2_ungo[57] ? frac_2_ungo[16439:16328] : 
	check_2_ungo[56] ? frac_2_ungo[16438:16327] : 
	check_2_ungo[55] ? frac_2_ungo[16437:16326] : 
	check_2_ungo[54] ? frac_2_ungo[16436:16325] : 
	check_2_ungo[53] ? frac_2_ungo[16435:16324] : 
	check_2_ungo[52] ? frac_2_ungo[16434:16323] : 
	check_2_ungo[51] ? frac_2_ungo[16433:16322] : 
	check_2_ungo[50] ? frac_2_ungo[16432:16321] : 
	check_2_ungo[49] ? frac_2_ungo[16431:16320] : 
	check_2_ungo[48] ? frac_2_ungo[16430:16319] : 
	check_2_ungo[47] ? frac_2_ungo[16429:16318] : 
	check_2_ungo[46] ? frac_2_ungo[16428:16317] : 
	check_2_ungo[45] ? frac_2_ungo[16427:16316] : 
	check_2_ungo[44] ? frac_2_ungo[16426:16315] : 
	check_2_ungo[43] ? frac_2_ungo[16425:16314] : 
	check_2_ungo[42] ? frac_2_ungo[16424:16313] : 
	check_2_ungo[41] ? frac_2_ungo[16423:16312] : 
	check_2_ungo[40] ? frac_2_ungo[16422:16311] : 
	check_2_ungo[39] ? frac_2_ungo[16421:16310] : 
	check_2_ungo[38] ? frac_2_ungo[16420:16309] : 
	check_2_ungo[37] ? frac_2_ungo[16419:16308] : 
	check_2_ungo[36] ? frac_2_ungo[16418:16307] : 
	check_2_ungo[35] ? frac_2_ungo[16417:16306] : 
	check_2_ungo[34] ? frac_2_ungo[16416:16305] : 
	check_2_ungo[33] ? frac_2_ungo[16415:16304] : 
	check_2_ungo[32] ? frac_2_ungo[16414:16303] : 
	check_2_ungo[31] ? frac_2_ungo[16413:16302] : 
	check_2_ungo[30] ? frac_2_ungo[16412:16301] : 
	check_2_ungo[29] ? frac_2_ungo[16411:16300] : 
	check_2_ungo[28] ? frac_2_ungo[16410:16299] : 
	check_2_ungo[27] ? frac_2_ungo[16409:16298] : 
	check_2_ungo[26] ? frac_2_ungo[16408:16297] : 
	check_2_ungo[25] ? frac_2_ungo[16407:16296] : 
	check_2_ungo[24] ? frac_2_ungo[16406:16295] : 
	check_2_ungo[23] ? frac_2_ungo[16405:16294] : 
	check_2_ungo[22] ? frac_2_ungo[16404:16293] : 
	check_2_ungo[21] ? frac_2_ungo[16403:16292] : 
	check_2_ungo[20] ? frac_2_ungo[16402:16291] : 
	check_2_ungo[19] ? frac_2_ungo[16401:16290] : 
	check_2_ungo[18] ? frac_2_ungo[16400:16289] : 
	check_2_ungo[17] ? frac_2_ungo[16399:16288] : 
	check_2_ungo[16] ? frac_2_ungo[16398:16287] : 
	check_2_ungo[15] ? frac_2_ungo[16397:16286] : 
	check_2_ungo[14] ? frac_2_ungo[16396:16285] : 
	check_2_ungo[13] ? frac_2_ungo[16395:16284] : 
	check_2_ungo[12] ? frac_2_ungo[16394:16283] : 
	check_2_ungo[11] ? frac_2_ungo[16393:16282] : 
	check_2_ungo[10] ? frac_2_ungo[16392:16281] : 
	check_2_ungo[9] ? frac_2_ungo[16391:16280] : 
	check_2_ungo[8] ? frac_2_ungo[16390:16279] : 
	check_2_ungo[7] ? frac_2_ungo[16389:16278] : 
	check_2_ungo[6] ? frac_2_ungo[16388:16277] : 
	check_2_ungo[5] ? frac_2_ungo[16387:16276] : 
	check_2_ungo[4] ? frac_2_ungo[16386:16275] : 
	check_2_ungo[3] ? frac_2_ungo[16385:16274] : 
	check_2_ungo[2] ? frac_2_ungo[16384:16273] : 
	check_2_ungo[1] ? frac_2_ungo[16383:16272] : 
	check_2_ungo[0] ? frac_2_ungo[16382:16271] : 
	0;
assign ungo = {sign_ungo,expt_ungo,frac_ungo};
//verilog-fp_add end
assign z1_shit_merd = z0_shit_merd;
//verilog-fp_mac end

endmodule


