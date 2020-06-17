@call _dots %~n0 %*
if %ERRORLEVEL% equ 1 exit /b

rem ::: Show available commands with short description
rem ::: 
rem ::: .HELP [command name]
rem ::: 
rem ::: Description: 
rem :::     List available commands with short description. 
rem :::     When command name is provided display given command's help.
rem ::: 


call :parse_name %1

if "%COMMAND_NAME%" equ "" (call :show_all) else (call _dothelp %COMMAND_NAME%.cmd)
goto :eof


:show_all
set DOT_CMD_MASK=.?*.cmd  
for /f %%f in ('dir /b %DOT_PATH%%DOT_CMD_MASK%') do call _dothelp %%f desc
goto :eof


:parse_name
if "%~1" equ "" goto :eof
set COMMAND_NAME=%~1
if /i "%COMMAND_NAME:~0,1%" equ "." goto :eof
if /i "%COMMAND_NAME:~0,2%" equ "." goto :eof
set COMMAND_NAME=.%COMMAND_NAME%
goto :eof