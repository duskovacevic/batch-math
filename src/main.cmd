setlocal EnableDelayedExpansion
	
	%%CONSTANTS%%
	
	set method=%~1

    :: float
	if [%method%] equ [:set] call :set return = %~3 & goto :done
	if [%method%] equ [:to_string] call :to_string return = %~3 & goto :done
	if [%method%] equ [:shift] call :shift return = %~3, %~4 & goto :done
	if [%method%] equ [:compare] call :compare return = %~3, %~4 & goto :done
	if [%method%] equ [:is_negative] call :is_negative return = %~3 & goto :done
	if [%method%] equ [:abs] call :abs return = %~3 & goto :done
	if [%method%] equ [:negate] call :negate return = %~3 & goto :done
	if [%method%] equ [:to_int] call :to_int return = %~3 & goto :done
	if [%method%] equ [:add] call :add return = %~3, %~4 & goto :done
	if [%method%] equ [:sub] call :sub return = %~3, %~4 & goto :done
	if [%method%] equ [:inc] call :inc return = %~3 & goto :done
	if [%method%] equ [:dec] call :dec return = %~3 & goto :done

    :: math
    if [%method%] equ [:mul] call :mul return = %~3, %~4 & goto :done
	if [%method%] equ [:div] call :div return = %~3, %~4 & goto :done
	if [%method%] equ [:sin] call :sin return = %~3 & goto :done
	if [%method%] equ [:cos] call :cos return = %~3 & goto :done
	if [%method%] equ [:tan] call :tan return = %~3 & goto :done
	if [%method%] equ [:sinh] call :sinh return = %~3 & goto :done
	if [%method%] equ [:cosh] call :cosh return = %~3 & goto :done
	if [%method%] equ [:tanh] call :tanh return = %~3 & goto :done
	if [%method%] equ [:asin] call :asin return = %~3 & goto :done
	if [%method%] equ [:acos] call :acos return = %~3 & goto :done
	if [%method%] equ [:atan] call :atan return = %~3 & goto :done
	if [%method%] equ [:sqrt] call :sqrt return = %~3 & goto :done

	echo Method %method% not found.
	
	endlocal & set "%~2=Method %method% not found."
	exit /b -1

	:done
endlocal & set %~2=%return%
exit /b 0
goto :eof