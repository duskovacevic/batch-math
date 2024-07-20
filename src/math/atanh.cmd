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