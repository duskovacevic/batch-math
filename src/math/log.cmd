:log return = w, b
setlocal EnableDelayedExpansion

	set debug=rem
	set w=%~2
	set b=%~3

	call :ln r1 = %w%
	call :ln r2 = %b%
	call :div return = %r1%, %r2%

endlocal & set %~1=%return%
exit /b 0