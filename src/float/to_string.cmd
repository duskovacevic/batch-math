:to_string return = value
setlocal EnableDelayedExpansion

	set debug=rem
	set /a done=%FALSE%
	if [%~2] equ [%POS_INF%] set /a done=%TRUE%
	if [%~2] equ [%NEG_INF%] set /a done=%TRUE%
	if [%~2] equ [%NAN%] set /a done=%TRUE%
	
	if [%done%] equ [%TRUE%] (
		endlocal & set %~1=%~2
		exit /b 0
	)

	set /a whole=0
	call :_decode m,e=%~2
	
	%debug% echo test 1 = [%m%][%e%]

	if %m% lss 0 (
		set sign=-
		set /a m=-m
	)
	
	%debug% echo test 2 = [%sign%][%m%][%e%]
	
	set /a binFrac=m
	
	%debug% echo test 4 = [!binFrac!]
	
	if %e% gtr -1 (
		set /a "int=m >> (30 - e)"
		set /a "intPart=int << (30 - e)"
		
		%debug% echo test 4a = [!int!][!intPart!]
		
		set /a "binFrac=m - intPart"
		
		%debug% echo test 4b = [!binFrac!]
		
		set /a "binFrac<<=e+1"
	) else (
		set /a int=0
		set /a "binFrac>>=-e-1"
	)
		
	%debug% echo test 5 = [!int!][!binFrac!]
	
	set /a test=1073741824

	set /a bits[0]=500000000, fbits[0]=0,          ffbits[0]=0
	set /a bits[1]=250000000, fbits[1]=0,          ffbits[1]=0
	set /a bits[2]=125000000, fbits[2]=0,          ffbits[2]=0
	set /a bits[3]=62500000,  fbits[3]=0,          ffbits[3]=0
	set /a bits[4]=31250000,  fbits[4]=0,          ffbits[4]=0
	set /a bits[5]=15625000,  fbits[5]=0,          ffbits[5]=0
	set /a bits[6]=7812500,   fbits[6]=0,          ffbits[6]=0
	set /a bits[7]=3906250,   fbits[7]=0,          ffbits[7]=0
	set /a bits[8]=1953125,   fbits[8]=0,          ffbits[8]=0
	set /a bits[9]=976562,    fbits[9]=500000000,  ffbits[9]=0
	set /a bits[10]=488281,   fbits[10]=250000000, ffbits[10]=0
	set /a bits[11]=244140,   fbits[11]=625000000, ffbits[11]=0
	set /a bits[12]=122070,   fbits[12]=312500000, ffbits[12]=0
	set /a bits[13]=61035,    fbits[13]=156250000, ffbits[13]=0
	set /a bits[14]=30517,    fbits[14]=578125000, ffbits[14]=0
	set /a bits[15]=15258,    fbits[15]=789062500, ffbits[15]=0
	set /a bits[16]=7629,     fbits[16]=394531250, ffbits[16]=0
	set /a bits[17]=3814,     fbits[17]=697265625, ffbits[17]=0
	set /a bits[18]=1907,     fbits[18]=348632812, ffbits[18]=500000000
	set /a bits[19]=953,      fbits[19]=674316406, ffbits[19]=250000000
	set /a bits[20]=476,      fbits[20]=837158203, ffbits[20]=125000000
	set /a bits[21]=238,      fbits[21]=418579101, ffbits[21]=562500000
	set /a bits[22]=119,      fbits[22]=209289550, ffbits[22]=781250000
	set /a bits[23]=59,       fbits[23]=604644775, ffbits[23]=390625000
	set /a bits[24]=29,       fbits[24]=802322387, ffbits[24]=695312000
	set /a bits[25]=14,       fbits[25]=901161193, ffbits[25]=847656000
	set /a bits[26]=7,        fbits[26]=450580596, ffbits[26]=923828000
	set /a bits[27]=3,        fbits[27]=725290298, ffbits[27]=461914000
	set /a bits[28]=1,        fbits[28]=862645149, ffbits[28]=230957000
	set /a bits[29]=0,        fbits[29]=931322574, ffbits[29]=615478500
	set /a bits[30]=0,        fbits[30]=465661287, ffbits[30]=307739260

	set /a decFrac=1000000000, fdecFrac=0, ffdecFrac=0
	
	set /a i=0
	
	:for_to_string
	set /a "compare=binFrac & test"
	
	call set /a bit=%%bits[%i%]%%, fbit=%%fbits[%i%]%, %ffbit=%%ffbits[%i%]%%
	
	if %compare% equ 0 goto :skip_fraction

	:: set /a decFrac+=bit, fdecFrac+=fbit, ffdecFrac+=ffbit
	set /a ffdecFracCheck=ffdecFrac+ffbit

	if %ffdecFracCheck% geq 2000000000 goto :roll_ffdec
	if %ffdecFracCheck% lss 0 goto :roll_ffdec

	set /a ffdecFrac+=ffbit

	goto :check_fdec
	
	:roll_ffdec
	set /a ffdecFrac-=1000000000
	set /a ffdecFrac+=fbit
	set /a fdecFrac+=1

	:check_fdec

	set /a fdecFracCheck=fdecFrac+fbit
	
	if %fdecFracCheck% geq 2000000000 goto :roll_fdec
	if %fdecFracCheck% lss 0 goto :roll_fdec

	set /a fdecFrac+=fbit

	goto :set_dec

	:roll_fdec
	set /a fdecFrac-=1000000000
	set /a fdecFrac+=fbit
	set /a decFrac+=1

	:set_dec
	set /a decFrac=decFrac+bit
	
	:skip_fraction

	%debug% echo compare = [!decFrac!][!fdecFrac!][!ffdecFrac!]
	
	set /a "test>>=1"
	set /a i+=1
	if !i! lss 31 goto :for_to_string
	
	set strDecFrac=%decFrac:~1%%fdecFrac:~1%%ffdecFrac:~1%
	
	%debug% echo test 8 = [%sign%%int%.%strDecFrac%]
	
endlocal & set %~1=%sign%%int%.%strDecFrac%
exit /b 0