:shift return = a, bits
setlocal EnableDelayedExpansion
	call :_decode aM, aE = %~2
	set /a bits = aE + %~3
endlocal & set %~1=%aM%E%bits%
exit /b 0