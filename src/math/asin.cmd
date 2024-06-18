:asin return = w
setlocal EnableDelayedExpansion

	set debug=
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
	echo %compare%
	if %compare% lss 0 (
		echo test 5
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

	%debug% echo [%r1%][%r2%][%r3%][%r4%]

endlocal & set %~1=%return%
exit /b 0