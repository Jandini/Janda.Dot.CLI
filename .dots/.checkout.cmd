@call _dots %~n0 %* --require-git --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git branch checkout
rem ::: 
rem ::: .CHECKOUT <branch name>
rem ::: 
rem ::: Parameters: 
rem :::     branch name - full or partial branch name
rem ::: 
rem ::: Description: 
rem :::     Finds matching branch and check it out. 
rem ::: 

echo Searching for branch like %1

for /f %%i in ('git branch --all ^| findstr "%~1"') do echo %%i
for /f %%i in ('git branch --all ^| findstr "%~1"') do set CHECKOUT_BRANCH_NAME=%%i
echo.

if "%CHECKOUT_BRANCH_NAME%" neq "" goto branch_found
echo Branch like %1 not found.

:: Return error code 1 so for example .branch is aware of branch not found 
exit /b 1

:branch_found

if "%CHECKOUT_BRANCH_NAME:~0,15%" neq "remotes/origin/" goto checkout
set CHECKOUT_BRANCH_NAME=%CHECKOUT_BRANCH_NAME:~15%

echo Found %CHECKOUT_BRANCH_NAME% 

:checkout
echo Checking out %CHECKOUT_BRANCH_NAME%
git checkout %CHECKOUT_BRANCH_NAME%

