:_normalize m, e = a
setlocal EnableDelayedExpansion

	set a=%~3
	
	set /a e=0
	call :abs m = %a%
	
	:while_normalize_less
	call :compare compare = %m%, %HALF%
	
	if %compare% geq 0 goto :while_normalize_more
	
	call :shift m = %m%, 1
    set /a e-=1
	
	goto :while_normalize_less
	
	:while_normalize_more
	call :compare compare = %m%, %ONE%
	
	if %compare% lss 0 goto :done_normalize
	
	call :shift m = %m%, -1
    set /a e+=1
	
	goto :while_normalize_more
	
	:done_normalize
	call :is_negative neg = %a%
	
	if [%neg%] equ [%TRUE%] (
		call :negate m = !m!
	)

endlocal & set "%~1=%m%" & set "%~2=%e%"
exit /b 0