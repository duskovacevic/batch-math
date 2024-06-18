:asinh return = w
setlocal EnableDelayedExpansion

	set debug=rem
	set w=%~2

	call :mul r1 = %w%, %w%
	call :add r2 = %r1%, %ONE%
	call :sqrt r3 = %r2%
	call :add r4 = %w%, %r3%
	call :ln result = %r4%

endlocal & set %~1=%return%
exit /b 0