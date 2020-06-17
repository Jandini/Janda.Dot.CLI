@call _dots %~n0 %* --require-git 
if %ERRORLEVEL% equ 1 exit /b

rem ::: Show available branches or switch branch
rem ::: 
rem ::: .BRANCH [branch name]
rem ::: 
rem ::: Parameters:
rem :::     branch name - full or partial branch name
rem ::: 
rem ::: Description: 
rem :::     Display list of available branches. The current branch is marked with "*".
rem :::     Checkout branch based on given branch name. If the branch name is partial,
rem :::     then first matching branch is checked out.
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
goto :eof

:find_branch
call .checkout %BRANCH_NAME%