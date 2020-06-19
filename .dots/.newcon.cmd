@call _dots %~n0 %* --require-nogit --require-param
if %ERRORLEVEL% equ 1 call :display_hint & exit /b

rem ::: Dots new console
rem ::: 
rem ::: .NEWCON <.|repository name> [--project <name>]
rem ::: 
rem ::: Parameters: 
rem :::     repository name - New repository name or "." = current folder name.
rem :::     project name - Console application project name. Default = repository name
rem ::: 
rem ::: Description: 
rem :::     Creates new repository and add new console application.
rem ::: 


call _dotnew addcon %*
goto :eof


:display_hint
if defined DOT_ARG_INSIDE_GIT_REPO echo Try to use .addcon instead.
goto :eof

