:compare return = a, b
setlocal EnableDelayedExpansion
	call :sub diff = %~2, %~3
	call :_decode m, e = %diff%
	set /a return = m
endlocal & set %~1=%return%
exit /b 0