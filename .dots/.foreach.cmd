@call _dots %~n0 "Calls command for each dotset repository" "<command>" "" %1 %2 %3
if %ERRORLEVEL% equ 1 exit /b

if "%1" equ "" .help foreach && exit /b

for /R "." %%G in (.) do (
pushd %%G
if exist .dotset echo Running %1 for %cd%... && call .%1 %2 %3
popd 
)


