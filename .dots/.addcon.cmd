@call _dots %~n0 %* --require-dot --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dots add console
rem ::: 
rem ::: .ADDCON <.|[.]project name> [--solution <name>] [--add-args] [--namespace <.|[.]name>]
rem ::: 
rem ::: Parameters: 
rem :::     project name - new project name
rem :::     solution name - existing or new solution
rem :::     namespace name - project namespace 
rem :::
rem ::: Switches: 
rem :::     add-args - add more command line arguments
rem :::
rem ::: Description: 
rem :::     Add new console application.
rem ::: 


call _dotname "%~1" PROJECT_NAME

call _dotsrc
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call _dotadd dotcon %PROJECT_NAME%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call _dotsln %PROJECT_NAME%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call :update_config

goto :eof


:update_config
find "DOT_PUBLISH_PROJECTS=" ..\%DOT_CONFIG%>nul
if %ERRORLEVEL% equ 0 goto :eof

echo # Semicolon delimited project names to be published>>..\%DOT_CONFIG%
echo DOT_PUBLISH_PROJECTS=%PROJECT_NAME%>>..\%DOT_CONFIG%
goto :eof

