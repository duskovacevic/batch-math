:ln return = w
setlocal EnableDelayedExpansion

	set debug=rem
	set w=%~2

	call :compare compare = %w%
	if %compare% leq 0 (
		endlocal & set %~1=%NAN%
		exit /b 0
	)
	
	:: ln(M * 2^E) = ln(M) + E * ln(2)
	:: 0.5 <= M < 1
	call :_normalize m, e = %w%

	call :add r1 = %m%, %ONE%
	call :sub r2 = %m%, %ONE%

	call :hyperbolic_cordic _x, _y, z = %r1%, %r2%, %ZERO%, %VECTORING%
	
	call :shift r3 = %z%, 1
	call :set e = %e%
	call :mul r4 = %e%, %LN_2%
	call :add return = %r3%, %r4%

endlocal & set %~1=%return%
exit /b 0