rem This is batch command line argument parser written on 23rd of May 2020 by Matt Janda
rem Argument cleanup added on 16th of June 2020 by Matt Janda
rem 
rem Usage: example.cmd --show-message --message "Hello World" --by "Matt Janda" "I am default argument"
rem 
rem call _dotargs %*
rem echo %DOT_ARG_DEFAULT% is default value without --
rem if %DOT_ARG_SHOW-MESSAGE% neq 1 goto :eof
rem if defined DOT_ARG_MESSAGE echo %DOT_ARG_MESSAGE%
rem if defined DOT_ARG_BY echo %DOT_ARG_BY%

rem This script is called from _dots.cmd with the first argument set to the caller. 
rem It cannot be treated as default argument value
set IGNORE_FIRST_DEFAULT_ARG=1


rem WARNING: when arguments are kept, some optional parameters may be left behind unwanted
if not defined DOT_KEEP_ARGS call :clear_arguments

call :parse_arguments %*

goto :eof


:clear_arguments
rem clear all variables starting with DOT_ARG_
for /f "tokens=1* delims==" %%x in ('set') do call :clear_argument %%x 
goto :eof

:clear_argument
set VAR=%~1
if "%VAR:~0,8%" neq "DOT_ARG_" goto :eof

rem clear it
set %VAR%=
goto :eof


:parse_arguments

rem count number of provided parameters 
rem the count is required so we can skip empty parameters

set DOT_ARG_DEFAULT=
set /A DOT_PARAMS_COUNT=0
for %%x in (%*) do set /A DOT_PARAMS_COUNT+=1

:parse_next
rem if current argument is empty finish parsing
if %DOT_PARAMS_COUNT% equ 0 goto :eof

rem decrement number of parameters
set /A DOT_PARAMS_COUNT-=1

rem save current parameter in DOT_ARG_NAME
set DOT_ARG_NAME=%~1

rem shift to the next parameter
shift

rem if the parameter is empty then parse next parameter
if "%DOT_ARG_NAME%" equ "" goto :parse_next

rem check if saved parameter is argument i.e. starts with argument prefix
if /i "%DOT_ARG_NAME:~0,2%" equ "--" goto :parse_value
rem if saved parameter is not an argument then continue parsing


rem if not defined IGNORE_FIRST_DEFAULT_ARG goto :parse_default
rem _dotargs are called from _dots where the caller is givin as first argument
rem skip argument zero i.e. the caller script
if not defined DOT_ARG_ZERO set DOT_ARG_ZERO=%DOT_ARG_NAME%&goto :parse_next

:parse_default
rem if not yet default arument was found treat the first as default value
if not defined DOT_ARG_DEFAULT set DOT_ARG_DEFAULT=%DOT_ARG_NAME%
goto :parse_next


:parse_value
rem make sure next parameter exist
if "%~1" neq "" goto :get_value

:get_switch
rem next parameter does not exist then assume this argument is a switch
set DOT_ARG_%DOT_ARG_NAME:~2%=1
goto :parse_next

:get_value
rem check if next parameter is a value or next argument
set DOT_NEXT_ARG_NAME=%~1
if /i "%DOT_NEXT_ARG_NAME:~0,2%" equ "--" goto :get_switch
set DOT_ARG_%DOT_ARG_NAME:~2%=%~1
goto :parse_next


