@call _dots %~n0 "Get git status" "" " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Shows current git branch and status
rem ::: 


echo You are working on %DOT_GIT_BRANCH%
git branch
echo.
git status -sb
echo.
echo.
