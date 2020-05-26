@call _dots %~n0 " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Checkout master branch
rem ::: 
rem ::: .MASTER
rem ::: 

git checkout master
git branch

