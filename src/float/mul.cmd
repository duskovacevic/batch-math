:mul return = a, b
setlocal EnableDelayedExpansion
	
	call :_decode aM, aE = %~2
	call :_decode bM, bE = %~3

    set /a negate = 0
    if %aM% lss 0 set /a negate = 1
    if %bM% lss 0 set /a "negate ^= 1"
    if %aM% lss 0 set /a aM=-aM
    set /a "aMu = aM >> 16"
    set /a "aMl = aM - (aMu << 16)"
    if %bM% lss 0 set /a bM=-bM
    set /a "bMu = bM >> 16"
    set /a "bMl = bM - (bMu << 16)"
	
    set /a Muu = aMu * bMu
    set /a Mul = aMu * bMl
    set /a Mlu = aMl * bMu
    set /a Mll = aMl * bMl

    set /a Euu = aE + bE + 2
    set /a Eul = aE + (bE - 16) + 1
    set /a Elu = (aE - 16) + bE + 1
    set /a Ell = (aE - 16) + (bE - 16) 

    call :_encode Muu = %Muu%, %Euu%
    call :_encode Mul = %Mul%, %Eul%
    call :_encode Mlu = %Mlu%, %Elu%
    call :_encode Mll = %Mll%, %Ell%

    call :_safe_add r1 = %Muu%, %Mul%
    call :_safe_add r2 = %r1%, %Mlu%
    call :_safe_add return = %r2%, %Mll%
    
    if %negate% equ 1 call :negate return=%return%

endlocal & set %~1=%return%
exit /b 0