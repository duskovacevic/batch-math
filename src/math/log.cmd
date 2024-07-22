:log return = b, w
setlocal EnableDelayedExpansion

	set b=%~2
	set w=%~3

	:: log b(w) = ln(w) / ln(b)
	call :ln r1 = %w%
	call :ln r2 = %b%
	call :div return = %r1%, %r2%

endlocal & set %~1=%return%
exit /b 0