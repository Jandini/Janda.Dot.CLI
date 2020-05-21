@call _dots %~n0 "Creates new repository and add new class library" "<.|name> [library name]" " G1" %1 %2 %3
if %ERRORLEVEL% equ 1 call :display_hint %1 & exit /b

call .newdot %1
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL% /b

set LIBNAME=%1
if "%2" equ "" goto addlib
set LIBNAME=%2

:addlib 
call .addlib %LIBNAME%
goto :eof


:display_hint
if "%1" neq "--help" echo Try to use .addlib instead.
goto :eof

