@call _dots %~n0 %* --require-git --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git fix commit
rem ::: 
rem ::: .FIX <comment>
rem ::: 
rem ::: Parameters: 
rem :::     comment - Comment text
rem ::: 
rem ::: Description: 
rem :::     Runs .commit with fix: conventional commit prefix. 
rem :::     See .commit --help for more information.
rem ::: 
rem ::: Example: 
rem :::     .fix "my world" 
rem :::     

.commit "%~1" fix
