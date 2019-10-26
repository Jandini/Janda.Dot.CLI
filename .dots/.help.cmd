@call _dots %~n0 "List all available scripts or get single command description and syntax" "[command name|--help|--usage]" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

call .dots

set DOTS_MASK=.*.cmd  
set DOTS_HELP=--help
set DOTS_NAME=%1

if /i "%DOTS_NAME%" equ "usage" goto usage_show_all_commands
if /i "%DOTS_NAME%" neq "" goto help_show_signle_command
goto help_show_all_commands

:usage_show_all_commands
set DOTS_HELP=--usage
goto help_show_all_commands


:help_show_signle_command
if not exist %DOTS_PATH%.%DOTS_NAME%.cmd echo .%DOTS_NAME% script is missing && exit /b 2 
call .%DOTS_NAME% --help
call .%DOTS_NAME% --usage
goto exit

:help_show_all_commands
for /f %%f in ('dir /b %DOTS_PATH%%DOTS_MASK%') do if "%%f" neq "%~nx0" call %DOTS_PATH%%%f %DOTS_HELP% 

:exit