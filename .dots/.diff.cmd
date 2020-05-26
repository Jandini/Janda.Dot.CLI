@call _dots %~n0 " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Run git diff
rem ::: 
rem ::: .DIFF
rem ::: 

echo You are working on %DOT_GIT_BRANCH%
git diff --stat


