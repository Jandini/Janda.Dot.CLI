@call _dots %~n0 "  1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

start "" devenv /diff "%DOT_CURRENT_DIR_PATH%\%~1" "%DOT_CURRENT_DIR_PATH%\%~2"
