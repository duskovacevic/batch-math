@echo off

setlocal EnableDelayedExpansion
	
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
	set _E=1459366439E1
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
	
	:: return = :method param1, param2
	:: :method param1, param2
	set arg1=%~1

	if not [%arg1::=%] == [%arg1%] (
		set method=%~1
		set param1=%~2
		set param2=%~3
	) else (
		set var=%~1
		set method=%~2
		set param1=%~3
		set param2=%~4
	)

	set convert=%FALSE%
	if [%method%] equ [:set] goto :main_skip_set

	if [%param1:E=%] == [%param1%] (
		set convert=%TRUE%
		call :set param1 = %param1%
		if [%param2%] neq [] (
			call :set param2 = %param2%
		)
	)

	:main_skip_set
	
	:: TODO handle more params
	:: TODO add some help

    :: float
	if [%method%] equ [:set] call :set return = %param1% & goto :done
	if [%method%] equ [:to_string] call :to_string return = %param1% & goto :done
	if [%method%] equ [:shift] call :shift return = %param1%, %param2% & goto :done
	if [%method%] equ [:compare] call :compare return = %param1%, %param2% & goto :done
	if [%method%] equ [:is_negative] call :is_negative return = %param1% & goto :done
	if [%method%] equ [:abs] call :abs return = %param1% & goto :done
	if [%method%] equ [:negate] call :negate return = %param1% & goto :done
	if [%method%] equ [:to_int] call :to_int return = %param1% & goto :done
	if [%method%] equ [:add] call :add return = %param1%, %param2% & goto :done
	if [%method%] equ [:sub] call :sub return = %param1%, %param2% & goto :done
	if [%method%] equ [:inc] call :inc return = %param1% & goto :done
	if [%method%] equ [:dec] call :dec return = %param1% & goto :done

    :: math
    if [%method%] equ [:mul] call :mul return = %param1%, %param2% & goto :done
	if [%method%] equ [:div] call :div return = %param1%, %param2% & goto :done
	if [%method%] equ [:sin] call :sin return = %param1% & goto :done
	if [%method%] equ [:cos] call :cos return = %param1% & goto :done
	if [%method%] equ [:tan] call :tan return = %param1% & goto :done
	if [%method%] equ [:sinh] call :sinh return = %param1% & goto :done
	if [%method%] equ [:cosh] call :cosh return = %param1% & goto :done
	if [%method%] equ [:tanh] call :tanh return = %param1% & goto :done
	if [%method%] equ [:asin] call :asin return = %param1% & goto :done
	if [%method%] equ [:acos] call :acos return = %param1% & goto :done
	if [%method%] equ [:atan] call :atan return = %param1% & goto :done
	if [%method%] equ [:asinh] call :asinh return = %param1% & goto :done
	if [%method%] equ [:acosh] call :acosh return = %param1% & goto :done
	if [%method%] equ [:atanh] call :atanh return = %param1% & goto :done
	if [%method%] equ [:sqrt] call :sqrt return = %param1% & goto :done
	if [%method%] equ [:ln] call :ln return = %param1% & goto :done
	if [%method%] equ [:log] call :log return = %param1%, %param2% & goto :done
	if [%method%] equ [:exp] call :exp return = %param1% & goto :done
	if [%method%] equ [:pow] call :pow return = %param1%, %param2% & goto :done

	:: Add help instead
	echo Method %method% not found.
	
	endlocal
	exit /b -1

	:done
	if [%convert%] == [%TRUE%] (
		call :to_string return = %return%
	)

	if not [%var%] == [] (
		endlocal & set %var%=%return%
	) else (
		if defined param2 (
			echo %~2,%~3,%return%
		) else (
			echo %~2,%return%
		)
	)

endlocal
exit /b 0
goto :eof

:acos return = w
setlocal EnableDelayedExpansion

	set w=%~2

	:: acos(w) = π / 2 - asin(w)
	call :asin r1 = %w%
	call :sub return = %HALF_PI%, %r1%

endlocal & set %~1=%return%
exit /b 0

:acosh return = w
setlocal EnableDelayedExpansion

	set debug=rem
	set w=%~2

	call :compare compare = %w%, %ONE%
	if %compare% equ 0 (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)
	if %compare% lss 0 (
		endlocal & set %~1=%NAN%
		exit /b 0
	)

	:: acosh(w) = ln(w + sqrt(w^2 - 1))
	call :mul r1 = %w%, %w%
	call :sub r2 = %r1%, %ONE%
	call :sqrt r3 = %r2%
	call :add r4 = %w%, %r3%
	call :ln return = %r4%

endlocal & set %~1=%return%
exit /b 0

:asin return = w
setlocal EnableDelayedExpansion

	set debug=rem
	set w=%~2

	if %w% equ -%ONE% (
		endlocal & set %~1=-%HALF_PI%
		exit /b 0
	)
	if %w% equ %ONE% (
		endlocal & set %~1=%HALF_PI%
		exit /b 0
	)
	call :compare compare = %w%, -%ONE%
	if %compare% lss 0 (
		echo %_c%[asin.cmd][line 17]%_r% test 5
		endlocal & set %~1=%NAN%
		exit /b 0
	)
	call :compare compare = %w%, %ONE%
	if %compare% gtr 0 (
		endlocal & set %~1=%NAN%
		exit /b 0
	)

	:: asin(w) = atan(w / sqrt(1 - w^2))
	call :mul r1 = %w%, %w%
	call :sub r2 = %ONE%, %r1%
	call :sqrt r3 = %r2%
	call :div r4 = %w%, %r3%
	call :atan return = %r4%

endlocal & set %~1=%return%
exit /b 0

:asinh return = w
setlocal EnableDelayedExpansion

	set debug=rem
	set w=%~2

	:: ln(w + sqrt(w^2 + 1))
	call :mul r1 = %w%, %w%
	call :add r2 = %r1%, %ONE%
	call :sqrt r3 = %r2%
	call :add r4 = %w%, %r3%
	call :ln return = %r4%

endlocal & set %~1=%return%
exit /b 0

:atan return = w
setlocal EnableDelayedExpansion

	set debug=rem
	set w=%~2

	:: atan(1 / w) = π / 2 - atan(w)
	:: w < 1
	call :compare compare = %w%, %ONE%
	if %compare% geq 0 (
		call :div w = %ONE%, %w%
	)

	:: z1 = z0 + atan(y / x)
	call :_circular_cordic _x, _y, z = %ONE%, %w%, %ZERO%, %VECTORING%

	if %compare% geq 0 (
		call :sub return = %HALF_PI%, %z%
	) else (
		set return=%z%
	)

