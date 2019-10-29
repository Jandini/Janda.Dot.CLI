@echo off
set DOT_NUL=nul
if /i "%DOT_TRACE%" equ "1" echo on && set DOT_NUL=con

rem TODO: add number of required parameters - show help when not match => Usage: call _dots <caller script name> <help text|""> <usage syntax|""> <number of required parameters> <flags string> [parameters]
rem TODO: add flags "" "dg" "d" " g" "  1" "dg1" 
rem TODO: help via grep type _dots.cmd | grep -o -P (?^<=rem).*

rem This is a boot strap script. It will handle 

rem Usage: @call _dots <caller name> <help text|""> <usage syntax|""> <script flags> [parameters %1 %2 %3 %4]
rem 
rem <caller name>  - Calling script name. It should be always set to %~n0
rem <help text>    - Text to be displayed when help is requested
rem <usage synax>  - Usage syntax when usage help is requested
rem <script flags> - Flag string. Each position in string represents one flag. Space character represents the flag as not set.
rem                  Available flags: "dg"
rem                  d - command must be run in dot repository (.dotset file must be present) 
rem                  g - command must be run withing git repository
rem                  1 - at least one parameter is required (%~1 checking as unquoted)
rem [parameters]   - Pass privided parameters %1 %2 %3 %4

rem Example: 
rem @call _dots %~n0 "This is a script" "[some|parameter]" "dg1" %1 %2 %3 %4

rem set this .script help text and usage syntax


rem version 1.2.0

rem * As user I cannot run .pack, .build and .restore commands recursively only when '*' is given. 
rem * As user I can run .pack, .build and .restore commands only within single project by giving '.' parameter. 
rem * As user I can see ".dots prerequisites" instead of "Elevating privileges..." when I call .dots install 
rem * As user I can upstream local branches using .mirror command
rem * As developer I want to access current git version through DOT_GIT_VERSION environment variable
rem * As user I don't need .prerequisites to be separate command.  
rem * As developer I want to access dot repository directory name through DOT_DIR_NAME environment variable
rem * As developer I want to access dot repository full path through DOT_DIR_PATH environment variable
rem * As user I want to set gitlab base url through DOT_GITLAB_URL environment variable
rem * As user I want to set gitlab user name using DOT_GITLAB_USER environment variable
rem * As developer I want to access dot repository current branch through DOT_GIT_BRNACH environment variable
rem * As developer I want to access DOT_BASE_NAME
rem * As user I do not want any of dot commands to close cmd window if execute directly from it


rem - As developer I can define command flags so they can check command's constraints before the command is executed    
rem - As user I can use .feature command to checkout feature branch so I can work on it  
rem - As user I cannot execute git based commands outside git repositories 
rem - As user I can run .init command in any folder without dotset or git repository check
rem - As user I want the installer to replace old dots so the depricated commands are removed


if /i "%~1" equ "" exit

rem get properties only once
if defined TIME_STAMP goto already_defined
rem get timestamp
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined TIME_STAMP set TIME_STAMP=%%x
set DATE_STAMP=%TIME_STAMP:~0,8%

rem get directory where script was executed
for %%I in (.) do set CURRENT_DIR_NAME=%%~nxI
set CURRENT_DIR_PATH=%cd%

:already_defined

rem always update flags as the script may call another where requirements are different
set DOTS_FLAGS=%~4

set FLAG_SKIP_DOTSET_CHECK=
set FLAG_SKIP_GITREPO_CHECK=
set FLAG_SKIP_PARAM_CHECK=

if /i "%DOTS_FLAGS:~0,1%" neq "d" set FLAG_SKIP_DOTSET_CHECK=1
if /i "%DOTS_FLAGS:~1,1%" neq "g" set FLAG_SKIP_GITREPO_CHECK=1
if /i "%DOTS_FLAGS:~2,1%" neq "1" set FLAG_SKIP_PARAM_CHECK=1


set DOTS_FILE=.dotset
set DOTS_PATH=%~dp0
set DOTS_TYPE=local
set DOTS_GLOBAL=%USERPROFILE%\.dots\
if "%DOTS_PATH%" equ "%DOTS_GLOBAL%" set DOTS_TYPE=global

set BASE_PATH=.
set BASE_NAME=

set HELP_TEXT=%~2
set HELP_USAGE=%3

rem call help and exit script if help was requested
call _help %~5 %~1 
if %ERRORLEVEL% equ 1 exit /b

rem skip parameter check if it is not required  
if /i "%FLAG_SKIP_PARAM_CHECK%" equ "1" goto find_dotset
if /i "%~5" neq "" goto find_dotset

call _help --help %~1
call _help --usage %~1 
exit /b 1


:find_dotset
for %%I in (%BASE_PATH%) do set BASE_NAME=%%~nI%%~xI
if exist %BASE_PATH%\%DOTS_FILE% goto use_dotset
set BASE_PATH=%BASE_PATH%\..
rem goto parent
if "%BASE_NAME%" neq "" goto find_dotset

rem set base name to current folder if .dotset file not found
if "%BASE_NAME%" equ "" for %%I in (.) do set BASE_NAME=%%~nI%%~xI


rem dotset file is required but file is not found
if "%FLAG_SKIP_DOTSET_CHECK%" equ "1" goto skip_dotset
echo %DOTS_FILE% not found 
exit /b 1


:use_dotset
cd %BASE_PATH%
rem .dotset file consist of set statements VARIABLE=value(s)
rem read all lines and apply as sets
rem this file can be used to override e.g. BASE_NAME
for /F "tokens=*" %%A in (%DOTS_FILE%) do set %%A
    

:skip_dotset

if "%FLAG_SKIP_GITREPO_CHECK%" equ "1" goto skip_gitrepo
git rev-parse --is-inside-work-tree 1>nul 2>nul
if %ERRORLEVEL% neq 0 echo %~1 must be run from a git repository. && exit /b 1

rem get the current git branch name only if git is available
for /F "tokens=* USEBACKQ" %%F in (`git rev-parse --abbrev-ref HEAD`) do set CURRENT_BRANCH=%%F

:skip_gitrepo

rem check if path variable contains local dots location
rem for %%G in ("%PATH:;=" "%") do if /i %%G equ ".\.dots" goto exit
rem echo You must add ".\.dots" to PATH variable. 
rem exit 2

:exit

