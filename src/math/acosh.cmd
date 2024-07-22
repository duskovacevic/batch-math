:acosh return = w
setlocal EnableDelayedExpansion

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