@call _dots %~n0 "Creates new repository and add new console application" "<.|name> [application name]" "  1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

call .newdot %1

set APPNAME=%1
if "%2" equ "" goto addcon
set APPNAME=%2

:addcon 
call .addcon %APPNAME%
 