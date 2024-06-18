:acos return = w
setlocal EnableDelayedExpansion

	set debug=rem
	set w=%~2

	if %w% equ -%ONE% (
		endlocal & set %~1=-%PI%
		exit /b 0
	)
	if %w% equ %ONE% (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)
	call :compare compare = %w%, -%ONE%
	if %compare% lss 0 (
		endlocal & set %~1=%NAN%
		exit /b 0
	)
	call :compare compare = %w%, %ONE%
	if %compare% gtr 0 (
		endlocal & set %~1=%NAN%
		exit /b 0
	)

	:: acos(w) = atan(sqrt(1 - w^2) / w)
	call :mul r1 = %w%, %w%
	call :sub r2 = %ONE%, %r1%
	call :sqrt r3 = %r2%
	call :div r4 = %w%, %r3%
	call :is_negative wNeg = %w%
	
	if %wNeg% equ %TRUE% (
		call :add r5 = %r4%, %PI%
		call :atan return = %r5%
	) else (
		call :atan return = %r4%
	)

endlocal & set %~1=%return%
exit /b 0