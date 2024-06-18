:mul return = a, b
setlocal EnableDelayedExpansion
	
    set debug=rem

	call :_decode aM, aE = %~2
	call :_decode bM, bE = %~3

    set /a negate = 0
    if %aM% lss 0 set /a negate = 1
    if %bM% lss 0 set /a "negate ^= 1"

    %debug% echo $$$ [%negate%]

    if %aM% lss 0 set /a aM=-aM
    set /a "aMu = aM >> 16"
    set /a "aMl = aM - (aMu << 16)"
    if %bM% lss 0 set /a bM=-bM
    set /a "bMu = bM >> 16"
    set /a "bMl = bM - (bMu << 16)"
	
    %debug% echo aM = [%aM%] aE = [%aE%] bM = [%bM%] bE = [%bE%]
    %debug% echo aMu = [%aMu%] aMl = [%aMl%] bMu = [%bMu%] bMl = [%bMl%]

    set /a Muu = aMu * bMu
    set /a Mul = aMu * bMl
    set /a Mlu = aMl * bMu
    set /a Mll = aMl * bMl

    %debug% echo Muu = [%Muu%] Mul = [%Mul%] Mlu = [%Mlu%] Mll = [%Mll%]

    set /a Euu = aE + bE + 2
    set /a Eul = aE + (bE - 16) + 1
    set /a Elu = (aE - 16) + bE + 1
    set /a Ell = (aE - 16) + (bE - 16) 

    %debug% echo Euu = [%Euu%] Eul = [%Eul%] Elu = [%Elu%] Ell = [%Ell%]

    call :_encode Muu = %Muu%, %Euu%
    call :_encode Mul = %Mul%, %Eul%
    call :_encode Mlu = %Mlu%, %Elu%
    call :_encode Mll = %Mll%, %Ell%

    %debug% echo [%Muu%][%Mul%][%Mlu%][%Mll%]

    call :_safe_add r1 = %Muu%, %Mul%
    call :_safe_add r2 = %r1%, %Mlu%
    call :_safe_add return = %r2%, %Mll%
    
    if %negate% equ 1 call :negate return=%return%

    %debug% echo $$$ [%negate%][%return%]

endlocal & set %~1=%return%
exit /b 0