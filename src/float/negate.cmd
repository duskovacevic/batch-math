:negate return = a
setlocal EnableDelayedExpansion

	call :_decode m, e = %~2
	set /a m=-m
	
endlocal & set %~1=%m%E%e%
exit /b 0