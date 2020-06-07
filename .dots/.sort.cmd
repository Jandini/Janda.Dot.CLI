@call _dots %~n0 "  1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

sort /REC 65535 "%DOT_CURRENT_DIR_PATH%\%~1" /O "%DOT_CURRENT_DIR_PATH%\%~1.sorted"
