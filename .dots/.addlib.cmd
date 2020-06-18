@call _dots %~n0 %* --require-dot --require-param 
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dots add library
rem ::: 
rem ::: .ADDLIB <.|[.]project name> [--solution <name>] [--namespace <name>]
rem ::: 
rem ::: Parameters: 
rem :::     project name - New project name
rem :::     solution name - Existing or new solution
rem :::     namespace name - Project namespace 
rem ::: 
rem ::: Description: 
rem :::     Add new class library.
rem ::: 

rem Create new library name and SOLUTION
call _dotname "%~1" LIBRARY_NAME

call _dotsrc
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call _dotnew dotlib %LIBRARY_NAME% 
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call _dotsln %LIBRARY_NAME%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%




