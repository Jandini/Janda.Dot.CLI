@echo off
set DOT_NUL=nul
if /i "%DOT_TRACE%" equ "1" echo on && set DOT_NUL=con

rem TODO: add number of required parameters - show help when not match => Usage: call _dots <caller script name> <help text|""> <usage syntax|""> <number of required parameters> <flags string> [parameters]
rem TODO: help via grep type _dots.cmd | grep -o -P (?^<=rem).* ; or find or findstr 

rem This is a boot strap script. 

rem Usage: @call _dots <caller name> <help text|""> <usage syntax|""> <script flags> [parameters %1 %2 %3 %4]
rem 
rem <caller name>  - Calling script name. It should be always set to %~n0
rem <help text>    - Text to be displayed when help is requested
rem <usage synax>  - Usage syntax when usage help is requested
rem <script flags> - Flag string. Each position in string represents one flag. Space character represents the flag as not set.
rem                  Available flags: "d[g|G]1"
rem                  d   - command must be run in dot repository (.dotconfig file must be present) 
rem                  g/G - command must be/cannot run within git repository
rem                  1   - at least one parameter is required (%~1 checking as unquoted)
rem [parameters]   - Pass privided parameters %1 %2 %3 %4

rem Example: 
rem @call _dots %~n0 "This is a script" "[some|parameter]" "dg1" %1 %2 %3 %4

rem set this .script help text and usage syntax


if /i "%~1" equ "" exit

rem get properties only once
if defined TIME_STAMP goto already_defined
rem get timestamp
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined TIME_STAMP set TIME_STAMP=%%x
set DATE_STAMP=%TIME_STAMP:~0,8%

rem get directory where script was executed
for %%I in (.) do set DOT_CURRENT_DIR_NAME=%%~nxI
set DOT_CURRENT_DIR_PATH=%cd%

:already_defined

rem always update flags as the script may call another where requirements are different
set DOTS_FLAGS=%~4
set FLAG_SKIP_DOTSET_CHECK=
set FLAG_SKIP_GITREPO_CHECK=
set FLAG_SKIP_PARAM_CHECK=
set FLAG_NO_GITREPO_ONLY=

if "%DOTS_FLAGS:~0,1%" neq "d" set FLAG_SKIP_DOTSET_CHECK=1
if "%DOTS_FLAGS:~1,1%" neq "g" set FLAG_SKIP_GITREPO_CHECK=1
if "%DOTS_FLAGS:~1,1%" neq "G" set FLAG_SKIP_NO_GITREPO_ONLY=1
if "%DOTS_FLAGS:~2,1%" neq "1" set FLAG_SKIP_PARAM_CHECK=1


set DOTS_CONFIG=.dotconfig
set DOTS_PATH=%~dp0
set DOTS_TYPE=local
set DOTS_GLOBAL=%USERPROFILE%\.dots\
if "%DOTS_PATH%" equ "%DOTS_GLOBAL%" set DOTS_TYPE=global

set DOT_BASE_PATH=.
set DOT_BASE_NAME=

set HELP_TEXT=%~2
set HELP_USAGE=%3

rem call help and exit script if help was requested
call _help %~5 %~1 
if %ERRORLEVEL% equ 1 exit /b

rem skip parameter check if it is not required  
if /i "%FLAG_SKIP_PARAM_CHECK%" equ "1" goto find_dotconfig
if /i "%~5" neq "" goto find_dotconfig

call _help --help %~1
call _help --usage %~1 
exit /b 1


:find_dotconfig
for %%I in (%DOT_BASE_PATH%) do set DOT_BASE_NAME=%%~nI%%~xI
if exist %DOT_BASE_PATH%\%DOTS_CONFIG% goto parse_dotconfig
set DOT_BASE_PATH=%DOT_BASE_PATH%\..
rem goto parent
if "%DOT_BASE_NAME%" neq "" goto find_dotconfig

rem set base name to current folder if .dotconfig file not found
if "%DOT_BASE_NAME%" equ "" for %%I in (.) do set DOT_BASE_NAME=%%~nI%%~xI


rem dotset file is required but file is not found
if "%FLAG_SKIP_DOTSET_CHECK%" equ "1" goto skip_dotconfig
echo %DOTS_CONFIG% not found 
exit /b 1


:parse_dotconfig
cd %DOT_BASE_PATH%
rem .dotconfig file consist of set statements VARIABLE=value(s)
rem read all lines and apply as sets
rem this file can be used to override e.g. DOT_BASE_NAME
for /F "tokens=*" %%A in (%DOTS_CONFIG%) do set %%A
    

:skip_dotconfig
if "%FLAG_SKIP_NO_GITREPO_ONLY%" equ "1" goto check_gitrepo
git rev-parse --is-inside-work-tree 1>nul 2>nul
if %ERRORLEVEL% equ 0 echo %~1 cannot run inside existing git repository.&exit /b 1


:check_gitrepo
if "%FLAG_SKIP_GITREPO_CHECK%" equ "1" goto skip_gitrepo
git rev-parse --is-inside-work-tree 1>nul 2>nul
if %ERRORLEVEL% neq 0 echo %~1 must be run from a git repository.& exit /b 1

rem get the current git branch name only if git is available
for /F "tokens=* USEBACKQ" %%F in (`git rev-parse --abbrev-ref HEAD`) do set DOT_GIT_BRANCH=%%F

:skip_gitrepo

