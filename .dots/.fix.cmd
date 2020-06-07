@call _dots %~n0 " g1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

.commit "%~1" fix
