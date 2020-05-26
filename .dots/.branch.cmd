@call _dots %~n0 " g" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: List git branches or checkout selected branch
rem ::: 
rem ::: .BRANCH [branch-name]
rem ::: 

if "%1" neq "" goto checkout_branch
git branch
goto :eof

:checkout_branch
echo Checking out %1
git checkout %1
if %ERRORLEVEL% equ 1 goto :find_branch
git branch
goto :eof

:find_branch
call .checkout %1




