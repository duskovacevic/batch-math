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

	%debug% echo Ml = [%Ml%] El = [%El%] Mr = [%Mr%] Er = [%Er%]
	
	call :shift MrShift = %Mr%, 1
	
	call :_linear_cordic _x, _y, z = %MrShift%, %Ml%, %ZERO%, %VECTORING%
		
	set /a e=El-Er+1
	call :shift return = %z%, %e%

	::call :_fast_divide t = %l%, %r%
	::echo DIV [%l%][%r%][%return%][%t%]

endlocal & set %~1=%return%
exit /b 0