:cosh return = w
setlocal EnableDelayedExpansion

	set debug=rem

	:: cosh(Q * ln2 + D) = (2^Q / 2)(cosh D + sinh D + (2^(-2 * Q) * (cosh D - sinh D)))
	:: D < ln2
	set w=%~2
	
	call :div Q = %w%, %LN_2%
	call :to_int Q = %Q%
	call :set fQ = %Q%
	call :mul m = %fQ%, %LN_2%
	call :sub D = %w%, %m%

	call :_hyperbolic_cordic x, y, _z = %inverseHyperbolicGain%, %ZERO%, %D%, %ROTATION%

	call :add r1 = %x%, %y%
	call :sub r2 = %x%, %y%
	set /a shiftQ1 = -2 * Q
	call :shift r3 = %r2%, %shiftQ1%
	call :add r4 = %r1%, %r3%
	set /a shiftQ2 = Q - 1
	call :shift return = %r4%, %shiftQ2%

endlocal & set %~1=%return%
exit /b 0