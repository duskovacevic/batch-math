:_cordic_mul return = l, r
setlocal EnableDelayedExpansion
       
	set l=%~2
	set r=%~3
	
	if %l% equ %ZERO% (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)
	if %r% equ %ZERO% (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)
	if %l% equ %ONE% (
		endlocal & set %~1=%r%
		exit /b 0
	)
	if %r% equ %ONE% (
		endlocal & set %~1=%l%
		exit /b 0
	)
	
	:: (Ml * 2^El) * (Mr * 2^Er) = (Ml * Mr) * 2^(El+Er)
	:: 0.5 <= Ml * Mr < 1.0
	call :_normalize Ml, El = %l%
	call :_normalize Mr, Er = %r%
	
	call :_linear_cordic _x, y, _z = %Ml%, %ZERO%, %Mr%, %ROTATION%
		
	set /a e=El+Er
	
	call :shift y = %y%, %e%
	
endlocal & set %~1=%y%
exit /b 0