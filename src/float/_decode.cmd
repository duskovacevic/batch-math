:_decode m, e = float
setlocal EnableDelayedExpansion

	set float=%~3
	set e=%float:*E=%
	
	set /a "m=!float:E%e%=!" || goto :_decode_error

	goto _decode_done

	:_decode_error
	echo ERR [%float%][%e%][%m%]
	pause

	:_decode_done

endlocal & set "%~1=%m%" & set "%~2=%e%"
exit /b 0