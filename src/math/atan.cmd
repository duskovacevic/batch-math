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

	call :_circular_cordic _x, _y, z = %ONE%, %w%, %ZERO%, %VECTORING%

	if %compare% geq 0 (
		call :sub return = %HALF_PI%, %z%
	) else (
		set return=%z%
	)

endlocal & set %~1=%return%
exit /b 0