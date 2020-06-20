@call _dots %~n0 %* --require-git --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git feature commit
rem ::: 
rem ::: .FEAT <comment> [--scope <scope>]
rem ::: 
rem ::: Parameters: 
rem :::     comment - comment text
rem :::     scope - optional commit scope 
rem ::: 
rem ::: Description: 
rem :::     Runs .commit with feat: conventional commit prefix. 
rem :::     See .commit --help for more information.
rem ::: 
rem ::: Example: 
rem :::     .feat "whole world" 
rem :::     .feat "world" --scope entire
rem :::     

.commit "%~1" --prefix feat %*
