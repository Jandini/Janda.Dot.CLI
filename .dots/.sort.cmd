@call _dots %~n0 %* --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: File sort
rem ::: 
rem ::: .SORT [file name]
rem ::: 
rem ::: Parameters: 
rem :::     file name - text file name 
rem ::: 
rem ::: Description: 
rem :::     Read and sort conent of given file and save it in [file name].sorted file.
rem ::: 


sort /REC 65535 "%DOT_CURRENT_DIR_PATH%\%~1" /O "%DOT_CURRENT_DIR_PATH%\%~1.sorted"
