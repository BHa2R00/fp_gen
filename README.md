# fp_gen
Generator of combinational logic float point operators in Verilog HDL

Depends:
1. [tinylisp](https://github.com/Robert-van-Engelen/tinylisp)
2. [tinylisp_extra_funcs](https://github.com/BHa2R00/tinylisp_extra_funcs)

![format](https://github.com/BHa2R00/fp_gen/blob/main/20230612215725_922x169_scrot.png)

Format constraints:
1. Little endian.
2. sign-expt_msb==1
3. expt_lsb-frac_msb==1
4. frac_lsb==0

Operators:

![operators](https://github.com/BHa2R00/fp_gen/blob/main/20230614215608_840x328_scrot.png)
