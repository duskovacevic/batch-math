:_most_significant_bit return = a
setlocal EnableDelayedExpansion
	set /a a=%~2
	set /a match=1073741824
	set /a msb=31
	
	:: TODO FIX THIS LOOP
	:while_msb
		set /a "compare=a & match"
	
		if !compare! neq 0 goto :done_msb
		
		set /a "match>>=1"
		set /a msb-=1
		
		goto :while_msb
	:done_msb
	
endlocal & set %~1=%msb%
exit /b 0