@echo off

(setlocal enabledelayedexpansion
for /F "tokens=* delims=" %%a in (text.txt) do (
    set x=%%a
    if not "!x:360_TEMPLATE=!"=="!x!" (
        :: REPLACE 360_TEMPLATE WITH SKU
        set x=!x! & echo !x:360_TEMPLATE=ABC123!
    ) else (
        echo !x!
    )
))>aaaaaaaaaaaaaa.txt


pause
