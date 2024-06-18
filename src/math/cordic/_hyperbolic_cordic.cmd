:_hyperbolic_cordic x, y, z = x0, y0, z0, vecmode
setlocal EnableDelayedExpansion
	
	set debug=rem
	set x=%~4
	set y=%~5
	set z=%~6
	set vecmode=%~7
	
	set /a i=0
	set /a k=3
	:for_hyperbolic
		if !i! geq %MAXBITS% goto :done_hyperbolic
		
		set /a j=0
		:for_hyperbolic_inner
			if !j! geq 2 goto :done_hyperbolic_inner
			
			set /a l=-i - 1

			%debug% echo x=%x%, y=%y%, z=%z%
			
			if %vecmode% equ %VECTORING% (
				call :is_negative yNeg = !y!
				if !yNeg! equ %FALSE% goto :negativeDirection_hyperbolic
				if !y! equ %ZERO% goto :negativeDirection_hyperbolic
			) else (
				call :is_negative zNeg = !z!
				if !zNeg! equ %TRUE% goto :negativeDirection_hyperbolic
			)
				
			:positiveDirection_hyperbolic
			call :shift y1 = %y%, %l%
			call :add x1 = %x%, %y1%
			
			call :shift x2 = %x%, %l%
			call :add y = %y%, %x2%
			
			set "atanhValue=!atanhTable[%i%]!"
			call :sub z = %z%, %atanhValue%

			goto :continue_hyperbolic
			
			:negativeDirection_hyperbolic
			
			call :shift y1 = %y%, %l%
			call :sub x1 = %x%, %y1%
			
			call :shift x2 = %x%, %l%
			call :sub y = %y%, %x2%
			
			set "atanhValue=!atanhTable[%i%]!"
			call :add z = %z%, %atanhValue%
			
			:continue_hyperbolic
			
			set x=%x1%
			
			if %k% gtr 0 (
				set /a k-=1
				goto :done_hyperbolic_inner
			) else (
				set /a k=3
			)
			
			set /a j+=1 & goto :for_hyperbolic_inner
		:done_hyperbolic_inner
		
		set /a i+=1 & goto :for_hyperbolic
	:done_hyperbolic
	
endlocal & set "%~1=%x%" & set "%~2=%y%" & set "%~3=%z%"
exit /b 0