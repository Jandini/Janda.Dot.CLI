@call _dots %~n0 "List all available scripts or get single command description and syntax" "[command name|--help|--usage]" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

call .dots

set DOT_CMD_MASK=.?*.cmd  
set DOT_ARG_HELP=--help
set DOT_CMD_NAME=%1


if /i "%DOT_CMD_NAME:~0,2%" equ "." goto already_dotted
if /i "%DOT_CMD_NAME:~0,1%" equ "." goto already_dotted
set DOT_CMD_NAME=.%DOT_CMD_NAME%

:already_dotted
if /i "%DOT_CMD_NAME%" neq "." goto help_show_signle_command
goto help_show_all_commands


:usage_show_all_commands
set DOT_ARG_HELP=--usage
goto help_show_all_commands


:help_show_signle_command
if not exist %DOT_PATH%%DOT_CMD_NAME%.cmd echo %DOT_CMD_NAME% script is missing && exit /b 2 
call %DOT_CMD_NAME% --help
call %DOT_CMD_NAME% --usage
goto exit

:help_show_all_commands
for /f %%f in ('dir /b %DOT_PATH%%DOT_CMD_MASK%') do if "%%f" neq "%~nx0" call %DOTS_PATH%%%f %DOT_ARG_HELP% 

:exit