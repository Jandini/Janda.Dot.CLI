@call _dots %~n0 %* --require-git --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git fix commit
rem ::: 
rem ::: .FIX <comment> [--scope <scope>]
rem ::: 
rem ::: Parameters: 
rem :::     comment - comment text
rem :::     scope - optional commit scope 
rem ::: 
rem ::: Description: 
rem :::     Runs .commit with fix: conventional commit prefix. 
rem :::     See .commit --help for more information.
rem ::: 
rem ::: Example: 
rem :::     .fix "my world" 
rem :::     

.commit "%~1" --prefix fix %*
