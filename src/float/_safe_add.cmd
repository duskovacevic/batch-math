:_safe_add return = a, b
setlocal EnableDelayedExpansion

	set a=%~2
	set b=%~3
	
	call :_decode aM, aE = %~2
	call :_decode bM, bE = %~3
	
	if %aM% equ 0 (
		endlocal & set %~1=%bM%E%bE%
		exit /b 0
	)
	if %bM% equ 0 (
		endlocal & set %~1=%aM%E%aE%
		exit /b 0
	)
	
	set /a newE=0
	
	if %aE% lss %bE% (
		if %aM% lss 0 (
			set /a aM=-aM
			set /a "aM>>=bE - aE"
			set /a aM=-aM
		) else (
			set /a "aM>>=bE - aE"
		)
		set /a newE=bE
	) else (
		if %aE% gtr %bE% (
			if %bM% lss 0 (
				set /a bM=-bM
				set /a "bM>>=aE - bE"
				set /a bM=-bM
			) else (
				set /a "bM>>=aE - bE"
			)
			set /a newE=aE
		) else (
			set /a "aM>>=1"
			set /a "bM>>=1"
			set /a newE=aE + 1
		)
	)
	
	:: magic number needs to be handled -2147483648
	set /a newM=aM + bM

	:: check if zero
	if %newM% equ 0 (
		endlocal & set %~1=%ZERO%
		exit /b 0
	)
	
	set overflow=%FALSE%
	if %aM% lss 0 (
		if %bM% lss 0 (
			if %newM% geq 0 (
				set overflow=%TRUE%
			)
		)
	)
	if %aM% geq 0 (
		if %bM% geq 0 (
			if %newM% lss 0 (
				set overflow=%TRUE%
			)
		)
	)
	if %newM% equ -2147483648 (
		set overflow=%TRUE%
	)
	
	if %overflow% equ %TRUE% (
		:: Overflow
		set /a "aM>>=1"
		set /a "bM>>=1"
		set /a newE+=1
		set /a newM=aM + bM
	)
	
	:: normalize
	if %newM% neq 0 (
		set /a sign=0
		if %newM% lss 0 (
			set /a sign=1
			set /a newM=-newM
		)
		call :_most_significant_bit bit = !newM!
		set /a nE=31 - bit
		set /a "newM<<=nE"
		set /a "newE-=nE"
		if !sign! equ 1 (
			set /a newM=-newM
		)
	)

endlocal & set %~1=%newM%E%newE%
exit /b 0