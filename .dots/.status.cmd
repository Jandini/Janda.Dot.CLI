@call _dots %~n0 "Get git status" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

echo You are working on %CURRENT_BRANCH%
git branch
git status

