:to_int return = a
setlocal EnableDelayedExpansion

	set /a sign=0
	call :_decode m, e = %~2
	if %m% lss 0 (
		set /a sign=1, m=-m
	)
	set /a "retval=m >> 30 - e"
	if %sign% equ 1 (
		set /a retval=-retval
	)
	
endlocal & set %~1=%retval%
exit /b 0