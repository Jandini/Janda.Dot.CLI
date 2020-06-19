@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git remote origin 
rem ::: 
rem ::: .GITORIGIN [origin url]
rem ::: 
rem ::: Parameters: 
rem :::     origin url - new git origin url 
rem ::: 
rem ::: Description: 
rem :::      Display current git origin or set new git origin.
rem ::: 


if "%~1" equ "" git remote -v && goto exit

echo Setting remote origin to %1...
git remote set-url origin %1

:exit
