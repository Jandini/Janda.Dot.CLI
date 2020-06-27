@call _dots %~n0 %* --require-nogit --require-param
if %ERRORLEVEL% equ 1 call :display_hint & exit /b %ERRORLEVEL%

rem ::: Dots new library 
rem ::: 
rem ::: .NEWLIB <.|repository name> [--project <.|[.]name>] [--namespace <.|[.]name>]
rem ::: 
rem ::: Parameters: 
rem :::     repository name - new repository name 
rem :::     project name - class library project name
rem :::     namespace name - project namespace
rem ::: 
rem ::: Description: 
rem :::     Create new repository and add new class library.
rem ::: 


call _dotnew addlib %*
goto :eof

:display_hint
if defined DOT_ARG_INSIDE_GIT_REPO echo Try to use .addlib instead.
goto :eof

