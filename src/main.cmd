@echo off

setlocal EnableDelayedExpansion
	
	%%CONSTANTS%%
	
	:: return = :method param1, param2
	:: :method param1, param2
	set arg1=%~1

	if not [%arg1::=%] == [%arg1%] (
		set method=%~1
		set param1=%~2
		if defined %~3 set param2=%~3
	) else (
		set var=%~1
		set method=%~2
		set param1=%~3
		if defined %~4 set param2=%~4
	)

	if [%param1:E=%] == [%param1%] (
		set convert=%TRUE%
		call :set param1 = %param1%
		if defined param2 (
			call :set param2 = %param2%
		)
	)
	
    :: float
	if [%method%] equ [:set] call :set return = %param1% & goto :done
	if [%method%] equ [:to_string] call :to_string return = %param1% & goto :done
	if [%method%] equ [:shift] call :shift return = %param1%, %param2% & goto :done
	if [%method%] equ [:compare] call :compare return = %param1%, %param2% & goto :done
	if [%method%] equ [:is_negative] call :is_negative return = %param1% & goto :done
	if [%method%] equ [:abs] call :abs return = %param1% & goto :done
	if [%method%] equ [:negate] call :negate return = %param1% & goto :done
	if [%method%] equ [:to_int] call :to_int return = %param1% & goto :done
	if [%method%] equ [:add] call :add return = %param1%, %param2% & goto :done
	if [%method%] equ [:sub] call :sub return = %param1%, %param2% & goto :done
	if [%method%] equ [:inc] call :inc return = %param1% & goto :done
	if [%method%] equ [:dec] call :dec return = %param1% & goto :done

    :: math
    if [%method%] equ [:mul] call :mul return = %param1%, %param2% & goto :done
	if [%method%] equ [:div] call :div return = %param1%, %param2% & goto :done
	if [%method%] equ [:sin] call :sin return = %param1% & goto :done
	if [%method%] equ [:cos] call :cos return = %param1% & goto :done
	if [%method%] equ [:tan] call :tan return = %param1% & goto :done
	if [%method%] equ [:sinh] call :sinh return = %param1% & goto :done
	if [%method%] equ [:cosh] call :cosh return = %param1% & goto :done
	if [%method%] equ [:tanh] call :tanh return = %param1% & goto :done
	if [%method%] equ [:asin] call :asin return = %param1% & goto :done
	if [%method%] equ [:acos] call :acos return = %param1% & goto :done
	if [%method%] equ [:atan] call :atan return = %param1% & goto :done
	if [%method%] equ [:asinh] call :asinh return = %param1% & goto :done
	if [%method%] equ [:acosh] call :acosh return = %param1% & goto :done
	if [%method%] equ [:atanh] call :atanh return = %param1% & goto :done
	if [%method%] equ [:sqrt] call :sqrt return = %param1% & goto :done
	if [%method%] equ [:ln] call :ln return = %param1% & goto :done
	if [%method%] equ [:log] call :log return = %param1%, %param2% & goto :done
	if [%method%] equ [:exp] call :exp return = %param1% & goto :done
	if [%method%] equ [:pow] call :pow return = %param1%, %param2% & goto :done

	echo Method %method% not found.
	
	endlocal
	exit /b -1

	:done
	if [%convert%] == [%TRUE%] (
		call :to_string return = %return%
	)

	if not [%var%] == [] (
		endlocal & set %var%=%return%
	) else (
		if defined param2 (
			echo %~2,%~3,%return%
		) else (
			echo %~2,%return%
		)
	)

endlocal
exit /b 0
goto :eof