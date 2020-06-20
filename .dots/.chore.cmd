@call _dots %~n0 %* --require-git --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git chore commit
rem ::: 
rem ::: .CHORE <comment> [--scope <scope>]
rem ::: 
rem ::: Parameters: 
rem :::     comment - commit comment text
rem :::     scope - optional commit scope 
rem ::: 
rem ::: Description: 
rem :::     Runs .commit with chore: conventional commit prefix. 
rem :::     See .commit --help for more information.
rem ::: 
rem ::: Example: 
rem :::     .chore "hello world" 
rem :::     .chore "hello world" --scope onlymine
rem :::     

.commit "%~1" --prefix chore %*
