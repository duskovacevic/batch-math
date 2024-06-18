:sinh return = w
setlocal EnableDelayedExpansion

	set debug=rem

	:: sinh(Q * ln2 + D) = (2^Q / 2)(cosh D + sinh D - (2^(-2 * Q) * (cosh D - sinh D)))
	:: D < ln2
	set w=%~2
	
	call :div Q = %w%, %LN_2%
	call :to_int Q = %Q%
	call :set fQ = %Q%
	call :mul m = %fQ%, %LN_2%
	call :sub D = %w%, %m%

	%debug% echo Q=%fQ%, m=%m%, D=%d%
	%debug% call :to_string sm = %m%
	%debug% call :to_string sd = %D%
	%debug% echo Q=%Q%, m=%sm%, D=%sd%

	call :_hyperbolic_cordic x, y, _z = %inverseHyperbolicGain%, %ZERO%, %D%, %ROTATION%
	
	%debug% echo x=%x%, y=%y%, z=%_z%
	%debug% call :to_string sx = %x%
	%debug% call :to_string sy = %y%
	%debug% call :to_string sz = %_z%
	%debug% echo x=%sx%, y=%sy%, z=%sz%

	call :add r1 = %x%, %y%
	call :sub r2 = %x%, %y%
	set /a shiftQ1 = -2 * Q
	call :shift r3 = %r2%, %shiftQ1%
	call :sub r4 = %r1%, %r3%
	set /a shiftQ2 = Q - 1
	call :shift return = %r4%, %shiftQ2%

endlocal & set %~1=%return%
exit /b 0