:cos return = w
setlocal EnableDelayedExpansion

	set debug=rem

	:: cos((Q * π / 2) + D) 
	::  = cos D if Q mod 4 = 0
	::  = -sin D if Q mod 4 = 1
	::  = -cos D if Q mod 4 = 2
	::  = sin D if Q mod 4 = 3
	set w=%~2

	call :div Q = %w%, %HALF_PI%
	call :to_int Q = %Q%
	call :set fQ = %Q%
	call :mul m = %fQ%, %HALF_PI%
	call :sub D = %w%, %m%
	set /a "Qmod4=Q%%4"

	:: x1 = K(x0 * cos(z) - y0 * sin(z))
	:: y1 = K(y0 * cos(z) + x0 * sin(z))
	call :_circular_cordic x, y, _z = %inverseCircularGain%, %ZERO%, %D%, %ROTATION%
	
	if %Qmod4% equ 0 set return=%x% & goto :cos_done
	if %Qmod4% equ 1 call :negate return = %y% & goto :cos_done
	if %Qmod4% equ -3 call :negate return = %y% & goto :cos_done
	if %Qmod4% equ 2 call :negate return = %x% & goto :cos_done
	if %Qmod4% equ -2 call :negate return = %x% & goto :cos_done
	if %Qmod4% equ 3 set return=%y% & goto :cos_done
	if %Qmod4% equ -1 set return=%y% & goto :cos_done
	
	set return=%ZERO%
	
	:cos_done
endlocal & set %~1=%return%
exit /b 0