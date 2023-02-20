@echo off

set test1=360_TEMPLATE


(for /f "tokens=1,2,3 delims=./" %%a in (text.txt) do (
    echo %%a%%b%%c
    if %%b EQU %test1% echo SDJFHSDKFJSHDKFJ
))


pause


