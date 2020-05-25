@call _dots %~n0 "Creates new repository and add new console application" "<.|name> [application name]" " G1" %1 %2 %3
if %ERRORLEVEL% equ 1 call :display_hint %1 & exit /b

rem ::: Creates new repository and add new console application
rem ::: 

call .newdot %1
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL% /b

set APPNAME=%1
if "%2" equ "" goto addcon
set APPNAME=%2

:addcon 
call .addcon %APPNAME%
goto :eof


:display_hint
if "%1" neq "--help" echo Try to use .addcon instead.
goto :eof

