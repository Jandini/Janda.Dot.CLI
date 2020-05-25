@call _dots %~n0 "Create new repository and add new class library" "<.|repository name> [--library-name <library name>]" " G1" %*
if %ERRORLEVEL% equ 1 call :display_hint %1 & exit /b

rem ::: Create new repository and add new class library
rem ::: 

@call _dotargs %*

set LIBRARY_NAME=%1
if defined DOT_ARG_LIBRARY-NAME set LIBRARY_NAME=%DOT_ARG_LIBRARY-NAME%

call .newdot %1
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL% /b

call .addlib %LIBRARY_NAME% %*
goto :eof


:display_hint
if "%1" neq "--help" echo Try to use .addlib instead.
goto :eof

