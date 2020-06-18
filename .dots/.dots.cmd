@call _dots %~n0 %*
if %ERRORLEVEL% equ 1 exit /b 

rem ::: Dots
rem ::: 
rem ::: .DOTS
rem ::: 
rem ::: Description: 
rem :::     Display current version and type of the dots
rem ::: 


if not exist %DOT_PATH%.dotversion echo .dotversion is missing
for /f %%i in ('type %DOT_PATH%.dotversion 2^>nul') do set DOT_VERSION=%%i
echo %DOT_VERSION% %DOT_TYPE%