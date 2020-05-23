@echo off
call :parse_arguments %*

rem if defined DOT_ARG_SOLUTION echo %DOT_ARG_SOLUTION%
rem if defined DOT_ARG_SWITCH echo %DOT_ARG_SWITCH%
rem if defined DOT_ARG_DUPA echo %DOT_ARG_DUPA%
goto :eof







:parse_arguments

rem count number of provided parameters 
rem the count is required so we can skip empty parameters
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



