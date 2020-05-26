@call _dots %~n0 " g1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Checkout branch by partial name
rem ::: 
rem ::: .CHECKOUT <partial-branch-name>
rem ::: 

echo Searching for branch like %1

for /f %%i in ('git branch --all ^| findstr "%~1"') do echo %%i
for /f %%i in ('git branch --all ^| findstr "%~1"') do set CHECKOUT_BRANCH_NAME=%%i
echo.

if "%CHECKOUT_BRANCH_NAME%" neq "" goto branch_found
echo Branch like %1 not found.
exit /b

:branch_found

if "%CHECKOUT_BRANCH_NAME:~0,15%" neq "remotes/origin/" goto checkout
set CHECKOUT_BRANCH_NAME=%CHECKOUT_BRANCH_NAME:~15%

echo Found %CHECKOUT_BRANCH_NAME% 

:checkout
echo Checking out %CHECKOUT_BRANCH_NAME%
git checkout %CHECKOUT_BRANCH_NAME%

