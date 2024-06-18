:_circular_cordic x, y, z = x0, y0, z0, vecmode
setlocal EnableDelayedExpansion
	
	set debug=rem

	set x=%~4
	set y=%~5
	set z=%~6
	set vecmode=%~7
	
	set /a i=0
	:for_circular
		if !i! geq %MAXBITS% goto :done_circular
					
		set /a j=-i
	
		if %vecmode% equ %VECTORING% (
			call :is_negative yNeg = !y!
			if !yNeg! equ %FALSE% goto :negativeDirection_circular
			if !y! equ %ZERO% goto :negativeDirection_circular
		) else (
			call :is_negative zNeg = !z!
			if !zNeg! equ %TRUE% goto :negativeDirection_circular
		)
		
		:positiveDirection_circular
		call :shift y1 = %y%, %j%
		call :sub x1 = %x%, %y1%

		call :shift x2 = %x%, %j%
		call :add y = %y%, %x2%
		
		set "atanValue=!atanTable[%i%]!"
		::echo bug 1 [%z%]
		call :sub z = %z%, !atanValue!
		::echo bug 2 [%z%][!atanValue!]

		::%debug% echo circular 1 - [%x1%][%y%][%z%][%atanValue%]
		%debug% call :to_string sx = %x1%
		%debug% call :to_string sy = %y%
		%debug% call :to_string sz = %z%
		%debug% call :to_string atan = %atanValue%
		%debug% echo circular 1a - [%sx%][%sy%][%sz%][%atan%]

		goto :continue_circular
		
		:negativeDirection_circular
		call :shift y1 = %y%, %j%
		call :add x1 = %x%, %y1%
		
		call :shift x2 = %x%, %j%
		call :sub y = %y%, %x2%
		
		set "atanValue=!atanTable[%i%]!"
		call :add z = %z%, !atanValue!
		
		::%debug% echo circular 2 - [%x1%][%y%][%z%][%atanValue%]
		%debug% call :to_string sx = %x1%
		%debug% call :to_string sy = %y%
		%debug% call :to_string sz = %z%
		%debug% call :to_string atan = %atanValue%
		%debug% echo circular 2a - [%sx%][%sy%][%sz%][%atan%]
		
		:continue_circular
		
		set x=%x1%
		
		set /a i+=1 & goto :for_circular
	:done_circular
	
endlocal & set "%~1=%x%" & set "%~2=%y%" & set "%~3=%z%"
exit /b 0