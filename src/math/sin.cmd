:sin return = w
setlocal EnableDelayedExpansion

	:: sin((Q * π / 2) + D) 
	::  = sin D if Q mod 4 = 0
	::  = cos D if Q mod 4 = 1
	::  = -sin D if Q mod 4 = 2
	::  = -cos D if Q mod 4 = 3
	set w=%~2

	call :div Q = %w%, %HALF_PI%
	call :to_int Q = %Q%
	call :set fQ = %Q%
	call :mul m = %fQ%, %HALF_PI%
	call :sub D = %w%, %m%
	set /a "Qmod4=Q%%4"

	call :_circular_cordic x, y, _z = %inverseCircularGain%, %ZERO%, %D%, %ROTATION%

	if %Qmod4% equ 0 set return=%y% & goto :sin_done
	if %Qmod4% equ 1 set return=%x% & goto :sin_done
	if %Qmod4% equ -3 set return=%x% & goto :sin_done
	if %Qmod4% equ 2 call :negate return = %y% & goto :sin_done
	if %Qmod4% equ -2 call :negate return = %y% & goto :sin_done
	if %Qmod4% equ 3 call :negate return = %x% & goto :sin_done
	if %Qmod4% equ -1 call :negate return = %x% & goto :sin_done
	
	set return=%ZERO%
	
	:sin_done
endlocal & set %~1=%return%
exit /b 0