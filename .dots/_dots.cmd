@if not defined DOT_DEBUG @echo off

rem This is boot strap script. 

rem Usage: @call _dots <caller name> [--require-dot] [--require-git|--require-nogit] [--require-param] [parameters]
rem 
rem <caller name>  - Calling script name. It should be always set to %~n0
rem 
rem     --require-dot   - command must be run in dot repository (.dotconfig file must be present) 
rem     --require-git   - command must run within git repository 
rem     --require-nogit - command cannot run within git repository
rem     --require-param - at least one (default) parameter is required 
rem 
rem [parameters]   - Pass privided parameters %1 %2 %3 %4 or %* 

rem Example: 
rem @call _dots %~n0 --require-dot %*

if /i "%~1" equ "" exit 

rem boot strap can be nested so the flags must be cleared before parse


call _dotargs %*
call :get_time_stamp
call :get_current_dir
call :init_dots

set DOT_COMMAND_NAME=%~1
if defined DOT_ARG_HELP call _dothelp %DOT_COMMAND_NAME%.cmd & exit /b 1 

if not defined DOT_ARG_REQUIRE-DOT set DOT_FLAG_SKIP_CONFIG_CHECK=1
if not defined DOT_ARG_REQUIRE-GIT set DOT_FLAG_SKIP_GITREPO_CHECK=1
if not defined DOT_ARG_REQUIRE-NOGIT set DOT_FLAG_SKIP_NO_GITREPO_ONLY=1
if not defined DOT_ARG_REQUIRE-PARAM set DOT_FLAG_SKIP_PARAM_CHECK=1


rem skip parameter check if it is not required  
if /i "%DOT_FLAG_SKIP_PARAM_CHECK%" equ "1" goto find_dotconfig
if /i "%DOT_ARG_DEFAULT%" neq "" goto find_dotconfig

call _dothelp %DOT_COMMAND_NAME%.cmd
exit /b 1 


:find_dotconfig
for %%I in (%DOT_BASE_PATH%) do set DOT_BASE_NAME=%%~nI%%~xI
if exist %DOT_BASE_PATH%\%DOT_CONFIG% goto parse_dotconfig
set DOT_BASE_PATH=%DOT_BASE_PATH%\..
rem goto parent
if "%DOT_BASE_NAME%" neq "" goto find_dotconfig

rem set base name to current folder if .dotconfig file not found
if "%DOT_BASE_NAME%" equ "" for %%I in (.) do set DOT_BASE_NAME=%%~nI%%~xI


rem dotconfig file is required but file is not found
if "%DOT_FLAG_SKIP_CONFIG_CHECK%" equ "1" goto skip_dotconfig
echo %DOT_CONFIG% not found 
exit /b 1


:parse_dotconfig
cd "%DOT_BASE_PATH%"
call :parse_config_file %DOT_CONFIG%

rem parse local config .dotlocal file if exists
if exist %DOT_CONFIG_LOCAL% call :parse_config_file %DOT_CONFIG_LOCAL%
rem this is only a test echo
if "%ECHO_LOCAL_CONFIG%" neq "" echo %ECHO_LOCAL_CONFIG%


:skip_dotconfig
if "%DOT_FLAG_SKIP_NO_GITREPO_ONLY%" equ "1" goto check_gitrepo
git rev-parse --is-inside-work-tree 1>nul 2>nul
if %ERRORLEVEL% equ 0 set DOT_ARG_INSIDE_GIT_REPO=1&echo %~1 cannot run inside existing git repository.&exit /b 1


:check_gitrepo
if "%DOT_FLAG_SKIP_GITREPO_CHECK%" equ "1" goto skip_gitrepo
git rev-parse --is-inside-work-tree 1>nul 2>nul
if %ERRORLEVEL% neq 0 echo %~1 must be run from a git repository.&exit /b 1

rem get the current git branch name only if git is available
for /F "tokens=* USEBACKQ" %%F in (`git rev-parse --abbrev-ref HEAD`) do set DOT_GIT_BRANCH=%%F
:skip_gitrepo




goto :eof


:init_dots
rem Subroutine:  init_dots
rem Description: Initialize dot environment variables
rem Output:      DOT_CONFIG - default config is ".dotconfig"
rem              DOT_CONFIG_LOCAL - default local config is ".dotlocal"
rem              DOT_PATH - current path
rem              DOT_PATH_GLOBAL -
rem              DOT_TYPE - "local" or "global"
rem              DOT_BASE_PATH - set to current folder .
rem              DOT_BASE_NAME - clear it 
set DOT_CONFIG=.dotconfig
set DOT_CONFIG_LOCAL=.dotlocal
set DOT_PATH=%~dp0
set DOT_PATH_GLOBAL=%USERPROFILE%\.dots\

set DOT_TYPE=local
if "%DOT_PATH%" equ "%DOT_PATH_GLOBAL%" set DOT_TYPE=global

set DOT_BASE_PATH=.
set DOT_BASE_NAME=
goto :eof




:parse_config_file
rem Subroutine:  parse_config_file
rem Description: Read config file line by line and execute SET command.
rem              Comments are supported. Lines starting with # are ignored. 
rem Notes:       .dotconfig or .dotlocal file consist of set statements VARIABLE=value(s)
rem              this file can be used to override e.g. DOT_BASE_NAME
rem Parameters:  %1 - input text/config file 
rem Output:      GIVEN_VARIABLE=given_value
rem Returns:     0

for /F "tokens=*" %%A in (%1) do call :parse_config_line "%%A"
goto :eof


:parse_config_line
rem Subroutine:  parse_config_line
rem Description: This routine is called for each line in :parse_config_file. 
rem              Assign value to environment variable unless it  starts  with # then line is ignored. 
rem Parameters:  %~1 - single line like DOT_BASE_NAME=My.Name 
rem Output:      GIVEN_VARIABLE=given_value
rem Returns:     0

set DOT_CONFIG_LINE=%~1
rem skip line if first character is # 
if "%DOT_CONFIG_LINE:~0,1%" equ "#" goto :eof
set %DOT_CONFIG_LINE%
goto :eof



:get_time_stamp
rem Subroutine:  get_time_stamp
rem Description: Get current date and time and save it in environment variables. 
rem              Execute once DOT_TIME_STAMP is not defined.
rem Parameters:  -
rem Output:      DOT_TIME_STAMP - full date and time (ddMMyyyy_HHmmss) e.g. 25052020_163447
rem              DOT_DATE_STAMP - date only (ddMMyyyy) e.g. DOT_DATE_STAMP
rem Returns:     0

if defined DOT_TIME_STAMP goto :eof
set DOT_TIME_STAMP=%date:/=%_%time::=%
rem the date comes with .milliseconds so take only 15 first characters
set DOT_TIME_STAMP=%DOT_TIME_STAMP:~0,15%
rem get date only
set DOT_DATE_STAMP=%DOT_TIME_STAMP:~0,8%
goto :eof


:get_current_dir
rem Subroutine:  get_current_dir
rem Description: Get the directory path and name where script was executed from.
rem              Execute once DOT_CURRENT_DIR_PATH is not defined.
rem Parameters:  -
rem Output:      DOT_CURRENT_DIR_PATH - directory path
rem              DOT_CURRENT_DIR_NAME - directory name
rem Returns:     0

if defined DOT_CURRENT_DIR_PATH goto :eof
for %%I in (.) do set DOT_CURRENT_DIR_NAME=%%~nxI
set DOT_CURRENT_DIR_PATH=%cd%
goto :eof

