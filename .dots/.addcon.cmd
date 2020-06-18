@call _dots %~n0 %* --requre-dot --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dots add console
rem ::: 
rem ::: .ADDCON <.|[.]project name> [--solution <name>] [--add-args] [--namespace <name>]
rem ::: 
rem ::: Parameters: 
rem :::     project name - New project name
rem :::     solution name - Existing or new solution
rem :::     namespace name - Project namespace 
rem :::
rem ::: Switches: 
rem :::     add-args - Add more command line arguments
rem :::
rem ::: Description: 
rem :::     Add new console application.
rem ::: 


call _dotname "%~1" PROJECT_NAME

call _dotsrc
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call _dotnew dotcon %PROJECT_NAME% 
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

rem Make sure the namespace is provided to the abstractions
if not defined DOT_ARG_NAMESPACE set DOT_ARG_NAMESPACE=%PROJECT_NAME%

call _dotnew dotconabs %PROJECT_NAME%.Abstractions
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call _dotsln %PROJECT_NAME%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call _dotsln %PROJECT_NAME%.Abstractions
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

call :update_config

goto :eof



:update_config
find "DOT_PUBLISH_PROJECTS=" ..\%DOT_CONFIG%>nul
if %ERRORLEVEL% equ 0 goto :eof

echo # Semicolon delimited project names to be published>>..\%DOT_CONFIG%
echo DOT_PUBLISH_PROJECTS=%PROJECT_NAME%>>..\%DOT_CONFIG%
goto :eof

