@call _dots %~n0 %* --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Compare text files
rem ::: 
rem ::: .COMPARE <first> <second>
rem ::: 
rem ::: Parameters:
rem :::     first  - first file name or full file path
rem :::     second - second file name or full file path
rem :::     
rem ::: Description: 
rem :::     Compare two text files using Visual Studio
rem ::: 
rem ::: Examples: 
rem :::     .compare file1.txt file2.txt


if "%~2" equ "" _dothelp %~n0.cmd

start "" devenv /diff "%DOT_CURRENT_DIR_PATH%\%~1" "%DOT_CURRENT_DIR_PATH%\%~2"
