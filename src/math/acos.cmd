:acos return = w
setlocal EnableDelayedExpansion

	set w=%~2

	:: acos(w) = π / 2 - asin(w)
	call :asin r1 = %w%
	call :sub return = %HALF_PI%, %r1%

endlocal & set %~1=%return%
exit /b 0