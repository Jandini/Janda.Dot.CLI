@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git push with tags
rem ::: 
rem ::: .PUSH [--all]
rem ::: 
rem ::: Parameters: 
rem :::     all - Run git push for all branches and tags. 
rem ::: 
rem ::: Description: 
rem :::     Run git push 
rem ::: 

set PARAMS=%1
if defined DOT_ARG_ALL set PARAMS=--all --follow-tags %1

git push



