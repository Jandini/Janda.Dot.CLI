@call _dots %~n0 " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Checkout develop branch
rem ::: 
rem ::: .DEVELOP
rem ::: 


git checkout develop
git branch

