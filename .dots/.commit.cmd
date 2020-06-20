@call _dots %~n0 %* --require-git --require-param 
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git commit
rem ::: 
rem ::: .COMMIT <comment> [prefix]
rem ::: 
rem ::: Parameters:
rem :::     comment - Comment text
rem :::     prefix - Conventional commit prefix
rem ::: 
rem ::: Description: 
rem :::     Display all unstaged changes and prompt user before continue. 
rem :::     When user confirms [Y] it stage the changes and commit with the comment.
rem :::     The prefix is added to the comment text. e.g. chore|fix|feat
rem ::: 
rem ::: Examples: 
rem :::     .commit "Hello World"
rem :::     .commit "Add something" chore
rem :::     .commit "Add great feature" feat
rem :::     .commit "Name parser miss a letter" fix
rem ::: 


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


