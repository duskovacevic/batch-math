:pow return = w, t
setlocal EnableDelayedExpansion

	set debug=rem
	set w=%~2
	set t=%~3

	call :ln r1 = %w%
	call :mul r2 = %t%, %r1%
	call :exp return = %r2%

endlocal & set %~1=%return%
exit /b 0