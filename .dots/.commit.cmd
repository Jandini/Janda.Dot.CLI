@call _dots %~n0 "Add changes and commit" "<comment>" " g1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

git status

set /P CONFIRM=Do you want to add and commit %1 to %DOT_GIT_BRANCH% now (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto script_end

git add .
git commit -m %1

:script_end
