@echo off
set DOT_NUL=nul
if /i "%DOT_TRACE%" equ "1" echo on && set DOT_NUL=con

rem TODO: add number of required parameters - show help when not match => Usage: call _dots <caller script name> <help text|""> <usage syntax|""> <number of required parameters> <flags string> [parameters]
rem TODO: add flags "" "dg" "d" " g" "  1" "dg1" 

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
rem                  1 - at least one parameter is required 
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
for %%I in (.) do set CURRENT_DIR_NAME=%%~nxI
set CURRENT_DIR_PATH=%cd%

:already_defined

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
call _help %~4 %~1 
if %ERRORLEVEL% equ 1 exit /b


:parent
for %%I in (%BASE_PATH%) do set BASE_NAME=%%~nI%%~xI
if exist %BASE_PATH%\%DOTS_FILE% goto dotset
set BASE_PATH=%BASE_PATH%\..
if "%BASE_NAME%" neq "" goto parent

rem set base name to current folder if .dotset file not found
if "%BASE_NAME%" equ "" for %%I in (.) do set BASE_NAME=%%~nI%%~xI

rem following commands does not require .dotset file
if "%~1" equ ".foreach" goto skip_dotset
if "%~1" equ ".help" goto skip_dotset
if "%~1" equ ".dots" goto skip_dotset
if "%~1" equ ".status" goto skip_dotset
if "%~1" equ ".sync" goto skip_dotset
if "%~1" equ ".mirror" goto skip_dotset
if "%~1" equ ".origin" goto skip_dotset
if "%~1" equ ".diff" goto skip_dotset
if "%~1" equ ".prerequisites" goto skip_dotset
if "%~1" equ ".newsln" goto skip_dotset
if "%~1" equ ".clone" goto skip_dotset
if "%~1" equ ".develop" goto skip_dotset
if "%~1" equ ".master" goto skip_dotset

if "%~1" equ ".pack" goto skip_dotset
if "%~1" equ ".build" goto skip_dotset
if "%~1" equ ".restore" goto skip_dotset

echo %DOTS_FILE% not found 
exit /b 1


:dotset
cd %BASE_PATH%
rem .dotset file consist of set statements VARIABLE=value(s)
rem read all lines and apply as sets
rem this file can be used to override e.g. BASE_NAME
for /F "tokens=*" %%A in (%DOTS_FILE%) do set %%A
    

:skip_dotset

rem following commands does not require git repository
if "%~1" equ ".foreach" goto exit
if "%~1" equ ".init" goto exit
if "%~1" equ ".help" goto exit
if "%~1" equ ".dots" goto exit
if "%~1" equ ".clone" goto exit
if "%~1" equ ".newsln" goto exit
if "%~1" equ ".addsln" goto exit
if "%~1" equ ".addcon" goto exit
if "%~1" equ ".addlib" goto exit
if "%~1" equ ".prerequisites" goto exit
if "%~1" equ ".install" goto exit

if "%~1" equ ".pack" goto exit
if "%~1" equ ".build" goto exit
if "%~1" equ ".restore" goto exit


git rev-parse --is-inside-work-tree 1>nul 2>nul
if %ERRORLEVEL% neq 0 echo %~1 must be run from a git repository. && exit /b 1

rem get the current git branch name only if git is available
for /F "tokens=* USEBACKQ" %%F in (`git rev-parse --abbrev-ref HEAD`) do set CURRENT_BRANCH=%%F

rem check if path variable contains local dots location
rem for %%G in ("%PATH:;=" "%") do if /i %%G equ ".\.dots" goto exit
rem echo You must add ".\.dots" to PATH variable. 
rem exit 2

:exit
