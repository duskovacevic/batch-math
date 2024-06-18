:is_negative return = a
setlocal EnableDelayedExpansion

	set a=%~2
	set sign=%a:~0,1%
	set return=%FALSE%
	if [%sign%] equ [-] set return=%TRUE%
	
endlocal & set %~1=%return%
exit /b 0