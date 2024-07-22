:sqrt return = w
setlocal EnableDelayedExpansion

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