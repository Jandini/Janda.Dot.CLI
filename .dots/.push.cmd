@call _dots %~n0 "Calls git push" " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b
git push --all