endlocal & set %~1=%return%
exit /b 0

:atanh return = w
setlocal EnableDelayedExpansion

	set debug=rem
	set w=%~2

	call :compare compare = %w%, -%ONE%
	if %compare% leq 0 (
		endlocal & set %~1=%NAN%
		exit /b 0
	)
	call :compare compare = %w%, %ONE%
	if %compare% geq 0 (
		endlocal & set %~1=%NAN%
		exit /b 0
	)
	if %w% equ %ZERO% (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)	

	:: atanh(1 - M*2^-E) = atanh(T) + (E/2) * ln2
	:: where T = (2 - M - M * 2^-E) / (2 + M - M * 2^-E)
	:: 0.5 <= M < 1
	:: E >= 1
	:: 0.17 < T < 0.75
	call :abs r1 = %w%
	call :sub M = %ONE%, %r1%
	set /a E = 0

	:while_atanh
		call :compare compare = %M%, %HALF%
		if %compare% geq 0 goto :done_atanh
	
		call :shift M = %M%, 1
		set /a E+=1
	
		goto :while_atanh
	:done_atanh

	if %E% neq 0 goto :atanh_normalize
	
	:: z1 = z0 + atanh(y / x)
	call :_hyperbolic_cordic _x, _y, return = %ONE%, %w%, %ZERO%, %VECTORING%
	endlocal & set %~1=%return%
	exit /b 0

	:atanh_normalize

	:: T = (2 - M - M * 2^-E) / (2 + M - M * 2^-E)
	call :sub r2 = %TWO%, %M%
	call :shift r3 = %M%, -%E%
	call :sub r4 = %r2%, %r3%
	call :add r5 = %TWO%, %M%
	call :sub r6 = %r5%, %r3%
	call :div r7 = %r4%, %r6%

	:: z1 = z0 + atanh(y / x)
	call :_hyperbolic_cordic _x, _y, z = %ONE%, %r7%, %ZERO%, %VECTORING%

	:: atanh(1 - M*2^-E) = atanh(T) + (E/2) * ln2
	call :set fE = %E%
	call :shift halfE = %fE%, -1
	call :mul r8 = %halfE%, %LN_2%
	call :add return = %z%, %r8%

	call :is_negative wNeg = %w%
	if %wNeg% equ %TRUE% (
		call :negate return = %return%
	)

endlocal & set %~1=%return%
exit /b 0

:cos return = w
setlocal EnableDelayedExpansion

	set debug=rem

	:: cos((Q * π / 2) + D) 
	::  = cos D if Q mod 4 = 0
	::  = -sin D if Q mod 4 = 1
	::  = -cos D if Q mod 4 = 2
	::  = sin D if Q mod 4 = 3
	set w=%~2

	call :div Q = %w%, %HALF_PI%
	call :to_int Q = %Q%
	call :set fQ = %Q%
	call :mul m = %fQ%, %HALF_PI%
	call :sub D = %w%, %m%
	set /a "Qmod4=Q%%4"

	:: x1 = K(x0 * cos(z) - y0 * sin(z))
	:: y1 = K(y0 * cos(z) + x0 * sin(z))
	call :_circular_cordic x, y, _z = %inverseCircularGain%, %ZERO%, %D%, %ROTATION%
	
	if %Qmod4% equ 0 set return=%x% & goto :cos_done
	if %Qmod4% equ 1 call :negate return = %y% & goto :cos_done
	if %Qmod4% equ -3 call :negate return = %y% & goto :cos_done
	if %Qmod4% equ 2 call :negate return = %x% & goto :cos_done
	if %Qmod4% equ -2 call :negate return = %x% & goto :cos_done
	if %Qmod4% equ 3 set return=%y% & goto :cos_done
	if %Qmod4% equ -1 set return=%y% & goto :cos_done
	
	set return=%ZERO%
	
	:cos_done
endlocal & set %~1=%return%
exit /b 0

:cosh return = w
setlocal EnableDelayedExpansion

	set debug=rem

	:: cosh(Q * ln2 + D) = (2^Q / 2)(cosh D + sinh D + (2^(-2 * Q) * (cosh D - sinh D)))
	:: D < ln2
	set w=%~2
	
	call :div Q = %w%, %LN_2%
	call :to_int Q = %Q%
	call :set fQ = %Q%
	call :mul m = %fQ%, %LN_2%
	call :sub D = %w%, %m%

	call :_hyperbolic_cordic x, y, _z = %inverseHyperbolicGain%, %ZERO%, %D%, %ROTATION%

	call :add r1 = %x%, %y%
	call :sub r2 = %x%, %y%
	set /a shiftQ1 = -2 * Q
	call :shift r3 = %r2%, %shiftQ1%
	call :add r4 = %r1%, %r3%
	set /a shiftQ2 = Q - 1
	call :shift return = %r4%, %shiftQ2%

endlocal & set %~1=%return%
exit /b 0

:: See https://en.wikipedia.org/wiki/Division_algorithm#Pseudocode
:div return = n, d
setlocal EnableDelayedExpansion

    set debug=rem

    :: log2((P + 1) / log2(17)) ~ 3 where P is number of bits i.e. 31
    set REPEAT=3
    set F48_17=1515870846E1
    set F32_17=2021161089E0

    set n=%~2
    set d=%~3

    call :compare nComp = %n%, %ZERO%
    call :compare dComp = %d%, %ZERO%
    set /a negate = 0
    if %nComp% lss 0 set /a negate = 1
    if %dComp% lss 0 set /a "negate ^= 1"

    call :abs n = %n%
    call :abs d = %d%

    call :_normalize d, dE = %d%
    call :shift n = %n%, -%dE%

    :: X := 48/17 − 32/17 × D'
    call :mul r1 = %F32_17%, %d%
    call :sub x = %F48_17%, %r1%

    for /L %%I in (1,1,%REPEAT%) do call :_newton_raphson_iteration x = !x!, %d%

    :: return N' × X
    call :mul return = %n%, %x%

    if %negate% equ 1 call :negate return=%return%

endlocal & set "%~1=%return%"
exit /b 0

