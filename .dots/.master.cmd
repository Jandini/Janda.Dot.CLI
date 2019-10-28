@call _dots %~n0 "Checkout master branch" "" " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

git checkout master
git branch

