@echo off

rem nul or con
set DOT_OUT=nul

call .pack
if %ERRORLEVEL% neq 0 echo .pack [ FAILED ] && echo Expected value is 0. Return value is %ERRORLEVEL% && exit 1 /b

for /f %%f in ('dir /b tests\*.cmd') do echo.&echo ----TEST: %%f&call tests\%%f 

echo.
echo Tests completed successfully.
