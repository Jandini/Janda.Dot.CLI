@call _dots %~n0 "List git branches or checkout selected branch" "[branch name]" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if "%1" neq "" goto checkout_branch
git branch
goto exit

:checkout_branch
echo Checking out %1
git checkout %1
git branch

:exit

