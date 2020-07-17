@call _dots %~n0 %* --require-dot --require-param 
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dots add library
rem ::: 
rem ::: .ADDLIB <.|[.]project name> [--solution <name>] [--namespace <.|[.]name>]
rem ::: 
rem ::: Parameters: 
rem :::     project name - new project name
rem :::     solution name - existing or new solution
rem :::     namespace name - project namespace 
rem ::: 
rem ::: Description: 
rem :::     Add new class library.
rem ::: 

call _dotname "%~1" PROJECT_NAME

call _dotsrc
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call _dotadd dotlib %PROJECT_NAME% 
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call _dotsln %PROJECT_NAME%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%




