@call _dots %~n0 "Display or set git origin url" "[new origin url]" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if "%1" equ "" git remote -v && goto exit

echo Setting remote origin to %1...
git remote set-url origin %1

:exit
