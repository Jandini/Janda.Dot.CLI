@call _dots %~n0 %* --require-git
if %ERRORLEVEL% equ 1 exit /b

rem ::: Git push with tags
rem ::: 
rem ::: .PUSH [--all]
rem ::: 
rem ::: Parameters: 
rem :::     all - Run git push for all branches and tags. 
rem ::: 
rem ::: Description: 
rem :::     Run git push 
rem ::: 

:: params are not avaialbe for the time being
set PARAMS=%1
if defined DOT_ARG_ALL set PARAMS=--all --follow-tags %2 %3

echo Running git push %PARAMS%
git push
if %ERRORLEVEL% equ 128 git push --set-upstream origin %DOT_GIT_BRANCH%
if not defined DOT_ARG_ALL goto :eof
echo Running git push --all
git push --all
echo Running git push --tags
git push --tags

