:mod return = a, b
setlocal EnableDelayedExpansion
	
    set debug=rem
	call :_decode aM, aE = %~2
	call :_decode bM, bE = %~3

	if %aE% lss %bE% (
		endlocal & set %~1=0 & set %~2=%~2
		exit /b 0
	)

	if %aE% equ %bE% (
		if %aM% geq %bM% (
			call :sub remainder = %aM%, %bM%
			endlocal & set %~1=1 & set %~2=%remainder%
			exit /b 0
		) else (
			endlocal & set %~1=0 & set %~2=%~2
			exit /b 0
		)
	)

	:: avoid division
	set /a "raE<<=aE+1"
	set /a "rbE<<=bE+1"
	set /a rE=raE/rbE


endlocal & set %~1=%m%E%e%
exit /b 0