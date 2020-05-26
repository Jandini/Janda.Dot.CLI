@call _dots %~n0 "  1" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

rem ::: Calls given command for each dot repository
rem ::: 
rem ::: .FOREACH <command>
rem ::: 

echo Searching for dot repositories in %DOT_CURRENT_DIR_NAME%...
for /R "." %%G in (.) do (
pushd %%G
if exist %DOT_CONFIG% echo Running %1 for %%G && call .%1 %2 %3 %4
popd 
)


