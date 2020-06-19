@call _dots %~n0 %* --require-git --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git chore commit
rem ::: 
rem ::: .CHORE <comment>
rem ::: 
rem ::: Parameters: 
rem :::     comment - Comment text
rem ::: 
rem ::: Description: 
rem :::     Runs .commit with chore: conventional commit prefix. 
rem :::     See .commit --help for more information.
rem ::: 
rem ::: Example: 
rem :::     .chore "hello world" 
rem :::     

.commit "%~1" chore
