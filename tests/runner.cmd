@echo off
setlocal EnableDelayedExpansion

    set call=call .\output\math.cmd

    %call% %~1 result = %~2 || goto :error
    
    echo %~2,%result% >> .\output\csv\test_result.csv

    endlocal

exit

:error
    echo There was an error %errorlevel% 1>&2

endlocal

exit