@call _dots %~n0 "" %1 %2 %3 
if %ERRORLEVEL% equ 1 exit /b 

rem ::: Display current version and type of the dots 
rem ::: 
rem ::: .DOTS
rem ::: 

for /f %%i in ('type %DOT_PATH%.dotversion') do set DOT_VERSION=%%i
echo %DOT_VERSION% %DOT_TYPE%