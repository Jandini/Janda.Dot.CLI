@call _dots %~n0 %* --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Dots foreach call
rem ::: 
rem ::: .FOREACH <command> [arguments]
rem ::: 
rem ::: Parameters:
rem :::     command - Command name without dot
rem :::     arguments - Command's arguments
rem ::: 
rem ::: Description: 
rem :::     Runs dot command for each repository.
rem :::     Search for dot repositories and execute given command for each of them.
rem :::     The DOT_IS_FOREACH varialbe is defined when the command is executed via foreach. 
rem :::     This way some of the command's actions can be based on this condition.
rem ::: 

set DOT_IS_FOREACH=1

echo Searching for dot repositories in %DOT_CURRENT_DIR_NAME%...
for /R "." %%G in (.) do call :exec "%%G" %1 %2 %3 %4 %5 %6 %8 %9
set DOT_IS_FOREACH=
goto :eof


:exec
pushd "%~1"
if exist .template.config goto next
if not exist %DOT_CONFIG% goto next
set REPO_PATH=%~1
echo Running %~2 for %REPO_PATH:~0,-2%
call .%2 %3 %4 %5 %6 %7 %8 %9
:next
popd 
goto :eof


