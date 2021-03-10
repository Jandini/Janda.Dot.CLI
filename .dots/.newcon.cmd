@call _dots %~n0 %* --require-nogit --require-param
if %ERRORLEVEL% equ 1 call :display_hint & exit /b

rem ::: Dots new console
rem ::: 
rem ::: .NEWCON <.|repository name> [--project <.|[.]name>] [--namespace <.|[.]name>] [--add-args]
rem ::: 
rem ::: Parameters: 
rem :::     repository name - repository name
rem :::     project name - console application project name. default = repository name
rem :::     namespace name - project namespace
rem ::: 
rem ::: Description: 
rem :::     Creates new repository and add new console application.
rem ::: 
rem ::: Examples:
rem :::     
rem :::     Creates dot repository "Janda.Device.Sequential" 
rem :::     add console application "Janda.Device.Sequential.Console" 
rem :::     with namespace "Janda.Device.Sequential"
rem :::     
rem :::     .newcon Janda.Device.Sequential --project .Console --namespace . 
rem :::     


call _dotnew addcon %*
goto :eof


:display_hint
if defined DOT_ARG_INSIDE_GIT_REPO echo Try to use .addcon instead.
goto :eof

