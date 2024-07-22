:_linear_cordic x, y, z = x0, y0, z0, vecmode
setlocal EnableDelayedExpansion
	
	set t=%ONE%
	set x=%~4
	set y=%~5
	set z=%~6
	set vecmode=%~7
	
	set /a i=0
	:for_linear
		if !i! geq %MAXBITS% goto :done_linear
		
		set /a j=-i
	
		if %vecmode% equ %VECTORING% (
			call :is_negative yNeg = !y!
			if !yNeg! equ %FALSE% goto :negativeDirection_linear
			if !y! equ %ZERO% goto :negativeDirection_linear
		) else (
			call :is_negative zNeg = !z!
			if !zNeg! equ %TRUE% goto :negativeDirection_linear
		)
		
		:positiveDirection_linear
		:: y = y + x >> i
        call :shift x1 = %x%, %j%
		call :add y = %y%, %x1%
		
		:: z = z - t
		call :sub z = %z%, %t%
		
		goto :continue_linear
		
		:negativeDirection_linear
		:: y = y - x >> i;
		call :shift x1 = %x%, %j%
		call :sub y = %y%, %x1%
		
		:: z = z + t
		call :add z = %z%, %t%
				
		:continue_linear
		
		call :shift t = %t%, -1
		
		set /a i+=1 & goto :for_linear
	:done_linear
	
endlocal & set "%~1=%x%" & set "%~2=%y%" & set "%~3=%z%"
exit /b 0