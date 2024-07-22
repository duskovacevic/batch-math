:exp return = w
setlocal EnableDelayedExpansion

	set w=%~2

	if %w% equ %ZERO% (
		endlocal & set %~1=%ONE%
		exit /b 0
	)

	if %w% equ %ONE% (
		endlocal & set %~1=%_E%
		exit /b 0
	)

	:: exp(Q * ln2 + D) = 2^Q * (cosh D + sinh D)
	:: |D| < ln2
	call :div Q = %w%, %LN_2%
	call :to_int Q = %Q%
	call :set fQ = %Q%
	call :mul m = %fQ%, %LN_2%
	call :sub D = %w%, %m%
	
	call :_hyperbolic_cordic x, y, _z = %inverseHyperbolicGain%, %ZERO%, %D%, %ROTATION%

	call :add r1 = %x%, %y%
	call :shift return = %r1%, %Q%

endlocal & set %~1=%return%
exit /b 0