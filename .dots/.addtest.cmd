@call _dots %~n0 %* --require-dot --require-param 
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dots add xunit test
rem ::: 
rem ::: .ADDTEST <.|[.]project name> [--solution <name>] [--namespace <name>]
rem ::: 
rem ::: Parameters: 
rem :::     project name - New project name
rem :::     solution name - Existing or new solution
rem :::     namespace name - Project namespace 
rem ::: 
rem ::: Description: 
rem :::     Add new xunit test 
rem ::: 

call _dotname "%~1" PROJECT_NAME

call _dotsrc
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call _dotnew xunit %PROJECT_NAME% 
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call _dotsln %PROJECT_NAME%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%


