@call _dots %~n0 %* --require-git --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git feature commit
rem ::: 
rem ::: .FEAT <comment>
rem ::: 
rem ::: Parameters: 
rem :::     comment - Comment text
rem ::: 
rem ::: Description: 
rem :::     Runs .commit with feat: conventional commit prefix. 
rem :::     See .commit --help for more information.
rem ::: 
rem ::: Example: 
rem :::     .feat "whole world" 
rem :::     

.commit "%~1" feat
