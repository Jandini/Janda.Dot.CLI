@call _dots %~n0 "Undo git changes" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

