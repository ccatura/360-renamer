@echo off

:: RENAMES ALL IMAGES TO PROPER CONVENTION FOR 360 FOLDER
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
set /a count=1

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


