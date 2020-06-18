@echo off
if "%~1" equ "" goto :eof

rem ::: Read command script and display help comments
rem ::: 
rem ::: _DOTHELP [_command]|[.command.cmd]
rem ::: 
rem ::: Example:
rem :::     _dothelp _dothelp
rem :::     _dothelp .help.cmd


set DOT_COMMAND_FILE_NAME=%~n1
set DOT_COMMAND_FILE_PATH="%DOT_PATH%%DOT_COMMAND_FILE_NAME%.cmd"

if "%DOT_COMMAND_FILE_NAME%" equ "" echo Make sure [.command] has .cmd extension&goto :eof
if not exist "%DOT_COMMAND_FILE_PATH%" echo %DOT_COMMAND_FILE_NAME% command does not exist&exit /b 1

setlocal enabledelayedexpansion

for /F "tokens=* usebackq" %%G in (`type %DOT_COMMAND_FILE_PATH%^|findstr /irc:"^rem ::: .*"`) do (
  set LINE=%%G 
  set OUTPUT=!LINE:~8!
  set TRIM=!OUTPUT: =!

  if "%~2" equ "desc" set OUTPUT=%~n1 - !OUTPUT!
  if "!TRIM!" neq "" (echo !OUTPUT!) else (echo.)
  if "%~2" equ "desc" goto :eof
)


