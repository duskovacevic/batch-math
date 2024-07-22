:_circular_cordic x, y, z = x0, y0, z0, vecmode
setlocal EnableDelayedExpansion

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
		
		call :sub z = %z%, !atanValue!
		
		goto :continue_circular
		
		:negativeDirection_circular
		call :shift y1 = %y%, %j%
		call :add x1 = %x%, %y1%
		
		call :shift x2 = %x%, %j%
		call :sub y = %y%, %x2%
		
		set "atanValue=!atanTable[%i%]!"
		call :add z = %z%, !atanValue!
				
		:continue_circular
		
		set x=%x1%
		
		set /a i+=1 & goto :for_circular
	:done_circular
	
endlocal & set "%~1=%x%" & set "%~2=%y%" & set "%~3=%z%"
exit /b 0