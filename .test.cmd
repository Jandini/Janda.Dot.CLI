@echo off

call .pack
if %ERRORLEVEL% neq 0 echo .pack [ FAILED ] && echo Expected value is 0. Return value is %ERRORLEVEL% && exit 1 /b


for /f %%f in ('dir /b tests\*.cmd') do call tests\%%f 

echo.
echo Tests completed successfully.