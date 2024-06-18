:sub return = a, b
setlocal EnableDelayedExpansion
	
	set a=%~2
	call :negate b = %~3
	call :_safe_add return = %a%, %b%
endlocal & set %~1=%return%
exit /b 0