@call _dots %~n0 "Checkout develop branch" "" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

git checkout develop
git branch

