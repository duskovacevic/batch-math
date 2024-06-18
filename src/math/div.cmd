:: See https://en.wikipedia.org/wiki/Division_algorithm#Pseudocode
:div return = n, d
setlocal EnableDelayedExpansion

    set debug=rem

    :: log2((P + 1) / log2(17)) ~ 3 where P is number of bits i.e. 31
    set REPEAT=3
    set F48_17=1515870846E1
    set F32_17=2021161089E0

    set n=%~2
    set d=%~3

    set /a negate = 0
    if %n% lss 0 set /a negate = 1
    if %d% lss 0 set /a "negate ^= 1"

    call :_normalize d, dE = %d%
    call :shift n = %n%, -%dE%
    
    :: X := 48/17 − 32/17 × D'
    call :mul r1 = %F32_17%, %d%
    call :sub x = %F48_17%, %r1%
    
    for /L %%I in (1,1,%REPEAT%) do call :_newton_raphson_iteration x = !x!, %d%

    :: return N' × X
    call :mul return = %n%, %x%

    if %negate% equ 1 call :negate return=%return%

endlocal & set "%~1=%return%"
exit /b 0

:_newton_raphson_iteration x = x, d
setlocal EnableDelayedExpansion

    set x=%~2
    set d=%~3

    :: X = X + X × (1 - D' × X)
    call :mul r1 = %d%, %x%
    call :sub r2 = %ONE%, %r1%
    call :mul r3 = %x%, %r2%
    call :add return = %x%, %r3%

endlocal & set "%~1=%return%"
exit /b 0