@call _dots %~n0 " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Display current or set new git origin
rem ::: 
rem ::: .GITORIGIN [new origin url]
rem ::: 


if "%1" equ "" git remote -v && goto exit

echo Setting remote origin to %1...
git remote set-url origin %1

:exit
