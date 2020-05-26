@call _dots %~n0 " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Run git log
rem ::: 
rem ::: .GITLOG [max count]
rem ::: 


set MAX_COUNT=20 
if /i "%1" neq "" set MAX_COUNT=%1

if %MAX_COUNT% neq 1 echo You are working on %DOT_GIT_BRANCH%
git log --pretty=oneline --abbrev-commit --max-count=%MAX_COUNT%




