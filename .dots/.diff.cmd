@call _dots %~n0 "Run git diff" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

echo You are working on %CURRENT_BRANCH%
git diff


