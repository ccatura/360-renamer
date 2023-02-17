@echo off

set /a framelimit = 48
set /a toomany = %framelimit% + 4

:: GETS COUNT OF FILES IN THE FOLDER
set /a framesinfolder=0
for %%A in (%1\*.jpg) do set /a framesinfolder+=1

:: CHECKS IF FRAME COUNT IS CORRECT
if %framesinfolder% LSS %framelimit% (
    echo There are not enough frames. Please re-render your video with a slightly lower step count.
    echo.
    pause
    exit
)

:: A FEW FRAMES OVER, WE WILL FIX BY DELETING SOME
if %framesinfolder% GEQ %framelimit% if %framesinfolder% LEQ %toomany% (
    echo There are too many frames. 360 Renamer will delete some frames to be compliant.
    echo.
    pause
    goto :deleteextras
)

:: TOO MANY FRAMES OVER. NEED TO RE-RENDER FRAMES.
if %framesinfolder% GTR %toomany% (
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

:: FIGURE OUT WHICH FRAMES TO DELETE
set /a framedifference=%framesinfolder% - %framelimit%

echo there are %framedifference% frames too many.

set /a deleteinterval=%framelimit% / %framedifference%
set /a startdeleteat=%deleteinterval% / 2
echo.


for /l %%g IN (%startdeleteat%, %deleteinterval%, %framelimit%) do (
    echo G Count: %%g
    SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
    set count=1

    for %%a in (%1\*) do (
        set thepath=%%~pa
        set thename=%%~na
        set theext=%%~xa
        set origname=C:!thepath!!thename!!theext!

        if %%g EQU !count! (
            del "!origname!"
        )

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
)
echo thats it
pause
goto :readytogo