@call _dots %~n0 %*
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dots help
rem ::: 
rem ::: .HELP [command name|search term]
rem ::: 
rem ::: Parameters: 
rem :::     command name - name of the comand  
rem :::     search term - keyword search term
rem ::: 
rem ::: Description: 
rem :::     Show available commands with short description. 
rem :::     When command name is provided display given command's help.
rem :::     If command is not found by name then the command name is considered as search term.
rem :::     Search is performed in  available commands list i.e. command's name and short description.
rem ::: 


call :parse_name %1

if "%COMMAND_NAME%" equ "" (call :show_all) else (call :show_one %1)
goto :eof


:show_one
call _dothelp %COMMAND_NAME%.cmd
if %ERRORLEVEL% equ 0 goto :eof
echo Searching help for %~1...
call :show_all > "%TEMP%\.help" 
echo.
type "%TEMP%\.help" | findstr /i %~1

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