:_newton_raphson_iteration x = x, d
setlocal EnableDelayedExpansion

    set x=%~2
    set d=%~3

    :: X = X + X × (1 - D' × X)
    call :mul r1 = %d%, %x%
    call :sub r2 = %ONE%, %r1%
    call :mul r3 = %x%, %r2%
    call :add return = %x%, %r3%

endlocal & set "%~1=%return%"
exit /b 0

:exp return = w
setlocal EnableDelayedExpansion

	set debug=rem
	set w=%~2

	if %w% equ %ZERO% (
		endlocal & set %~1=%ONE%
		exit /b 0
	)

	if %w% equ %ONE% (
		endlocal & set %~1=%_E%
		exit /b 0
	)

	:: exp(Q * ln2 + D) = 2^Q * (cosh D + sinh D)
	:: |D| < ln2
	call :div Q = %w%, %LN_2%
	call :to_int Q = %Q%
	call :set fQ = %Q%
	call :mul m = %fQ%, %LN_2%
	call :sub D = %w%, %m%
	
	call :_hyperbolic_cordic x, y, _z = %inverseHyperbolicGain%, %ZERO%, %D%, %ROTATION%

	call :add r1 = %x%, %y%
	call :shift return = %r1%, %Q%

endlocal & set %~1=%return%
exit /b 0

:ln return = w
setlocal EnableDelayedExpansion

	set debug=rem
	set w=%~2

	call :compare compare = %w%, %ZERO%
	
	if %compare% leq 0 (
		endlocal & set %~1=%NAN%
		exit /b 0
	)

	if %w% equ %ONE% (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)

	if %w% equ %_E% (
		endlocal & set %~1=%ONE%
		exit /b 0
	)

	call :_normalize m, e = %w%

	call :add r1 = %m%, %ONE%
	call :sub r2 = %m%, %ONE%

	:: ln(w) = 2 * atanh(w - 1 / w + 1)
	:: z1 = z0 + atanh(y / x)
	call :_hyperbolic_cordic _x, _y, z = %r1%, %r2%, %ZERO%, %VECTORING%
	
	:: ln(M * 2^E) = ln(M) + E * ln(2)
	:: 0.5 <= M < 1
	call :shift r3 = %z%, 1
	call :set e = %e%
	call :mul r4 = %e%, %LN_2%
	call :add return = %r3%, %r4%

endlocal & set %~1=%return%
exit /b 0

:log return = b, w
setlocal EnableDelayedExpansion

	set debug=rem
	set b=%~2
	set w=%~3

	:: log b(w) = ln(w) / ln(b)
	call :ln r1 = %w%
	call :ln r2 = %b%
	call :div return = %r1%, %r2%

endlocal & set %~1=%return%
exit /b 0

:pow return = w, t
setlocal EnableDelayedExpansion

	set debug=rem
	set w=%~2
	set t=%~3

	:: w^t = e^(t * ln(w))
	call :ln r1 = %w%
	call :mul r2 = %t%, %r1%
	call :exp return = %r2%

endlocal & set %~1=%return%
exit /b 0

:sin return = w
setlocal EnableDelayedExpansion

	set debug=rem

	:: sin((Q * π / 2) + D) 
	::  = sin D if Q mod 4 = 0
	::  = cos D if Q mod 4 = 1
	::  = -sin D if Q mod 4 = 2
	::  = -cos D if Q mod 4 = 3
	set w=%~2

	call :div Q = %w%, %HALF_PI%
	%debug% echo %_c%[sin.cmd][line 14]%_r% Q = [%Q%]
	%debug% call :to_string sq = %Q%
	%debug% echo %_c%[sin.cmd][line 16]%_r% sq = [%sq%]
	
	call :to_int Q = %Q%
	%debug% echo %_c%[sin.cmd][line 19]%_r% Q = [%Q%]
	call :set fQ = %Q%
	%debug% echo %_c%[sin.cmd][line 21]%_r% fQ = [%fQ%]
	%debug% call :to_string sfQ = %fQ%
	%debug% echo %_c%[sin.cmd][line 23]%_r% sfQ = [%sfQ%]
	
	call :mul m = %fQ%, %HALF_PI%
	%debug% call :to_string sm = %m%
	%debug% echo %_c%[sin.cmd][line 27]%_r% sm = [%sm%]
	call :sub D = %w%, %m%
	set /a "Qmod4=Q%%4"

	%debug% echo %_c%[sin.cmd][line 31]%_r% sin 0 - [%Q%][%w%][%m%][%Qmod4%]
	
	%debug% echo %_c%[sin.cmd][line 33]%_r% sin 1 - [%inverseCircularGain%][%D%]
	%debug% call :to_string sicg = %inverseCircularGain%
	%debug% call :to_string sd = %D%
	%debug% echo %_c%[sin.cmd][line 36]%_r% sin 2 - [%sicg%][%sd%]

	call :_circular_cordic x, y, _z = %inverseCircularGain%, %ZERO%, %D%, %ROTATION%
	
	%debug% echo %_c%[sin.cmd][line 40]%_r% sin 3 - [%x%][%y%][%_z%]

	if %Qmod4% equ 0 set return=%y% & goto :sin_done
	if %Qmod4% equ 1 set return=%x% & goto :sin_done
	if %Qmod4% equ -3 set return=%x% & goto :sin_done
	if %Qmod4% equ 2 call :negate return = %y% & goto :sin_done
	if %Qmod4% equ -2 call :negate return = %y% & goto :sin_done
	if %Qmod4% equ 3 call :negate return = %x% & goto :sin_done
	if %Qmod4% equ -1 call :negate return = %x% & goto :sin_done
	
	set return=%ZERO%
	
	:sin_done
endlocal & set %~1=%return%
exit /b 0

:sinh return = w
setlocal EnableDelayedExpansion

	set debug=rem

	:: sinh(Q * ln2 + D) = (2^Q / 2)(cosh D + sinh D - (2^(-2 * Q) * (cosh D - sinh D)))
	:: D < ln2
	set w=%~2
	
	call :div Q = %w%, %LN_2%
	call :to_int Q = %Q%
	call :set fQ = %Q%
	call :mul m = %fQ%, %LN_2%
	call :sub D = %w%, %m%

	%debug% echo %_c%[sinh.cmd][line 16]%_r% Q=%fQ%, m=%m%, D=%d%
	%debug% call :to_string sm = %m%
	%debug% call :to_string sd = %D%
	%debug% echo %_c%[sinh.cmd][line 19]%_r% Q=%Q%, m=%sm%, D=%sd%

	call :_hyperbolic_cordic x, y, _z = %inverseHyperbolicGain%, %ZERO%, %D%, %ROTATION%
	
	%debug% echo %_c%[sinh.cmd][line 23]%_r% x=%x%, y=%y%, z=%_z%
	%debug% call :to_string sx = %x%
	%debug% call :to_string sy = %y%
	%debug% call :to_string sz = %_z%
	%debug% echo %_c%[sinh.cmd][line 27]%_r% x=%sx%, y=%sy%, z=%sz%

	call :add r1 = %x%, %y%
	call :sub r2 = %x%, %y%
	set /a shiftQ1 = -2 * Q
	call :shift r3 = %r2%, %shiftQ1%
	call :sub r4 = %r1%, %r3%
	set /a shiftQ2 = Q - 1
	call :shift return = %r4%, %shiftQ2%

endlocal & set %~1=%return%
exit /b 0

:sqrt return = w
setlocal EnableDelayedExpansion

	set debug=rem
	set w=%~2
	
	call :is_negative wNeg = %w%
	if %wNeg% equ %TRUE% (
		endlocal & set %~1=%NAN%
		exit /b 0
	)
	if %w% equ %ZERO% (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)

	:: sqrt(M * 2^E) =
	::  2^E/2 * sqrt(M)     if E mod 2 = 0  and 0.5 <= M < 1
	::  2^(E+1)/2 * sqrt(M / 2)     if E mod 2 = 1 and 0.25 <= M / 2 < 0.5
	call :_normalize m, e = %w%
	
	set /a "even=e%%2"

	if %even% neq 0 goto :odd_sqrt

		call :add r1 = %m%, %QUARTER%
		call :sub r2 = %m%, %QUARTER%
		call :_hyperbolic_cordic x, _y, _z = %r1%, %r2%, %ZERO%, %VECTORING%
		
		call :mul r3 = %x%, %inverseHyperbolicGain%
		set /a "halfE = e / 2"
		call :shift return = %r3%, %halfE%
	
	goto :done_sqrt
	:odd_sqrt

		call :shift r1 = %m%, -1
		call :add r2 = %r1%, %QUARTER%
		call :sub r3 = %r1%, %QUARTER%
		call :_hyperbolic_cordic x, _y, _z = %r2%, %r3%, %ZERO%, %VECTORING%
		
		call :mul r4 = %x%, %inverseHyperbolicGain%
		set /a "halfE = (e + 1) / 2"
		call :shift return = %r4%, %halfE%

	:done_sqrt

endlocal & set %~1=%return%
exit /b 0

:tan return = w
setlocal EnableDelayedExpansion
	set debug=rem

	:: tan(w) = sin(w) / cos(w)
	set w=%~2

	if %w% equ %ZERO% (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)

	call :div Q = %w%, %HALF_PI%
	call :to_int Q = %Q%

	call :set fQ = %Q%
	call :mul m = %fQ%, %HALF_PI%
	call :sub D = %w%, %m%
	set /a "Qmod4=Q%%4"

	%debug% echo %_c%[tan.cmd][line 21]%_r% %Q%, %m%, %D%

	call :_circular_cordic x, y, _z = %inverseCircularGain%, %ZERO%, %D%, %ROTATION%

	%debug% echo %_c%[tan.cmd][line 25]%_r% %x%, %y%, %_z%

	call :negate negX = %x%
	call :negate negY = %y%

	if %Qmod4% equ 0 call :div return = %y%, %x% & goto :tan_done
	if %Qmod4% equ 1 call :div return = %x%, %negY% & goto :tan_done  
	if %Qmod4% equ -3 call :div return = %x%, %negY% & goto :tan_done
	if %Qmod4% equ 2 call :div return = %negY%, %negX% & goto :tan_done
	if %Qmod4% equ -2 call :div return = %negY%, %negX% & goto :tan_done
	if %Qmod4% equ 3 call :div return = %negX%, %y% & goto :tan_done
	if %Qmod4% equ -1 call :div return = %negX%, %y% & goto :tan_done

	set return=%ZERO%
	
	:tan_done
endlocal & set %~1=%return%
exit /b 0

:tanh return = w
setlocal EnableDelayedExpansion

	set debug=rem

	:: tanh(w) = sinh(w) / cosh(w)
	:: D < ln2
	set w=%~2
	
	call :div Q = %w%, %LN_2%
	call :to_int Q = %Q%
	call :set fQ = %Q%
	call :mul m = %fQ%, %LN_2%
	call :sub D = %w%, %m%

	call :_hyperbolic_cordic x, y, _z = %inverseHyperbolicGain%, %ZERO%, %D%, %ROTATION%

	call :add r1 = %x%, %y%
	call :sub r2 = %x%, %y%
	set /a shiftQ1 = -2 * Q
	call :shift r3 = %r2%, %shiftQ1%
	call :sub r4 = %r1%, %r3%
	call :add r5 = %r1%, %r3%
	call :div return = %r4%, %r5%
	
endlocal & set %~1=%return%
exit /b 0

:_normalize m, e = a
setlocal EnableDelayedExpansion

	set debug=rem
	set a=%~3
	
	set /a e=0
	call :abs m = %a%
	
	%debug% echo %_c%[_normalize.cmd][line 10]%_r% _normalize 1 - [%m%][%HALF%]

	:while_normalize_less
	call :compare compare = %m%, %HALF%
	
	%debug% echo %_c%[_normalize.cmd][line 15]%_r% _normalize 2 - [%compare%][!compare!]
	
	if %compare% geq 0 goto :while_normalize_more
	
	call :shift m = %m%, 1
    set /a e-=1
	
	goto :while_normalize_less
	
	:while_normalize_more
	call :compare compare = %m%, %ONE%
	
	%debug% echo %_c%[_normalize.cmd][line 27]%_r% _normalize 3 - [%compare%]
	
	if %compare% lss 0 goto :done_normalize
	
	call :shift m = %m%, -1
    set /a e+=1
	
	goto :while_normalize_more
	
	:done_normalize
	call :is_negative neg = %a%
	
	if [%neg%] equ [%TRUE%] (
		call :negate m = !m!
	)

endlocal & set "%~1=%m%" & set "%~2=%e%"
exit /b 0

:_circular_cordic x, y, z = x0, y0, z0, vecmode
setlocal EnableDelayedExpansion
	
	set debug=rem

	set x=%~4
	set y=%~5
	set z=%~6
	set vecmode=%~7
	
	set /a i=0
	:for_circular
		if !i! geq %MAXBITS% goto :done_circular
					
		set /a j=-i
	
		if %vecmode% equ %VECTORING% (
			call :is_negative yNeg = !y!
			if !yNeg! equ %FALSE% goto :negativeDirection_circular
			if !y! equ %ZERO% goto :negativeDirection_circular
		) else (
			call :is_negative zNeg = !z!
			if !zNeg! equ %TRUE% goto :negativeDirection_circular
		)
		
		:positiveDirection_circular
		call :shift y1 = %y%, %j%
		call :sub x1 = %x%, %y1%

		call :shift x2 = %x%, %j%
		call :add y = %y%, %x2%
		
		set "atanValue=!atanTable[%i%]!"
		::echo %_c%[_circular_cordic.cmd][line 34]%_r% bug 1 [%z%]
		call :sub z = %z%, !atanValue!
		::echo %_c%[_circular_cordic.cmd][line 36]%_r% bug 2 [%z%][!atanValue!]

		::%debug% echo %_c%[_circular_cordic.cmd][line 38]%_r% circular 1 - [%x1%][%y%][%z%][%atanValue%]
		%debug% call :to_string sx = %x1%
		%debug% call :to_string sy = %y%
		%debug% call :to_string sz = %z%
		%debug% call :to_string atan = %atanValue%
		%debug% echo %_c%[_circular_cordic.cmd][line 43]%_r% circular 1a - [%sx%][%sy%][%sz%][%atan%]

		goto :continue_circular
		
		:negativeDirection_circular
		call :shift y1 = %y%, %j%
		call :add x1 = %x%, %y1%
		
		call :shift x2 = %x%, %j%
		call :sub y = %y%, %x2%
		
		set "atanValue=!atanTable[%i%]!"
		call :add z = %z%, !atanValue!
		
		::%debug% echo %_c%[_circular_cordic.cmd][line 57]%_r% circular 2 - [%x1%][%y%][%z%][%atanValue%]
		%debug% call :to_string sx = %x1%
		%debug% call :to_string sy = %y%
		%debug% call :to_string sz = %z%
		%debug% call :to_string atan = %atanValue%
		%debug% echo %_c%[_circular_cordic.cmd][line 62]%_r% circular 2a - [%sx%][%sy%][%sz%][%atan%]
		
		:continue_circular
		
		set x=%x1%
		
		set /a i+=1 & goto :for_circular
	:done_circular
	
endlocal & set "%~1=%x%" & set "%~2=%y%" & set "%~3=%z%"
exit /b 0

:_cordic_div return = l, r
setlocal EnableDelayedExpansion
    
	set debug=rem
	set l=%~2
	set r=%~3
	
	if %l% equ %ZERO% (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)
	if %r% equ %ZERO% (
		endlocal & set %~1=%NAN%
		exit /b 0
	)
	if %r% equ %ONE% (
		endlocal & set %~1=%l%
		exit /b 0
	)
	
	:: (Ml * 2^El) / (Mr * 2^Er) = (Ml / 2 * Mr) * 2^(El-Er+1)
	:: 0.25 <= Ml / 2 *Mr < 1.0
	call :_normalize Ml, El = %l%
	call :_normalize Mr, Er = %r%

	%debug% echo %_c%[_cordic_div.cmd][line 26]%_r% Ml = [%Ml%] El = [%El%] Mr = [%Mr%] Er = [%Er%]
	
	call :shift MrShift = %Mr%, 1
	
	call :_linear_cordic _x, _y, z = %MrShift%, %Ml%, %ZERO%, %VECTORING%
		
	set /a e=El-Er+1
	call :shift return = %z%, %e%

	::call :_fast_divide t = %l%, %r%
	::echo %_c%[_cordic_div.cmd][line 36]%_r% DIV [%l%][%r%][%return%][%t%]

endlocal & set %~1=%return%
exit /b 0

:_cordic_mul return = l, r
setlocal EnableDelayedExpansion
       
	set l=%~2
	set r=%~3
	
	:: echo %_c%[_cordic_mul.cmd][line 7]%_r% mul 1 - [%l%][%r%]
	
	if %l% equ %ZERO% (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)
	if %r% equ %ZERO% (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)
	if %l% equ %ONE% (
		endlocal & set %~1=%r%
		exit /b 0
	)
	if %r% equ %ONE% (
		endlocal & set %~1=%l%
		exit /b 0
	)
	
	:: (Ml * 2^El) * (Mr * 2^Er) = (Ml * Mr) * 2^(El+Er)
	:: 0.5 <= Ml * Mr < 1.0
	call :_normalize Ml, El = %l%
	call :_normalize Mr, Er = %r%
	
	:: echo %_c%[_cordic_mul.cmd][line 31]%_r% mul 2 - [%Ml%][%El%][%Mr%][%Er%]
	
	call :_linear_cordic _x, y, _z = %Ml%, %ZERO%, %Mr%, %ROTATION%
	
	rem note that rotation assumes that Z goes towards 0 so expect a low value for Z
	rem note that linear doesn't touch X therefore it should remain the same
	
	:: echo %_c%[_cordic_mul.cmd][line 38]%_r% mul 3 - [%_x%][%y%][%_z%]
	
	set /a e=El+Er
	
	:: echo %_c%[_cordic_mul.cmd][line 42]%_r% mul 4 - [%e%]
	
	call :shift y = %y%, %e%
	
	:: echo %_c%[_cordic_mul.cmd][line 46]%_r% mul 5 - [%y%]

endlocal & set %~1=%y%
exit /b 0

:_hyperbolic_cordic x, y, z = x0, y0, z0, vecmode
setlocal EnableDelayedExpansion
	
	set debug=rem
	set x=%~4
	set y=%~5
	set z=%~6
	set vecmode=%~7
	
	set /a i=0
	set /a k=3
	:for_hyperbolic
		if !i! geq %MAXBITS% goto :done_hyperbolic
		
		set /a j=0
		:for_hyperbolic_inner
			if !j! geq 2 goto :done_hyperbolic_inner
			
			set /a l=-i - 1

			%debug% echo %_c%[_hyperbolic_cordic.cmd][line 21]%_r% x=%x%, y=%y%, z=%z%
			
			if %vecmode% equ %VECTORING% (
				call :is_negative yNeg = !y!
				if !yNeg! equ %FALSE% goto :negativeDirection_hyperbolic
				if !y! equ %ZERO% goto :negativeDirection_hyperbolic
			) else (
				call :is_negative zNeg = !z!
				if !zNeg! equ %TRUE% goto :negativeDirection_hyperbolic
			)
				
			:positiveDirection_hyperbolic
			call :shift y1 = %y%, %l%
			call :add x1 = %x%, %y1%
			
			call :shift x2 = %x%, %l%
			call :add y = %y%, %x2%
			
			set "atanhValue=!atanhTable[%i%]!"
			call :sub z = %z%, %atanhValue%

			goto :continue_hyperbolic
			
			:negativeDirection_hyperbolic
			
			call :shift y1 = %y%, %l%
			call :sub x1 = %x%, %y1%
			
			call :shift x2 = %x%, %l%
			call :sub y = %y%, %x2%
			
			set "atanhValue=!atanhTable[%i%]!"
			call :add z = %z%, %atanhValue%
			
			:continue_hyperbolic
			
			set x=%x1%
			
			if %k% gtr 0 (
				set /a k-=1
				goto :done_hyperbolic_inner
			) else (
				set /a k=3
			)
			
			set /a j+=1 & goto :for_hyperbolic_inner
		:done_hyperbolic_inner
		
		set /a i+=1 & goto :for_hyperbolic
	:done_hyperbolic
	
endlocal & set "%~1=%x%" & set "%~2=%y%" & set "%~3=%z%"
exit /b 0

:_linear_cordic x, y, z = x0, y0, z0, vecmode
setlocal EnableDelayedExpansion
	
	set t=%ONE%
	set x=%~4
	set y=%~5
	set z=%~6
	set vecmode=%~7
	
	set /a i=0
	:for_linear
		if !i! geq %MAXBITS% goto :done_linear
		
		set /a j=-i
	
		if %vecmode% equ %VECTORING% (
			call :is_negative yNeg = !y!
			if !yNeg! equ %FALSE% goto :negativeDirection_linear
			if !y! equ %ZERO% goto :negativeDirection_linear
		) else (
			call :is_negative zNeg = !z!
			if !zNeg! equ %TRUE% goto :negativeDirection_linear
		)
		
		:positiveDirection_linear
		:: y = y + x >> i
        call :shift x1 = %x%, %j%
		call :add y = %y%, %x1%
		
		:: z = z - t
		call :sub z = %z%, %t%
		
		rem echo %_c%[_linear_cordic.cmd][line 33]%_r% linear 4 - [%x%][%y%][%z%]
		rem call :to_string sx = %x%
		rem call :to_string sy = %y%
		rem call :to_string sz = %z%
		rem echo %_c%[_linear_cordic.cmd][line 37]%_r% linear 4a - [%sy%][%sz%]

		goto :continue_linear
		
		:negativeDirection_linear
		:: y = y - x >> i;
		call :shift x1 = %x%, %j%
		call :sub y = %y%, %x1%
		
		:: z = z + t
		call :add z = %z%, %t%
		
		rem echo %_c%[_linear_cordic.cmd][line 49]%_r% linear 5 - [%x%][%y%][%z%]
		rem call :to_string sx = %x%
		rem call :to_string sy = %y%
		rem call :to_string sz = %z%
		rem echo %_c%[_linear_cordic.cmd][line 53]%_r% linear 5a - [%sy%][%sz%]
		
		:continue_linear
		
		call :shift t = %t%, -1
		
		set /a i+=1 & goto :for_linear
	:done_linear
	
endlocal & set "%~1=%x%" & set "%~2=%y%" & set "%~3=%z%"
exit /b 0

:abs return = a
setlocal EnableDelayedExpansion
	
	call :_decode m, e = %~2
	if %m% lss 0 (
		set /a m=-m
	)
	
endlocal & set %~1=%m%E%e%
exit /b 0

:add return = a, b
setlocal EnableDelayedExpansion
	
	set a=%~2
	set b=%~3
	call :_safe_add return = %a%, %b%
	
endlocal & set %~1=%return%
exit /b 0

:compare return = a, b
setlocal EnableDelayedExpansion
	call :sub diff = %~2, %~3
	call :_decode m, e = %diff%
	set /a return = m
endlocal & set %~1=%return%
exit /b 0

:dec return = a, b
setlocal EnableDelayedExpansion
	
	set a=%~2
	call :_safe_add return = %a%, -1073741824E0
	
endlocal & set %~1=%return%
exit /b 0

:inc return = a, b
setlocal EnableDelayedExpansion
	
	set a=%~2
	call :_safe_add return = %a%, 1073741824E0
	
endlocal & set %~1=%return%
exit /b 0

:is_negative return = a
setlocal EnableDelayedExpansion

	set a=%~2
	set sign=%a:~0,1%
	set return=%FALSE%
	if [%sign%] equ [-] set return=%TRUE%
	
endlocal & set %~1=%return%
exit /b 0

:mod return = a, b
setlocal EnableDelayedExpansion
	
    set debug=rem
	call :_decode aM, aE = %~2
	call :_decode bM, bE = %~3

	if %aE% lss %bE% (
		endlocal & set %~1=0 & set %~2=%~2
		exit /b 0
	)

	if %aE% equ %bE% (
		if %aM% geq %bM% (
			call :sub remainder = %aM%, %bM%
			endlocal & set %~1=1 & set %~2=%remainder%
			exit /b 0
		) else (
			endlocal & set %~1=0 & set %~2=%~2
			exit /b 0
		)
	)

	:: avoid division
	set /a "raE<<=aE+1"
	set /a "rbE<<=bE+1"
	set /a rE=raE/rbE


endlocal & set %~1=%m%E%e%
exit /b 0

:mul return = a, b
setlocal EnableDelayedExpansion
	
    set debug=rem

	call :_decode aM, aE = %~2
	call :_decode bM, bE = %~3

    set /a negate = 0
    if %aM% lss 0 set /a negate = 1
    if %bM% lss 0 set /a "negate ^= 1"

    %debug% echo %_c%[mul.cmd][line 13]%_r% $$$ [%negate%]

    if %aM% lss 0 set /a aM=-aM
    set /a "aMu = aM >> 16"
    set /a "aMl = aM - (aMu << 16)"
    if %bM% lss 0 set /a bM=-bM
    set /a "bMu = bM >> 16"
    set /a "bMl = bM - (bMu << 16)"
	
    %debug% echo %_c%[mul.cmd][line 22]%_r% aM = [%aM%] aE = [%aE%] bM = [%bM%] bE = [%bE%]
    %debug% echo %_c%[mul.cmd][line 23]%_r% aMu = [%aMu%] aMl = [%aMl%] bMu = [%bMu%] bMl = [%bMl%]

    set /a Muu = aMu * bMu
    set /a Mul = aMu * bMl
    set /a Mlu = aMl * bMu
    set /a Mll = aMl * bMl

    %debug% echo %_c%[mul.cmd][line 30]%_r% Muu = [%Muu%] Mul = [%Mul%] Mlu = [%Mlu%] Mll = [%Mll%]

    set /a Euu = aE + bE + 2
    set /a Eul = aE + (bE - 16) + 1
    set /a Elu = (aE - 16) + bE + 1
    set /a Ell = (aE - 16) + (bE - 16) 

    %debug% echo %_c%[mul.cmd][line 37]%_r% Euu = [%Euu%] Eul = [%Eul%] Elu = [%Elu%] Ell = [%Ell%]

    call :_encode Muu = %Muu%, %Euu%
    call :_encode Mul = %Mul%, %Eul%
    call :_encode Mlu = %Mlu%, %Elu%
    call :_encode Mll = %Mll%, %Ell%

    %debug% echo %_c%[mul.cmd][line 44]%_r% [%Muu%][%Mul%][%Mlu%][%Mll%]

    call :_safe_add r1 = %Muu%, %Mul%
    call :_safe_add r2 = %r1%, %Mlu%
    call :_safe_add return = %r2%, %Mll%
    
    if %negate% equ 1 call :negate return=%return%

    %debug% echo %_c%[mul.cmd][line 52]%_r% $$$ [%negate%][%return%]

endlocal & set %~1=%return%
exit /b 0

:negate return = a
setlocal EnableDelayedExpansion

	call :_decode m, e = %~2
	set /a m=-m
	
endlocal & set %~1=%m%E%e%
exit /b 0

:set return = value
setlocal EnableDelayedExpansion

	set debug=rem
	set value=%~2

	:: check if . is specified
	set test=%value:.=#%
	if [%test%] equ [%value%] (
		set value=%value%.0
	)

	set frac=%value:*.=%
	call set /a "int=%%value:.%frac%=%%"
	set /a sign=0
	
	%debug% echo %_c%[set.cmd][line 17]%_r% test 1 = [%value%][%int%][%frac%]
	
	if [%value:~0,1%] equ [-] (
		set /a sign=1, int=-int
	)
	
	%debug% echo %_c%[set.cmd][line 23]%_r% test 2 = [%value%][%sign%][%int%][%frac%]
	
	if %int% equ 0 (
		set /a msb=0
	) else (
		call :_most_significant_bit msb = %int%
	)
	
	%debug% echo %_c%[set.cmd][line 31]%_r% test 3 = [%msb%]
	
	set /a binFrac=0, fmsb=0, fe=0
	:: leading zeros are an issue as it gets interpreted as octal
	set /a decFrac=1%frac%-(11%frac%-1%frac%)/10
	
	%debug% echo %_c%[set.cmd][line 37]%_r% test 4 = [%decFrac%]
	
	if %decFrac% equ 0 goto :done_set

	set target=1%frac%
	set /a target=target - decFrac		
	set /a test=decFrac
	
	%debug% echo %_c%[set.cmd][line 45]%_r% test 5 = [!target!][%test%]
	
	set /a remainingBits=31 - msb
		
	:while_set
		if !test! equ !target! goto :done_set
		if !fmsb! geq !remainingBits! goto :done_set
		
		set /a test*=2
		
		if !binFrac! neq 0 (
			set /a "binFrac<<=1"
		) else (
			set /a fe+=1
		)
		
		if !test! geq !target! (
			set /a "binFrac|=1, test-=target"
		)
		
		if !binFrac! neq 0 (
			set /a fmsb+=1
		)
		
		%debug% echo %_c%[set.cmd][line 69]%_r% loop = (!fmsb!)(!test!)(!binFrac!)(!bin!)
		
		goto :while_set
	:done_set
	
	%debug% echo %_c%[set.cmd][line 74]%_r% test 6 = [%binFrac%][%fmsb%]
	
	if !int! neq 0 (
		set /a "m=(int << (31 - msb))"
		set /a "f=binFrac >> fe - 1"
		set /a "m|=f"
	) else (
		set /a "m=binFrac << 31 - fmsb"
	)
	
	set /a e=0
	if !int! neq 0 (
		set /a e=msb - 1
	) else (
		set /a e=-fe
	)

	if !sign! equ 1	(
		set /a m=-m
	)
	
	%debug% echo %_c%[set.cmd][line 95]%_r% test 7 = [!m!][!e!]
	
	endlocal & set %~1=%m%E%e%
exit /b 0

:shift return = a, bits
setlocal EnableDelayedExpansion
	call :_decode aM, aE = %~2
	set /a bits = aE + %~3
endlocal & set %~1=%aM%E%bits%
exit /b 0

:sub return = a, b
setlocal EnableDelayedExpansion
	
	set a=%~2
	call :negate b = %~3
	call :_safe_add return = %a%, %b%
endlocal & set %~1=%return%
exit /b 0

:to_int return = a
setlocal EnableDelayedExpansion

	set /a sign=0
	call :_decode m, e = %~2
	if %m% lss 0 (
		set /a sign=1, m=-m
	)
	set /a "retval=m >> 30 - e"
	if %sign% equ 1 (
		set /a retval=-retval
	)
	
endlocal & set %~1=%retval%
exit /b 0

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
	
	%debug% echo %_c%[to_string.cmd][line 18]%_r% test 1 = [%m%][%e%]

	if %m% lss 0 (
		set sign=-
		set /a m=-m
	)
	
	%debug% echo %_c%[to_string.cmd][line 25]%_r% test 2 = [%sign%][%m%][%e%]
	
	set /a binFrac=m
	
	%debug% echo %_c%[to_string.cmd][line 29]%_r% test 4 = [!binFrac!]
	
	if %e% gtr -1 (
		set /a "int=m >> (30 - e)"
		set /a "intPart=int << (30 - e)"
		
		%debug% echo %_c%[to_string.cmd][line 35]%_r% test 4a = [!int!][!intPart!]
		
		set /a "binFrac=m - intPart"
		
		%debug% echo %_c%[to_string.cmd][line 39]%_r% test 4b = [!binFrac!]
		
		set /a "binFrac<<=e+1"
	) else (
		set /a int=0
		set /a "binFrac>>=-e-1"
	)
		
	%debug% echo %_c%[to_string.cmd][line 47]%_r% test 5 = [!int!][!binFrac!]
	
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

	%debug% echo %_c%[to_string.cmd][line 130]%_r% compare = [!decFrac!][!fdecFrac!][!ffdecFrac!]
	
	set /a "test>>=1"
	set /a i+=1
	if !i! lss 31 goto :for_to_string
	
	set strDecFrac=%decFrac:~1%%fdecFrac:~1%%ffdecFrac:~1%
	
	%debug% echo %_c%[to_string.cmd][line 138]%_r% test 8 = [%sign%%int%.%strDecFrac%]
	
endlocal & set %~1=%sign%%int%.%strDecFrac%
exit /b 0

:_decode m, e = float
setlocal EnableDelayedExpansion

	::echo %_c%[_decode.cmd][line 4]%_r% _decode

	set float=%~3
	set e=%float:*E=%
	
	:: we need to error out if there is no E
	
	set /a "m=!float:E%e%=!" || goto :_decode_error

	goto _decode_done

	:_decode_error
	echo %_c%[_decode.cmd][line 16]%_r% ERR [%float%][%e%][%m%]
	pause

	:_decode_done
	
	:: echo %_c%[_decode.cmd][line 21]%_r% decode = [%m%][%e%]

endlocal & set "%~1=%m%" & set "%~2=%e%"
exit /b 0

:_encode return = m, e
setlocal EnableDelayedExpansion

	set /a m = %~2
	set /a e = %~3

	if %m% equ 0 (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)

	if %~2 lss 0 set /a m=-m

	:while_encode
		set /a "msb = %m% & 1073741824"
		if %msb% equ 1073741824 goto :done_encode

		set /a "m<<=1"
		set /a e-=1

		goto :while_encode
	:done_encode

	if %~2 lss 0 set /a m=-m

endlocal & set %~1=%m%E%e%
exit /b 0

:_most_significant_bit return = a
setlocal EnableDelayedExpansion
	set /a a=%~2
	set /a match=1073741824
	set /a msb=31
	
	:: TODO FIX THIS LOOP
	:while_msb
		set /a "compare=a & match"
	
		if !compare! neq 0 goto :done_msb
		
		set /a "match>>=1"
		set /a msb-=1
		
		goto :while_msb
	:done_msb
	
endlocal & set %~1=%msb%
exit /b 0

:_safe_add return = a, b
setlocal EnableDelayedExpansion

	set debug=rem
	set a=%~2
	set b=%~3
	
	call :_decode aM, aE = %~2
	call :_decode bM, bE = %~3
	
	%debug% echo %_c%[_safe_add.cmd][line 11]%_r% [%aM%][%aE%][%bM%][%bE%]
	
	if %aM% equ 0 (
		endlocal & set %~1=%bM%E%bE%
		exit /b 0
	)
	if %bM% equ 0 (
		endlocal & set %~1=%aM%E%aE%
		exit /b 0
	)
	
	set /a newE=0
	
	if %aE% lss %bE% (
		if %aM% lss 0 (
			set /a aM=-aM
			set /a "aM>>=bE - aE"
			set /a aM=-aM
		) else (
			set /a "aM>>=bE - aE"
		)
		set /a newE=bE
	) else (
		if %aE% gtr %bE% (
			if %bM% lss 0 (
				set /a bM=-bM
				set /a "bM>>=aE - bE"
				set /a bM=-bM
			) else (
				set /a "bM>>=aE - bE"
			)
			set /a newE=aE
		) else (
			set /a "aM>>=1"
			set /a "bM>>=1"
			set /a newE=aE + 1
		)
	)
	
	%debug% echo %_c%[_safe_add.cmd][line 50]%_r% Add 1 - [%aM%] + [%bM%]; [%aE%] [%bE%]
	
	:: magic number needs to be handled -2147483648

	set /a newM=aM + bM

	:: check if zero
	if %newM% equ 0 (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)
	
	%debug% echo %_c%[_safe_add.cmd][line 62]%_r% Add 2 - = [%newM%] [%newE%]
	
	set overflow=%FALSE%
	if %aM% lss 0 (
		if %bM% lss 0 (
			if %newM% geq 0 (
				set overflow=%TRUE%
			)
		)
	)
	if %aM% geq 0 (
		if %bM% geq 0 (
			if %newM% lss 0 (
				set overflow=%TRUE%
			)
		)
	)
	if %newM% equ -2147483648 (
		set overflow=%TRUE%
	)
	
	%debug% echo %_c%[_safe_add.cmd][line 83]%_r% Add 2a - [%overflow%]
	
	if %overflow% equ %TRUE% (
		:: Overflow
		set /a "aM>>=1"
		set /a "bM>>=1"
		set /a newE+=1
		set /a newM=aM + bM
	)
	
	%debug% echo %_c%[_safe_add.cmd][line 93]%_r% Add 3 - [!aM!] + [!bM!]; [!aE!] [!bE!] = [!newM!] [!newE!]
	
	:: normalize
	if %newM% neq 0 (
		set /a sign=0
		::if %newM% equ -2147483648
		if %newM% lss 0 (
			%debug% echo %_c%[_safe_add.cmd][line 100]%_r% What
			set /a sign=1
			set /a newM=-newM
		)
		%debug% echo %_c%[_safe_add.cmd][line 104]%_r% Add 3a - !newM!
		call :_most_significant_bit bit = !newM!
		%debug% echo %_c%[_safe_add.cmd][line 106]%_r% Add 3b - !bit!
		set /a nE=31 - bit
		set /a "newM<<=nE"
		set /a "newE-=nE"
		if !sign! equ 1 (
			set /a newM=-newM
		)
	)

	%debug% echo %_c%[_safe_add.cmd][line 115]%_r% Add 4 - [!aM!] + [!bM!]; [!aE!] [!bE!] = [!newM!] [!newE!]

endlocal & set %~1=%newM%E%newE%
exit /b 0