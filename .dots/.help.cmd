@call _dots %~n0 "List all available scripts or get single command description and syntax" "[command name|--help|--usage]" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Show available commands with short description
rem ::: 


call :parse_name %1

if "%COMMAND_NAME%" equ "" (call :show_all) else (call _dothelp %DOT_PATH%%COMMAND_NAME%.cmd)
goto :eof




:show_all
set DOT_CMD_MASK=.?*.cmd  
for /f %%f in ('dir /b %DOT_PATH%%DOT_CMD_MASK%') do call _dothelp %DOT_PATH%%%f desc
goto :eof



:parse_name
if "%~1" equ "" goto :eof
set COMMAND_NAME=%~1
if /i "%COMMAND_NAME:~0,1%" equ "." goto :eof
if /i "%COMMAND_NAME:~0,2%" equ "." goto :eof
set COMMAND_NAME=.%COMMAND_NAME%
goto :eof