@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git log
rem ::: 
rem ::: .GITLOG [max count]
rem ::: 
rem ::: Parameters: 
rem :::     max count = Number of entries to display. Default value is 20.
rem ::: 
rem ::: Description: 
rem :::     Show git log
rem ::: 


set MAX_COUNT=20 
if /i "%1" neq "" set MAX_COUNT=%1

if %MAX_COUNT% neq 1 echo You are working on %DOT_GIT_BRANCH%
git log --pretty=oneline --abbrev-commit --max-count=%MAX_COUNT%




