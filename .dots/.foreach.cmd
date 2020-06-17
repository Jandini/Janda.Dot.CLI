@call _dots %~n0 %* --require-param
if %ERRORLEVEL% equ 1 exit /b

rem ::: Run command for each repository
rem ::: 
rem ::: .FOREACH <command> [arguments]
rem ::: 
rem ::: Parameters:
rem :::     command - command name without dot
rem :::     arguments - command's arguments
rem ::: 
rem ::: Description: 
rem :::     Search for dot repositories and execute given command for each of them.
rem :::     The DOT_IS_FOREACH varialbe is defined when the command is executed via foreach. 
rem :::     This way some of the command's actions can be based on this condition.
rem ::: 

set DOT_IS_FOREACH=1

echo Searching for dot repositories in %DOT_CURRENT_DIR_NAME%...
for /R "." %%G in (.) do (
pushd %%G
if exist %DOT_CONFIG% echo Running %1 for %%G && call .%1 %2 %3 %4 %5 %6 %8 %9
popd 
)

set DOT_IS_FOREACH=


