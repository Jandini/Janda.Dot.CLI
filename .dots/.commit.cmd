@call _dots %~n0 " g1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Stage changes and commit
rem ::: 
rem ::: .COMMIT <comment> [chore|fix|feat]
rem ::: 
rem ::: Parameters:
rem :::     comment - comment text
rem ::: 
rem ::: Description: 
rem :::     Display all unstaged changes and prompt user before continue. 
rem :::     When user confirms [Y] it stage the changes and commit with the comment.
rem ::: 
rem ::: Examples: 
rem :::     .commit "Hello World"


echo You are about to stage all and commit "%~2: %~1"
git status

set /P CONFIRM=Do you want to stage changes and commit "%~1" to %DOT_GIT_BRANCH% now (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto :eof

git add .

if "%~2" neq "" goto :conventional_commit
git commit -m %1
goto :eof

:conventional_commit
git commit -m "%~2: %~1"
goto :eof


