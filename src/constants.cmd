set TRUE=true
set FALSE=false
set POS_INF=+Inf
set NEG_INF=-Inf
set NAN=NaN

set /a MAXBITS=31
set PI=1686629737E1
set HALF_PI=1686629791E0
set LN_2=1488522277E-1
set ZERO=0E0
set ONE=1073741824E0
set TWO=1073741824E1
set HALF=1073741824E-1
set QUARTER=1073741824E-2
set ROTATION=rotation
set VECTORING=vectoring
set MINUS=-

set "atanTable[0]=1686629791E-1" & rem 0.7853982
set "atanTable[1]=1991351278E-2" & rem 0.4636476
set "atanTable[2]=2104350751E-3" & rem 0.24497867
set "atanTable[3]=2136402563E-4" & rem 0.124354996
set "atanTable[4]=2144693980E-5" & rem 0.06241881
set "atanTable[5]=2146785045E-6" & rem 0.031239834
set "atanTable[6]=2147308963E-7" & rem 0.015623729
set "atanTable[7]=2147439942E-8" & rem 0.007812341
set "atanTable[8]=2147472762E-9" & rem 0.0039062302
set "atanTable[9]=2147481009E-10" & rem 0.0019531226
set "atanTable[10]=2147482988E-11" & rem 0.0009765622
set "atanTable[11]=2147483516E-12" & rem 0.00048828122
set "atanTable[12]=2147483604E-13" & rem 0.00024414062
set "atanTable[13]=2147483604E-14" & rem 0.00012207031
set "atanTable[14]=2147483639E-15" & rem 6.1035156E-05
set "atanTable[15]=2147483639E-16" & rem 3.0517578E-05
set "atanTable[16]=2147483639E-17" & rem 1.5258789E-05
set "atanTable[17]=2147483639E-18" & rem 7.6293945E-06
set "atanTable[18]=1073741833E-18" & rem 3.8146973E-06
set "atanTable[19]=2147483611E-20" & rem 1.9073486E-06
set "atanTable[20]=2147483611E-21" & rem 9.536743E-07
set "atanTable[21]=1073741828E-21" & rem 4.7683716E-07
set "atanTable[22]=1073741828E-22" & rem 2.3841858E-07
set "atanTable[23]=1073741828E-23" & rem 1.1920929E-07
set "atanTable[24]=1073741828E-24" & rem 5.9604645E-08
set "atanTable[25]=2147483620E-26" & rem 2.9802322E-08
set "atanTable[26]=2147483620E-27" & rem 1.4901161E-08
set "atanTable[27]=1073741882E-27" & rem 7.450581E-09
set "atanTable[28]=1073741824E-28" & rem 3.7252903E-09
set "atanTable[29]=2147483591E-30" & rem 1.8626451E-09
set "atanTable[30]=1073741853E-30" & rem 9.313226E-10

set "atanhTable[0]=1179625974E-1" & rem 0.54930615
set "atanhTable[1]=1096989708E-2" & rem 0.25541282
set "atanhTable[2]=1079387300E-3" & rem 0.12565722
set "atanhTable[3]=1075143357E-4" & rem 0.06258158
set "atanhTable[4]=1074091606E-5" & rem 0.03126018
set "atanhTable[5]=1073829235E-6" & rem 0.015626272
set "atanhTable[6]=1073763676E-7" & rem 0.007812659
set "atanhTable[7]=1073747321E-8" & rem 0.00390627
set "atanhTable[8]=1073743088E-9" & rem 0.0019531273
set "atanhTable[9]=1073742043E-10" & rem 0.0009765627
set "atanhTable[10]=1073741824E-11" & rem 0.00048828125
set "atanhTable[11]=2147483604E-13" & rem 0.00024414062
set "atanhTable[12]=2147483604E-14" & rem 0.00012207031
set "atanhTable[13]=2147483639E-15" & rem 6.1035156E-05
set "atanhTable[14]=2147483639E-16" & rem 3.0517578E-05
set "atanhTable[15]=2147483639E-17" & rem 1.5258789E-05
set "atanhTable[16]=2147483639E-18" & rem 7.6293945E-06
set "atanhTable[17]=1073741833E-18" & rem 3.8146973E-06
set "atanhTable[18]=2147483611E-20" & rem 1.9073486E-06
set "atanhTable[19]=2147483611E-21" & rem 9.536743E-07
set "atanhTable[20]=1073741828E-21" & rem 4.7683716E-07
set "atanhTable[21]=1073741828E-22" & rem 2.3841858E-07
set "atanhTable[22]=1073741828E-23" & rem 1.1920929E-07
set "atanhTable[23]=1073741828E-24" & rem 5.9604645E-08
set "atanhTable[24]=2147483620E-26" & rem 2.9802322E-08
set "atanhTable[25]=2147483620E-27" & rem 1.4901161E-08
set "atanhTable[26]=1073741882E-27" & rem 7.450581E-09
set "atanhTable[27]=1073741824E-28" & rem 3.7252903E-09
set "atanhTable[28]=2147483591E-30" & rem 1.8626451E-09
set "atanhTable[29]=1073741853E-30" & rem 9.313226E-10
set "atanhTable[30]=1073741853E-31" & rem 4.656613E-10

set "inverseCircularGain=1304065748E-1" & rem 0.607252935009
set "inverseHyperbolicGain=1296540104E0" & rem 1.207497067763

set _r=[0m & rem reset
set _c=[30m[100m & rem colour