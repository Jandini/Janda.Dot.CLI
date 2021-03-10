@call _dots %~n0 %* --require-git 
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git branch
rem ::: 
rem ::: .BRANCH [branch name] [--pull]
rem ::: 
rem ::: Parameters:
rem :::     branch name - full or partial branch name
rem :::     pull - execute git pull immediatelly after the checkout
rem ::: 
rem ::: Description: 
rem :::     Show available branches or switch current branch. 
rem :::     When display available branches, the current branch is marked with "*".
rem :::     The branch name is first considered as full branch name. The branch checkout is performed. 
rem :::     If the checkout fails then it use .checkout to find and match partial branch name.
rem :::

set BRANCH_NAME=%DOT_ARG_DEFAULT%
if "%BRANCH_NAME%" neq "" goto checkout_branch
git branch
goto :eof

:checkout_branch
echo Checking out %BRANCH_NAME%
git checkout %BRANCH_NAME%
if %ERRORLEVEL% equ 1 goto :find_branch
git branch
call :pull_branch
goto :eof

:find_branch
:: use .checkout command to find and checkout branch 
call .checkout %BRANCH_NAME%

:: if branch was found by .checkout make sure it is up to date and exit the script
if %ERRORLEVEL% equ 0 call :pull_branch&goto :eof

:: fetch before calling checkout again
echo Fetching...
git fetch

:: try one more time to checkout branch
call .checkout %BRANCH_NAME%
goto :eof


:pull_branch
if defined DOT_ARG_PULL git pull
goto :eof

