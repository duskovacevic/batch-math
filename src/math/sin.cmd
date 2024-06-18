:sin return = w
setlocal EnableDelayedExpansion

	set debug=rem

	:: sin((Q * π / 2) + D) 
	::  = sin D if Q mod 4 = 0
	::  = cos D if Q mod 4 = 1
	::  = -sin D if Q mod 4 = 2
	::  = -cos D if Q mod 4 = 3
	set w=%~2

	call :div Q = %w%, %HALF_PI%
	%debug% echo Q = [%Q%]
	%debug% call :to_string sq = %Q%
	%debug% echo sq = [%sq%]
	
	call :to_int Q = %Q%
	%debug% echo Q = [%Q%]
	call :set fQ = %Q%
	%debug% echo fQ = [%fQ%]
	%debug% call :to_string sfQ = %fQ%
	%debug% echo sfQ = [%sfQ%]
	
	call :mul m = %fQ%, %HALF_PI%
	%debug% call :to_string sm = %m%
	%debug% echo sm = [%sm%]
	call :sub D = %w%, %m%
	set /a "Qmod4=Q%%4"

	%debug% echo sin 0 - [%Q%][%w%][%m%][%Qmod4%]
	
	%debug% echo sin 1 - [%inverseCircularGain%][%D%]
	%debug% call :to_string sicg = %inverseCircularGain%
	%debug% call :to_string sd = %D%
	%debug% echo sin 2 - [%sicg%][%sd%]

	call :_circular_cordic x, y, _z = %inverseCircularGain%, %ZERO%, %D%, %ROTATION%
	
	%debug% echo sin 3 - [%x%][%y%][%_z%]

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