@echo off

set /a framelimit = 48
set /a toomany = %framelimit% + 4

:: GETS COUNT OF FILES IN THE FOLDER
set /a cnt=0
for %%A in (%1\*.jpg) do set /a cnt+=1

if %cnt% LSS %framelimit% (
    echo There are not enough frames. Please re-render your video with a slightly lower step count.
    echo.
    pause
    exit
)

if %cnt% GEQ %framelimit% if %cnt% LEQ %toomany% (
    echo There are too many frames. 360 Renamer will delete some frames to be compliant.
    echo.
    pause
    goto :deleteextras
)

if %cnt% GTR %toomany% (
    echo There are too many frames for 360 Renamer to fix. Please re-render your video with a slightly higher step count.
    echo.
    pause
    exit
)
pause
:readytogo



:: RENAMES ALL IMAGES TO PROPER CONVENTION FOR 360 FOLDER
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
set count=1

for %%a in (%1\*) do (
    set thepath=%%~pa
    set thename=%%~na
    set theext=%%~xa
    set origname=C:!thepath!!thename!!theext!

    if !count! LSS 10 (
        set renamed=img0!count!.jpg
    ) else (
        set renamed=img!count!.jpg
    )

    echo Original Name:      !origname!
    echo    Renamed To:      !renamed!
    rename "!origname!" "!renamed!"
    echo .

    set /a count+=1
)
ENDLOCAL


exit
:deleteextras
echo We deleted shit for you!
pause
goto :readytogo