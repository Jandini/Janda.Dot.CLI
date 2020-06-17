@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git diff
rem ::: 
rem ::: .DIFF
rem ::: 
rem ::: Description: 
rem :::     Display current working branch and run "git diff --stat" within git repository.
rem ::: 

echo You are working on %DOT_GIT_BRANCH%
git diff --stat


