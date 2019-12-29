@call _dots %~n0 "Run git diff" "" " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

echo You are working on %DOT_GIT_BRANCH%
git diff --stat


