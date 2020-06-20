@call _dots %~n0 %* --require-nogit --require-param
if %ERRORLEVEL% equ 1 call :display_hint & exit /b

rem ::: Dots new application
rem ::: 
rem ::: .NEWAPP <.|repository name> [--project <name>]
rem ::: 
rem ::: Parameters: 
rem :::     repository name - new repository name (. = current folder name)
rem :::     project name - console application project name (default = repository name)
rem ::: 
rem ::: Description: 
rem :::     Creates new repository and add new console application with abstractions class library.
rem ::: 


call _dotnew addapp %*
goto :eof


:display_hint
if defined DOT_ARG_INSIDE_GIT_REPO echo Try to use .addapp instead.
goto :eof

