:_cordic_mul return = l, r
setlocal EnableDelayedExpansion
       
	set l=%~2
	set r=%~3
	
	:: echo mul 1 - [%l%][%r%]
	
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
	
	:: echo mul 2 - [%Ml%][%El%][%Mr%][%Er%]
	
	call :_linear_cordic _x, y, _z = %Ml%, %ZERO%, %Mr%, %ROTATION%
	
	rem note that rotation assumes that Z goes towards 0 so expect a low value for Z
	rem note that linear doesn't touch X therefore it should remain the same
	
	:: echo mul 3 - [%_x%][%y%][%_z%]
	
	set /a e=El+Er
	
	:: echo mul 4 - [%e%]
	
	call :shift y = %y%, %e%
	
	:: echo mul 5 - [%y%]

endlocal & set %~1=%y%
exit /b 0