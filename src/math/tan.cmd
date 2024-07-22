:tan return = w
setlocal EnableDelayedExpansion

	:: tan(w) = sin(w) / cos(w)
	set w=%~2

	if %w% equ %ZERO% (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)

	call :div Q = %w%, %HALF_PI%
	call :to_int Q = %Q%

	call :set fQ = %Q%
	call :mul m = %fQ%, %HALF_PI%
	call :sub D = %w%, %m%
	set /a "Qmod4=Q%%4"

	call :_circular_cordic x, y, _z = %inverseCircularGain%, %ZERO%, %D%, %ROTATION%

	call :negate negX = %x%
	call :negate negY = %y%

	if %Qmod4% equ 0 call :div return = %y%, %x% & goto :tan_done
	if %Qmod4% equ 1 call :div return = %x%, %negY% & goto :tan_done  
	if %Qmod4% equ -3 call :div return = %x%, %negY% & goto :tan_done
	if %Qmod4% equ 2 call :div return = %negY%, %negX% & goto :tan_done
	if %Qmod4% equ -2 call :div return = %negY%, %negX% & goto :tan_done
	if %Qmod4% equ 3 call :div return = %negX%, %y% & goto :tan_done
	if %Qmod4% equ -1 call :div return = %negX%, %y% & goto :tan_done

	set return=%ZERO%
	
	:tan_done
endlocal & set %~1=%return%
exit /b 0