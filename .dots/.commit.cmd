@call _dots %~n0 %* --require-git --require-param 
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git commit
rem ::: 
rem ::: .COMMIT <comment> [--prefix <prefix>] [--scope <scope>] [--force]
rem ::: 
rem ::: Parameters:
rem :::     comment - Comment text
rem :::     prefix - conventional commit prefix
rem :::     scope - optional commit scope 
rem :::     force - skip confirmation
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
rem :::     .commit "Add great feature" feat --scope world
rem ::: 



set COMMIT_COMMENT=%DOT_ARG_DEFAULT%
if defined DOT_ARG_PREFIX call :conventional_commit "%DOT_ARG_DEFAULT%" "%DOT_ARG_PREFIX%"

echo You are about to stage all and commit "%COMMIT_COMMENT%"
git status

if defined DOT_ARG_FORCE goto :force
set /P CONFIRM=Do you want to stage changes and commit "%COMMIT_COMMENT%" to %DOT_GIT_BRANCH% now (Y/[N])?
if /i "%CONFIRM%" neq "Y" goto :eof
:force


git add .
git commit -m "%COMMIT_COMMENT%"
goto :eof


:conventional_commit
if defined DOT_ARG_SCOPE (set COMMIT_COMMENT=%~2^(%DOT_ARG_SCOPE%^)^: %~1) else (set COMMIT_COMMENT=%~2: %~1)
goto :eof


