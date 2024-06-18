:dec return = a, b
setlocal EnableDelayedExpansion
	
	set a=%~2
	call :_safe_add return = %a%, -1073741824E0
	
endlocal & set %~1=%return%
exit /b 0