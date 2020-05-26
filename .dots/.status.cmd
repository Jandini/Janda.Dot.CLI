@call _dots %~n0 " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Shows current git branch and status
rem ::: 
rem ::: .STATUS
rem ::: 


echo You are working on %DOT_GIT_BRANCH%
git branch
echo.
git status -sb
echo.
echo.
