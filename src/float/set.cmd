:set return = value
setlocal EnableDelayedExpansion

	set value=%~2

	:: check if . is specified
	set test=%value:.=#%
	if [%test%] equ [%value%] (
		set value=%value%.0
	)

	set frac=%value:*.=%
	call set /a "int=%%value:.%frac%=%%"
	set /a sign=0
	
	if [%value:~0,1%] equ [-] (
		set /a sign=1, int=-int
	)
	
	if %int% equ 0 (
		set /a msb=0
	) else (
		call :_most_significant_bit msb = %int%
	)
	
	set /a binFrac=0, fmsb=0, fe=0
	:: leading zeros are an issue as it gets interpreted as octal
	set /a decFrac=1%frac%-(11%frac%-1%frac%)/10
	
	if %decFrac% equ 0 goto :done_set

	set target=1%frac%
	set /a target=target - decFrac		
	set /a test=decFrac

	set /a remainingBits=31 - msb
		
	:while_set
		if !test! equ !target! goto :done_set
		if !fmsb! geq !remainingBits! goto :done_set
		
		set /a test*=2
		
		if !binFrac! neq 0 (
			set /a "binFrac<<=1"
		) else (
			set /a fe+=1
		)
		
		if !test! geq !target! (
			set /a "binFrac|=1, test-=target"
		)
		
		if !binFrac! neq 0 (
			set /a fmsb+=1
		)
		
		goto :while_set
	:done_set
	
	if !int! neq 0 (
		set /a "m=(int << (31 - msb))"
		set /a "f=binFrac >> fe - 1"
		set /a "m|=f"
	) else (
		set /a "m=binFrac << 31 - fmsb"
	)
	
	set /a e=0
	if !int! neq 0 (
		set /a e=msb - 1
	) else (
		set /a e=-fe
	)

	if !sign! equ 1	(
		set /a m=-m
	)
	
	endlocal & set %~1=%m%E%e%
exit /b 0