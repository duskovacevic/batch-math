:_encode return = m, e
setlocal EnableDelayedExpansion

	set /a m = %~2
	set /a e = %~3

	if %m% equ 0 (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)

	if %~2 lss 0 set /a m=-m

	:while_encode
		set /a "msb = %m% & 1073741824"
		if %msb% equ 1073741824 goto :done_encode

		set /a "m<<=1"
		set /a e-=1

		goto :while_encode
	:done_encode

	if %~2 lss 0 set /a m=-m

endlocal & set %~1=%m%E%e%
exit /b 0